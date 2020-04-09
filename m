Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A804C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E88D2074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgDIPP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:15:26 -0400
Received: from mail-vi1eur05olkn2018.outbound.protection.outlook.com ([40.92.90.18]:58209
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727327AbgDIPP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:15:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4m/sS19mmMt1N+t1zn6voGNIVDxwAQenClM+TLYIK3UC2uZviA0KBu2/4ThmDomLChw3CjW4/eLbtC9E+2oSzWKFOWlkChJbpVqYP179NVRTsilkBMltKt3I3LY6t4mo+k+rW2sdQDCyKB+a8QSsU/k6l5vCWIUueY/EUFl9zt0oztqR9jJvFFtz7wEdTK6UgA3Eg0btszeJ6+4Nt2r/lmKQ8hMChEQVduTGlqD3fWrwh8Aq3DhrlFpFoY9yP42UTK3RxEqhIMfvuxFQ+1csc4cfY7dcE7tg8dF3J9BQlyPQWWVwBrCvbZ8tTzIFHvoUt+jjYIEX9/cZurotiNJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYkaMUVUWrjTWlBOgz5riUPSSmbi4RUgL7Pl4yfzKdE=;
 b=ZCdytNgA4TvQ37rXfuMmuvtImFXIcc17dO+taiy5aFxX97FwXFUDXTQzZh2nX1dJhHf5qXkokUQkUJGG1PDqQcuTQJPaAEamMjcwmRVbNUdltKVdsZ2H4Ta1sHI8U8n2nGymODibsf1DOhcC4Hzq39scJ/Vb9zbnUPJmN7bBnqTKLHmbmQvdpJw/rEOHCrIJZTW9KXzcMBQxtqgpO1IpbQMOeiVvX89Rsenlz35uKQRC/VprNArIRuWI7Ao+XoqAvRbzlQC36lYxPsRg2wo859pKYJw3ZcREUUvIkv5dgu3TdsEr/VGap5z8Vd5ayyrnQuwiS60DGglT8SU0+0Ts9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM6EUR05FT053.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::49) by
 AM6EUR05HT221.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 15:15:09 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::47) by AM6EUR05FT053.mail.protection.outlook.com
 (2a01:111:e400:fc11::62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 15:15:09 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:79687001BE73F537367425562DBA77C680238535504D4AEEC93261358408D81A;UpperCasedChecksum:2698351A0AF86177E6815142F6FE94083B55D943408C4E74026B98556980B45C;SizeAsReceived:8936;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 15:15:09 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org>
 <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org>
 <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170B4DE6096F78BAB79BF72E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 9 Apr 2020 17:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <87y2r4so3i.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <41c183bb-7376-de02-999a-6e683dac25c6@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Thu, 9 Apr 2020 15:15:08 +0000
X-Microsoft-Original-Message-ID: <41c183bb-7376-de02-999a-6e683dac25c6@hotmail.de>
X-TMN:  [93JsiLBEeYQWz/MhBxOeKCHuhRGOr4wZ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 0e6d6c15-d170-4087-1bb9-08d7dc98cad3
X-MS-TrafficTypeDiagnostic: AM6EUR05HT221:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdmA4UEhpojLcdZAc7sKqdIowDaAyNgo1mU/ynmooTwP6WsGp9bCneRdKdq1D5c5GJoGVyjhOZ9YvYyHYkILc/RdbXiuCWVHYwn9q8EKYhmMc1Gjg16fF3oK7o4S+qt8LQGfNjdBrsiyup4JcpSOyD3hv1dYNcPWUAxk1uiAOB62P9rw7nt7F8k2d7cM13Y8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: XPgszUWOaMBcmjtits8BOMIPpna+w5zBvsIpenTi2Wv+5rp5SffS9xUphh3uzWiJDFVQb9G9JuhfoHjbgRa958BuW/qGoq7VXvsIsScX/iUUpZmzFPhrdrJ7KXcKnDJnGFLT7XlsH443GdVmggAjxQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6d6c15-d170-4087-1bb9-08d7dc98cad3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 15:15:09.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/20 4:58 PM, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Wed, Apr 8, 2020 at 8:17 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>
>>> Yes.  I missed the fact that we could take the lock killable.
>>> We still unfortunately have the deadlock with ptrace.
>>
>> That, I feel, is similarly trivial.
>>
>> Again, anybody who takes the lock for writing should just do so
>> killably. So you have three cases:
>>
>>  - ptrace wins the race and gets the lock.
>>
>>    Fine, the execve will wait until afterwards.
>>
>>  - ptrace loses the race and is not a thread with execve.
>>
>>    Fine, the execve() won, and the ptrace will wait until after execve.
>>
>>  - ptrace loses the race and is a thread with execve.
>>
>>    Fine, the execve() will kill the thing in dethread() and the ptrace
>> thread will release the lock and die.
> 
> That would be nice.
> 
> That is unfortunately not how ptrace_event(PTRACE_EVENT_EXIT, ...) works.
> 
> When a thread going about it's ordinary business receives the SIGKILL
> from de_thread the thread changes course and finds it's way to do_exit.
> In do_exit the thread calls ptrace_event(PTRACE_EVENT_EXIT, ...) and
> blocks waiting for the tracer to let it continue.
> 
> Further from previous attempts to fix this we know that there
> are pieces of userspace expect that stop to happen.  So if the
> PTRACE_EVENT_EXIT stop does not happen userspace which is already
> attached breaks.
> 
> Further this case with ptrace is something we know userspace
> does and is is just a matter of bad timing of attaching to the
> threads when one thread is exec'ing.  So we don't even need to wonder if
> userspace would do such a silling thing.
> 
> 
> 
> There are a lot similar cases that can happen if userspace inserts
> itself into the path of page faults, directly or indirectly,
> as long as some wait somewhere ultimately waits for a ptrace attach.
> 
> 

Remember, as a last resort there is my "insane" 15/16 patch, which
Linus admittedly hates, but it works.  If we find a cleaner solution
it can always be reverted, that is just fine for me.

Thanks
Bernd.

>> So all three cases are fine, and none of them have any behavioral
>> differences (as mentioned, the killing is "invisible" to users since
>> it's fundamentally a race, and you can consider the kill to have
>> happened before the ptrace started).
> 
> See above.
> 
> 
>>> It might be simpler to make whichever lock we are dealing with per
>>> task_struct instead of per signal_struct.  Then we don't even have to
>>> think about what de_thread does or if the lock is taken killable.
>>
>> Well, yes, but I think the dethread behavior of killing threads is
>> required anyway, so..
> 
> It is, but it is actually part of the problem.
> 
> I think making some of this thread local might solve another easy case
> and let us focus more on the really hard problem.
> 
>>> I keep wondering if we could do something similar to vfork.  That is
>>> allocate an new task_struct and fully set it up for the post exec
>>> process, and then make it visible under tasklist_lock.  Finally we could
>>> free the old process.
>>>
>>> That would appear as if everything happened atomically from
>>> the point of view of the rest of the kernel.
>>
>> I do think that would have been a lovely design originally, and would
>> avoid a lot of things. So "execve()" would basically look like an exit
>> and a thread creation with the same pid (without the SIGCHILD to the
>> parent, obviously)
>>
>> That would also naturally handle the "flush pending signals" etc issues.
>>
>> The fact that we created a whole new mm-struct ended up fixing a lot
>> of problems (even if it was painful to do). This might be similar.
>>
>> But it's not what we've ever done, and I do suspect you'd run into a
>> lot of odd small special cases if we were to try to do it now.
> 
> I completely agree, which is why I haven't been rushing to do that.
> But this remains the only idea that I have thought of that would solve all
> of the issues.
> 
>> So I think it's simpler to just start making the "cred lock waiters
>> have to be killable" rule. It's not like that's a very complex rule.
> 
> I just looked at the remaining users of cred_guard_mutex and they are
> all killable or interruptible.  Further all of the places that have been
> converted to use the exec_update_mutex are also all killable or
> interruptible.
> 
> So where we came in is that we had the killable rule and that has what
> has allowed this to remain on the backburner for so long.  At least you
> could kill the affected process from userspace.   Unfortunately the
> deadlocks still happen.
> 
> Eric
> 
