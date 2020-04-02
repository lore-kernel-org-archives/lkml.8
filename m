Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D13C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183562073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbgDBXWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:22:53 -0400
Received: from mail-vi1eur05olkn2101.outbound.protection.outlook.com ([40.92.90.101]:2291
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388709AbgDBXWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:22:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzghrghjffnMw1D4lkSg0RNnGHAm0iLmZK2RvPA7wwgOHcAfUzPOyKWFUZKXu2NcgAQNjvs0ux+Jwz74ThpYARZrcTosNWA+aCmG64z3zluldWbp3C9vc8Djr0u/+0UdelVV9AGieiPjDUwvVzF6mPHj098JqmxHd+GKfgk5MDWN3koCsyTWzyRnbEpGgj9eP+J9hFuUu4OFAcRqyWM3iVeu1HikKQFA9Af92Gmg/mpENI49GJdzlyGZY5/wzCJUO2LQL/9aURJllj212yAm5MnBCNPuNS0stURuO2YSe8K16aQ1Dlw935Dnp53SES2zB3fwrHzkAFggJiV/5570bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxsEYSqW2TGSYculNuoGCEoXOdhao4LdWgkE7dqqPKI=;
 b=SPcugKB1pw9Y6Avt4UhMa3RCJFY9Q/ynFYA5QfF6zYDu+2m340djw6pNZgsP7MC0MbUsTxyffG76pUPLBvJQkHemsrA/8YPFXuNc8tJP1m0DS3zBGs1FPkw8wXXwJi5/EciWeA8ttK9f6QOyRDKjvs/dGPldlfh5igkJLX9qIKtR6/GzQ3goZnCEOU/c10M9hxvDKeMhre0sHlYQJw8YP1uBsZ/gYwacRvGwQpEFujSvj9Ts6CjDKjEteZHN/TTZJ68DolAXftRhQqnbBQKOc4U+kF5turDaUCx41OfC3ro/x1HHjQ0cvzB9BwdBMBheGwZBg9jKVWUusUGxpRcumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM6EUR05FT003.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::41) by
 AM6EUR05HT141.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::461)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 23:22:47 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::4e) by AM6EUR05FT003.mail.protection.outlook.com
 (2a01:111:e400:fc11::343) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 23:22:47 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:CDAE7C71731066D19846F745724D27D7DE679AB6EFD2B5225A40AE0D46AEF1EE;UpperCasedChecksum:768666E5A65860925323C7457443D8D77A1C98BDEF5BF637466DCAE243322F31;SizeAsReceived:9309;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 23:22:47 +0000
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
Message-ID: <AM6PR03MB51701A2A2704B095AE96776BE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 01:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:200:89::17) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <22e59b58-0d3c-c6b5-2060-4e02238fb754@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM4PR0202CA0007.eurprd02.prod.outlook.com (2603:10a6:200:89::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 23:22:46 +0000
X-Microsoft-Original-Message-ID: <22e59b58-0d3c-c6b5-2060-4e02238fb754@hotmail.de>
X-TMN:  [G6sQq/hu/t7+ClzEAMNnsRA2N+xv75RG]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 0d525ba3-be2d-4f1b-14e5-08d7d75cc0b0
X-MS-TrafficTypeDiagnostic: AM6EUR05HT141:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lM2OZSi49hbi84Xr4Kqw1+l5VxJDlZqKOHI2+NIYRBjguJKBczTeLR2NRdWjA4wp22vwrANxcp5YoJCo7r61jSpAIjduYTr+4WQp0uSjhFef8ax29kxEJXuhI+QrsKJNj4h+dU+bCVic/UPF53BT09J8acVP+7x7YBZ4Jva+cVQ8LoF55j38n98qVX52Z9asZgQtQg4B7W8PNH/ZKf13Nld4cWXf7txanJRRqRKns1U=
X-MS-Exchange-AntiSpam-MessageData: gBFOqs5520bEebI61GHalfu17sCBzlZdMUDoM5xK+xVaClBLdZdtqB3fmqJJy93n61oPy/0XTOdnjw1xj5INCKDTEsf7hDYH+ToiGRIVjJIwfeZ+DbQpokUzMCpkLhOMvxxuaJ18pnUWxpeGt+o7kA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d525ba3-be2d-4f1b-14e5-08d7d75cc0b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 23:22:46.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT141
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

Linus,

let me explain what the locking here does.

It is a kind of soft mutex, which is normally strong, so taken
from 1 .. 4.  and nothing changes from how it was before.

But it can also be weak.

So if we detect that another thread is being ptraced, we drop
the lock, and keep the boolean set to true, which makes the ptrace_attach
acquire the lock, and the boolean is true, that make the
ptrace_attach return -EAGAIN. release the lock immediatly,
the deadlock is broken, the thread can handle the deadly signal
from de_thread, de_thread continues.  And just
at the end of the execve, when the boolean has to be set
to false again, we have to lock the mutex, set the boolean to
false, and unlock the mutex.  It is very important for the
correctness that the boolean is only changed when the mutex
is held.

Once again, please give Eric the time to catch up with his
sleep, that can be more serious as you would think to have
too less sleep.  Then I am looking forward to see his idea,
usually that may be something worth do consider.  But
we have all the time we want for that.


Thanks
Bernd.


> I'm seriously starting to feel like I should not have pulled this
> code, because the future looks _worse_ than what we used to have.
> 
> No. No no no. Eric, this is not an acceptable direction.
> 
>              Linus
> 
