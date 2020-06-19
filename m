Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4DD21556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zp7wbghX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbgFSSLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFSSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:11:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C6C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RlTbO/ySGCld/EqXTk8DFn5MI7q+hzjQi9/I5bKcuZo=; b=Zp7wbghX5O/7gHboFZepzQFW5O
        91zOt7qScEz0lnbQrUMZRgUF/4V0Iebpu+CjpNpygCYADLRXY2z0NRZziA9wiaUKB+OtOUSnwd1b2
        xwG3CMQwzu5jqzldOm6oWmbYU5yV2/hiloF7ekth82/Gf0b6WlmpvsUZTZT2E4BQF3BWI2Jj3QXu2
        lkYhaBW3oj4zYKBpve/ftsbXj5kcGhQZx1gluH3kfD0sBhxrSJxbnF+69hgRsMCKN6/Fn+WUCM+dz
        9PTFgmRP14MnF+ghf0J9tQTFPyOzeUITxGRwUng3AjPoxNfotDq1nxzMkHE54YgsgZG6uvd0uoRd0
        JGYlmxvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmLUB-0005wd-5N; Fri, 19 Jun 2020 18:11:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F62030018A;
        Fri, 19 Jun 2020 20:11:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE80B2C36DD93; Fri, 19 Jun 2020 20:11:28 +0200 (CEST)
Date:   Fri, 19 Jun 2020 20:11:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        npiggin@gmail.com
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200619181128.GC576888@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
 <20200615191158.GK2531@hirez.programming.kicks-ass.net>
 <20200616170410.GL2554@hirez.programming.kicks-ass.net>
 <20200616171721.GM2554@hirez.programming.kicks-ass.net>
 <20200619134423.GB577403@hirez.programming.kicks-ass.net>
 <20200619172047.GK2723@paulmck-ThinkPad-P72>
 <20200619174802.GA10403@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619174802.GA10403@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:48:02AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 19, 2020 at 10:20:47AM -0700, Paul E. McKenney wrote:

> > > @@ -2615,7 +2617,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> > >  	 * let the waker make forward progress. This is safe because IRQs are
> > >  	 * disabled and the IPI will deliver after on_cpu is cleared.
> > >  	 */
> > > -	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
> > > +	if (smp_load_acquire(&p->on_cpu) &&
> 
> Given the x86 memory model, this only protects against the compiler
> reordering accesses in ttwu_queue_wakelist() against the fetch of
> p->on_cpu, correct?

Yes.

> Don't get me wrong, I do see some potential compiler misorderings,
> including with cpu_rq(cpu)->nr_running.  Just curious.

Given this is arch independent code, I'd better write generic code, and
there I really think this wants to be acquire. I'll also try and write a
comment for next time.

