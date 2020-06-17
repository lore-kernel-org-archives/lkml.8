Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A01CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1044C21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="EzGFftKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFQR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:28:36 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:13919
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbgFQR2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfwNk+6GqBta5gwMFoFo91tNl42TUcTG/wV6pC1OEvg=;
 b=EzGFftKYf7YhAlmaaLpXmoKoWYmECH0aMSUQZYGVrKroLFlzb49gNQUgey7+oIVJyyq6NyK25FXKKi6KJKdZuiI6hbM6bMan92Jg+obv8+7pMevX7U1fz3EhHdd+xh7YVOkmyp8k4vZCsPAZyv1p2i9scyTT6rOUPy8LG2X2//Q=
Received: from DB6PR07CA0084.eurprd07.prod.outlook.com (2603:10a6:6:2b::22) by
 DB8PR04MB5593.eurprd04.prod.outlook.com (2603:10a6:10:ae::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19; Wed, 17 Jun 2020 17:28:28 +0000
Received: from DB5EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::81) by DB6PR07CA0084.outlook.office365.com
 (2603:10a6:6:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend
 Transport; Wed, 17 Jun 2020 17:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 DB5EUR01FT062.mail.protection.outlook.com (10.152.5.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 17:28:28 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.174) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 17 Jun 2020 17:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0dowVSzQ8H0imsDhfAnSyd2nR6+xLlWp0e36ZNPLBWoiA+QAvCcQ07lnCttxBJYw6giyRA+BLeyZAilVNWYwfanlDa0mf6NRnXRnev7wgm9ruOpJck8dYPU2SwFOweBptoLfl6P8+DRaWgbyDqN7otB9Ord/eggH/cSarWUfC0NZ+763PLM1YznKy5TxhNNinSN9hPpPSiMrfjGubvVxg3W0gRO/DdF3xPVrVhT8510VWzXsnQWgDKL9ri5Nujxi9pSX+Chal23EgIArcTWL8virnhZLf5GG9MNSEO09fKnWlr/6zegG4iN1p3PXlhc42eUOt4wUJOte8vsxvjdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ENfW9uRwlAUr+SjrHr5dzJU8v2/uw+Nq5VogGcC6Ww=;
 b=OvUSoYWMh74OhTzi+rzcSSm2Xt0lQ3CBYtaYvLKLB2984tQawIZMyCrvQJgi5OFe4ctv4M9R+4ol3xgw3uWiC0JjC4zF59yWArn+SR25a1DKOTE7rTx/WWiA3UYaEmkfinWL7OGQgKIhqCe900EIuBDC3SqMxIRvrk/BRiyjKN5LKyakRcCZr9Bkw00L+TCyeiPLo6yp+j+NQhqQnBkXLfZXjx6xOHQolX49QU8ZRa9mgg6MNod+ZwuBAathcIhJPUzA+v5sGaRabm6ggGiUzdci3R8QY66IuaFUS/aoXTrqofJmZp6Jt0V5ItCpAJ2o8lrt1K55sX+bO1IasBx8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6731.eurprd04.prod.outlook.com (2603:10a6:10:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Wed, 17 Jun
 2020 17:28:24 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 17:28:24 +0000
Subject: Re: [PATCH v2] usb: dwc3: Add support for VBUS power control
To:     Rob Herring <robh@kernel.org>
CC:     Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20200603120915.14001-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37aec1ae-7fee-44cb-ae24-a10a151abcb3@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.3fedbcf4-0977-416b-9979-d557fd9233a7@emailsignatures365.codetwo.com>
 <20200610202255.GA3646369@bogus>
 <504080a1-cbc9-f781-04bb-12d5679ba697@topic.nl>
 <CAL_Jsq+6cj99+7cb1vrZ9eLouo-pPWTDjDEOotDQExazdrx-XA@mail.gmail.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <413a840f-6765-51ba-a4b4-dd6204265fb7@topic.nl>
Date:   Wed, 17 Jun 2020 19:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAL_Jsq+6cj99+7cb1vrZ9eLouo-pPWTDjDEOotDQExazdrx-XA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0152.eurprd05.prod.outlook.com
 (2603:10a6:207:3::30) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM3PR05CA0152.eurprd05.prod.outlook.com (2603:10a6:207:3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 17:28:23 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a418056-79ca-4b76-3c54-08d812e3d959
X-MS-TrafficTypeDiagnostic: DB8PR04MB6731:|DB8PR04MB5593:
X-Microsoft-Antispam-PRVS: <DB8PR04MB5593549D94DFB00E5341AE44969A0@DB8PR04MB5593.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: As6dwfXCF5VJ6R96Hw4wkUTR52yjeATFekh5x5ppyB0l/dw35QAiQVRIXyWCfPDoqMhXmuDRCvemEBjITsO1XVAIUT7Xk1PZ2+OzATar3dG60QlFR98m5dq7APiV/BFIabJApgZgK8WX56T4hln4iEPe+whzVtQ/EoUo2dY1ByhIQBFHE/UhBs+R/gxXQ9a20ZKzAYjT4Gydw/o8ZmNOquIN/Jhp0lChxG2fPv5IMJxbPAcHDGacW5MbSzlT2ZlUxgnkxzQXwVY+fAJHDtIp6Is1kSMr4jQ4QLcDcaXTVCP+II2d/TuLWF8oj1yYIrD0ZPavJ1Iu0X3s0uRQ0exHvLOHXoX2D1IeFwm3FXfmQqTiIcg/ubM6AT+T0FAEaglzl4sourX3rbaYlQaES/TO+LeqnNKiLWjPaGZ9yS/wku/KcwrFmzlf/omHhrefrdMbD9Yq+WDOzPtfH7ve5z5Zpg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39840400004)(346002)(376002)(366004)(136003)(16526019)(15974865002)(8936002)(186003)(42882007)(5660300002)(2906002)(31696002)(83380400001)(26005)(4326008)(2616005)(36916002)(53546011)(52116002)(6916009)(83170400001)(316002)(508600001)(16576012)(44832011)(54906003)(36756003)(66556008)(31686004)(66476007)(66946007)(8676002)(6486002)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: w5+ETKAfuYjhOejpUHre1RKFrrX6ND8DdEj5/CoHng8koKeWbL0e0NckBaG8rtz1tFZub7zJUpDcbgbR41EnE1PUyp6x1NNIDA1fdOb3fdiNw1Bk1qjEeXDSNsSic5OGCMiuhGsFBSlCfCQgQa68Y79xERZdTrU3F4RFzlL/t5fuY5PdtnP4V6TNk8OlHMbR8yKa3Gwqpjk4ucS0XhWXJl+xiI21nEle6yXpY4NTIu/9irmolOz7qJcz+izVcM7dGXgRyvEAZA9THCogcPofTkylpKfi2vuYdHNI+JYi7lwRlLyM6c2UZnNsk2CZXgMKat9Ow880M2iv2CbZG7VItFs6xEyGv/1/cq3fwVGupmU4IDpNI63cykjG/2Q8EIqpxogfUtbwxCnSuGAnYGfmq9IHIKcHw6jmzDkWOo37wqsIC78Xmy2tES/YNIyuqyi2dhET+eZmV6P/VIepyG40wL01g8Wt6aYdsIwfWxKDR6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6731
X-CodeTwo-MessageID: 56b6907e-2d9d-4b09-bb75-66cd7f6ce0be.20200617172827@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(376002)(39840400004)(136003)(346002)(396003)(46966005)(6916009)(7636003)(83380400001)(6486002)(356005)(82310400002)(31696002)(83170400001)(47076004)(70206006)(31686004)(7596003)(70586007)(2906002)(956004)(2616005)(54906003)(316002)(15974865002)(44832011)(16576012)(5660300002)(8676002)(186003)(336012)(508600001)(8936002)(36756003)(4326008)(26005)(16526019)(36916002)(42882007)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 90091dbf-0c7a-48cc-13b5-08d812e3d6aa
X-Forefront-PRVS: 04371797A5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afZvmP8A/D4quBtBM9qFpQ3CRdsly+AiofMLkVTlOwTBNkmhQT7kX4TR8zwuoOgQ2/tp2U0uc2chxyyKL4F6WfX2w0vPR27qA76Ag4gyJRxBIrR/kKN+2X5KbGuqTDcbhjB/Zl3jSzwROtm4it8bPNumrAQEqV2bimuR5ZEKG8tUgR54rV4eADOdbiz22DZ6/ND9kRVraY9o9H0gXOUTqEfJZDOoF8kflA18fVzAbRdm/J787EQ7YDX7nB9OlLrqTWjgH/1URwY7D3VibPjTOdJoE+4MttovneLaMRRwOW4flN1hVRYnPb7gV35+MP8lF4J1094hPzWgY2PKDprkCZ4AxzNQtcGCLS7rcXK3KSOUQyF7ZrdVfG0nav+lnGOM5BMJo3tzDm4O5rHED/vb9OJqxb6WZ8UXqHBPUA3XsYx3wXsCbzT760ppiIn0PlObyBSOwy8hI0X+/D08pyc9w3dbdkTVNSM8FVRfBgPasq9VWMXNod4b2DNQxqKD+7+i
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 17:28:28.5015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a418056-79ca-4b76-3c54-08d812e3d959
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 17-06-2020 18:13, Rob Herring wrote:
> On Wed, Jun 17, 2020 at 8:38 AM Mike Looijmans <mike.looijmans@topic.nl> =
wrote:
>>
>> Met vriendelijke groet / kind regards,
>>
>> Mike Looijmans
>> System Expert
>>
>>
>> TOPIC Embedded Products B.V.
>> Materiaalweg 4, 5681 RJ Best
>> The Netherlands
>>
>> T: +31 (0) 499 33 69 69
>> E: mike.looijmans@topicproducts.com
>> W: www.topicproducts.com
>>
>> Please consider the environment before printing this e-mail
>> On 10-06-2020 22:22, Rob Herring wrote:
>>> On Wed, Jun 03, 2020 at 02:09:15PM +0200, Mike Looijmans wrote:
>>>> Support VBUS power control using regulator framework. Enables the regu=
lator
>>>> while the port is in host mode.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>> ---
>>>> v2: Add missing devm_regulator_get call which got lost during rebase
>>>>
>>>>    .../devicetree/bindings/usb/dwc3.txt          |  1 +
>>>>    drivers/usb/dwc3/core.c                       | 34 ++++++++++++++--=
---
>>>>    drivers/usb/dwc3/core.h                       |  4 +++
>>>>    drivers/usb/dwc3/drd.c                        |  6 ++--
>>>>    4 files changed, 33 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Document=
ation/devicetree/bindings/usb/dwc3.txt
>>>> index 9946ff9ba735..56bc3f238e2d 100644
>>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> @@ -37,6 +37,7 @@ Optional properties:
>>>>     - phys: from the *Generic PHY* bindings
>>>>     - phy-names: from the *Generic PHY* bindings; supported names are =
"usb2-phy"
>>>>       or "usb3-phy".
>>>> + - vbus-supply: Regulator handle that provides the VBUS power.
>>> Does the DWC3 block require Vbus to power itself? Doubtful. This
>>> belongs in a usb-connector node. If the DWC3 driver wants to get the
>>> Vbus supply, it can fetch it from that node.
>>>
>>> Rob
>> Okay, I've been digging into that. But there's no actual driver that
>> binds to a "usb-b-connector" compatible, so how do we get to the
>> vbus-supply from there?
>>
>> [devm_]regulator_get only accepts a device as argument, and will not
>> look into child nodes. The only way to get at the vbus of a child node
>> (or a node linked through a port) would be to hand-code the equivalent
>> of of_regulator_get(), which will not be acceptable.
> Doesn't it look into child nodes calling of_get_child_regulator()?
Looking at the code in regulator/core.c, yeah, it should. I'll have to=20
add some debugging lines and look into why it didn't work in my test.
> You're right that it wouldn't work if graph is used. The connector has
> to be either a child of a controller for the connector or the USB
> controller. I'd expect you'd have the former for Type-C, but for
> "usb-b-connector" the parent is more likely just the USB controller.
For my current case, using a direct child would be fine, there's nothing=20
else connected. But I expect that we'll produce a board with some USB-C=20
connector some day yeah.
>
> In any case, having a struct device shouldn't be a requirement and
> most subsystems expose a get function only needing the DT node.
>
>> Or is it the intention that I write a usb-X-connector device driver
>> first that handles the vbus?
> That's a kernel implementation detail that is independent of the
> binding, but yes we'll probably need a driver or library helper
> functions eventually. Note that it is possible to have a struct device
> without a driver.
>
> Rob


--=20
Mike Looijmans

