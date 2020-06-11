Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A18CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4CE2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="br9Lpdtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFKGJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:09:34 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:50917
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbgFKGJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3JSoFjk2otbJKj0WzG27ouIzkKMfvJU0LZD3t/Tgvo=;
 b=br9LpdtjVAMDtJAA4GtH6aZMu7fl+0p6HLdETCwR7WLxV7Qf31PCUb/rgAint3LzxwB4oiwtu953iy4P6/XfG+86fP4++QrsxAKE+t5BVu6xsG8HFo6ubjNKCKzQBXeBbkYWLzmXFJsz9KSWltSiK3LucI3YgZeSf8Qs437OP68=
Received: from AM5PR0701CA0072.eurprd07.prod.outlook.com (2603:10a6:203:2::34)
 by VI1PR0401MB2367.eurprd04.prod.outlook.com (2603:10a6:800:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Thu, 11 Jun
 2020 06:09:27 +0000
Received: from VE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::b8) by AM5PR0701CA0072.outlook.office365.com
 (2603:10a6:203:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.10 via Frontend
 Transport; Thu, 11 Jun 2020 06:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 VE1EUR01FT056.mail.protection.outlook.com (10.152.3.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:09:26 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.107) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 11 Jun 2020 06:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WShm78tnpQyWFeAI6d6Asi4y5dy7U01xmdYPJXVZwC9im3XcCUPRMD6HuYQLgp1UbHHvBpnbAEHciJKaOGdHAUtUu2+YHCv9TOFrTMKrmzJQi1DK/5EYZj7n5u5Gk13zs+W9l3lQNo7x/acp7hRsW1AqwBAzdRX6479Ym+OMGnch/lPf60LIIzas8AJx9uD1S/TlXp+rbNb8XD81LZnAkKGZqhJM/NBaYMIg7CbV8Obbg6sNkMizt6VZFVPOBdSJVRXoTW1xJ1nD/esJdluA80FFnyYNx6bkezpCza2yoRGMS3yy46wm1V8MMxH/SX5by5t5geFqjbzSZs1zCeW1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9818eqo0Z8kYdkulCdzMkvq5BK9Pwqh89PqG+XOfn1w=;
 b=UiTq6uLpzMKlSWSpxIzN9MqWNIBY9fV8vRmWGhFYFHSV/Ui2EpOP6d/za8XWmE4Q1Zp+MK385OgFZDvUSeNu3MLVTQKgqQLUcbvrd99IOv1KAJ4FjIHu53HZsfsc3VvwHBM9RqYi9hdRCJMvR6yGmSb6Ukrtw5AaBJqTxRk9wvORABA6rqkMcf2ev2+Ie87VL6ExRryowCQq71LyvyAmXBqra+NMEbN55oa9hK45x5FjXdYlXL7aDAfq6Mv1gT6jgu7/aMLDuq1b1ZSTv8OQOhS4QHjWGW9yO+qVRB/B8h0TJp4bq5JcB9u0jbTb4yPlAHxWl40WIGqqW67/LW8jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB7003.eurprd04.prod.outlook.com (2603:10a6:10:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 06:09:23 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9%7]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 06:09:23 +0000
Subject: Re: [PATCH v2] usb: dwc3: Add support for VBUS power control
To:     Rob Herring <robh@kernel.org>
CC:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org
References: <20200603120915.14001-1-mike.looijmans@topic.nl>
 <20200610202255.GA3646369@bogus>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5c7af9b2-8c7e-406c-b29a-f20ab6b96179@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.3b5128fd-1d26-4e6d-9ccd-7154c30bef49@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <be0f6d7b-aa2e-39de-f5ee-83592c9bed7f@topic.nl>
Date:   Thu, 11 Jun 2020 08:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200610202255.GA3646369@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR01CA0085.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:09:23 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff8224c2-d0cd-4e79-7d7e-08d80dcdff02
X-MS-TrafficTypeDiagnostic: DB8PR04MB7003:|VI1PR0401MB2367:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23678D607ABE7D298A40C40996800@VI1PR0401MB2367.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;OLM:7691;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RGvt414lbT7ipYX5czfjFvYsZKyvSYiXSqoW3cat4BLah0gBI7qg+8A7VfoI0VZDxJOpXolA8TTMTK5NPeuizy+AmvtZyG5JB0WRVN5hZL+VvRKw//iDRrXoiFLL6cspNpbziwT6zy2jFOnztGnHiB3qESddvqHrKHMK8m/QfpCT+8BzuV01rvD10Xn8dwxmUHVNiEQ1HTcqL3xh3DEfC209BqRFLhDieKItuCYOo/A3cMna9VuSNdXJvJIPc5/WgCL0yceRATmNnN30Ph5BTZ9yd5WThN5QGLWOBaQToCBXeCbI2RhbH0M6NjZDtuHo7PKv8SVyhT61gjk6UMpUA45AWdu4zyx0h5FY519tqIMGFCce+HoTSiDvwSeJsTrY
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(136003)(376002)(366004)(396003)(346002)(44832011)(31686004)(186003)(16526019)(36756003)(5660300002)(66476007)(26005)(66556008)(66946007)(31696002)(83380400001)(8936002)(16576012)(8676002)(52116002)(36916002)(508600001)(6916009)(42882007)(4326008)(316002)(53546011)(2616005)(83170400001)(6486002)(956004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B9HnIUfladDQVDLKMd82D+OR92vqFdt6VEodN4LFlGuPAOHHgolOuwLU7NeTg6JGp5/rsu6BNTl7AFlt+2S3SsBOd7idUnhdWQJSnixVjaCuzaSj9jv+sP5D3+BEcvApDP8x6zXbTu8sT/WDsM8l+ZVbrD7WE2DZ66lGKGH9urXFEB0EDzhkiCPx/brtVARUlVZ2Z6Ij/JddA6PIeYeyaoiAgV92GwmTfO14Ta+6HlutT/pmQBUwGBGGkJi0slgg6chNwsmrybywPpTekd9cn7Ahk0hWTZbYcuZxH9VPdb5aVo7J+UVn1poQNfWUheblpH88igvTR3dEIIbJDsI5PSMkZ6Zb9AQ1Intgg+zVwRE7tBu3Z2/3vOWH9JZru1kK5S6/hQzW/v3IktL0glaozZN2v/J3rGBzxWzpzj0jc1KrWZ5E9DEUG+EuPPNdSIwnekrQhP/HP5P+dm1wliLbc0F/HW7U/qjF0CA+e5qwRVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7003
X-CodeTwo-MessageID: f92714fe-3caf-40a5-9c1f-4cdedffa7473.20200611060925@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(39840400004)(376002)(136003)(396003)(346002)(46966005)(83380400001)(82310400002)(83170400001)(31686004)(5660300002)(7596003)(356005)(36756003)(8676002)(7636003)(6486002)(8936002)(15974865002)(44832011)(4326008)(336012)(16576012)(186003)(36916002)(31696002)(2906002)(508600001)(316002)(70206006)(47076004)(70586007)(26005)(16526019)(53546011)(6916009)(42882007)(2616005)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d488746-ecd6-4961-81cd-08d80dcdfcc8
X-Forefront-PRVS: 0431F981D8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKyUV3lFLonOKgKV6IJiT/G2FnKZZkg4SmvPfEfkznGaSdMP6uZ/d0c9jfa0OpkGdcVccVQrgFqQZjxp+xaBhDbAEhUjuRWyv2wxMVNd+ITg1xpM71qyoHtgzrWNiHzPaepFWvhxVz2iXmF4jbdlE1lgsff9OoQhreYNN/3WLTv1CcxdKhy8TDQQc43Mm2PO3KvKXIf+0QT1pU8HoVElcSdHRNLZRq/uzKthR1+h18BYaXhrWayvRq1zT39/nf0F/8HBwUwVK6ERrIjIg7uvhFrfuMHien1j25oej2pkLSSU6+bdxvUGuKOCArCiFf8wcUugQqnwNRPVczMpRNWnVGvZ1Cm3UCwB5m+xmF6BJ5/X0b9hDhPgE+Y23jSI10VKxP0oGjJFMYD4jTM88b9YPkUCWutiSrLJZc5Qa0BjJWwfgpIFYf+EHB37kEYUuZh1BkfCiA0rsXCYYEyIFsKF1rN2CVi/8x30u8xzRism0PROwXy9iN/zsIvaRILf3HoS
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:09:26.8818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8224c2-d0cd-4e79-7d7e-08d80dcdff02
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2367
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
On 10-06-2020 22:22, Rob Herring wrote:
> On Wed, Jun 03, 2020 at 02:09:15PM +0200, Mike Looijmans wrote:
>> Support VBUS power control using regulator framework. Enables the regula=
tor
>> while the port is in host mode.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> v2: Add missing devm_regulator_get call which got lost during rebase
>>
>>   .../devicetree/bindings/usb/dwc3.txt          |  1 +
>>   drivers/usb/dwc3/core.c                       | 34 ++++++++++++++-----
>>   drivers/usb/dwc3/core.h                       |  4 +++
>>   drivers/usb/dwc3/drd.c                        |  6 ++--
>>   4 files changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentat=
ion/devicetree/bindings/usb/dwc3.txt
>> index 9946ff9ba735..56bc3f238e2d 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>> @@ -37,6 +37,7 @@ Optional properties:
>>    - phys: from the *Generic PHY* bindings
>>    - phy-names: from the *Generic PHY* bindings; supported names are "us=
b2-phy"
>>   	or "usb3-phy".
>> + - vbus-supply: Regulator handle that provides the VBUS power.
> Does the DWC3 block require Vbus to power itself? Doubtful. This
> belongs in a usb-connector node. If the DWC3 driver wants to get the
> Vbus supply, it can fetch it from that node.
>
> Rob

Ah, now I understand. There's a vbus-supply in the connector in newer=20
kernel versions than the one I have to test with. It'll have to wait=20
until I've been able to upgrade the kernel version for this board.


--=20
Mike Looijmans

