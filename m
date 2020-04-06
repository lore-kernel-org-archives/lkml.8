Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1389C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0EE2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDFWUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:20:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35886 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFWUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:20:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLa6L-0007a2-Ah; Mon, 06 Apr 2020 16:20:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLa6J-0004ZD-QZ; Mon, 06 Apr 2020 16:20:17 -0600
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
Date:   Mon, 06 Apr 2020 17:17:27 -0500
In-Reply-To: <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 3 Apr 2020 12:26:51 -0700")
Message-ID: <87blo45keg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jLa6J-0004ZD-QZ;;;mid=<87blo45keg.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Hw6BC0R8d+nTg64OR2vW+KvY7sHH/xm8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ For Waiman & co - the problem is that the current cred_guard_mutex
> is horrendous and has problems with execve() deadlocking against
> various users. We've had this bug before, there's a new one, it's just
> nasty ]
>
> On Thu, Apr 2, 2020 at 4:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> That is not the direction I intend to take either.
>>
>> I was hoping I could put off replying to this thread for a bit because
>> I only managed to get 4 hours of sleep last night and I am not as alert
>> to technical details as I would like to be.
>
> Hmm.. So I've been looking at this cred_guard_mutex, and I wonder...
>
> This is a bit hand-wavy, because I haven't walker through all the
> paths, but could we perhaps work around a lot of the problems a
> different way., namely:
>
>  - make the "cred_guard_mutex" an rwsem-like thing instead of being a mutex.
>
>  - make the ptrace_attach() case get it for writing - not because
> ptrace changes the creds, but because ptrace changes 'task->ptrace'
> and depends on dumpability etc.
>
>  - change the *name* of that damn thing. Not because it's now
> rwsem'ish rather than a mutex, but because it was never really about
> just "creds". It was about creds+ptrace+dumpable flags etc.
>
>  - make all the ones that read the creds to just take it for reading
> (IOW, the cases that were basically switched over to
> exec_update_mutex).
>
>  - and finally: make "execve()" take it just for reading too, but
> introduce a "upgrade to write" at the very end (when it actually is
> all done and then finally changes the creds and dumpability)
>
> Wouldn't that solve all problems? We wouldn't get deadlocks wrt
> execve(), simply because execve() doesn't need it to be writable, and
> the things execve() does and can deadlock all only want readability.
>
> But hear me out, because the above is fundamentally broken in a couple
> of ways, so let me address that brokenness before you tell me I'm a
> complete nincompoop and an idiot.
>
> I'm including some locking people here because of these issues, so
> that they can maybe verify my thinking.
>
>  (a) our rwsem's are fair
>
>      So the whole "execve takes it for reading, so now others can take
> it for reading too without deadlocks" is simply not true - if you use
> the existing rwsem.
>
>      Because a concurrent (blocked) writer will then block other
> readers for fairness reasons, and holding it for reading doesn't
> guarantee that others can get it for reading.
>
>      So clearly, the above doesn't even *fix* the deadlocks - unless
> we have an unfair mode (or just a special lock for just this that is
> not our standard rwsem, but a special unfair one).
>
>      So I'm suggesting we use a special unfair rwsem here (we can make
> a simple spinlock-based one - it doesn't need to be as clever or
> optimized as the real rwsems are)
>
>  (b) similarly, our rwsem's don't actually have a "upgrade from read
> to write", because that's also a fundamentally deadlocky operation.
>
>      Again, that's true. Except execve() is special, and we know
> there's only _one_ execve() at a time that will complete, since we're
> serializing them. So for this particular use, "upgrade to write" would
> be possible without the general-case deadlock issues.
>
>  (c) I didn't think things through, and even with these special
> semantics, my idea is complete garbage
>
>      Ok, this may well be true.
>
> Anyway, the advantage of this (if it works) is that it would allow us
> to go back to the _really_ simple original model of just taking this
> lock for reading at the beginning of execve(), and not worrying so
> much about complex nesting or very complex rules for exactly when we
> got the lock and error handling.
>
> The final part when we actually update the credentials and dumpability
> and stuff in execve() is actually fairly simple. So the "upgrade to a
> write lock" phase doesn't worry me too much.  It's the interaction
> with all the previous parts (which happen with it held just for
> reading) that tend to be the nastier ones.
>
> And ptrace_attach() really is special, and I think it would be the
> only one that really needs that write lock.
>
> The disadvantage, of course, is that it would require that
> special-case lock semantic, and I might also be missing some thing
> that makes it not work anyway.
>
> Comments? Am I just dreaming of a simpler model without my medications
> again?

Withough reading everything through at least.

* There is also security_setprocattr which needs ptrace and nnp state not to
  change it needs to set something that at least selinux's cred
  calculations needs to remain constant (like nnp and ptrace).

  Which means one thread calling security_setprocattr and another thread
  calling exec can deadlock in de_thread.

* Even with your lock and just the ptrace case I can deadlock.
  Ptracer:                  Thread A               Tread B
     ptrace_attach A
                                                   exec
     ptrace_attach B
                                                   uprade R to RW
     ---------------------- DEADLOCKED -------------------------

Those are the first two cases I have thought of.  There are probably
more.



But fundamentally the only reason we need this information stable
before the point of no return is so that we can return a nice error
code to the process calling exec.  Instead of terminating the
process with SIGSEGV.

These are for the most part unlikely scenarios or people would have been
complaining much more loudly about deadlock.

So my plan is to perform the relevant calculations effectively twice.
Once just before the point of no return, and give a graceful return code
if necessary and possible.  Once just afer the point of no return, and
SIGSEGV if necessary.



Of course this all only applies to LSMs that refuse to continue under
NNP or ptrace without changing the cred.  Linux without those LSMs
enabled will just continue with the original credentials.


So I don't think we will noticably be sacraficing the quality of
the user experience with my plan.  In the worst case a deadlock
will become a SIGSEGV killing the execing program.

Eric

p.s. Yes we can do better than a mutex that makes everything mutually
     exclusive. I am just starting there for simplicity, and to
     see if we need anything better.  Unfortuantely too many things are
     changing simultaneously for rcu to cover all of the read side
     cases.

