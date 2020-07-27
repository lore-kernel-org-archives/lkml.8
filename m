Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39DC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61177206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="vu8SArfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgG0Lug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:50:36 -0400
Received: from mail-vi1eur05on2075.outbound.protection.outlook.com ([40.107.21.75]:41152
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbgG0Luf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMUVGi0JHY8UUOEkwQdKZF3dejzv60skuCeoQrUkmvY=;
 b=vu8SArfuLrFmU+OxAnpzN39EKRQhNNDiWI6W40Z84ELjOetAhi0SJvdv0qiPMokBNKs5UhDFf7NOyt+ptCrJKsZ22dQexvzDPe/nqqb/KG1aMdTTXgOqHaIzyxLsNPixdgLeaP1ficO4fpfpZ+dhjlH0tbDX8fx7h9RA5ugL0LA=
Received: from AM6P195CA0049.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::26)
 by AM4PR0401MB2401.eurprd04.prod.outlook.com (2603:10a6:200:47::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Mon, 27 Jul
 2020 11:50:32 +0000
Received: from HE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::37) by AM6P195CA0049.outlook.office365.com
 (2603:10a6:209:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Mon, 27 Jul 2020 11:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT023.mail.protection.outlook.com (10.152.0.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 11:50:31 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.50) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 27 Jul 2020 11:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGOJlS9TDZ4LFsRXf1/ObUr4IU2Kg/8mg4AeV9Gc5E7ntW/09z17BorWLHkAfQ90JwGRPeeUBVtyyLR55scLBH3U4U+aKubltTh+w4W8DNAtiTxZwWfMvnM3mdNDxsGx/TnPHPkxAeIFxAB1sbLWWNn5b2zp9BMf5obYO/2iVGch2Bcy6/jyDnjYtTrmZHQSx/Z8uM8hDrmUWtC+simbTsrn6LbjkLFb1yCTr1fzW9z10O5BDvUYG9tQlreMrd9Metyi1ca49Q8GSSfv4KWOTrWy9geFKF06SE7bhfTzXwzvr+QCQEBJcto47/wJk5WAVBdNZ0/X5W+VHq2Uhx4/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E44+fP3+lMlgTZV6CwA3nKz50Oz8xWuDOmPJKDZH/yo=;
 b=W1vbqZgkmsJyqJkjhVYwuB83aI4rwr+ryilIfgBd7CNnE/ISr2PzkZa3BPviS4eBgK50+4wKnzrjYDsCF9kLgm7BjWItEKSy9fcEw+fdaqhroY7QF79xJp/fSXM58PabNZL2VhFMJNDkAPmGuvd4aNwJXappAXg4OYiL25M85UT2S50WpaYHeGD6K70nIqMT8mrrGXjpui8DSMyiNJUO8WThYngcbgvW4fEybWo1ayXjy6usVCF8QCdqH52YXTkFts1S5/59b+Aw+zuXkZpoGHbgIxAEZRSkkU3aRN66EhE9zXC2q0R2IDG43bqY1QjxQfqH0WxF/vVJwI3jEEZePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB7PR04MB4044.eurprd04.prod.outlook.com (2603:10a6:5:1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 11:50:27 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 11:50:27 +0000
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
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <be4013b6-01c6-7f67-35ad-5c398b85c066@topic.nl>
Date:   Mon, 27 Jul 2020 13:50:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727102317.GA6275@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:200:89::34) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.80.121] (81.173.50.109) by AM4PR0202CA0024.eurprd02.prod.outlook.com (2603:10a6:200:89::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 11:50:26 +0000
X-Originating-IP: [81.173.50.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f653421d-072b-49d6-16f1-08d8322343e1
X-MS-TrafficTypeDiagnostic: DB7PR04MB4044:|AM4PR0401MB2401:
X-Microsoft-Antispam-PRVS: <AM4PR0401MB240138C7E550724E304A627A96720@AM4PR0401MB2401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HuotB+N5ujEcfdyHNbUpV/YooNDo31TwDJvWNBqyW7q05CPgsETVg8qkjNUyDmpUR4j95x3i5TaM/7pZucAB6SZcaL2d+SF1RPjl++WwNuJI34XQsAeYlvhwziw4zHTO35Mxaq2saRj8pUitpJjFjVDjnabnHpMatVJL2WJoqE9D22iJe4FIbwIM+1pJYNP9zvtbUEc/bctEyIhfE6ojmBxNPBz26Vw+VbvPJ33z+OOABy39mj1q3RUMPQmhJudOF/vU5Wta6BgS4d+5xmwzjUFD3kt/UtyM5c1o7iUcE+LVTLMdW/7AKdSKskrsDsMDNdwIRbGVYXRxHuXcUrfnMEZcLW5RGsanLyxNJ66vQO7Rb9VTLYbI8cj4E1gOs2TD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(366004)(39840400004)(5660300002)(316002)(16576012)(8936002)(8676002)(6486002)(6916009)(4326008)(36756003)(42882007)(44832011)(2616005)(956004)(508600001)(186003)(52116002)(4744005)(26005)(16526019)(53546011)(31696002)(66476007)(2906002)(66556008)(83170400001)(31686004)(66946007)(36916002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: o4SRiwCrTwE4CmLrekDxlTXXztCwWeo3oj1O86rKji1UHxrUqrk+O4Zlya7wuX1PguXfWr2ROyTtIAjZWSk/PX5A+ai/i+243WFJYMhfT1+GWCOW7Rz+ivn+2ayMr31L8nf+lrMNMKgDO13spmzwo1amwBmXnHgYtTHlzl7ptjzOjgRieZetZ5z73Ldt9izFVp71hA7pX85Ir4WQ5+u1L09d0QeIx0aJfuX/QOiE0EDuJGQrxIMVixI9GvwNgUiem1TsMbVW/KEKZUm+e1vaxp5azttpRUqygJdcCH88I++i4tHvUjYqhyyVya6S4LFSMNpQXnb/HU8x1riXVu0XyBbGo2X/KL0iKtCfZ30ODuaxabRvVNxPkPjpVsoP18saJ63dPv3EB88HnePK2oBs3wV0ijbec+9RH8frBzj4pjNOOdqkNjoY4NcxTKngxRlWwVe1hyeXel3WJseIAVZ6ZgXROUnyi+K9Qc4FZBHgSXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4044
X-CodeTwo-MessageID: 72434b3d-50dc-4613-9e5a-05cb7d2e10e2.20200727115029@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9ace1697-7e74-468a-4b38-08d83223412b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2iCEe4MmZiD8eVPmDGs846vumL+OvC5VPTQy1PJ5+Jl8lhwv994KydykgWw0iPOOCLebb3fkQj2lASrBKRUObe3QilwVcK2NFfy2oNte0VLN+UxQPUYxBUzdgo1AUKtr4FxrLdYNIzZ2nYJKCfYFRJZbTncB9hbjPGFLJOFkIoPyGfEnUQOr8HWX1IB/cbkVzw4DybJuNeNSKK7fOerWuE2iYlrNLIh0eBCJVs132a9k8XhN6Tk1yT3gVoekoU/BIIl0EVylJIJvgm0M31aZGdNgX9g/126W2SmiNk2PG84bbhlAqXxq1yizOGBNO3frytyJEo+i/OLMxhDdSR+1CBNOhFDGGNsAsf9YvDn6rumHlSxY4ACYajKen1L4OVNUnURaVv1YPbHgLEheW/lN2jCOZ3RJ0hn03NhdU4Bc9LfKkqdqubMeK4XhS3d/xz2Sk8aZdNRWWRAkEBxw9+7VzU2zgFzdd167JPdADcCcVOduufldfNPIr1tG8vuznamh
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(136003)(39840400004)(46966005)(316002)(4326008)(36916002)(31696002)(15974865002)(8936002)(16576012)(7636003)(7596003)(47076004)(83170400001)(356005)(82310400002)(31686004)(508600001)(2906002)(2616005)(186003)(16526019)(53546011)(70586007)(70206006)(36756003)(42882007)(26005)(8676002)(44832011)(336012)(6916009)(5660300002)(956004)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 11:50:31.4705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f653421d-072b-49d6-16f1-08d8322343e1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2401
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
On 27-07-2020 12:23, Mark Brown wrote:
> On Sun, Jul 26, 2020 at 09:10:39AM +0200, Mike Looijmans wrote:
>> On 23-07-2020 13:05, Mark Brown wrote:
>=20
>>> Does the device actually support running without power so that's a thin=
g
>>> that can happen?  _get_optional() should only ever be used for supplies
>>> that may be physically absent.
>=20
>> It's the 5V VBUS power for the USB "plug" that's being controlled here. =
It
>> must turned on when the controller is in "host" mode. Some boards arrang=
e
>> this in hardware through the PHY, and some just don't have any control a=
t
>> all and have it permanently on or off. On a board where the 5V is contro=
lled
>> using a GPIO line or an I2C chip, this patch is required to make it work=
.
>=20
> That sounds like the driver should not be using _get_optional() then.
>=20

Making it mandatory would break most (read: all except Topic's) existing=20
boards as they won't have it in their devicetree. I'm perfectly okay with=20
that, but others might disagree.

