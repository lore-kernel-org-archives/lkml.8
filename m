Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377D5C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4D52072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgD1MUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:20:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52580 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD1MUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:20:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPDT-0006cz-Aw; Tue, 28 Apr 2020 06:19:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPDS-00016K-Gn; Tue, 28 Apr 2020 06:19:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
Date:   Tue, 28 Apr 2020 07:16:44 -0500
In-Reply-To: <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 27 Apr 2020 13:27:40 -0700")
Message-ID: <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTPDS-00016K-Gn;;;mid=<87sggnajpv.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Ca6+ElOCctvOcWA7bIRbvwRUv+5ClZTc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the work to remove proc_mnt I noticed that we were calling
proc_flush_task now proc_flush_pid possibly multiple times for the same
pid because of how de_thread works.

This is a bare minimal patchset to sort out de_thread, by introducing
exchange_tids and the helper of exchange_tids hlists_swap_heads_rcu.

The actual call of exchange_tids should be slowpath so I have
prioritized readability over getting every last drop of performance.

I have also read through a bunch of the code to see if I could find
anything that would be affected by this change.  Users of
has_group_leader_pid were a good canidates.  But I also looked at other
cases that might have a pid->task->pid transition.  I ignored other
sources of races with de_thread and exec as those are preexisting.

I found a close call with send_signals user of task_active_pid_ns, but
all pids of a thread group are guaranteeds to be in the same pid
namespace so there is not a problem.

I found a few pieces of debugging code that do:

	task = pid_task(pid, PIDTYPE_PID);
        if (task) {
        	printk("%u\n", task->pid);
        }

But I can't see how we care if it happens at the wrong moment that
task->pid might not match pid_nr(pid);

Similarly because the code in posix-cpu-timers goes pid->task->pid it
feels like there should be a problem.  But as the code that works with
PIDTYPE_PID is only available within the thread group, and as de_thread
kills all of the other threads before it makes any changes of this
kind the race can not happen.

In short I don't think this change will introduce any regressions.

Eric W. Biederman (2):
      rculist: Add hlists_swap_heads_rcu
      proc: Ensure we see the exit of each process tid exactly once

 fs/exec.c               |  5 +----
 include/linux/pid.h     |  1 +
 include/linux/rculist.h | 21 +++++++++++++++++++++
 kernel/pid.c            | 19 +++++++++++++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)

Eric
