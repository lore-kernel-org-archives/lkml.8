Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3E2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23882072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390287AbgDBXt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:49:26 -0400
Received: from mail-oln040092073094.outbound.protection.outlook.com ([40.92.73.94]:48386
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390216AbgDBXtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf0HQWF5/HqxTQ+f8aG7qUaV/XKuH/ms/sibQFY8NG9mkzJvnLOXi/BGfxsGoJhq8drNlvrmQfZx0ejwpUta5ZpPe3sQxkS4UFlo5Xt+8tiyubH3KAeSFliIvnRB2xi8tz+pfZ/dq3r8LBTURHY+pgpTatJCAxXso+3+Dk+fRC+E2o1pnLbAGDtSrQQGfYvQQizMmXcZSmRlcKfpPti3adnB2IyNhqe7LY7kII0UPQOORlp6VH+GLQfPJJlgPvucCDMQgEEobMbnjPsCiP1ehKxzpCU6QLQMwlYxehI5xZkBgHR9T/gr94sPU8R+Z9oSlC61kygrfFHjhe6B6VUYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY84njDj/RyO/cqdvi8oKiQK49ryfUSwpEjZ0bmI6MI=;
 b=IcKdPkZcJIFovHDp0tMBzk4/E8wuf42jqEKdLxOvxkdwCK4TkrGuoiahF4pOXeo5gvLfljqe/GXtdjIMzbecIMkO8Q7pHJBeQBx1koaCbDEi9pi6jDr/WPl+iveEfMOuOVQuiZJ0MDSaf3b1sAErmjvOX07Hwydpd5bf+Pdee/Gryg9UP1mGdeA/988AUvcfh/Uzw74nhLled6ujLPAzKC1+qu8SeSFiN0RlU/UV7cSFHjekecdAuSwPwCkgPDyigvXSzdp6BSblcgJNsSs8nTTPtr12R/Qyn8v2ZQsfITzbhCQBa9d/51tZPch1iMh4qtWnDv/qU5uLH/7A7nxA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR04FT060.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::47) by
 VI1EUR04HT124.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::119)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 23:49:21 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0e::53) by VI1EUR04FT060.mail.protection.outlook.com
 (2a01:111:e400:7e0e::354) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 23:49:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4E4295300501C160FC6C32515F8AB41C6C2DE99D6C43341B4B5011D49B95B6E5;UpperCasedChecksum:5993509586306BF2F6EFF6424B90CAC3C9AB00D54768AF331528D56B803B143C;SizeAsReceived:8581;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 23:49:21 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51702497FDBDA78921515562E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87a73ta1vj.fsf@x220.int.ebiederm.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517093529994AAE481255755E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 01:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <87a73ta1vj.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12)
 To AM6PR03MB5170.eurprd03.prod.outlook.com (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <e4a35c17-3649-addf-e643-b8154df6ac10@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 23:49:20 +0000
X-Microsoft-Original-Message-ID: <e4a35c17-3649-addf-e643-b8154df6ac10@hotmail.de>
X-TMN:  [wrMC4VJMLd5+k6FKtQQFeEYh+sC646Ko]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: b4f60b32-8625-44fd-5a18-08d7d76076e2
X-MS-TrafficTypeDiagnostic: VI1EUR04HT124:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iY/B7S4UamdvSW7EF1tMEo/B2MA7+SjBjXKRiMaA/3JIGUeDv84pLNVOmbfdhotIVu6uab0mIZ/slAdFIMz00coUAZ9lgQS7KNvHqDcBPzhJXjHCDuAsz8ZhL0191o+m9i4Wklz57QLQwvvaCkLzfoupgNRL48UC6bcFhqNGz7oPv/7hbGuYODsub0IirCJB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: R5S3PWlqDZeiHP+3NaAceSHEfpC+tJvznJDcNEsMraASp1ptHA5X0/clDuDAWVIKPnAUc1UzhrKC0UJjuSF/UbV0Ca2iExTqeauU4iUQovChBKoSQOEFQvOahuqqlQjt3HFhljWeFA959iQ2e10H5Q==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f60b32-8625-44fd-5a18-08d7d76076e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 23:49:21.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 1:45 AM, Eric W. Biederman wrote:
> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
> 
>> oh, sorry for that, that was requested in the peer review, I could not
>> get a patch approved that does not have such a boolean, that simplified
>> the error handling.
> 
> If you had included a note in your changlog when you respun my patch I
> probably would have realized what you had done I would have spotted it
> faster.
> 

Yeah, mistakes happen.

> When I glanced at the patch quickly I thought you had just added the
> missing unlock.
> 
> Eric
> 
