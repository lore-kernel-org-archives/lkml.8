Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B77C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B07920888
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="z79SRsJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFQOi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:38:26 -0400
Received: from mail-am6eur05on2066.outbound.protection.outlook.com ([40.107.22.66]:9345
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgFQOiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+Aoo1Q95KsQdYv5kDTMHcirJTH6+N/5kN7Ksgg5JSQ=;
 b=z79SRsJg7cz4E0GGeW+jrhJ2c7TAUllwrFrAuIK9JvQshut1LzkdyYywnONgDtLt5v+vnwvBOe7m/eqMtEw58RreqKjFCl+Hha4i0Z6IT/rGisTEPW47JFEtLKrMQ87npXqGSkujU7MaGb1NJVWgOaSJrBlhdKy0WxLVXxL7LsY=
Received: from MRXP264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::24)
 by AM0PR04MB4050.eurprd04.prod.outlook.com (2603:10a6:208:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Wed, 17 Jun
 2020 14:38:16 +0000
Received: from VE1EUR01FT028.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:500:14:cafe::45) by MRXP264CA0036.outlook.office365.com
 (2603:10a6:500:14::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Wed, 17 Jun 2020 14:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 VE1EUR01FT028.mail.protection.outlook.com (10.152.2.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 14:38:15 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (104.47.9.59) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 17 Jun 2020 14:38:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtJn6C8pEo6jXF8k3aLiBI9h/C4Ec7EGNnsxVssQU51Lp3jMEAXKIAHnNNXU5C3TgDRZB+e51ji0XeJYwLH7Mnz4MLHJptQNZMREqWteDo+QXeiTtQH3p0S4o04YOMU0oDKFE+/I1w/je67kK1/CRWI1uGDFF1M89U0GzPr6V7vB58qg+tNelHJKJmyr0t5WwlRI2JaEiXDM41KhrxZ3F/UOjyHtPvmj3ccqrvF6/ojxlCWKqp0kTMeUl+ASlW5jpEiBy4hQ7bOk+lHcEqbobXHMBRQJ8v/LkE+DLX/St9VmSMVbRxdaGnSi2jUaSx15grrtCfC//MoYnK/OglNotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXG+P7BgxlVPq69xYWgJel3gIu1Ik0j6T56E+lP9zM0=;
 b=b53xMj6jGTFaONOwzceFVb3ZE4KYpxlmj9aIE4dSlH+HMye8HsjBi6eEYFZxEV05UCSw2c1rg/+upedG/ZpTKPjG9Mi3B3cRHmY5ZVOANp6TyI99VlNY40/Onx1sE5fUl6as00RR+b9ksD5YWboljLAdwJKkqUysDgiKu/hTmhc8KuTfiDJImq3cyi8ppowbun6/jesvPPepT32CYNUeuJwugMxfvsLD/gM1ZPi6UfhfIsyCb6LtPZDdZmiN2hTGJc5tRhZ6UJwOI7h1VVq1fbvspahz/kxCB2y9iOQpA+AAJasgK7hqUfGN7Rel+D/XBadiTHPdHciSAaVeRB8jUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB7099.eurprd04.prod.outlook.com (2603:10a6:10:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 14:38:12 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 14:38:12 +0000
Subject: Re: [PATCH v2] usb: dwc3: Add support for VBUS power control
To:     Rob Herring <robh@kernel.org>
CC:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org
References: <20200603120915.14001-1-mike.looijmans@topic.nl>
 <20200610202255.GA3646369@bogus>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37aec1ae-7fee-44cb-ae24-a10a151abcb3@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.3fedbcf4-0977-416b-9979-d557fd9233a7@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <504080a1-cbc9-f781-04bb-12d5679ba697@topic.nl>
Date:   Wed, 17 Jun 2020 16:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200610202255.GA3646369@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:208:154::28) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR02CA0087.eurprd02.prod.outlook.com (2603:10a6:208:154::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 14:38:12 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fea30eb4-e12e-4483-32c2-08d812cc1223
X-MS-TrafficTypeDiagnostic: DB8PR04MB7099:|AM0PR04MB4050:
X-Microsoft-Antispam-PRVS: <AM0PR04MB405090B4E80134299846D2EA969A0@AM0PR04MB4050.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MpWOrZgfOgpRKQgn+7AxK8vXEU4QMt2qc7xg1hA+7teDsaAZ3S0UL72TZsBvwgd1IswThpChN3jKN/T1GK2jifmAQdb3km5Bu/s+EZl42GYeivWekGK4WA5FCLs4hXhPuS44LccA5BbDErqFU+WXhX+qJLMiyhTWwZNfnNUgSB5ab67blx/7mHbnLfuJ6VmuhubAyS7ZRcOpP11DPb73VTmh9dkDF6YYSfdd7punSqJV6/jwfa5Y4Oti+CWG4IhFY/9cxrZEsaqWhromgMS/kEDNxtZdmyQoWbYsAFdLc7psjG1pcJFgZwo0sftKua2cQ56/s0g6YTlTszgMJNZ79kxQbfdFdyUxeN612bj8SY0hzol5oNgqdmbIztmhdohT
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(366004)(376002)(136003)(39840400004)(5660300002)(53546011)(316002)(16576012)(26005)(42882007)(83380400001)(2906002)(2616005)(508600001)(8936002)(36756003)(44832011)(31696002)(6486002)(8676002)(66946007)(36916002)(52116002)(186003)(16526019)(83170400001)(4326008)(956004)(66476007)(31686004)(6916009)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: psikNakrHD1JQGy6Pui9EInVpOzF/9UNFPnPuNxkXxS2tfBKP980uT2HcIjtl1A9UB1qfZDeQ4+B4ohWcaxB+0zgySko/gMRTId6rQA9ZQzZcPZ5jdeX/XDgk2Yl7fGrOL/UMWbASMnUf3yLWaw4S73hvnbFcu+q1Qa1B5obh6+FV0rUX5rdBWGMqIlyfUVVOrOCyeg+ZFpyy5aCv9ec9IUnwugARlVNlo6tMdLHyWL2roPLUWtNJUK4mG9qgDwKp9H7QV+hn9ClfPrDP6eLWA0lIB/fWb20sU/DX8rvAbTSBtkSc/cfsO1D5WnDfgKdtssf34i1K60NyPmluBZih/gzCDPO/Cu6LXN+dw2PmHtlq4nCAr57gup9WxJ8ZpDSu9JNkXGsxZpjA8qxonB3urMwxiT9JX5EAjdAVyrsyWt47sfToW4/A1hniB0jZlWr4Ydt6qsKgI6+557XTNaZkfnPqfhFLYE50Wocmcyudpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7099
X-CodeTwo-MessageID: 00a1bbec-31c0-4c1f-94cc-b384fabd0a86.20200617143814@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT028.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(376002)(39840400004)(346002)(396003)(136003)(46966005)(2906002)(8676002)(956004)(70206006)(8936002)(36756003)(2616005)(70586007)(16576012)(36916002)(316002)(6486002)(508600001)(26005)(5660300002)(16526019)(44832011)(7596003)(336012)(47076004)(83380400001)(4326008)(31686004)(356005)(83170400001)(82310400002)(15974865002)(186003)(7636003)(6916009)(31696002)(42882007)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a913330e-4771-40dd-0f07-08d812cc101c
X-Forefront-PRVS: 04371797A5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 648JtfLt7qD7LGWfWt47mghP38o7W55cA2Mj2QpWURDwemqVMnz9UEublvJ7yUU77noNCmOVBS0PLsQsKKp8QNlILwze7tKuPdyQopZvf44vBpjLN3/BiPR4Kpnr3KqxTC7BKhvGrHf5IhfuuCXFBzh+3bTr2z/tUs6gkJdhMCKfSmtH1KjuT1P7rk/0Rv3hVi6EiFplr9oxPKzUtQ52FZQl8/MHoxaWqdghPsMOiIUSy/AVgIzFg1qQWZlv4MU7kmJa+SWwMsYAzzYDwVXxJJi+qjJU1V/AY+0XHDOAbsWxoKs0igBxT8lS9it15a187JPgdqhrXVMKm4FCMxHloWVd52ptfNs1XRAmFhhIy4f3/FhjzUQBmGVMqkXlvTZjXV5eUBbZ6d+Mz6kI1Fzde547Q3MCH6Bt4LDPN25eVhFQccY3SqTfUv6NGyk4qk6gvy4HpjpcaORNp3eI41l4G2dnlog9BbFk5s5T6G1DgGLfQ+zV19TYMdDRmj0QfUXP
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 14:38:15.7831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea30eb4-e12e-4483-32c2-08d812cc1223
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4050
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

Okay, I've been digging into that. But there's no actual driver that=20
binds to a "usb-b-connector" compatible, so how do we get to the=20
vbus-supply from there?

[devm_]regulator_get only accepts a device as argument, and will not=20
look into child nodes. The only way to get at the vbus of a child node=20
(or a node linked through a port) would be to hand-code the equivalent=20
of of_regulator_get(), which will not be acceptable.

Or is it the intention that I write a usb-X-connector device driver=20
first that handles the vbus?

--=20
Mike Looijmans

