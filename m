Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E98020873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hPHSSPqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgBNTf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:35:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43905 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgBNTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:35:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so7737367qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yb1Saty64VwiYtQw012LpM7Ap4tjw5lo68MqBy5+/VM=;
        b=hPHSSPqt0nNC2m3jft0uX/iIsH6E+Ux0ehwtz7fglLs3w7OY2cI+j3N3spIgVLJdLN
         iePRrPUg4ftxW2Jiwldqt3Mkd9EmfTlYYymGc5rJw/CW30Vs1mptipeuKEuBL6DYxFzj
         Eo5qLWgnHXtsYXfucnEoqDRVdaEWi1mNBRjF3Slfx7hLlPmOZcWSBfBNmhIw/d3b599m
         Oj2Z0yY9h4M6KbTInG1vrkr3x8zHDMC/3Xnf/qWAWqlBMWjnTxUVXXVEugIDoVDDBxJX
         tDKrhTKeRQbyJc/aV0Zm0dMflZnK0dtqoVu79oDpVDLJ1rVMqYI7MFxRORjF9WWCPgOW
         3AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yb1Saty64VwiYtQw012LpM7Ap4tjw5lo68MqBy5+/VM=;
        b=qdEQ4TgjkIm9KWx1vG7dEA4vdcDnHwyM+PEkeIZvw7N4UcBmsosPo82oFruh5rWEr3
         HIAjc35zYt9qrEUedFzeM3AJkv08aMz9eQelR0Rr8cfT/VAHoJ4da0aYQWHARBrYk8b3
         5V3mELz+o2Z1q977z5K4gSzU10bYpkx/Brl3Ra+z0tMcXXK/hFL0O70A49p/eN08cJf5
         LEE5r6zjpoLWQNJFJdnFhjggm6wVAcSLikvOK9xmCCH/O4RSUAE3sZYhI05lSwPZ20xK
         TPwQgTr38NCkqQsB/zW93WwJfXuIM55xZHMDwXfJZinXtcSU+D/NeWIfADylzj36wyL7
         wFQg==
X-Gm-Message-State: APjAAAX7xtVqPDBeL03Uuk2du2VTeWNkOp81YCLz73zdfBruqQvPaG62
        g8Tstk5NSIBaDbyeyKW5jhzWtA==
X-Google-Smtp-Source: APXvYqwrQA7pXiL1hh4mW0TuJitBe1OgRXLldhR9YeEp8NM+v+FjPJEuEZTge0NncA0cgpC44WbdMA==
X-Received: by 2002:aed:2ce4:: with SMTP id g91mr3869190qtd.352.1581708958590;
        Fri, 14 Feb 2020 11:35:58 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l25sm3762879qkk.115.2020.02.14.11.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 11:35:58 -0800 (PST)
Message-ID: <1581708956.7365.75.camel@lca.pw>
Subject: Re: [PATCH] kcsan, trace: Make KCSAN compatible with tracing
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Date:   Fri, 14 Feb 2020 14:35:56 -0500
In-Reply-To: <20200214190500.126066-1-elver@google.com>
References: <20200214190500.126066-1-elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 20:05 +0100, Marco Elver wrote:
> Previously the system would lock up if ftrace was enabled together with
> KCSAN. This is due to recursion on reporting if the tracer code is
> instrumented with KCSAN.
> 
> To avoid this for all types of tracing, disable KCSAN instrumentation
> for all of kernel/trace.

I remembered that KCSAN + ftrace was working last week, but I probably had a bad
memory. Anyway, this patch works fine. Feel free to add,

Tested-by: Qian Cai <cai@lca.pw>

> 
> Signed-off-by: Marco Elver <elver@google.com>
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/kcsan/Makefile | 2 ++
>  kernel/trace/Makefile | 3 +++
>  2 files changed, 5 insertions(+)
> 
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
