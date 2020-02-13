Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D9EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39C5218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgBMODM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgBMODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:03:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0A72073C;
        Thu, 13 Feb 2020 14:03:10 +0000 (UTC)
Date:   Thu, 13 Feb 2020 09:03:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zzyiwei@google.com
Cc:     linux-kernel@vger.kernel.org, prahladk@google.com,
        joelaf@google.com, android-kernel@google.com
Subject: Re: [PATCH v3] gpu/trace: add gpu memory tracepoints
Message-ID: <20200213090308.223f3f20@gandalf.local.home>
In-Reply-To: <20200213042331.157606-1-zzyiwei@google.com>
References: <20200212222922.5dfa9f36@oasis.local.home>
        <20200213042331.157606-1-zzyiwei@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yiwei,

You left off a lot of people that you Cc'd for the previous versions.
You'll need at least Greg's acked-by on this, and perhaps even others
that own the gpu directory.

-- Steve


On Wed, 12 Feb 2020 20:23:31 -0800
zzyiwei@google.com wrote:

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
>  obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
>  obj-y			+= drm/ vga/
>  obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
> +obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
> diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
> new file mode 100644
> index 000000000000..c24e9edd022e
> --- /dev/null
> +++ b/drivers/gpu/trace/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config TRACE_GPU_MEM
> +	bool
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
> +	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> +
> +	TP_ARGS(gpu_id, pid, size),
> +
> +	TP_STRUCT__entry(
> +		__field(uint32_t, gpu_id)
> +		__field(uint32_t, pid)
> +		__field(uint64_t, size)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->gpu_id = gpu_id;
> +		__entry->pid = pid;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("gpu_id=%u pid=%u size=%llu",
> +		__entry->gpu_id,
> +		__entry->pid,
> +		__entry->size)
> +);
> +
> +#endif /* _TRACE_GPU_MEM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

