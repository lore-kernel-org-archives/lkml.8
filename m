Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0E206F8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDEGeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 02:34:25 -0400
Received: from mail-oln040092074093.outbound.protection.outlook.com ([40.92.74.93]:47233
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbgDEGeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 02:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivn+PEmFWarxXb9rPsCeheCrf/wzs+OPqlSKezQmBeBcTc0TvV35W00+Pd0L/vKiNn7/mrrZ7vYlxp6LiEl9LqTGKfLP2mc7DG1ZSMP7MJpOg3EjF7e01CLUI29KRLZovAf88HL8kbeRiS4sflgNG+diE9nL5Jh2ieZXr6hUP3AS4vQoZabHNCOLG+Hon6AjPjpPV6icQvPUW9Z3NFXRuKpuoROXx9JRRi4ypA2EiuO+qbfU6ZvqNoUZQmqmB6Q9yY3QmccePmCyb6MEMUZ6oDbAB5zDQd9oKrmeJn/ojy75AFxpxZH4FMWgnekrqGFVDuY8bNCMfLdS8JARaQ27cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxhzjIxIf5MCduCpCQp8M1Pbp2ylRHh6/yCeR0QM3IU=;
 b=BG0+cn5Smw7frwXMDVZ6d6v4W0m2RkXj2lG39T3WGCbhWBHqUeC+GMN5wsf4OuBBwjbFW14MdO4RdWe46NyzqNuohcmVOiqtvLXyW0n3ZctBDimLMECHe5btu7q9BLGgjdjDRHCgxK/NxN0w42mW+3howWZM2NWMMbNG6CCLsSvdViyddaGUB5BpO0nrmHMxISj6GZsVn2d/OVSbimw+nfiAziCVsYjqtj/x934LP6Ct3lTDd43iuHyiFM58D8OgBjh9RsGEagzvHFNnzCetWAm34gmgxvaQqUBjfMBXNo+jSILlNeHmJLOUrofQ6ygP6skawpJR0AM0/AoO3myk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR04FT062.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::44) by
 VI1EUR04HT202.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::112)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 06:34:20 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0e::49) by VI1EUR04FT062.mail.protection.outlook.com
 (2a01:111:e400:7e0e::373) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Sun, 5 Apr 2020 06:34:20 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4596A0A8718E7B25E6AFFF60C24B45428D24114AF3A601FE5FCAE1FE641A068A;UpperCasedChecksum:0A696970F7D6B5A3159313ED9095A4336D923A42E3CE48EB4E38F651E62BFCBF;SizeAsReceived:9979;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 06:34:20 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
 <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
 <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
 <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
 <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
 <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
 <AM6PR03MB517044AE8D005BB0BBB1EC98E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Message-ID: <AM6PR03MB5170135E51DBF9093346E1DDE4C50@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sun, 5 Apr 2020 08:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <AM6PR03MB517044AE8D005BB0BBB1EC98E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:208:136::33) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <04e0bf81-d308-8133-78bf-9726c37fec34@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR05CA0093.eurprd05.prod.outlook.com (2603:10a6:208:136::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Sun, 5 Apr 2020 06:34:20 +0000
X-Microsoft-Original-Message-ID: <04e0bf81-d308-8133-78bf-9726c37fec34@hotmail.de>
X-TMN:  [jW1tMMZOXqDTtNOVAm5aYsRboV7a0sSE]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4505aef3-b560-4205-c5e5-08d7d92b5f68
X-MS-TrafficTypeDiagnostic: VI1EUR04HT202:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xy4WQMq4vfasBBM05Gv448cIzPLt55302rdqbVnGSyXcGw22d4cG9YSW7ESuXxDZCVJeS+WoZClPF4sD3WMJpLTr6e7NCkNxNDjnDrU8z+3p0PNHdIC8VSj7eZSHelKldajQ+tCr1ubrtVWIvY/sP8Jjf0s/Hf7vpH9c0Ne2xld+kniJLkqR7khFoN7u+T16
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: CDAgNVKytQAoqot76IzzPtndArfVaiwoo3jbk3jMiAJXbJsCoV9rKh1NxoJYyu7J7jXZgAj1ooGCyuiJMzijx6J+2J98qwfaqbqDt70rvNWusGrA3EOQOE3jShL7aZzsCWSczTHPgr5HN0gmvJxJJg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4505aef3-b560-4205-c5e5-08d7d92b5f68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 06:34:20.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/20 8:34 AM, Bernd Edlinger wrote:
> 
> 
> On 4/4/20 4:28 AM, Linus Torvalds wrote:
>> On Fri, Apr 3, 2020 at 7:02 PM Waiman Long <longman@redhat.com> wrote:
>>>
>>> So in term of priority, my current thinking is
>>>
>>>     upgrading unfair reader > unfair reader > reader/writer
>>>
>>> A higher priority locker will block other lockers from acquiring the lock.
>>
>> An alternative option might be to have readers normally be 100% normal
>> (ie with fairness wrt writers), and not really introduce any special
>> "unfair reader" lock.
>>
>> Instead, all the unfairness would come into play only when the special
>> case - execve() - does it's special "lock for reading with intent to
>> upgrade".
>>
>> But when it enters that kind of "intent to upgrade" lock state, it
>> would not only block all subsequent writers, it would also guarantee
>> that all other readers can continue to go).
>>
>> So then the new rwsem operations would be
>>
>>  - read_with_write_intent_lock_interruptible()
>>
>>    This is the beginning of "execve()", and waits for all writers to
>> exit, and puts the lock into "all readers can go" mode.
>>
>>    You could think of it as a "I'm queuing myself for a write lock,
>> but I'm allowing readers to go ahead" state.
>>
>>  - read_lock_to_write_upgrade()
>>
>>    This is the "now this turns into a regular write lock". It needs to
>> wait for all other readers to exit, of course.
>>
>>  - read_with_write_intent_unlock()
>>
>>    This is the "I'm unqueuing myself, I aborted and will not become a
>> write lock after all" operation.
>>
>> NOTE! In this model, there may be multiple threads that do that
>> initial queuing thing. We only guarantee that only one of them will
>> get to the actual write lock stage, and the others will abort before
>> that happens.
> 
> One of the problems that add to the current situation, is that sometimes
> the cred_guard_mutex is locked killable, so can be killed by de_thread.
> But in other places cred_guard_mutex is not killable. So cannot be
> locked and cannot be killed either -> dead-lock.
> 
> 
> But Fear Not!
> 
> Overall we are pretty much in a good position to defeat the
> enemy now, once an forever.
> 
> - We have my ugly-crazy patch that just works.
> 
> - We will have Eric's patch that is even better.
> 
> - We can try to put something togeter with creative new rw-type semaphores.
> 
> - We can merge ideas from one of the patches to another.
> 
> 
> So it is impossible we not succeed to fix it this time :-)
> 

BTW there is one other independent thing that came to my attention when I tried
to fix the ptrace deadlock from user space, which I tried first.

In order to break the deadlock from user space the strace program would have
to be rewitten to be multi-threaded.  I tried that, but the problem was,
that an event from the tracee can be received either in the main thread,
or a signal handler, or another thread.  I tried to implement both possibilities,
see my strace-patches which I pointed out previously here.

The signal handler approach completely failed, and the second thread
approach did not completely fail but was just definitely insane.

What really makes it impossible to write a multi-threaded strace program,
is that *only* the tread that made PTRACE_ATTACH can do all the other
PTRACE-APIs, but for a multi-treaded strace, any thread should be able
to call PTRACE-APIs as long as we are in the same process.

I don't know if that is really hard to achieve, but it seems like something
that would allow user space much more flexibility.

What do you think?


Thanks
Bernd.


> 
> Bernd.
> 
>>
>> If that is a more natural state machine, then that should work fine
>> too. And it has some advantages, in that it keeps the readers normally
>> fair, and only turns them unfair when we get to that special
>> read-for-write stage.
>>
>> But whatever it most natural for the rwsem code. Entirely up to you.
>>
>>                Linus
>>
