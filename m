Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C81C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4051321739
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBMBsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbgBMBsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:48:52 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EA4820659;
        Thu, 13 Feb 2020 01:48:50 +0000 (UTC)
Date:   Wed, 12 Feb 2020 20:48:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zzyiwei@google.com
Cc:     mingo@redhat.com, gregkh@linuxfoundation.org, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, prahladk@google.com,
        joelaf@google.com, android-kernel@google.com
Subject: Re: [PATCH v2] Add gpu memory tracepoints
Message-ID: <20200212204848.6fe34240@oasis.local.home>
In-Reply-To: <20200213003259.128938-1-zzyiwei@google.com>
References: <20200213003259.128938-1-zzyiwei@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 16:32:59 -0800
zzyiwei@google.com wrote:

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
> +	TP_PROTO(
> +		uint32_t gpu_id,
> +		uint32_t pid,
> +		uint64_t size
> +	),
> +	TP_ARGS(
> +		gpu_id,
> +		pid,
> +		size
> +	),

This is unique whitespace parsing. Usually, this would be:

	TP_PROTO(uint32_t gpu_id, unint32_t pid, uint64_t size),

	TP_ARGS(gpu_id, pid, size),

> +	TP_STRUCT__entry(
> +		__field(uint32_t, gpu_id)
> +		__field(uint32_t, pid)
> +		__field(uint64_t, size)
> +	),
> +	TP_fast_assign(
> +		__entry->gpu_id = gpu_id;
> +		__entry->pid = pid;
> +		__entry->size = size;
> +	),
> +	TP_printk(
> +		"gpu_id=%u "
> +		"pid=%u "
> +		"size=%llu",

Breaking up a string is frowned upon.

	TP_print("gpu_id=%u pid=$u size=%llu",
		 __entry->gpu_id,
		 __entry->pid,
		 __entry->size)

-- Steve

> +		__entry->gpu_id,
> +		__entry->pid,
> +		__entry->size
> +	)
> +);
> +
> +#endif /* _TRACE_GPU_MEM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

