Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D66C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590E824656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCIT5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgCIT5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:57:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C1A24654;
        Mon,  9 Mar 2020 19:57:23 +0000 (UTC)
Date:   Mon, 9 Mar 2020 15:57:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, elver@google.com,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw, boqun.feng@gmail.com
Subject: Re: [PATCH kcsan 26/32] kcsan, trace: Make KCSAN compatible with
 tracing
Message-ID: <20200309155722.49d6bb93@gandalf.local.home>
In-Reply-To: <20200309190420.6100-26-paulmck@kernel.org>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
        <20200309190420.6100-26-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Mar 2020 12:04:14 -0700
paulmck@kernel.org wrote:

> From: Marco Elver <elver@google.com>
> 
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

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/lib/Makefile | 5 +++++
>  kernel/kcsan/Makefile | 2 ++
>  kernel/trace/Makefile | 3 +++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 432a077..6110bce7 100644
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
> index df6b779..d4999b3 100644
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
> index 0e63db6..9072486 100644
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

