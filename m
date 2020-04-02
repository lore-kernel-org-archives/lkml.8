Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0323C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D862077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390256AbgDBXm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:42:29 -0400
Received: from mail-oln040092064092.outbound.protection.outlook.com ([40.92.64.92]:15149
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390182AbgDBXm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SerQ5NCh8xgHckcFYIISuF62ek2rgcj9JTjFQF8gdY+I3/mLwQ9DDoy0t4Yk1W0A5ZSiiQ3EeLsRJ6tckkx0SDiXPtJAdKWlIqbRbIOfU34qGolHyUcvY/Cv0qzYrrzDElRCnlFEDnZ029tRBXfs296IsRreyjklsl2qD449l65ruPzLYxMOsBJuLKuQnlowDgFrZPHQzJ2Bkb09cTHUn5KIncy3KD4HQrW+PaqRorPbKcOnYjqnBr4d8Rz5oyZCBGBjfNYMP0hznmKXTHf7HyT/MPRB2RWOAZ+mtGM6kWumfUW03IPJFlhrKdrH5Py+ujkrnLz18Yg1AyGM27z1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55NliEkDdAueGRJridTEvkzrImK2hz7p+tLwMHaGvAI=;
 b=FnujMsF9IQmnaiEldX77eAR6CWgTv3uze2AqdREQ0AOckS5yU/Ye+1US2PBqnhYySKgxmMg8ldNRxE9DH4vHDntHekv7iO56oDuTRzkVGPWep5kvlp5tCiU1DcdNHHXaeiu5EtR37S9BhmqxvqUeLuKCWR2Zb3KiT4O9N1eHKTflPlAfho5gE/8PdmM+P4k5NjAaDdM7UVxIkKdnmgyfqob8PXkCiAUEm+W+TdSN82Swxw/pdFpa00I3G28aZllJJ69qwTDEEspsrapI6fMcvFnqzyA3bBdUUp2LyLBy2iBcjiQsds6OPsSxRuSh1obhY+H4qR25lw5E6ysS2sF6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e19::43) by
 VE1EUR01HT190.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e19::485)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 23:42:25 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e19::4f) by VE1EUR01FT062.mail.protection.outlook.com
 (2a01:111:e400:7e19::324) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 23:42:25 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:1B2F73A8B3A3E88E1F4C096B97BD86FAEE628E0E91020CC3170190CCC6208581;UpperCasedChecksum:E5E3390FEDD62BCB3758C7AE1AFE7F6A9A4BC5883B7BE4077F227C7684FBC1C6;SizeAsReceived:8467;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 23:42:25 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB51702497FDBDA78921515562E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 01:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <87lfnda3w3.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0108.eurprd05.prod.outlook.com
 (2603:10a6:207:1::34) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <8267c87f-0f47-8e1d-9542-a7a563454e25@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM3PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:207:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 23:42:24 +0000
