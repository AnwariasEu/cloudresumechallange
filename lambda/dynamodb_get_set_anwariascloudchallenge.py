import boto3
import json

print('Loading function')
dynamo = boto3.client('dynamodb')

TABLENAME = "anwariascloudchallenge_visitors"
ITEMNAME = "visitorcount_index.html"


def respond(err, res=None):
    return {
        'statusCode': '400' if err else '200',
        'body': err.message if err else json.dumps(res),
        'headers': {
            'Content-Type': 'application/json',
        },
    }


def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    result = dynamo.update_item(
        TableName = TABLENAME,
        Key = {'id': {"S": ITEMNAME}},
        UpdateExpression = 'SET amount = amount + :val',
        ExpressionAttributeValues={':val': {'N': '1'}},
        ReturnValues='UPDATED_NEW'
    )
    print(json.dumps(result))
    # result = table.update_item(Key=,)
    # 'GET': lambda dynamo, x: dynamo.scan(**x),
    # 'PUT': lambda dynamo, x: dynamo.update_item(**x),

    return respond(err=None, res=result['Attributes']['amount']['N'])
