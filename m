Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55A0C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6542085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgD1Slk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:41:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:41422 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbgD1Sle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:41:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47A0744A;
        Tue, 28 Apr 2020 18:41:34 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:41:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] docs: sysctl/kernel: document ftrace entries
Message-ID: <20200428124133.0fbaf7c5@lwn.net>
In-Reply-To: <20200423183651.15365-2-steve@sk2.org>
References: <20200423183651.15365-1-steve@sk2.org>
        <20200423183651.15365-2-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 20:36:50 +0200
Stephen Kitt <steve@sk2.org> wrote:

> Based on the ftrace documentation, the tp_printk boot parameter
> documentation, and the implementation in kernel/trace/trace.c.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

This one could benefit from an ack from Steve (CC'd).  Also one other
little nit below:

>  Documentation/admin-guide/sysctl/kernel.rst | 50 +++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 82bfd5892663..d4bbdaf96ebc 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -265,6 +265,27 @@ domain names are in general different. For a detailed discussion
>  see the ``hostname(1)`` man page.
>  
>  
> +ftrace_dump_on_oops
> +===================
> +
> +Determines whether ``ftrace_dump()`` should be called on an oops (or
> +kernel panic). This will output the contents of the ftrace buffers to
> +the console.  This is very useful for capturing traces that lead to
> +crashes and outputing it to a serial console.
> +
> += ===================================================
> +0 Disabled (default).
> +1 Dump buffers of all CPUs.
> +2 Dump the buffer of the CPU that triggered the oops.
> += ===================================================
> +
> +
> +ftrace_enabled, stack_tracer_enabled
> +====================================
> +
> +See :doc:`/trace/ftrace`.
> +
> +
>  hardlockup_all_cpu_backtrace
>  ============================
>  
> @@ -1191,6 +1212,35 @@ If a value outside of this range is written to ``threads-max`` an
>  ``EINVAL`` error occurs.
>  
>  
> +traceoff_on_warning
> +===================
> +
> +When set, disables tracing (see :doc:`/trace/ftrace`) when a
> +``WARN()`` is hit.
> +
> +
> +tracepoint_printk
> +=================
> +
> +When tracepoints are sent to printk() (enabled by the ``tp_printk``
> +boot parameter), this entry provides runtime control::
> +
> +    echo 0 > /proc/sys/kernel/tracepoint_printk
> +
> +will stop tracepoints from being sent to printk(), and
> +
> +::

I would just make that ", and::" and avoid the separate line.

> +
> +    echo 1 > /proc/sys/kernel/tracepoint_printk
> +
> +will send them to printk() again.
> +
> +This only works if the kernel was booted with ``tp_printk`` enabled.
> +
> +See :doc:`/admin-guide/kernel-parameters` and
> +:doc:`/trace/boottime-trace`.
> +
> +
>  unknown_nmi_panic
>  =================
>  

Thanks,

jon
