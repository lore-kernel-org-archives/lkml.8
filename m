Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C7DC352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4021739
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFh6DZtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgBMAj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:39:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37911 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgBMAj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:39:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so2932205lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfNXDyevJ626cFwOGGogMoXkBP5ywYOilgnnQtQl9t0=;
        b=JFh6DZtuiD721iox9F+GfVDF9vVt6Qpa5+PIV6NgbZ4HtOANt195lSwmGcNkYsSdVz
         x1m0uauEiogtNcmWTBckYjXxTZL10QCky9zIaVkitHXVHxFQSxRqGyelyjGlAQ86SPoR
         QdP9wxKn7UNZ8yMA6XUySHujhrzw7XB3zNQT9X5zSQXRHaPglhCAL2BkxLnUspYeAH3K
         94FxM0KP79IjiZahTDElHWTewj6/fFMGorBcv98l/nxI05+BHW8k4SeSJ91AY5cza9z5
         +loCwoKNR4j23SnYhYp5Lgwi2NcvQAosRx4MzObH9aqOYpHsrocuvO3BXAMvX6jO8rAm
         GrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfNXDyevJ626cFwOGGogMoXkBP5ywYOilgnnQtQl9t0=;
        b=gnqm1JSsa2K+j7slHu2lxA0GrLtaw99LIMSZxwZiLAiq+0HVyVcAutU3TpR/j9G7m7
         nkSAfgStjNb/anIOLo/S7DEdbv1QQKarMX+N1SOEfIKjfO6WFfpWpcPUGcr5xmc7QavP
         E9AIOL3PIiiUPsvxY+2P/UQ8AKIoFvjTG+MNzVTgGZHqneuaeDSHlaBLrNCptbueuXIB
         ZhFLGBp4i35SOq6/PTfphNKNxAZihY5Kh4Fw8tN0Ho5fwgpiw3RGNaT1xwJswoG8Ck7p
         cA8va8da2VuK8wAWXUE7+/zTAgSzEU6OrPFbiks/wwQ8RWhTmH5Jg0mSctvHzfvNiQGM
         nBfg==
X-Gm-Message-State: APjAAAWbnaCym7KcxMYRgH8xC1xtAhmfwsJTeBF9dpTGDcSZFspigv10
        GT9IKkf+zlziZER5H+CSEKip2LRmdIizhCstGF4r
X-Google-Smtp-Source: APXvYqwQn7RuW9r/cAxmw6FIlMYidHrVr3T6Rmw3sZSfsrHBFZWWX0rMMQwkpFQtuGc/O8l9ifxP8IZi6GjYSnKGvAA=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr7959353lfp.162.1581554366209;
 Wed, 12 Feb 2020 16:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20200213003259.128938-1-zzyiwei@google.com>
In-Reply-To: <20200213003259.128938-1-zzyiwei@google.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Wed, 12 Feb 2020 16:39:15 -0800
Message-ID: <CAKT=dDmpUVuuuDNQjgrfvwmj6ZQU7huM+3-tRVw4ap7FaxUwrw@mail.gmail.com>
Subject: Re: [PATCH v2] Add gpu memory tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        gregkh@linuxfoundation.org, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org
Cc:     Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context is here: https://lkml.org/lkml/2020/2/10/1903 and
https://lkml.org/lkml/2020/2/12/997

