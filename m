Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546F0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9E820756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597162107;
	bh=YXBnDr9tWBPpWviVYK4o6ebIMUfUB+PCboBIK49UgUo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=p8Vd40kNhFiXXS1oXgiLNk3XgB+sQPje1m3694BmLvD/BOKkK2Ik+m7AesXuTgjDR
	 CW9Hi/3Rm2nS/81sn3H5SQpDiLNtYIHxb/3/Y7+WT95TofdxS6gDPcBhN/rEjv4uu+
	 FXeXuqORpl87/nkcOQOLsBgoJbsiaZdkhwieuFiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgHKQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgHKQIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:08:25 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F4D206B5;
        Tue, 11 Aug 2020 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597162104;
        bh=YXBnDr9tWBPpWviVYK4o6ebIMUfUB+PCboBIK49UgUo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=af3H88W3v7EMMAKb7WaheEgqPqTKpQQbn3+BHd+EmRF76CyQrmvumehitO+OvC5sl
         CQlQRCFKJQHPIQAsKNY1JWS5wF3HfvaONAvjyU5s3ixEn5aG8xmHx4AfyZyyqaYVt0
         HfhO2cshwrvMhRGzghktPwaBCdOvz2KXeu5K/Ccs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 866C0352308E; Tue, 11 Aug 2020 09:08:24 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:08:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     Marco Elver <elver@google.com>, tglx@linutronix.de,
        mingo@kernel.org, will@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        rjw@rjwysocki.net
Subject: Re: [RFC][PATCH 0/3] Tracing, Idle, RCU and such goodness
Message-ID: <20200811160824.GY4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200807192336.405068898@infradead.org>
 <20200810095535.GA1597985@elver.google.com>
 <20200810121138.GV2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810121138.GV2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 02:11:38PM +0200, peterz@infradead.org wrote:
> On Mon, Aug 10, 2020 at 11:55:35AM +0200, Marco Elver wrote:
> 
> > Unfortunately I get LOCKDEP_DEBUG warnings, when testing with one of
> > syzbot's configs. This appears at some point during boot (no other
> > test):
> > 
> > 	DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> > 	WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4875 check_flags+0x52/0x200 kernel/locking/lockdep.c:4875
> > 	Modules linked in:
> > 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #8
> > 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > 	RIP: 0010:check_flags+0x52/0x200 kernel/locking/lockdep.c:4875
> > 	Code: c0 74 48 e8 40 f7 a5 03 85 c0 74 20 83 3d bd 33 53 05 00 75 17 48 c7 c7 ce 12 c9 85 48 c7 c6 04 8c ca 85 31 c0 e8 4e c1 f7 ff <0f> 0b 48 c7 c7 db 8b ca 85 e9 8c 01 00 00 85 c0 75 0f 65 8b 05 c5
> > 	RSP: 0000:ffffffff86203bf0 EFLAGS: 00010046
> > 	RAX: 1f9fa70771052a00 RBX: 0000000000000000 RCX: ffffffff8627e980
> > 	RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> > 	RBP: 0000000000000000 R08: ffffffff813d8494 R09: 0000000000000000
> > 	R10: 0000000000000012 R11: ffffffff8627e980 R12: ffffffff8627e980
> > 	R13: ffffffff862e3420 R14: 00000000ffffffff R15: 0000000000000046
> > 	FS:  0000000000000000(0000) GS:ffff88881fa00000(0000) knlGS:0000000000000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: ffff88883ffff000 CR3: 0000000006275001 CR4: 0000000000770ef0
> > 	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > 	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 	PKRU: 00000000
> > 	Call Trace:
> > 	 lock_is_held_type+0x4d/0x110 kernel/locking/lockdep.c:5043
> > 	 lock_is_held include/linux/lockdep.h:266 [inline]
> > 	 rcu_read_lock_sched_held+0x41/0x90 kernel/rcu/update.c:136
> > 	 trace_lock_acquire+0x49/0x120 include/trace/events/lock.h:13
> > 	 lock_acquire+0x8d/0x2c0 kernel/locking/lockdep.c:5003
> > 	 mutex_trylock+0xdd/0x120 kernel/locking/mutex.c:1420
> 
> *groan*, indeed! Which is the direct result of lockdep recursion because
> we pulled that tracepoint out from under the recursion thing.
> 
> Let me go prod this with a sharp stick...

On the other hand, the first two commits in this series did pass
weekend rcutorture testing.

I clearly need to make rcutorture more viscious.  ;-)

But in the meantime, for the first two:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul
