Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE8C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D4A2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kqM9UM3m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ys7zINHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgGZNjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 09:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F9C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 06:38:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595770737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aK8mHiybM7KGDIOQb4ogzFG1/0wY0a9yHpZB94aoc7o=;
        b=kqM9UM3mgoKRBmoYoFlq/X9AxXb+DPkbubBKB2ux+qDVmqGnePuHv4WtlY0vS2MzqJe+IU
        pOF0qvo1Ir7YBXzxrLAb7VsRs0crODDMlaSUfbldRiK3CWh2YfqPVWt8EBqgPUcutme5m9
        lBF2lhN1twRMUZcSkQeq4JmFPEhH+C6RvOTjeDfi/X3Fx3orkF+i0IdlNy1kJonf/YoZAs
        NmeHq3Jdui3YFbKvhITqO91i9kIMM2RzBb8Xq883bdmT+Qt3i3PUXVxQEzXTw/B3bnztBG
        +peGbErniQNUYnLQT5eC2ScQpFrm3He1w6IXHwTKNUi8GTcpSfMktdijpS3LbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595770737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aK8mHiybM7KGDIOQb4ogzFG1/0wY0a9yHpZB94aoc7o=;
        b=ys7zINHrOHEk0sHnAZnrQcggLQ/Vm78PX9aj8V9zO30QPiMF/bGgWRPJHKGu65gytxl/oU
        NapQ84vB3F/1KODw==
To:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] entry: Fix CONFIG_SECCOMP assumption
In-Reply-To: <20200725091951.744848-2-mingo@kernel.org>
References: <20200725091951.744848-1-mingo@kernel.org> <20200725091951.744848-2-mingo@kernel.org>
Date:   Sun, 26 Jul 2020 15:38:57 +0200
Message-ID: <87a6zmcs5q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:
> The __secure_computing() callback only exists on CONFIG_SECCOMP=y,

No. There is a stub function for the SECCOMP=n case.

> and on architectures that have CONFIG_HAVE_ARCH_SECCOMP_FILTER.

which is a prerequiste for converting over.

> Instead of complicating the #ifdef within the generic entry code,

There is no #ifdef in the generic code and there is none required.

> make the generic entry code depend on the availability of a modern
> seccomp framework. This was implicit in the generic code due to
> x86 being a modern seccomp-filter architecture.
>
> Also move the Kconfig entry to after its HAVE_ARCH_SECCOMP_FILTER
> dependency and fix minor whitespace damage while at it.
>
> Fixes: 142781e108b1: ("entry: Provide generic syscall entry
> functionality")

I don't see what that fixes.

> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/Kconfig          | 6 ++++--
>  kernel/entry/common.c | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 852a527f418f..c2b29cfc4796 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -27,8 +27,6 @@ config HAVE_IMA_KEXEC
>  config HOTPLUG_SMT
>  	bool
>  
> -config GENERIC_ENTRY
> -       bool
>  
>  config OPROFILE
>  	tristate "OProfile system profiling"
> @@ -654,6 +652,10 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
>  	  This spares a stack switch and improves cache usage on softirq
>  	  processing.
>  
> +config GENERIC_ENTRY
> +	bool
> +	depends on HAVE_ARCH_SECCOMP_FILTER

Any architecture which wants to switch over to this should have
that. Otherwise the build will just fail and rightfully so.

>  
> +#ifdef CONFIG_SECCOMP

And the exact point of that ifdef is? This code was carefully written
NOT to have ifdefs and all non-active things are optimized out by the
compiler.


>  	/* Do seccomp after ptrace, to catch any tracer changes. */
>  	if (ti_work & _TIF_SECCOMP) {
>  		ret = __secure_computing(NULL);
>  		if (ret == -1L)
>  			return ret;
>  	}
> +#endif

Thanks,

        tglx