On Wed, Feb 12, 2020 at 4:33 PM <zzyiwei@google.com> wrote:
>
> From: Yiwei Zhang <zzyiwei@google.com>
>
> This change adds the below gpu memory tracepoint:
> gpu_mem/gpu_mem_total: track global or process gpu memory total counters
>
> Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
> ---
>  drivers/Kconfig                   |  2 +
>  drivers/gpu/Makefile              |  1 +
>  drivers/gpu/trace/Kconfig         |  4 ++
>  drivers/gpu/trace/Makefile        |  3 ++
>  drivers/gpu/trace/trace_gpu_mem.c | 13 +++++++
>  include/trace/events/gpu_mem.h    | 64 +++++++++++++++++++++++++++++++
>  6 files changed, 87 insertions(+)
>  create mode 100644 drivers/gpu/trace/Kconfig
>  create mode 100644 drivers/gpu/trace/Makefile
>  create mode 100644 drivers/gpu/trace/trace_gpu_mem.c
>  create mode 100644 include/trace/events/gpu_mem.h
>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 8befa53f43be..e0eda1a5c3f9 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -200,6 +200,8 @@ source "drivers/thunderbolt/Kconfig"
>
>  source "drivers/android/Kconfig"
>
> +source "drivers/gpu/trace/Kconfig"
> +
>  source "drivers/nvdimm/Kconfig"
>
>  source "drivers/dax/Kconfig"
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index f17d01f076c7..835c88318cec 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -5,3 +5,4 @@
>  obj-$(CONFIG_TEGRA_HOST1X)     += host1x/
>  obj-y                  += drm/ vga/
>  obj-$(CONFIG_IMX_IPUV3_CORE)   += ipu-v3/
> +obj-$(CONFIG_TRACE_GPU_MEM)            += trace/
> diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
> new file mode 100644
> index 000000000000..c24e9edd022e
> --- /dev/null
> +++ b/drivers/gpu/trace/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config TRACE_GPU_MEM
> +       bool
> diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
> new file mode 100644
> index 000000000000..b70fbdc5847f
> --- /dev/null
> +++ b/drivers/gpu/trace/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
> diff --git a/drivers/gpu/trace/trace_gpu_mem.c b/drivers/gpu/trace/trace_gpu_mem.c
> new file mode 100644
> index 000000000000..01e855897b6d
> --- /dev/null
> +++ b/drivers/gpu/trace/trace_gpu_mem.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPU memory trace points
> + *
> + * Copyright (C) 2020 Google, Inc.
> + */
> +
> +#include <linux/module.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/gpu_mem.h>
> +
> +EXPORT_TRACEPOINT_SYMBOL(gpu_mem_total);
> diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
> new file mode 100644
> index 000000000000..3b632a2b5100
> --- /dev/null
> +++ b/include/trace/events/gpu_mem.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * GPU memory trace points
> + *
> + * Copyright (C) 2020 Google, Inc.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM gpu_mem
> +
> +#if !defined(_TRACE_GPU_MEM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_GPU_MEM_H
> +
> +#include <linux/tracepoint.h>
> +
> +/*
> + * The gpu_memory_total event indicates that there's an update to either the
> + * global or process total gpu memory counters.
> + *
> + * This event should be emitted whenever the kernel device driver allocates,
> + * frees, imports, unimports memory in the GPU addressable space.
> + *
> + * @gpu_id: This is the gpu id.
> + *
> + * @pid: Put 0 for global total, while positive pid for process total.
> + *
> + * @size: Virtual size of the allocation in bytes.
> + *
> + */
> +TRACE_EVENT(gpu_mem_total,
> +       TP_PROTO(
> +               uint32_t gpu_id,
> +               uint32_t pid,
> +               uint64_t size
> +       ),
> +       TP_ARGS(
> +               gpu_id,
> +               pid,
> +               size
> +       ),
> +       TP_STRUCT__entry(
> +               __field(uint32_t, gpu_id)
> +               __field(uint32_t, pid)
> +               __field(uint64_t, size)
> +       ),
> +       TP_fast_assign(
> +               __entry->gpu_id = gpu_id;
> +               __entry->pid = pid;
> +               __entry->size = size;
> +       ),
> +       TP_printk(
> +               "gpu_id=%u "
> +               "pid=%u "
> +               "size=%llu",
> +               __entry->gpu_id,
> +               __entry->pid,
> +               __entry->size
> +       )
> +);
> +
> +#endif /* _TRACE_GPU_MEM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> --
> 2.25.0.225.g125e21ebc7-goog
>
