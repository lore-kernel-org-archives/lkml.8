Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F4DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875DC20772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNbA+6MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgFEKj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgFEKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:39:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50856C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aT+9NRnOBIlqLniHO50ccPmQB5HZk8z1IetP+yjLpxk=; b=DNbA+6MJ8eOHPyR72vL3lR5TA3
        vaCgXxg3pxvcW2ANuw0iB4f0cNCCx+pwurLnRvjRIPXTMOVbEBrESKwlSitCvulreX7oGIYAIGSWZ
        1oMf4fdvZ46gqAiCku2JWSDHXjX+uIi8/TwYhUAw79NFkRd3kb833CYqdEg70ydBZ6Svot28BszWj
        BQTzAXI2w2gcw2AQi7tdoXlx8aJ8RlbwQ5dfMRESMBmsC4fYEuiFsNfUWfYfIFiP9etOcAOVCcSxP
        P8VwafrwBH6Gt+DxAf8P7t0+SDjwmOK/rLOL+vkNVkNhKPIT8NWB+j5Kx6d7i4xLb2tWYxRII1ptO
        pac2lQWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jh9kb-0004N9-Lj; Fri, 05 Jun 2020 10:39:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B146301A7A;
        Fri,  5 Jun 2020 12:38:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82F9221A74B26; Fri,  5 Jun 2020 12:38:59 +0200 (CEST)
Date:   Fri, 5 Jun 2020 12:38:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200605103859.GI3976@hirez.programming.kicks-ass.net>
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604225445.GA32319@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:54:45PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> I get the splat below at a rate of roughly two per thirty hours when
> running rcutorture scenario TREE03 on x86 at the June 3rd mainline commit:
> 
> cb8e59cc8720 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")
> 
> Running 140 hours of this same scenario at the following June 2nd mainline
> commit shows no errors:
> 
> d9afbb350990 ("Merge branch 'next-general' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security")
> 
> I have started a bisection, but it is likely to take several days to
> complete.  I am looking at ways of speeding this up, but in the meantime,
> I figured that I should check to see if others are also encountering this.
> 
> Thoughts?

I think this shows there's a boo-boo with the IPI patches. I've not
managed to reproduce, but I'll give them another hard look.

Would you have a .config for me? My compiler's check_preempt_wakeup
isn't anywhere near 0x180 bytes long. I'm thiknig you have
instrumentation enabled, KCSAN?

> BUG: kernel NULL pointer dereference, address: 0000000000000150
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0 
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 9 PID: 196 Comm: rcu_torture_rea Not tainted 5.7.0+ #3923
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:check_preempt_wakeup+0xb1/0x180
> Code: 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 75 05 48 85 ff 75 29 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 0f 95 c2 48 85 ff 0f 94
> RSP: 0018:ffffaccdc02ecd38 EFLAGS: 00010006
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffafa0bc20
> RDX: 0000000000000000 RSI: ffff946b5df50000 RDI: ffff946b5f469340
> RBP: 0000000000000000 R08: ffff946b5df80d00 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff946b5f469300
> R13: 0000000000000001 R14: ffff946b5df80d00 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff946b5f440000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000150 CR3: 0000000016e0a000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  check_preempt_curr+0x5d/0x90
>  ttwu_do_wakeup.isra.93+0xf/0x100
>  sched_ttwu_pending+0x66/0x90
>  smp_call_function_single_interrupt+0x2d/0xf0
>  call_function_single_interrupt+0xf/0x20

Right, so I frobbed at that recently, see:

a148866489fbe243c936fe43e4525d8dbfa0318f...19a1f5ec699954d21be10f74ff71c2a7079e99ad

