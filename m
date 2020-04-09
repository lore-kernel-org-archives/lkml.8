Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C264C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222EF20768
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgDIRGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:06:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38906 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgDIRGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:06:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMadb-0000tW-PT; Thu, 09 Apr 2020 11:06:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMada-0005PU-Py; Thu, 09 Apr 2020 11:06:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
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
Date:   Thu, 09 Apr 2020 12:03:55 -0500
In-Reply-To: <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 9 Apr 2020 09:24:23 -0700")
Message-ID: <87wo6or3pg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMada-0005PU-Py;;;mid=<87wo6or3pg.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xiliuIjxQOTWcYhWi4aqPdImDYESOPcY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Oleg to the conversation if for no other reason that he can see
it is happening.

Oleg has had a test case where this can happen for years and nothing
has come out as an obvious proper fix for this deadlock issue.

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 9, 2020 at 9:15 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> may_ptrace_stop() is supposed to stop the blocking exactly so that it
>> doesn't deadlock.
>>
>> I wonder why that doesn't work..
>>
>> [ Goes and look ]
>>
>> Oh. I see.
>>
>> That ptrace_may_stop() only ever considered core-dumping, not execve().
>>
>> But if _that_ is the reason for the deadlock, then it's trivially fixed.
>
> So maybe may_ptrace_stop() should just do something like this
> (ENTIRELY UNTESTED):
>
>         struct task_struct *me = current, *parent = me->parent;
>
>         if (!likely(me->ptrace))
>                 return false;
>
>         /* If the parent is exiting or core-dumping, it's not
> listening to our signals */
>         if (parent->signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP))
>                 return false;
>
>         /* if the parent is going through a execve(), it's not listening */
>         if (parent->signal->group_exit_task)
>                 return false;
>
>         return true;
>
> instead of the fairly ad-hoc tests for core-dumping.
>
> The above is hand-wavy - I didn't think a lot about locking.
> may_ptrace_stop() is already called under the tasklist_lock, so the
> parent won't change, but maybe it should take the signal lock?
>
> So the above very much is *not* meant to be a "do it like this", more
> of a "this direction, maybe"?
>
> The existing code is definitely broken. It special-cases core-dumping
> probably simply because that's the only case people had realized, and
> not thought of the execve() thing.


I don't see how there can be a complete solution in may_ptrace_stop.

a) We must stop in PTRACE_EVENT_EXIT during exec or userspace *breaks*.

   Those are the defined semantics and I believe it is something
   as common as strace that depends on them.

b) Even if we added a test for our ptrace parent blocking in a ptrace
   attach of an ongoing exec, it still wouldn't help.

   That ptrace attach could legitimately come after the thread in
   question has stopped and notified it's parent it is stopped.



None of this is to say I like the semantics of PTRACE_EVENT_EXIT.  It is
just we will violate the no regressions rule if we don't stop there
during exec.

The normal case is that the strace or whomever is already attached to
all of the threads during exec and no deadlock occurs.  So the current
behavior is quite usable.



Maybe my memory is wrong that userspace cares but I really don't think
so.


Eric
