Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ABDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5CE2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595935851;
	bh=MLXkc7psD4iIcSwaqdUY3rLnuAVRuWWIVacftM2ZY5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QnPzIq8G8aBwzs7awmfgdq+uXvZ7U0kBBuKhU3TdxWdGCdUmnned8FJtAtCoUH294
	 6Ssa+hm8BXA3xP5IGYF9BmyCTcdYlRLZFBl+GjLrIKX6eC1lUGJSntIt4ZBn8gTsib
	 Xm9hBdcGykcJpU2SkB88Ws3Fa0XAsafFFU4d/148=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgG1Lau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgG1Lat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:30:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7852CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:30:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l4so20220801ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FelnoziPl1weCVcahTpNmRZ5eU0TVIndxX9sUgwgWPQ=;
        b=Zk9V5lU13GHJCnY6fIAdIDYjzj/Dkfky1wqBahGNEV5DkhDQRAhBxlco0JtCSL5Brx
         IxHki1LNefunE9+097BBLCDfhIfIRG8ufEhwR7lLJK5NRMlSagtkUCI1L40tzICGdCSk
         WipS8QBgVBR08Am5RH7YZY8D7Tgj6zmoWF6CMrlBCwVb3rRZSHT7InISyJDE43oLNqJj
         4uIkTpZy6bvjgqhxHHVLawhMjZrT5TG59ncsZgR+17f8vEcbKurhgZPVF0JKzLNtWcOF
         tBp6i9td6ljuzA9Q2rp3xYoxsFp9hEdObAJRd4jz6z3NDgXV4JDKNBlNiV2J1vofAP8P
         G++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FelnoziPl1weCVcahTpNmRZ5eU0TVIndxX9sUgwgWPQ=;
        b=jnXAabp9N4As5NPSX3tsQ+V6WnAmdGbjOXL6D4lnRmpHs1/MbA35q+UDwijqH/NXZ6
         usF0cQnbrTQAIRNOJJOpqZ03M/0Ro/KrFRKm2d2IRJ8xkeroYynrRT+llZsGSsaGFtbp
         TefQxAx0IaweCBam0aAZMqLtvfx8ZYKimoeL+c1PtBc7RMtMJsE6lNgiimeygecppJoI
         B9M70R0BAzZET7qQG8jNEs457dXAs7iCBBhj/ZiRj9yMiZpINs7mroCzKWJ0Xb/2FZ1a
         hqR6ggjQgpxL9foH2nJqkm/2jovOnT7oYToxBXZpN3RQoRYam1Z5WFVxkv3gUgK/t+tQ
         aJZQ==
X-Gm-Message-State: AOAM531ZwQUoK1Bp3rq1bsKVqydL9JF1ry1RmvEyTEsab6Xz3NQZiJA6
        JW52cpF0dOAvFAejPGWwkoY=
X-Google-Smtp-Source: ABdhPJzjOMRbmRsPmCMDX4gM+H0rnTPVUoURzGHDT4kh/j2mLjPMsJ/bY0y3kkZuu806GJiW0uSbTg==
X-Received: by 2002:a17:907:100f:: with SMTP id ox15mr12454058ejb.323.1595935847173;
        Tue, 28 Jul 2020 04:30:47 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s2sm8792001ejd.17.2020.07.28.04.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:30:46 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:30:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        paulmck@kernel.org, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH tip/locking/core] kcsan: Improve IRQ state trace reporting
Message-ID: <20200728113044.GA233444@gmail.com>
References: <20200720120348.2406588-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720120348.2406588-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Marco Elver <elver@google.com> wrote:

