Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1B3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF4520787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390404AbgDCHiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:38:51 -0400
Received: from mail-oln040092067020.outbound.protection.outlook.com ([40.92.67.20]:33927
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388221AbgDCHiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:38:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irp0WlbdpAQvD0gnpW+P5b0THSi5GLZU4C67o9zfEKhIcP6mvUwMFpf6BHtyl5esc46ofqFrdExlQ64tvSi9ewEAr9JrXCb3lXSQAAcJaSYneQZ68c8tDfxTKY0Foko4vlKsGbZEFEGWBtrqVkGgsl+eq9ANzexW14KWa6Cn9mQaFEcHczhx/Pkq0gYnSc48uGVvJZVDxhB3laOCbxy8SNco4S16b/Ihqs3Y4k8A9jwiuG8+U0oR2eZJvPudubdHPccQ8oyp9rX4QhCXaZMzxzBgQpzbYVJ8Uz/HP3T7qzFG3kZ7BHfurpTNFmREMIGwVlasazcafghoSiJ0M68oQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdL0oINgMpyL2XDYh7B+qtSgM9qyH/fWnoXsMnfyiNE=;
 b=MlSvoFJEtzSw41E4YMDDZO7d2VjxiyT3nggrhO3ZSsPrV9bKiVlR0CNv+A4svvsoiXICx3Os+PoZQr1V9oufG9Ej6JLt618HbnPfrVgDrzqRv2Y64t2UmLeMDYl37sj+fe40GCo2EWws22rNDeblSn1HuGqMSOqSU6RbMRLo+7FUJSm/EOjq/o9sU8fXS3riE124eM4Xx6JkQiyBnT1xqgJER71/QHxhG6UcpN3LlvM1jF4I+yi6N6xYRChABDx7vbWZ7koKfhoA+lD9k2XBdT3Go55evvLnQ4actCTjr/Bk7w8DmIhUbZc4R7stO/SSo/awTervo1YznUiOcf71GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM5EUR02FT048.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1c::41) by
 AM5EUR02HT188.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1c::376)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 07:38:47 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e1c::4f) by AM5EUR02FT048.mail.protection.outlook.com
 (2a01:111:e400:7e1c::471) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 07:38:47 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C96205A4332D25A3A8CD48FCD8B645B18E645BDC83FFFC6A288B2D18B3C00F09;UpperCasedChecksum:339D430CF09861DC50DCA372DA1C9C9A9AD22632FDA05D36784255612A6E7A23;SizeAsReceived:9309;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 07:38:47 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517070AD3BEFB0E0D0490F3FE4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 09:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0063.eurprd05.prod.outlook.com
 (2603:10a6:200:68::31) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <2f53e53f-382f-ba13-3b88-8c5e90c6d136@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM4PR0501CA0063.eurprd05.prod.outlook.com (2603:10a6:200:68::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Fri, 3 Apr 2020 07:38:46 +0000
X-Microsoft-Original-Message-ID: <2f53e53f-382f-ba13-3b88-8c5e90c6d136@hotmail.de>
X-TMN:  [alHq6C0dLHqMP7Gzwztz4jdV8DEQmEqY]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 7a85b9b2-6716-482d-af96-08d7d7a20b33
X-MS-TrafficTypeDiagnostic: AM5EUR02HT188:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmlG1J5+GnyXSWKiQH93HyOHl46zaq+0Z8C7hpnnLsFolNe9IAOJLAE7LeRwbAK3dxKyKDek8wSVMQueznZrk9xj+7dEiaItsCpJ+E69QC7uJPmY8qjS5WyzYyr0WDbMmjZ48REZAdI/PnnM4VcxBelZdgH9r6xlFuGBcpdcIHfvZY+4/ZcvDSElIHyKEQ6QG5JbtJHPDsGbGPGWs+qKvFOi2mbck/A2fXZLsBnfzHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: /SqbYuaP4lGmhV58qBoTlbgbtkuXSofikUTcTMGCZNSDyaj6gX94sGQFizlLmlzjNGBoXlFrknSftpfJKSkyBu+yENzUk+5ykhiZUqpWwhxxcvf7BKbfbfaKR4fA056YYvRHmo1EZ8FW/spwiYI0Cg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a85b9b2-6716-482d-af96-08d7d7a20b33
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 07:38:47.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 11:46 PM, Linus Torvalds wrote:
> On Thu, Apr 2, 2020 at 2:00 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> There are two more patches, which might be of interest for you, just to
>> make the picture complete.
>> It is not clear if we go that way, or if Eric has a yet better idea.
>>
>> [PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
>> https://www.spinics.net/lists/kernel/msg3459067.html
> 
> There is no way I would ever take that patch.
> 
> The amount of confusion in that patch is not acceptable. Randomly
> unlocking the new lock?
> 
> That code makes everything worse, it's completely incomprehensible,
> the locking rules make no sense ahwt-so-ever.
> 
> I'm seriously starting to feel like I should not have pulled this
> code, because the future looks _worse_ than what we used to have.
> 

No problem, sometimes they say the cure is worse than the disease,
and I would not rule out the possibility that this is also
an example for that.

My initial proposal was much smaller and probably more on the issue,
but in peer review it turned out that we want to solve the problem
from ground up.  Otherwise I saw no possibility how to get it approved.
That forced me in that direction that this took.

I just try to help with that.  But I do not insist in a specific
direction (-:

This is what I initially proposed:

[PATCH] exec: Fix a deadlock in ptrace
https://lore.kernel.org/lkml/AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com/


Thanks
Bernd.

> No. No no no. Eric, this is not an acceptable direction.
> 
>              Linus
> 
