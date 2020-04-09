Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC82C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E2F20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDIUhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:37:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43562 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgDIUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:37:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMdvL-0000zI-2f; Thu, 09 Apr 2020 14:37:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMdvJ-0000eF-Ex; Thu, 09 Apr 2020 14:37:18 -0600
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
        <87wo6or3pg.fsf@x220.int.ebiederm.org>
        <CAHk-=wiB762bDtiNZJ8KcRSkapOv3VUZbzyCvAt-8tSMWhR1DA@mail.gmail.com>
Date:   Thu, 09 Apr 2020 15:34:26 -0500
In-Reply-To: <CAHk-=wiB762bDtiNZJ8KcRSkapOv3VUZbzyCvAt-8tSMWhR1DA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 9 Apr 2020 10:36:07 -0700")
Message-ID: <871rowpfe5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMdvJ-0000eF-Ex;;;mid=<871rowpfe5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19CX5i1Ts7PoEZRURbKkjhzAXkFSUrt6Gk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 9, 2020 at 10:06 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> a) We must stop in PTRACE_EVENT_EXIT during exec or userspace *breaks*.
>>
>>    Those are the defined semantics and I believe it is something
>>    as common as strace that depends on them.
>
> Don't be silly.
>
> Of course we must stop IF THE TRACER IS ACTUALLY TRACING US.
>
> But that's simply not the case. The deadlock case is where the tracer
> is going through an execve, and the tracing thread is being killed.

Linus please don't be daft.

I will agree that if one thread in a process ptracess another thread
in the same process, and the tracing thread calls execve we have
a problem.  A different problem but one worth addressing.




The deadlock case I am talking about.  The deadlock case that trivially
exists in real code is:

A single threaded process (the tracer) ptrace attaches to every thread of a
multi-threaded process (the tracee).

If one of these attaches succeeds, and another thread of the tracee
processes calls execve before the tracer attachs to it, then the tracer
blocks in ptrace_attach waitiing for the traccee's exeve to succeed
while the tracee blocks in de_thread waiting for it's other threads to
exit.  The threads of the tracee attempt to exit but one or more of them
are in PTRACE_EVENT_EXIT waiting for the tracer to let them continue.

The tracer of course is stalled waiting for the exec to succeed.


Let me see if I can draw a picture.




Tracer                       TraceeThreadA     TraceeThreadB
ptrace_attach(TraceeThreadA)
                                               execve
                                               acquires cred_guard_mutex
ptrace_attach(TraceeThreadB)
 Blocks on cred_guard_mutex
                                               de_thread
                                               waits for other threads to exit
                             Receives SIGKILL
                             do_exit()
                             PTRACE_EVENT_EXIT
                               Waits for tracer


So we have a loop.

    TraceeThreadB is waiting for TraceeThreadA to reach exit_noitfy.
    TraceeThreadA is waiting for the tracer to allow it to continue.
    The Tracer is waiting for TraceeThreadB to finish it's call to exec.

Since they are all waiting for each other that loop is a deadlock.

All it takes is a tracer that uses PTRACE_EVENT_EXIT.

Does that make the deadlock that I see clear?


In your proposed lock revision you were talking about ptrace_attach
taking your new the lock for write so I don't see your proposed lock
being any different in this scenario from cred_guard_mutex.  Perhaps I
missed something?

I know Oleg's test case was a little more involved but that was to
guarantee the timing perhaps that introduced confusion.

Eric

