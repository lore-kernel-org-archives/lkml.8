Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA330C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38072072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgDHPRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:17:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59702 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgDHPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:17:02 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMCRo-0003vB-Tz; Wed, 08 Apr 2020 09:17:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMCRn-0005Ft-WC; Wed, 08 Apr 2020 09:17:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
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
Date:   Wed, 08 Apr 2020 10:14:09 -0500
In-Reply-To: <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 7 Apr 2020 12:50:52 -0700")
Message-ID: <87v9maxb5q.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMCRn-0005Ft-WC;;;mid=<87v9maxb5q.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18IElz77CBQfmTS9aa6PTkXWD7jLB72d6E=
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

> On Mon, Apr 6, 2020 at 3:20 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> But fundamentally the only reason we need this information stable
>> before the point of no return is so that we can return a nice error
>> code to the process calling exec.  Instead of terminating the
>> process with SIGSEGV.
>
> I'd suggest doing it the other way around instead: let the thread that
> does the security_setprocattr() die, since execve() is terminating
> other threads anyway.
>
> And the easy way to do that is to just make the rule be that anybody
> who waits for this thing for write needs to use a killable wait.
>
> So if the execve() got started earlier, and already took the cred lock
> (whatever we'll call it) for reading, then zap_other_threads() will
> take care of another thread doing setprocattr().
>
> That sounds like a really simple model, no?

Yes.  I missed the fact that we could take the lock killable.
We still unfortunately have the deadlock with ptrace.

It might be simpler to make whichever lock we are dealing with per
task_struct instead of per signal_struct.  Then we don't even have to
think about what de_thread does or if the lock is taken killable.


Looking at the code in binfmt_elf.c there are about 11 other places
after install_exec_creds where we can fail and would be forced to
terminate the application with SIGSEGV instead of causing fork to fail.




I keep wondering if we could do something similar to vfork.  That is
allocate an new task_struct and fully set it up for the post exec
process, and then make it visible under tasklist_lock.  Finally we could
free the old process.

That would appear as if everything happened atomically from
the point of view of the rest of the kernel.

As well as fixing all of the deadlocks and making it easy
to ensure we don't have any more weird failures in the future.

Eric

p.s. For tasklist_lock I suspect we can put a lock in struct pid
and use that to guard the task lists in struct pid.  Which would
allow for tasklist_lock to be take much less.  Then we would
just need a solution for task->parent and task->real_parent and
I think all of the major users of tasklist_lock would be gone.


