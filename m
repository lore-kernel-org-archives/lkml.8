Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEE420734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="avDFj9b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFCJAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:00:55 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:46362
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgFCJAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS1zS00LajhhOfn3hjKzJ2y54vhDSIN8HvXR5Hlwx5E=;
 b=avDFj9b0vyVWfTH8FCzE97pMB2yMYQNR8N54PFbQxTRZXu9EXhdThFdodlLo9JOmIS/qiwzXla3Tjfow5dz9LNBQC+VZtzpkNDmt7AyClWWGOx5IOyhVZjf4nL0JdnF1z7WYHtVJBGaJgvs4Jay5I4c5fJ8oKELR45uY56XjzP8=
Received: from AM6P191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::43)
 by VI1PR0401MB2463.eurprd04.prod.outlook.com (2603:10a6:800:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 09:00:47 +0000
Received: from HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::70) by AM6P191CA0066.outlook.office365.com
 (2603:10a6:209:7f::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 09:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT017.mail.protection.outlook.com (10.152.0.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.21 via Frontend Transport; Wed, 3 Jun 2020 09:00:47 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (104.47.6.54) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 03 Jun 2020 09:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYvfIE9iSdcZ8H4G8aCoEH9n708kIR3Eqg+RgJcxs+mvbV3nyX9DAEoUJh2s8eMuaCzGS0+YLWG1SVY8yBcJMB5TPlSWYl8lXhlsG+MO8Mm9a0zJQVGtBsX95MSueKc2xON0Cx7UEsxRs0HWsWZ6foJY0QU6AmRXXdtukxjbQV+sjFMTHd034A1iFU3m6I2Ninu9hXysh1KmRIVqqAimqTjYkHgoMARwha/Lj26nsQ3Cf7ZwEljxiTkaWKrvzK4S7SnNbLbewCwFVPnCtViZZevgJ5hMoximJ1VFoXqUWFLNgVNFdzKc3LygSr4+S+VEZzhPveD/8YYRAXLOgviTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y1Oa5uUKN5gLX8DCuTeZu5z1P0xVPGA3V7vWQCZNok=;
 b=Lunnpz3F2Q9VIHos/e2mLQVHwiVRkzbgfBHmGKI58cYkcVvzt/sdqx7eRfl58qZhWOBlO0ed7vwF7kAcV6S6D+fdg0wAP+DidBkoqancYb/Ryi8Io4EhVwAurNAhKLHcxxqIqWl8uJAxznAGmz4KeyEJ/R5d4MgXEzaWNC1dSdRanVSTaZjdvIN9GEvU1FmNxtiyY+hrNcu4ijWpDvBvvFzT3GtIuebN1QFod5skAND2MkihBvUXlRCN9FjujwJsFd5uSQaxxAnyf1Z0HhDEdbsdyDOFkbyqd1bk7eckmcU6Anqo/qZKhIqbM2UWlt8ceUjFW+FbBtRQv9HK1hnjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6969.eurprd04.prod.outlook.com (2603:10a6:10:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 09:00:42 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9%7]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 09:00:42 +0000
Subject: Re: [PATCH v2] usb/phy-generic: Add support for OTG VBUS supply
 control
To:     Rob Herring <robh@kernel.org>
CC:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200529060045.25556-1-mike.looijmans@topic.nl>
 <20200529210816.GA2952126@bogus>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4a88d165-fef2-401c-bac5-b9c66c715faa@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.3ff37988-9502-4a43-9f09-0e852ed735ab@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <18d1793e-e214-f83b-a582-8174132375b7@topic.nl>
Date:   Wed, 3 Jun 2020 11:00:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200529210816.GA2952126@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR02CA0012.eurprd02.prod.outlook.com (2603:10a6:208:3e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 09:00:41 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 540cd90b-26aa-472f-6f8a-08d8079c9b2e
X-MS-TrafficTypeDiagnostic: DB8PR04MB6969:|VI1PR0401MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2463C45C15253DA026FEB2CF96880@VI1PR0401MB2463.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;OLM:4714;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tOebhZ+AJ/ElScPQqR2TlUaCPjvvzTcdBet7Xznll+Datk6H2ZlqgQdK6LvVcAxp6EchpdqSKMK2Zz/123H0sYhYUQZP/SLLIsD4ji5rmuKKZ14Tzqpk8ilB2mqbrz7NDwGI3BW6OilAbMTImv7hnNu04OCIQEm0Mph25luiJKnVBr7Pm/Zn0KxGNVycTbHzbmwSQluYFZvyUitRhF1qTd/gKDpglbHlrCYib8QJceHo458wulyzPAB7eRSP0IBa6mLOcf5T9U65Q7jbjgiKBAP1RotZSp4ibYVVfuYvfamkjE+UhVorpin5BTOw+y1kRFSmcUE1/4VCHWBsF1KqFf1R3cIyiUQD0IqopwUCANzKC+MjObRK0zyRPNjBD/S58uKYB9WaT1NxuCJ3lt5O7Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(136003)(396003)(39840400004)(4326008)(2906002)(52116002)(6486002)(36916002)(508600001)(16576012)(31696002)(316002)(6916009)(31686004)(8676002)(66556008)(42882007)(53546011)(8936002)(83380400001)(26005)(16526019)(186003)(83170400001)(44832011)(2616005)(956004)(36756003)(66476007)(5660300002)(66946007)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dW4c+aFBNWnPkwXAF0C+3rfL/fcegYXgf1RU5AZeiJ4urQL2NNspsRgCsaragfqvGuggA3AgZBK74pJTmnp3CkjZPFGch/d+2WmXu2AQw/nei2mD+/cm8n89loHnldEY48ahR2F2PpnMhQZwuWLLywtofiqC4J/eglckIODaGFElwdWaPVdrgipUfMMCNACJLEIYuINNu/E8i8oxsrIUykkTGScb2MQQHtfQJtWMrh5i8HQ8sXB5sOpt/lL+Lt0OhSEvNs3sdlYKh8AbfW9zaymHtTAGFGg/X2UeTg4Lz5V9qhzglVLYt6i6OJVDqkSOHqczQ37C95nhuVv/U9R3+dvRcS2kCwavICwQ5P8B/YR8ZT6mtOIVTT4NXZpIbaoOwgktuqVpLIFEQGd4U+ToBOU1OOIQnZdye5mWKukBLNJwecUaOq6/fNV8cu9Oh6nEhIChafB7YVtSD6Eh6b8P+a2XS0gwnV/RsTmYnVhW18Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6969
X-CodeTwo-MessageID: e31ce2f2-5204-4588-9e47-fe8213f2f3e2.20200603090045@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39840400004)(136003)(46966005)(47076004)(31696002)(16576012)(316002)(15974865002)(44832011)(16526019)(31686004)(7636003)(26005)(53546011)(83170400001)(186003)(36756003)(36916002)(6486002)(7596003)(82310400002)(508600001)(70586007)(336012)(70206006)(2906002)(4326008)(2616005)(356005)(5660300002)(8936002)(6916009)(83380400001)(956004)(8676002)(42882007)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 728dd7c4-d6fc-46fc-34da-08d8079c9816
X-Forefront-PRVS: 04238CD941
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71XO8r6RtPikIEXs6YnKlE/P5BaQpede7uaBGUfXNgvEnWXTmd9++p2fO6ffJ0QFbdUzwDjvcV78JGLXcIWRH/8UveZFanSWdyaCfqr6BJVHjEGvblcPf2i1m6ea1b8Wkl1NJGYcHJnJHtsjqHoFr6AY8DcdQ5c7epeGL5iL3b1wTlBbuWHSigoRGm1CcN+iWodWBQJN0UOZC2G1OOOf/T63exbhpxYNt2gvyA+lzjxetmptbnTPJnBgIjLdcggYQiGJ38guA3KFgN6Cb/ZGIBozBlDIkc9ZKKtBY7udviAZYoc2DfreCfPq1m18mpkDzNpzTopNPH7t5gU6Gj8QpT6BAh+PR7v6KCBQIYrLFqfx3jbw5/uwy5y5hqYW0qgzWd+j8/DxuJAeAUiDjgZvIJzHd8p4BVAMZ7xADjcvOI0jOF+lYZ8/g3korXhZn6++0bPzdh7JUPK8k6JcjMLsw7xMo7awYcUHQP9TjzUVkFQThx6F0iP3buTBx4+zaWVDlTGkIV6l5zszqBTPUFWlKUBrccM42015E+XOfhCGleQ=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 09:00:47.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540cd90b-26aa-472f-6f8a-08d8079c9b2e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2463
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
On 29-05-2020 23:08, Rob Herring wrote:
> On Fri, May 29, 2020 at 08:00:45AM +0200, Mike Looijmans wrote:
>> This enables support for VBUS on boards where the power is supplied
>> by a regulator. The regulator is enabled when the USB port enters
>> HOST mode.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> v2: Added missing "return 0;" in set_vbus method
>>
>>   .../devicetree/bindings/usb/usb-nop-xceiv.txt |  3 ++
>>   drivers/usb/phy/phy-generic.c                 | 46 ++++++++++++++++++-
>>   drivers/usb/phy/phy-generic.h                 |  2 +
>>   3 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/D=
ocumentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> index 4dc6a8ee3071..775a19fdb613 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> @@ -16,6 +16,9 @@ Optional properties:
>>  =20
>>   - vcc-supply: phandle to the regulator that provides power to the PHY.
>>  =20
>> +- vbus-supply: phandle to the regulator that provides the VBUS power fo=
r when
>> +  the device is in HOST mode.
>> +
> I'm going to say no to expanding this binding...
>
> First, there sure are a lot of controls on a NOP tranceiver.
>
> Second, unless Vbus is supplying the PHY, then this belongs in a
> connector node for which this is already supported.

Clear, I moved the implementation to the DWC3 driver and will submit a=20
new patch for that.


>
>>   - reset-gpios: Should specify the GPIO for reset.
>>  =20
>>   - vbus-detect-gpio: should specify the GPIO detecting a VBus insertion


--=20
Mike Looijmans