> To improve the general usefulness of the IRQ state trace information
> with KCSAN enabled, save and restore the trace information when entering
> and exiting the KCSAN runtime as well as when generating a KCSAN report.
> 
> Without this, reporting the IRQ state trace (whether via a KCSAN report
> or outside of KCSAN via a lockdep report) is rather useless due to
> continuously being touched by KCSAN. This is because if KCSAN is
> enabled, every instrumented memory access causes changes to IRQ state
> tracking information (either by KCSAN disabling/enabling interrupts or
> taking report_lock when generating a report).
> 
> Before "lockdep: Prepare for NMI IRQ state tracking", KCSAN avoided
> touching the IRQ state trace via raw_local_irq_save/restore() and
> lockdep_off/on().
> 
> Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> 
> 
> Hi, Peter,
> 
> If this is reasonable, please take it into the branch that currently has
> the series around "lockdep: Prepare for NMI IRQ state tracking"
> (tip/locking/core?).
> 
> Thanks,
> -- Marco
> 
> 
> ---
>  include/linux/sched.h | 13 +++++++++++++
>  kernel/kcsan/core.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  kernel/kcsan/kcsan.h  |  7 +++++++
>  kernel/kcsan/report.c |  3 +++
>  4 files changed, 62 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 692e327d7455..ca5324b1657c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1199,6 +1199,19 @@ struct task_struct {
>  #endif
>  #ifdef CONFIG_KCSAN
>  	struct kcsan_ctx		kcsan_ctx;
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	struct {
> +		unsigned int		irq_events;
> +		unsigned long		hardirq_enable_ip;
> +		unsigned long		hardirq_disable_ip;
> +		unsigned int		hardirq_enable_event;
> +		unsigned int		hardirq_disable_event;
> +		unsigned long		softirq_disable_ip;
> +		unsigned long		softirq_enable_ip;
> +		unsigned int		softirq_disable_event;
> +		unsigned int		softirq_enable_event;
> +	} kcsan_save_irqtrace;
> +#endif
>  #endif
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 732623c30359..7e8347c14530 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -291,6 +291,36 @@ static inline unsigned int get_delay(void)
>  				0);
>  }
>  
> +void kcsan_save_irqtrace(struct task_struct *task)
> +{
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	task->kcsan_save_irqtrace.irq_events = task->irq_events;
> +	task->kcsan_save_irqtrace.hardirq_enable_ip = task->hardirq_enable_ip;
> +	task->kcsan_save_irqtrace.hardirq_disable_ip = task->hardirq_disable_ip;
> +	task->kcsan_save_irqtrace.hardirq_enable_event = task->hardirq_enable_event;
> +	task->kcsan_save_irqtrace.hardirq_disable_event = task->hardirq_disable_event;
> +	task->kcsan_save_irqtrace.softirq_disable_ip = task->softirq_disable_ip;
> +	task->kcsan_save_irqtrace.softirq_enable_ip = task->softirq_enable_ip;
> +	task->kcsan_save_irqtrace.softirq_disable_event = task->softirq_disable_event;
> +	task->kcsan_save_irqtrace.softirq_enable_event = task->softirq_enable_event;
> +#endif
> +}
> +
> +void kcsan_restore_irqtrace(struct task_struct *task)
> +{
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	task->irq_events = task->kcsan_save_irqtrace.irq_events;
> +	task->hardirq_enable_ip = task->kcsan_save_irqtrace.hardirq_enable_ip;
> +	task->hardirq_disable_ip = task->kcsan_save_irqtrace.hardirq_disable_ip;
> +	task->hardirq_enable_event = task->kcsan_save_irqtrace.hardirq_enable_event;
> +	task->hardirq_disable_event = task->kcsan_save_irqtrace.hardirq_disable_event;
> +	task->softirq_disable_ip = task->kcsan_save_irqtrace.softirq_disable_ip;
> +	task->softirq_enable_ip = task->kcsan_save_irqtrace.softirq_enable_ip;
> +	task->softirq_disable_event = task->kcsan_save_irqtrace.softirq_disable_event;
> +	task->softirq_enable_event = task->kcsan_save_irqtrace.softirq_enable_event;
> +#endif

Please, make such type of assignment blocks cleaner by using a local 
helper variable, and by aligning the right side vertically as well.

Also, would it make sense to unify the layout between the fields in 
task struct and the new one you introduced? That would allow a simple 
structure copy.

Thanks,

	Ingo
