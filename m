Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E942CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42532078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="25pOpFy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgHUM60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:58:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4470C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fs9tyi7s7vl5c/kjSzahJIV3w7w67N8aLKAkPZ7hGos=; b=25pOpFy85n/mzSPR86PVtxsfCo
        AK+mI/loF1+JJ2xRbY50ImedRD/uuROvAy6L7HIpnMgEHU6JTxCzLJjNya5Xfg2X+Wp/Vh4+xdqyz
        BCHeA7BbQRgP9pkJhxRb4960hA/5h1pjSzqUnK3TnGfVFHBJl+GVjEK+U/gK9XR41F2Ld7alm2z9U
        gyD6HEcf2FMGp8wE6IYiwWfuAgZZplKUupFXb698WJauXNJXw9Ypy1cNGKwbOjwsw1jBYE9FQKBqo
        L9PGB8kJ9zmQ7kYY5rCDgDFHA5Mmi9dsY52WpiEreFcD+g/9AQIptNiZKLZ49QSOF3mNOlO65Uam5
        Xlt0PWLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k96cR-0002gj-B6; Fri, 21 Aug 2020 12:58:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11CDB301324;
        Fri, 21 Aug 2020 14:58:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 032F92C912D84; Fri, 21 Aug 2020 14:58:05 +0200 (CEST)
Date:   Fri, 21 Aug 2020 14:58:05 +0200
From:   peterz@infradead.org
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 00/11] TRACE_IRQFLAGS wreckage
Message-ID: <20200821125805.GO1362448@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821084738.508092956@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:47:38AM +0200, Peter Zijlstra wrote:

> TRACE_IRQFLAGS

> ---
> 
>  arch/arm/mach-omap2/pm34xx.c      |    4 --
>  arch/arm64/include/asm/irqflags.h |    5 ++
>  arch/arm64/kernel/process.c       |    2 -
>  arch/nds32/include/asm/irqflags.h |    5 ++
>  arch/powerpc/include/asm/hw_irq.h |   11 ++---
>  arch/s390/kernel/idle.c           |    3 -
>  arch/x86/entry/thunk_32.S         |    5 --
>  arch/x86/include/asm/mmu.h        |    1 
>  arch/x86/kernel/process.c         |    4 --
>  arch/x86/mm/tlb.c                 |   13 +-----
>  drivers/cpuidle/cpuidle.c         |   19 +++++++--
>  drivers/idle/intel_idle.c         |   16 --------
>  include/linux/cpuidle.h           |   13 +++---
>  include/linux/irqflags.h          |   73 ++++++++++++++++++++------------------
>  include/linux/lockdep.h           |   18 ++++++---
>  include/linux/mmu_context.h       |    5 ++
>  kernel/locking/lockdep.c          |   18 +++++----
>  kernel/sched/idle.c               |   25 +++++--------
>  18 files changed, 118 insertions(+), 122 deletions(-)

Whole set also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/wip
