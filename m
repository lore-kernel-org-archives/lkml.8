Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D812C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668472076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oA0RL+AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHLI5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHLI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:57:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741C0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nuSjbKLmgFUpujyztO9pZIgg8RwXK/k205UIQiNkmjY=; b=oA0RL+AUZC/9NzFpw32e8YGbiG
        0VcMjRTkK6gzyi6LHeQnGMZedrE247e0AD0iS9PuK19STFCes37/7sZrX2+QhWxirH2ub40je4iSp
        eTVV6/KGsbaHq+ZjwBe0fSjKLulkT0uN3I1uNocq1V2rleacFT0UF1OA3jexfzOBZJuS/DI+oZDlq
        cke/wCMKg4rXrUcFiI0Vwu+4dhGJukasRcaQhlVemsjENOmzGa5wH1E/hJztIE2IqScefyAxnVEd0
        FHgbU+yagNuIlrDxAdcOW3YNd1gw/+VNhqX8mx0uvYlgj5jc1KnHHWYHoE5T0UnEnArqR0mQRo7p2
        RtNwIp6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5mZT-0007yN-FP; Wed, 12 Aug 2020 08:57:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3137830753E;
        Wed, 12 Aug 2020 10:57:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F43625D0D543; Wed, 12 Aug 2020 10:57:17 +0200 (CEST)
Date:   Wed, 12 Aug 2020 10:57:17 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
Cc:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200812085717.GJ35926@hirez.programming.kicks-ass.net>
References: <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
 <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
 <20200811092054.GB2674@hirez.programming.kicks-ass.net>
 <20200811094651.GH35926@hirez.programming.kicks-ass.net>
 <20200811201755.GI35926@hirez.programming.kicks-ass.net>
 <20200812080650.GA3894595@elver.google.com>
 <20200812081832.GK2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812081832.GK2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:18:32AM +0200, peterz@infradead.org wrote:
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 
> > 	<... repeated many many times ...>
> > 
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	Lost 500 message(s)!
> > 	BUG: stack guard page was hit at 00000000cab483ba (stack is 00000000b1442365..00000000c26f9ad3)
> > 	BUG: stack guard page was hit at 00000000318ff8d8 (stack is 00000000fd87d656..0000000058100136)
> > 	---[ end trace 4157e0bb4a65941a ]---
> 
> Wheee... recursion! Let me try and see if I can make something of that.

All that's needed is enabling the preemptirq tracepoints. Lemme go fix.
