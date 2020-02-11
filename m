Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03690C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDEC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWHS6CxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgBKBW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:22:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35344 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgBKBWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:22:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id z18so5755572lfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 17:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7k4dXV8FoGM6V4cI0YWcq4eSmPiy0AYAzs4mdKTUt8=;
        b=gWHS6CxGgaf/q86I/rnbaBQNitqG4dPGGM5rzHsJ4hL+10XnGNsF0CPcNTeeuh2X8v
         wr+mqFY5rA5xin8b31WKS1Cjw5/NuNbY0puioN9yWLcFq1hrH0/3CCxZxRVM5umCp2I2
         pgx2jrmIZtt/a9RrSQSKNdkUuTRGZwt3pgZGEOtzEjdXBwwNNqdwuUy4DQ8WLu++0l29
         cE0asRyOe5/IuWhKkcy7yGs6GWTuA05rla5iP5TQLZnKmS4HCr+ym/+6na45H0LSX0/3
         H4ue9NE98p6h2OEdmcgmxRKrIpz5C4XeddNASwvYJ1Og0fHnoRLvWpqLzCntqG/gkjzq
         REXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7k4dXV8FoGM6V4cI0YWcq4eSmPiy0AYAzs4mdKTUt8=;
        b=BFEXOu1bmMH93VKfgtizfqfaU3CsxUBTK1yklYi7OQ2+v+SFj0HLkhalyIjO/TqKQl
         WFNyU8qNUfUnMJqf7F3H+4htF4YgPcAh5Gtiu4RqRz9ifA2z1mT78Rd8GdfhE5BRM5eV
         w9+N4LLrrFunpHATmAjMeJo9epDBSgl9n90uBmq/RpdE5SVZn5bWuAa6Nocq5dLCFyp0
         itjh3V3mQJm15QIYHTJh9ZclSoCRgXHoOh7QTrO/fgtNGxzJ9uDABTUtzzkV1T1b5jxx
         QnOiJNL6w2wfbbSFkqKe69mLseZomZ3FOVPYmfWTC5q6gpX8ou0G7vKNekjNUrDhGqq/
         cVHQ==
X-Gm-Message-State: APjAAAVs8hXwyADJT0PsRoRmpHcNkAinjj3r7tTQN/yJDmv6ervb9jfS
        jh2uR0KH6n8H3OOzaBmtuswxqUpWDAU7OreaI0CR
X-Google-Smtp-Source: APXvYqwI8a/W8H+gQns0aDagkr5JTlgOjC9AmuZ/sfyUWT07ntLmNqCXIfLAE2xpOqxxwhjhmixwFpmAjqIKRykvZOg=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr2152855lfp.162.1581384172899;
 Mon, 10 Feb 2020 17:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20200211011631.7619-1-zzyiwei@google.com> <CAKT=dDm=qdrWCN2TVfZaaMijEX5gn_VpjA+8NaW0x9TNDf+A-A@mail.gmail.com>
In-Reply-To: <CAKT=dDm=qdrWCN2TVfZaaMijEX5gn_VpjA+8NaW0x9TNDf+A-A@mail.gmail.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Mon, 10 Feb 2020 17:22:41 -0800
Message-ID: <CAKT=dDnPV2we0LrQ3xfUEtCR3r8wpzy0BRzL_pxh1_Z+DD0Gbw@mail.gmail.com>
Subject: Re: [PATCH] Add gpu memory tracepoints
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Prahlad Kilambi <prahladk@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 5:17 PM Yiwei Zhang <zzyiwei@google.com> wrote:
>
> On Mon, Feb 10, 2020 at 5:16 PM <zzyiwei@google.com> wrote:
> >
> > From: Yiwei Zhang <zzyiwei@google.com>
> >
> > This change adds the below gpu memory tracepoint:
> > gpu_mem/gpu_mem_total: track global or process gpu memory total counters
> >
> > Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
> > ---
> >  include/trace/events/gpu_mem.h | 64 ++++++++++++++++++++++++++++++++++
> >  kernel/trace/Kconfig           |  3 ++
> >  kernel/trace/Makefile          |  1 +
> >  kernel/trace/trace_gpu_mem.c   | 13 +++++++
> >  4 files changed, 81 insertions(+)
> >  create mode 100644 include/trace/events/gpu_mem.h
> >  create mode 100644 kernel/trace/trace_gpu_mem.c
> >
> > diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
> > new file mode 100644
> > index 000000000000..3b632a2b5100
> > --- /dev/null
> > +++ b/include/trace/events/gpu_mem.h
> > @@ -0,0 +1,64 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * GPU memory trace points
> > + *
> > + * Copyright (C) 2020 Google, Inc.
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM gpu_mem
> > +
> > +#if !defined(_TRACE_GPU_MEM_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_GPU_MEM_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +/*
> > + * The gpu_memory_total event indicates that there's an update to either the
> > + * global or process total gpu memory counters.
> > + *
> > + * This event should be emitted whenever the kernel device driver allocates,
> > + * frees, imports, unimports memory in the GPU addressable space.
> > + *
> > + * @gpu_id: This is the gpu id.
> > + *
> > + * @pid: Put 0 for global total, while positive pid for process total.
> > + *
> > + * @size: Virtual size of the allocation in bytes.
> > + *
> > + */
> > +TRACE_EVENT(gpu_mem_total,
> > +       TP_PROTO(
> > +               uint32_t gpu_id,
> > +               uint32_t pid,
> > +               uint64_t size
> > +       ),
> > +       TP_ARGS(
> > +               gpu_id,
> > +               pid,
> > +               size
> > +       ),
> > +       TP_STRUCT__entry(
> > +               __field(uint32_t, gpu_id)
> > +               __field(uint32_t, pid)
> > +               __field(uint64_t, size)
> > +       ),
> > +       TP_fast_assign(
> > +               __entry->gpu_id = gpu_id;
> > +               __entry->pid = pid;
> > +               __entry->size = size;
> > +       ),
> > +       TP_printk(
> > +               "gpu_id=%u "
> > +               "pid=%u "
> > +               "size=%llu",
> > +               __entry->gpu_id,
> > +               __entry->pid,
> > +               __entry->size
> > +       )
> > +);
> > +
> > +#endif /* _TRACE_GPU_MEM_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 91e885194dbc..cb404755b0a6 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -85,6 +85,9 @@ config EVENT_TRACING
> >  config CONTEXT_SWITCH_TRACER
> >         bool
> >
> > +config TRACE_GPU_MEM
> > +       bool
> > +
> >  config RING_BUFFER_ALLOW_SWAP
> >         bool
> >         help
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index f9dcd19165fa..267985313dca 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
> >  obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
> >  obj-$(CONFIG_KPROBE_EVENT_GEN_TEST) += kprobe_event_gen_test.o
> >  obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
> > +obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
> >  obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
> >  obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
> >  obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
> > diff --git a/kernel/trace/trace_gpu_mem.c b/kernel/trace/trace_gpu_mem.c
> > new file mode 100644
> > index 000000000000..01e855897b6d
> > --- /dev/null
> > +++ b/kernel/trace/trace_gpu_mem.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * GPU memory trace points
> > + *
> > + * Copyright (C) 2020 Google, Inc.
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/gpu_mem.h>
> > +
> > +EXPORT_TRACEPOINT_SYMBOL(gpu_mem_total);
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
