Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C58CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211692070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="IMydnnMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgG1H3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:29:52 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:35045
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgG1H3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERrw/ERRX6GqUktE8zR7RjWaEC5oC0smQHdYj4mSsog=;
 b=IMydnnMlIoIX+blgKEq+ln6c2mvBPhuHrt4EFdjqJ3G0G/QfMN5KtF7f/+ri7+whrU9emEoo4bGoL/AQGJqRd0k/PbxHN04oO7ZZdsCfDre07YATBtVZyJNl0IiQMDBZaE0jiTj9zBOAk1C0Cfcp5APum2jPs0Gl29hAbRMad7w=
Received: from AM6PR02CA0016.eurprd02.prod.outlook.com (2603:10a6:20b:6e::29)
 by DB7PR04MB4011.eurprd04.prod.outlook.com (2603:10a6:5:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.27; Tue, 28 Jul
 2020 07:29:46 +0000
Received: from VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::11) by AM6PR02CA0016.outlook.office365.com
 (2603:10a6:20b:6e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Tue, 28 Jul 2020 07:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 VE1EUR01FT011.mail.protection.outlook.com (10.152.2.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 07:29:45 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.58) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 Jul 2020 07:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaiAV/KJh7p7KCtiqRQmMkcDxX5LXvH1YDY+73h48Fg0hSr/ByPPpvawuqP8aS+towDJo2bjPr3Tj7sIFZq+ZqnQvp8OVfOkN+NKPCd9LcwDgwb9+XupaBcaoB0vvx5Vbbb9r2N17Ithdi+v6jr3XX+j3AAlrfDPCej6Cv6J+h1dQAYlFqbJGyOl3SEpjj2KKYhA0iWlyaNGrVGdwApEM7Eeml6QKB8oQlMnTl40m3UWhzhu11xa/is4/azNphcIzy7ihDHhap5QctsU8ZAVbk1p9kdXXXqdqMzM/0ShjRnFfgzAXVwlfNobbi/LZ1tEK+uR3iZCz/XKwYNZLKyVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKSzCnvVUirOmJ0X2In/ryIVeYE7P2iuSMBTpzALAl0=;
 b=CdIlFtd+T87s0UQK5MPXpPWzMktoy7EITgU3ic/i02pqEYlYPuxYZxz74KwyeN0PzsOXY6wPOZ54OthV2BJqaSRDaeWmerq/drHM6+rug2ilnljC0maZX8Kp+ZOxMH3Yts4KuKypdXYcRlYAIX9L8tjugB0D5+5J1ACdvf+DlXSKU9b6HEnCrCpURVgdfvOJGojUyelZ2lFMQRODFIJvGgdysBYbI8C/uJ3wk1aa/sFJzLjNziE/cgm4wyXHLOxNnbk7FSOaKojTmG0hVr+azIyXPnNgZ756Vfs8qoXrmauVF25Oa4m8PmRuIrMc8d+3AXOTnD8WmCNShtGwbsdk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB7PR04MB5948.eurprd04.prod.outlook.com (2603:10a6:10:8b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 07:29:40 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 07:29:40 +0000
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
To:     Mark Brown <broonie@kernel.org>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
 <20200723075612.tn5dbkhes2chohwh@axis.com>
 <20200723110523.GA4759@sirena.org.uk>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2698920d-90ba-4c46-abda-83e18e2093c8@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.ac9c2a67-d7df-4f70-81b3-db983bbfb4db@emailsignatures365.codetwo.com>
 <e63ee918-c9e3-a8ee-e7c5-577b5a3e09be@topic.nl>
 <20200727102317.GA6275@sirena.org.uk>
 <be4013b6-01c6-7f67-35ad-5c398b85c066@topic.nl>
 <20200727115321.GC6275@sirena.org.uk>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <a6821b3d-4034-8399-af5e-1b9de0493eac@topic.nl>
Date:   Tue, 28 Jul 2020 09:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727115321.GC6275@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:208:55::39) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.80.121] (81.173.50.109) by AM0PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:208:55::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 07:29:39 +0000
X-Originating-IP: [81.173.50.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9954c789-4145-49f7-14f0-08d832c800a0
X-MS-TrafficTypeDiagnostic: DB7PR04MB5948:|DB7PR04MB4011:
X-Microsoft-Antispam-PRVS: <DB7PR04MB401190D80C55D1D73935F9AE96730@DB7PR04MB4011.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /jjaBcYXhX/hWyB+S1kuSLJ22lZpVzuv+26qYMW+6netNGscGReatyoSWMKx1WYXipAZTYpTVohYqbGX92wWHewg3ZMgIgpjjKVq4/UZd7KsoZVoLbNVwspvi38hsGAksrGRBjxnHFNpqddJLwDuQ/V7SFavKPuF5KfdXO+Y+dYmZmSAchlR3DqzdozlzLgexGlZ+LDliPQekhl0HhPz1tavss+7BMOi6ZCnDOINBVh4zPbZpX6FAYeRjidnOb08SZG0GoLAo4omdLvzUUFQB9AtMKanzwcP2uT6LKDsj9eEdn2WjKIB5NWyNzCn7btxauIgoWJSFxcvpCCIlPSCB1DYQDrxpACQ1pnOSdg8Q9LtfYKTa+Or6vv4jdkyBAYy
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(376002)(396003)(346002)(39840400004)(31696002)(508600001)(16526019)(53546011)(186003)(8936002)(52116002)(4326008)(5660300002)(31686004)(36916002)(8676002)(6916009)(16576012)(956004)(316002)(42882007)(36756003)(66946007)(6486002)(2616005)(83170400001)(66556008)(26005)(66476007)(44832011)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lTdQqcEEUMJ81mRtDlLi9NU+/p0PxuorxtvxtrbX33TAyPU1UhfpD2GqpjJcWkFa+TugoeMnx8pqXjMhcutDlIUqFaP9FUjPctW8tvgxtEYPvyqyQHgpOrrXwxZbe/xQmc2Do9M5CTXGy9Gnd5DqLE6nmD01hHADUBAs1hoB6uH7VuEso/q5g4UtuLAHXZw8sNRoGVmL0Tleo7mrqCX7L93pGbXcEgG7+3BIhdZfwzQKkTqeVLfm1460LfS2z0gHSXPacLPNQRmeEW5MJ6uA7lGpTKWZuc2Rhcln7H6WS+1FJNrZkRmKoxb0RvPelZ8oUxHXI96BmjQlHlMZH0afVQtBjlZefGX1Jo9C66KtlBLYomM/YTzk5PGRIp3ziar2TyKX/R5EhZobySy1Ez4fgmm6tHwM5eJ4whY7ZYt/pQ/xtSdFlALKwnhpE4ZoIaunbddYSCq/60sTK3jTCLwIqnUnQAf9Ljq8EADbXcYdho0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5948
X-CodeTwo-MessageID: 44c138dc-bc32-4824-95dc-b07d307b4caf.20200728072943@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b9b91c9b-0f83-4aa9-7cfb-08d832c7fd4a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6t5vmRtgSSB712MrQ6RK4zfHlUMc1LBTFKPDQ5HW8eHiD3tYZg/lV3Is/NYkucxZYoJ3U8oVzh0tiIP9ZKg3ArBEYXjcCcAEeiSO6QKd/q4345c7iJ747z8I+1GnLyIW5UMrB+dt70fgkDaVBSzlrVDkkureI+PrGPqqnt9DGQctOffEjoU2kdAkVvi5ePkreXmPVgngWTwhQpV3kN6DxH/n3ztKZ3g1+YtIQMauztVYBG7bZxnhkc+XHrz4fPgWW1PZOd1Q37xIA2opE5mUerHCQAev9Uu+mShlNxzAzJhtxiRx74VzTHinTKBrkUNqRg4OsDfpiOM5OXkC2e4ul8cLJ8LUXNAfxgandfRW+a7vzGU+YgmI40q2flJDLc9HOPDJ5qgv4OcaeuyjbasfyCq1dWZ5nODWKYwkkEzcjaWM59bkV4GEuBUzAOk57div9X2BSAOKMmZwCYKxdfWSs3yiFaRIAmwGYKbFg2Rv288+DS+/sFzrKcGHrzVAInwX
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(136003)(346002)(396003)(39840400004)(376002)(46966005)(42882007)(36916002)(15974865002)(53546011)(4326008)(316002)(5660300002)(31696002)(2906002)(508600001)(6916009)(36756003)(44832011)(356005)(7636003)(31686004)(186003)(7596003)(70206006)(956004)(2616005)(8936002)(6486002)(26005)(8676002)(47076004)(83170400001)(16576012)(82310400002)(336012)(70586007)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:29:45.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9954c789-4145-49f7-14f0-08d832c800a0
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4011
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
On 27-07-2020 13:53, Mark Brown wrote:
> On Mon, Jul 27, 2020 at 01:50:26PM +0200, Mike Looijmans wrote:
>>
>> Met vriendelijke groet / kind regards,
>>
>> Mike Looijmans
>> System Expert
>=20
> You probably want to remove your signature when replying to the list...
>=20
>> On 27-07-2020 12:23, Mark Brown wrote:
>>> On Sun, Jul 26, 2020 at 09:10:39AM +0200, Mike Looijmans wrote:
>=20
>>>> It's the 5V VBUS power for the USB "plug" that's being controlled here=
. It
>>>> must turned on when the controller is in "host" mode. Some boards arra=
nge
>>>> this in hardware through the PHY, and some just don't have any control=
 at
>>>> all and have it permanently on or off. On a board where the 5V is cont=
rolled
>>>> using a GPIO line or an I2C chip, this patch is required to make it wo=
rk.
>=20
>>> That sounds like the driver should not be using _get_optional() then.
>=20
>> Making it mandatory would break most (read: all except Topic's) existing
>> boards as they won't have it in their devicetree. I'm perfectly okay wit=
h
>> that, but others might disagree.
>=20
> No, it wouldn't break them at all - they'd get a dummy regulator
> provided.
>=20

Ah, so *not* using _get_optional will yield the behaviour that I'd want. I'=
ll=20
test and make a v4 patch.
