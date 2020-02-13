Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E2C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EC320848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/5CQnxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgBMCYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:24:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33903 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgBMCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:24:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so3091280lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 18:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSarFzjCUH3kfS4CDHva3yRADeTQImCV43e7gEOMFvI=;
        b=c/5CQnxQFDr/RNYTm+RIliW9eEBeHgcmwBSWnUfKi2ivZfDBTn74yJWP4d/+7gIvmG
         3+jZKOVgS/gFuiJNGzp52GqqGdghIRnJcL5We8OdB44dZWO/hWEhHHSOVBpJ9qc0q7E5
         LeUQPCZcJnWxyypTM2K7m2XozNuTNCzxqsG2wgsoIoFK3Jn25uRqMCIi1R5xP3S7yiR1
         NZpubzVdS+f6QdJ80S3tjGzD5V9fMCUrGSBFKHwF7EMkEnVprRjYvQ5ikvv9d/wxojHw
         nsg/dRF5DOJiTi8uY7DfcTg20mw/cCI50XtZl66BljC37Z9bhc+0fKiVwbPVhdzN1xC0
         nE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSarFzjCUH3kfS4CDHva3yRADeTQImCV43e7gEOMFvI=;
        b=mGz72lmtYBxp38bvp40yW57TQoqjeUXjXQWJxJA4p805Cij81WyfqsM2Uzu6qNI8Ll
         ZHjNOc5k8PaHXhiNSCkKtThYFWJJPBuAp1A4kZPa3ZGyTzQG8P7bCs7/yq8CjWbdraLA
         l8g70byUdOQfZc1SN78Cga667HPxyBUl4yfKS/FOgO3J2pR1+Ag9hU+CnD5krFNn0MS8
         HIT+5WQpECX7mO0kUrSPt0kE/dBAoW7NyXvzXb/SGKLmgH/I0ldRHklzTuYJW2oHD9qT
         8xrPiAdQhdjUDwA/CPLxzO8XW6eOQjfa43hU7MLOOuFqKD9c1xdNYCzcXkTZPU9qUJRC
         Rhng==
X-Gm-Message-State: APjAAAVQPPLLodPMt9xPMwS8gSNED+V1/aZ/7MW//YEcwn9Rur8OiM6o
        FJza6ncLWIBKgC6MLEuXG7eTL2WooGMi2kXcCXwC
X-Google-Smtp-Source: APXvYqyRAqzP8Y3IiEI5dd9p5cY7cp5n7ioRzJnw9nkA/mJGUikGOcsIXnmzhuH3vM7hPiRwMkqgfFc6WN6YmgGMxGc=
X-Received: by 2002:ac2:485c:: with SMTP id 28mr8007115lfy.118.1581560683728;
 Wed, 12 Feb 2020 18:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20200213003259.128938-1-zzyiwei@google.com> <20200213022020.142379-1-zzyiwei@google.com>
In-Reply-To: <20200213022020.142379-1-zzyiwei@google.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Wed, 12 Feb 2020 18:24:32 -0800
Message-ID: <CAKT=dDnkfS9buZut8JwBTNO3duRbWX_mL=VpP1rK1yaucaFA8A@mail.gmail.com>
Subject: Re: [PATCH v2] Add gpu memory tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>,
        yamada.masahiro@socionext.com, tglx@linutronix.de,
        vilhelm.gray@gmail.com, tony.luck@intel.com, federico.vaga@cern.ch,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        elder@kernel.org, mingo@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I'm not sure if my use of "in-reply-to" is correct. I can only find
the Message-Id of my original email from cmdline. but looks like the
diff shows up right.

Best,
Yiwei

On Wed, Feb 12, 2020 at 6:20 PM <zzyiwei@google.com> wrote:
>
> From: Yiwei Zhang <zzyiwei@google.com>
>
> This change adds the below gpu memory tracepoint:
> gpu_mem/gpu_mem_total: track global or process gpu memory total counters
>
> Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
> ---
>  drivers/Kconfig                   |  2 ++
>  drivers/gpu/Makefile              |  1 +
>  drivers/gpu/trace/Kconfig         |  4 +++
>  drivers/gpu/trace/Makefile        |  3 ++
>  drivers/gpu/trace/trace_gpu_mem.c | 13 +++++++
>  include/trace/events/gpu_mem.h    | 57 +++++++++++++++++++++++++++++++
>  6 files changed, 80 insertions(+)
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
> index 000000000000..1897822a9150
> --- /dev/null
> +++ b/include/trace/events/gpu_mem.h
> @@ -0,0 +1,57 @@
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
> +
> +       TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> +
> +       TP_ARGS(gpu_id, pid, size),
> +
> +       TP_STRUCT__entry(
> +               __field(uint32_t, gpu_id)
> +               __field(uint32_t, pid)
> +               __field(uint64_t, size)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->gpu_id = gpu_id;
> +               __entry->pid = pid;
> +               __entry->size = size;
> +       ),
> +
> +       TP_printk("gpu_id=%u pid=%u size=%llu",
> +               __entry->gpu_id,
> +               __entry->pid,
> +               __entry->size)
> +);
> +
> +#endif /* _TRACE_GPU_MEM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> --
> 2.25.0.225.g125e21ebc7-goog
>