X-Microsoft-Original-Message-ID: <8267c87f-0f47-8e1d-9542-a7a563454e25@hotmail.de>
X-TMN:  [ZN0CqSM+b+CunuzckOp26PLvZWe6IAH/]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 063af71d-16f5-4a2f-52d3-08d7d75f7f1d
X-MS-TrafficTypeDiagnostic: VE1EUR01HT190:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqsDuou1BevhR0jPfF4nNE+KsQFjUk8fUtnloGuDAo3Vc5MYqQ9SScK6yc1ERMBrWft7GjUJ7Nu8CtQCo0ZWh4BJ8+6OWV+eaadNSdFrFekqOFkc6R5kaOoYzfixeiEMYZgOU76x1mpZ6dbYmzjw6DbX90THYFN9ODe8bxs+mQDEwxUcavnWMQyLW9AfgIF74s1HLZs7TY0Z3+I+pO1pnZCqXDHq294f8s9voRW6CbA=
X-MS-Exchange-AntiSpam-MessageData: 1RH78R6ZQznDqiC97fJKrYv5w7AyGXC1YI6Jmdpg4zFvbAoebubGlA8EQ6o0i9aw4CeE26M2CIFCdSqktLWJRtX/5BysKNMXCG4HTbU9qPd+wZRbE3GFdi6zFL2d2szG+jPuv0mde3e2pQAA+FNCIw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063af71d-16f5-4a2f-52d3-08d7d75f7f1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 23:42:25.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 1:01 AM, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Thu, Apr 2, 2020 at 2:00 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>>
>>> There are two more patches, which might be of interest for you, just to
>>> make the picture complete.
>>> It is not clear if we go that way, or if Eric has a yet better idea.
>>>
>>> [PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
>>> https://www.spinics.net/lists/kernel/msg3459067.html
>>
>> There is no way I would ever take that patch.
>>
>> The amount of confusion in that patch is not acceptable. Randomly
>> unlocking the new lock?
>>
>> That code makes everything worse, it's completely incomprehensible,
>> the locking rules make no sense ahwt-so-ever.
>>
>> I'm seriously starting to feel like I should not have pulled this
>> code, because the future looks _worse_ than what we used to have.
>>
>> No. No no no. Eric, this is not an acceptable direction.
> 
> That is not the direction I intend to take either.
> 
> I was hoping I could put off replying to this thread for a bit because
> I only managed to get 4 hours of sleep last night and I am not as alert
> to technical details as I would like to be.
> 
> Long story short:
> 
> The exec_update_mutex is to be a strict subset of today's
> cred_guard_mutex.  I tried to copy cred_guard_mutex's unlock style so
> that was obvious and that turns out was messier than I intended.
> 
> I thought the changes to the individual locking changes were
> sufficiently unsubtle that they did not need my personal attention.
> Especially as they are just a substitution of one lock for another
> with a slightly smaller scope.
> 
> I started working on the the series of changes that reorganizes
> the changes in exec.
> 
> It was reported that something had gone wrong with my introduction
> of exec_update_mutex and I pulled it from linux-next.
> 
> By the time I was ready to start putting humpty dumpty back together
> again Bernd had collected everything up and had it working.  I had seen
> that he had been given the feedback about better change descriptions.
> 
> I had looked at the code of his patches earlier and the basic changes
> were trivial.
> 
> Since I thought I already knew what was in the patches and the worst
> problem was the missing unlock of cred_guard_mutex, and I know Bernd's
> patches had been tested I applied them.  I missed that Bernd had added
> the exec_mmap_called flag into my patch.  I thought he had only added
> the missing unlock.
> 

Hi Eric,

oh, sorry for that, that was requested in the peer review, I could not
get a patch approved that does not have such a boolean, that simplified
the error handling.

Actually I had sent you an e-mail with that patch 24H before I posted
the update, then Greg asked me to re-post the whole series, that
took at least another two days, so at that time I was seriously
concerned how you are doing, since I head nothing from you about the
updated patch with the exec_mmap_called.

Linus that is not the boolean I was talking in the other mail.
That boolean is called unsafe_execve_in_progres.

So, and now I also try to get some sleep....


Thanks
Bernd.

> I spotted the weirdness in unlocking exec_update_mutex, and because it
> does fix a real world deadlock with ptrace I did not back it out from my
> tree.
> 
> I have been much laxer on the details than I like to be my apologies.
> 
> The plan is:
> 	exec_udpate_mutex will cover just the subset of cred_guard_mutex
>         after the point of no return, and after we do any actions that
> 	might block waiting for userspace to do anything.
> 
> 	So exec_update_mutex will just cover those things that exec
>         is updating, so if you want an atomic snapshot of them
>         plus the appropriate struct cred you can grab exec_update_mutex.
>         
> 	I added a new mutex instead of just fixing cred_guard_mutex so
>         that we can update or revert the individual code paths if it
>         is found that something is wrong.
> 
> 	The cred_guard_mutex also prevents other tasks from starting
>         to ptrace the task that is exec'ing, and other tasks from
>         setting no_new_privs on the task that is exec'ing.
> 
>         My plan is to carefully refactor the code so it can perform
>         both the ptrace and no_new_privs checks after the point of
>         no return.
> 
> I have uncovered all kinds of surprises while working in that direction
> and I realize it is going to take a very delicate and careful touch to
> achieve my goal.
> 
> There are silly things like normal linux exec when you are ptraced and
> exec changes the credentials the ordinary code will continue with the
> old credentials, but the an LSM enabled your process is likely to be
> killed instead.
> 
> There is the personal mind blowing scenario where selinux will increase
> your credentials upon exec but if a magic directive is supplied in it's
> rules will avoid setting AT_SECURE, so that userspace won't protect
> itself from hostile takeover from the pre credential change environment.
> Much to my surprise "noatsecure" is a known and documented feature of
> selinux.  I am not certain but I think I even spotted it in use on
> production.
> 
> I will catch up on my sleep before I allow any more changes, and I will
> see replacing the called_exec_mmap flag with something saner.
> 
> Eric
> 
