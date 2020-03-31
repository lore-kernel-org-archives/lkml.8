Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CE7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EC82072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="ROkgmOBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCaS4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:56:55 -0400
Received: from mail-eopbgr80133.outbound.protection.outlook.com ([40.107.8.133]:64534
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgCaS4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:56:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GryuARC6WEwfPWGvK/HYOcfDmBzhT90CmVK61iJ38d/jkJkG5CjHMfIgQ9PU4YdQ1CayKuZtn7zOBiw044HXNe8LXDGDA82pk9DGW24WFVnjvUQhk5NVVKYNZzWcwD0IZWFL1TzmFkkd2V3XsE3TrIugvuq0IcOCAKghVYDpwI/Vh6j9vLWPko3wF4hzIBvMJgEoQpzfw8iER5gfUWlouRjbSo50kE2JIOcMuuM2J3IpsPUHyCyWSVnNihs6AyYF7eyGZTVWw/qEYi+yb+pwn1Mh4yRnF6ZOLX0YWzgHkCER/oAlp2+c9Lg86ZgMuCtmaOgKuMEKSZAGbAsXoTYRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0sEbtWBleY6lf+7u0Z1p8PRRvba6Dh3Dg/R2UrtjdA=;
 b=DpBMFQY0DWvShxPREymZFh2Jp1lBbykxM0p3+Amgqx4/Vjg3xX4Kw2Uk7ePVf79baRLTFtsVhICWZ2NfIM6x7Psicj74MZ4i/h93MU4ASdoCnl7UbODvWOJNjDXDLYzv0lDBSoXTFqBk1DFntxmkR2HxZ4sadeYLxtYr3QQRbbyfsXpZmOTmpQAg9QIJX5/tg5xVr/mvTMnzw+w8ZsXl4l84NXYWf4Le3uqRN7cp4JNJfMaidSQXOIlHervYtNC781c+SaiglrZHHYWNW5LA8CDBV873lBlypUzDhnAxmawccAfZV6UxhPRS58s/aT5fI930yiUQofpyfGQAdXDHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0sEbtWBleY6lf+7u0Z1p8PRRvba6Dh3Dg/R2UrtjdA=;
 b=ROkgmOBv6U976wd5F5ge58kZmOTlmUqNaCsXN7qcc8iaJWkL0TFrjxNhdwFP9axghWixB1Krf6DuWjg3gAzxnGsgrw6svdllCwFIDQvPDYp/AcObVNJVREvaUeuf0UR8nK+TvDPvHRLwU8g7iQUhgNVH4gckg7lvA2ihVgsT1xs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rasmus.villemoes@prevas.dk; 
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
 VI1PR10MB1837.EURPRD10.PROD.OUTLOOK.COM (10.165.195.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 18:56:51 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7%5]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 18:56:51 +0000
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Joe Perches <joe@perches.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
 <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
Date:   Tue, 31 Mar 2020 20:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0054.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::31) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM6P191CA0054.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Tue, 31 Mar 2020 18:56:50 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8fa453-f5d8-4a8d-8d15-08d7d5a54597
X-MS-TrafficTypeDiagnostic: VI1PR10MB1837:
X-Microsoft-Antispam-PRVS: <VI1PR10MB183798126FAE38CE3FF60D5B93C80@VI1PR10MB1837.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(366004)(396003)(346002)(39850400004)(136003)(54906003)(316002)(110136005)(86362001)(16526019)(478600001)(44832011)(956004)(186003)(66476007)(26005)(31696002)(66946007)(66556008)(31686004)(2616005)(4326008)(4744005)(2906002)(8676002)(16576012)(5660300002)(36756003)(6486002)(8936002)(81166006)(81156014)(8976002)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NBLE4605JJWO0X3QxGiejYnnvwX0YBHHBew345k1lylQ77Wv7VgFIirzPliPdegIOv+r+fN+ftOl6KKsZA2FucwraXDqi33Tu0N8tQ50iKShiZ8IEX/2EFv/70FrbnkKmMac+wiqNPmlei15j1D4Uz+n4afW5PaiweaD1qkA9bUQK+viSj+0zDiOGJHYO6XvQNw6Eeg27IB/1z+Ob7mUnEuDuGf5JqMvou8E58ZQNrK4G2Tmpt9pvryVT07nNhfPWSma4WE09YDkZafHpu6XsHP3yHG2DB4hFujBsZhoOgVkXvGJ1lHZI0SttDi1q8in3tPk37ZP2ttTnRqxEE74Ncj0QvkWu2Jtzj+0cq8b/mZe1NVAQEkg9Id8WzlOqfcKqDaVERcNBCheEB6KPJ04bpl68RKaI79PxfmQBxI+z42XNdgC+7+so6LB2G12kWP
X-MS-Exchange-AntiSpam-MessageData: shhP9JW+g3lUB+VTWvN8zG78579USA5uBHzsXB8ff6FB7EZ0rsHhVOo1cTQzZfTx0pdrzFFGz+KgPyKpslArWSk7BMT3s7GM7fvdudwtLs2Bi3WF0yYMOY5y9yxe05gJgvsA0T0KxPlmQzQd+DSyjQ==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8fa453-f5d8-4a8d-8d15-08d7d5a54597
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 18:56:51.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM55+/LZHLMzdDsAuB12uBPhe0SVDCx3Dnl8jDAhjHbKnMewpTQbYZCPCvaQO+fCGTUZXSRY0Nh+/cFMnhwhi40XBtmy0VZBLIHuv4Wt4pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2020 20.20, Joe Perches wrote:
> On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:

>>  #define compiletime_assert(condition, msg) \
>> -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 
> This might be better using something like __LINE__ ## _ ## __COUNTER__
> 
> as line # is somewhat useful to identify the specific assert in a file.
> 

Eh, if the assert fires, doesn't the compiler's diagnostics already
contain all kinds of location information?

Rasmus
