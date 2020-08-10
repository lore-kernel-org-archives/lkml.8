Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F41C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5DA20729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qKCWptLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHJMLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHJMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:11:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFEAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F9rHrTNtavLmJnsON5rguqCFVYnqZxEY92qpddY9gk0=; b=qKCWptLlXNZ9MJYkpyJJTelWEI
        5m2ObfMuiBrbwk0iCOwK1wo5W8d9X7IVR9elMzSK9VjTwAm9fZDiSSID/U+80YPpHD8/tug3lYBKT
        5HZI7R2RErVfAb+H+ItQI1myQGDAoz2d0V2zbCbVIi8uNiXHK423yD4CgHSk4nPR+GK7TNzMd1HB3
        NI4oSuWf6QwvUcsUnW4Ou4wARxtxN7JXPGIdtaDRtgnlpnuY1XCeWqVU3IxQ2Wav944f3OogxL3Vh
        4mWnZtWyDh1r3qMes4bX7sUK5KNcMw9A2H8menQJy4Hl14++m+11TwewW/HPqMG/wnI/0pnYxA9vn
        JiqFxHxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k56eS-00005f-5C; Mon, 10 Aug 2020 12:11:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFE8230015A;
        Mon, 10 Aug 2020 14:11:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88AF52B2C8031; Mon, 10 Aug 2020 14:11:38 +0200 (CEST)
Date:   Mon, 10 Aug 2020 14:11:38 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rjw@rjwysocki.net
Subject: Re: [RFC][PATCH 0/3] Tracing, Idle, RCU and such goodness
Message-ID: <20200810121138.GV2674@hirez.programming.kicks-ass.net>
References: <20200807192336.405068898@infradead.org>
 <20200810095535.GA1597985@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810095535.GA1597985@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:55:35AM +0200, Marco Elver wrote:

> Unfortunately I get LOCKDEP_DEBUG warnings, when testing with one of
> syzbot's configs. This appears at some point during boot (no other
> test):
> 
> 	DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> 	WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4875 check_flags+0x52/0x200 kernel/locking/lockdep.c:4875
> 	Modules linked in:
> 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #8
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> 	RIP: 0010:check_flags+0x52/0x200 kernel/locking/lockdep.c:4875
> 	Code: c0 74 48 e8 40 f7 a5 03 85 c0 74 20 83 3d bd 33 53 05 00 75 17 48 c7 c7 ce 12 c9 85 48 c7 c6 04 8c ca 85 31 c0 e8 4e c1 f7 ff <0f> 0b 48 c7 c7 db 8b ca 85 e9 8c 01 00 00 85 c0 75 0f 65 8b 05 c5
> 	RSP: 0000:ffffffff86203bf0 EFLAGS: 00010046
> 	RAX: 1f9fa70771052a00 RBX: 0000000000000000 RCX: ffffffff8627e980
> 	RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> 	RBP: 0000000000000000 R08: ffffffff813d8494 R09: 0000000000000000
> 	R10: 0000000000000012 R11: ffffffff8627e980 R12: ffffffff8627e980
> 	R13: ffffffff862e3420 R14: 00000000ffffffff R15: 0000000000000046
> 	FS:  0000000000000000(0000) GS:ffff88881fa00000(0000) knlGS:0000000000000000
> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	CR2: ffff88883ffff000 CR3: 0000000006275001 CR4: 0000000000770ef0
> 	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 	PKRU: 00000000
> 	Call Trace:
> 	 lock_is_held_type+0x4d/0x110 kernel/locking/lockdep.c:5043
> 	 lock_is_held include/linux/lockdep.h:266 [inline]
> 	 rcu_read_lock_sched_held+0x41/0x90 kernel/rcu/update.c:136
> 	 trace_lock_acquire+0x49/0x120 include/trace/events/lock.h:13
> 	 lock_acquire+0x8d/0x2c0 kernel/locking/lockdep.c:5003
> 	 mutex_trylock+0xdd/0x120 kernel/locking/mutex.c:1420

*groan*, indeed! Which is the direct result of lockdep recursion because
we pulled that tracepoint out from under the recursion thing.

Let me go prod this with a sharp stick...
