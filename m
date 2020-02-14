Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16EEC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C1622314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581723607;
	bh=P3PrqY8rGU0zQljxzqKpqhR6KHKcyTeu6sKBhqLMeR8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZepAMrHD1jsnIVot/qoF0srxSdIR5AV+MgR9bVeJZ1qCQB8z/BIxBuk8lRlgu1cdV
	 pVoNPK7E8jCOP//6Mt2qoWm4YLYCPYlW8XSsQlziyOc6U/bilM5nPEJFqSqcDLV3Hb
	 7sS6bQgi4knSpJBYTucUuAq8yhe16f+wefXixTa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgBNXkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBNXkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:40:06 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B078E2187F;
        Fri, 14 Feb 2020 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723605;
        bh=P3PrqY8rGU0zQljxzqKpqhR6KHKcyTeu6sKBhqLMeR8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZoJanWRXUKxRt9zUSLc6Vh8940BKILbjXhvzhIxo+lsp3tVu1BmoITDnwbDD13msK
         9nPdOOXLYrYeW2X/3W0U6AyO16dgv+CQf17Nk6v3T/x7j73J6uRM5wV9+U8fEpCMIh
         UC/QEEYqUCRQ3VUp27ocIsRIrGBtsYaKrTynr0Zo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4A98E3520D46; Fri, 14 Feb 2020 15:40:04 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:40:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, x86@kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] kcsan, trace: Make KCSAN compatible with tracing
Message-ID: <20200214234004.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214211035.209972-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214211035.209972-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:10:35PM +0100, Marco Elver wrote:
> Previously the system would lock up if ftrace was enabled together with
> KCSAN. This is due to recursion on reporting if the tracer code is
> instrumented with KCSAN.
> 
> To avoid this for all types of tracing, disable KCSAN instrumentation
> for all of kernel/trace.
> 
> Furthermore, since KCSAN relies on udelay() to introduce delay, we have
> to disable ftrace for udelay() (currently done for x86) in case KCSAN is
> used together with lockdep and ftrace. The reason is that it may corrupt
> lockdep IRQ flags tracing state due to a peculiar case of recursion
> (details in Makefile comment).
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Queued for review and further testing, thank you!

Qian, does this also fix things for you?

							Thanx, Paul

> ---
> v2:
> *  Fix KCSAN+lockdep+ftrace compatibility.
> ---
>  arch/x86/lib/Makefile | 5 +++++
>  kernel/kcsan/Makefile | 2 ++
>  kernel/trace/Makefile | 3 +++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 432a077056775..6110bce7237bd 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -8,6 +8,11 @@ KCOV_INSTRUMENT_delay.o	:= n
>  
>  # KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
>  KCSAN_SANITIZE_delay.o := n
> +ifdef CONFIG_KCSAN
> +# In case KCSAN+lockdep+ftrace are enabled, disable ftrace for delay.o to avoid
> +# lockdep -> [other libs] -> KCSAN -> udelay -> ftrace -> lockdep recursion.
> +CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
> +endif
>  
>  # Early boot use of cmdline; don't instrument it
>  ifdef CONFIG_AMD_MEM_ENCRYPT
> diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> index df6b7799e4927..d4999b38d1be5 100644
> --- a/kernel/kcsan/Makefile
> +++ b/kernel/kcsan/Makefile
> @@ -4,6 +4,8 @@ KCOV_INSTRUMENT := n
>  UBSAN_SANITIZE := n
>  
>  CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
>  
>  CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
>  	$(call cc-option,-fno-stack-protector,)
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f9dcd19165fa2..6b601d88bf71e 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -6,6 +6,9 @@ ifdef CONFIG_FUNCTION_TRACER
>  ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
>  
> +# Avoid recursion due to instrumentation.
> +KCSAN_SANITIZE := n
> +
>  ifdef CONFIG_FTRACE_SELFTEST
>  # selftest needs instrumentation
>  CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
