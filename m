Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EA2206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgDIRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:17:54 -0400
Received: from mail-oln040092074056.outbound.protection.outlook.com ([40.92.74.56]:55169
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbgDIRRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmAR8mJigRkXNrqGCycIJrlbQC/00J3uHWs/AUwGvR+yOpiOnF7cSIH9nS3fpsrvh5INwENrksUqqi0JDepWfaZcUvAyJ4e1XcfmqO6E2FOT+dvIdqQyol3HXcTCJLSDWbuNhAJxaY05X57AZcgub7Jw0554KdKQet0hGiYUUiUBlXjqEFdIMS/fW3W60/KWw0J4ZWpPbfVsPSLUq8gsCQn6SsdqaXNdlxh93OwDExWyLRH3tRvv6gqL3Hmcv1dEFM4qP03D5Bpe+VuJF5y8cEI34Lezage39zjEFjnWMFBC0Hdye34utQNGVA58PorYiozqxVAUojaym/hcveGHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jcqyzavWO+ym2G6DM95GFEAEVOL9vZpOcR7dMv9xdo=;
 b=XQkG3vc/Z91Mf2zbZH5eBbLwWmewqwXd3nUr3Oha6b4HRVjqmWM3ZbJ77zaTvUtnD22kEQBUXnOJJgUsjrq6ZPPGQodRyqWic0J5H263BXMyuKWaRHitSn8kfG2udsc66FaORY3WOO+cT3Y0vsL91xV1jZtFHjfN7re+D4dZXRcaYVYmljdiQpeQQ1FGdU7czi0BG99nYc1xWe4DDswgtspDzCxtqPe5Lg/7xes/UDs9uNOo1AqTIQeM/ez4DWeglAiEHRykc1P21B577IPeb5YmB/2ZmimB016SbHoem0gblpAPPWCA/t4p7qv3pZzLZRuxwwmcjJArF24P4ghdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from HE1EUR04FT006.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::41) by
 HE1EUR04HT060.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::328)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 17:17:50 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0d::44) by HE1EUR04FT006.mail.protection.outlook.com
 (2a01:111:e400:7e0d::276) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 17:17:50 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C61DF14368610F1A67781D85C860BBE04ED6B02FE0CD83907BFD0A48B0778AC2;UpperCasedChecksum:F5873C1F02D610FDF08E829BC9F7B3D9C3EE1204E706DBF890848251D6681007;SizeAsReceived:9121;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 17:17:50 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
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
 <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 9 Apr 2020 19:17:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <87wo6or3pg.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <df85b5c5-40a8-ed71-c7e2-9b42f231f1a4@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Thu, 9 Apr 2020 17:17:49 +0000
X-Microsoft-Original-Message-ID: <df85b5c5-40a8-ed71-c7e2-9b42f231f1a4@hotmail.de>
X-TMN:  [1R2NUN7gW1uSyvDdBh+MOaWP1K62gxdG]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1ed58a28-6db0-4862-2276-08d7dca9ee74
X-MS-TrafficTypeDiagnostic: HE1EUR04HT060:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoJQ3p6JkrRN3M04U2HabkmNOm3tT5tjjDhKHlkvJMWzQ4Vx7fs6ZNIEtMq30zIm6OzcBVtEQr2lieLwkTzwlVZtU/gCFhM0Iue0PtEBKjcnVmyrwC1EeomqgDUUG07cC4THpK1eEg3we6OBflp9vNEr0UgrTW2zNch/WzSQah4RktgfRZgjncAl9UnPE32j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: chfybG7MraVPdopUsVs8y1oUAKBIa8ZQJrqdJsQ70uEKUmByq3D3AhxNJssBErqAKxvoqa8/uPZQMgvNPa6R5ERQJ/Dkxn+Fw9Mr1TdQY9DRp6wOjz+f4ZxvilAkRztX3xVSUfsllQDx84Ij8QtELg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed58a28-6db0-4862-2276-08d7dca9ee74
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 17:17:50.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/9/20 7:03 PM, Eric W. Biederman wrote:
> 
> Adding Oleg to the conversation if for no other reason that he can see
> it is happening.
> 
> Oleg has had a test case where this can happen for years and nothing
> has come out as an obvious proper fix for this deadlock issue.
> 

Just for reference, I used Oleg's test case,
and improved it a bit.  The test case  anticipates the
EAGAIN return code from PTRACE_ATTACH.  This is likely
to change somehow.
If Linus's idea works, you will probably have to
look at adjusting the test expectations again.

I would still be surprised if any other solution works.


Bernd. 

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Thu, Apr 9, 2020 at 9:15 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> may_ptrace_stop() is supposed to stop the blocking exactly so that it
>>> doesn't deadlock.
>>>
>>> I wonder why that doesn't work..
>>>
>>> [ Goes and look ]
>>>
>>> Oh. I see.
>>>
>>> That ptrace_may_stop() only ever considered core-dumping, not execve().
>>>
>>> But if _that_ is the reason for the deadlock, then it's trivially fixed.
>>
>> So maybe may_ptrace_stop() should just do something like this
>> (ENTIRELY UNTESTED):
>>
>>         struct task_struct *me = current, *parent = me->parent;
>>
>>         if (!likely(me->ptrace))
>>                 return false;
>>
>>         /* If the parent is exiting or core-dumping, it's not
>> listening to our signals */
>>         if (parent->signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP))
>>                 return false;
>>
>>         /* if the parent is going through a execve(), it's not listening */
>>         if (parent->signal->group_exit_task)
>>                 return false;
>>
>>         return true;
>>
>> instead of the fairly ad-hoc tests for core-dumping.
>>
>> The above is hand-wavy - I didn't think a lot about locking.
>> may_ptrace_stop() is already called under the tasklist_lock, so the
>> parent won't change, but maybe it should take the signal lock?
>>
>> So the above very much is *not* meant to be a "do it like this", more
>> of a "this direction, maybe"?
>>
>> The existing code is definitely broken. It special-cases core-dumping
>> probably simply because that's the only case people had realized, and
>> not thought of the execve() thing.
> 
> 
> I don't see how there can be a complete solution in may_ptrace_stop.
> 
> a) We must stop in PTRACE_EVENT_EXIT during exec or userspace *breaks*.
> 
>    Those are the defined semantics and I believe it is something
>    as common as strace that depends on them.
> 
> b) Even if we added a test for our ptrace parent blocking in a ptrace
>    attach of an ongoing exec, it still wouldn't help.
> 
>    That ptrace attach could legitimately come after the thread in
>    question has stopped and notified it's parent it is stopped.
> 
> 
> 
> None of this is to say I like the semantics of PTRACE_EVENT_EXIT.  It is
> just we will violate the no regressions rule if we don't stop there
> during exec.
> 
> The normal case is that the strace or whomever is already attached to
> all of the threads during exec and no deadlock occurs.  So the current
> behavior is quite usable.
> 
> 
> 
> Maybe my memory is wrong that userspace cares but I really don't think
> so.
> 
> 
> Eric
> 
