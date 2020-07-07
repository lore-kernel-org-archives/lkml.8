Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DFD206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmmLp4Dx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3VVJSWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGHeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGHeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:34:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAC2C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:34:20 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:34:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594107258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NThXY8gXYlYvd8/JfuwmR/mVqUOlROOhRtkmtCJ5LSs=;
        b=zmmLp4DxMPQwknqTKTBWBzRAPuWGMUhfuTOTNuSdx+zCGxSLCUIgZ4Zi3tBUOEjVk4nXGJ
        RI6uCM0hhxCvZMOjgIXW2UraEqxYsNTtq0YtgG3m7ZsAlf0uZsJEOchmHvIMwbWtyEsI0f
        SCD+BXa1cAEP6EaZVQ4RLwD6Zu0AEB89B6T5hTm3KUtuyDhGAOxT1igwwIHGjZForEW/QP
        aRyqRpU1mIbejcYc9kS1PXCLKTYV4g4ily+RqqCyIieBMH3VJkA32EF9zU0y/sOBUEhMnT
        6RjJyRj83Fk90sy382zi1XSezmXviA2Xf7O56PN/itDxKUzVx14ufn9A6pOUfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594107258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NThXY8gXYlYvd8/JfuwmR/mVqUOlROOhRtkmtCJ5LSs=;
        b=E3VVJSWVvpLlSz1Sdw0fSbXnvgbEHLre6K7w8IZv3Hm+KuFs4HiOOMQI5TWBU1wLaMXI2Y
        cZ0ldoZngI21TTCQ==
From:   "Sebastian A. Siewior" <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/20] lockdep: Add preemption enabled/disabled
 assertion APIs
Message-ID: <20200707073416.yyvxweonkotf72oq@linutronix.de>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-5-a.darwish@linutronix.de>
 <20200706205004.GC5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706205004.GC5523@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-06 22:50:04 [+0200], Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 07:44:36AM +0200, Ahmed S. Darwish wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d74ac0fd6b2d..e5e2e632b749 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1118,6 +1118,7 @@ config PROVE_LOCKING
> >  	select DEBUG_RWSEMS
> >  	select DEBUG_WW_MUTEX_SLOWPATH
> >  	select DEBUG_LOCK_ALLOC
> > +	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
> >  	select TRACE_IRQFLAGS
> >  	default n
> >  	help
> 
> I suspect this can be done unconditional, the thing that requires arch
> support is CONFIG_PREEMPTION.

|$ git grep -C 2 PREEMPT_COUNT lib/Kconfig.debug 
|lib/Kconfig.debug-config DEBUG_ATOMIC_SLEEP
|lib/Kconfig.debug-      bool "Sleep inside atomic section checking"
|lib/Kconfig.debug:      select PREEMPT_COUNT
|lib/Kconfig.debug-      depends on DEBUG_KERNEL
|lib/Kconfig.debug-      depends on !ARCH_NO_PREEMPT

There will be a build fault if you force preempt_count.

Sebastian
