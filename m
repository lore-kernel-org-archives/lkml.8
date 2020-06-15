Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9603D207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgFOVNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOVNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:13:40 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B2B207DD;
        Mon, 15 Jun 2020 21:13:39 +0000 (UTC)
Date:   Mon, 15 Jun 2020 17:13:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] tracing/probe: fix memleak in fetch_op_data operations
Message-ID: <20200615171337.6525cefa@oasis.local.home>
In-Reply-To: <20200615143034.GA1734@cosmos>
References: <20200615143034.GA1734@cosmos>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami or Srikar would you like to look at this patch.

And wondering why you were not on the Cc to this patch in the first
place, please take a look at the patch I want to add at the bottom ;-)


On Mon, 15 Jun 2020 20:00:38 +0530
Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> wrote:

> kmemleak report:
>     [<57dcc2ca>] __kmalloc_track_caller+0x139/0x2b0
>     [<f1c45d0f>] kstrndup+0x37/0x80
>     [<f9761eb0>] parse_probe_arg.isra.7+0x3cc/0x630
>     [<055bf2ba>] traceprobe_parse_probe_arg+0x2f5/0x810
>     [<655a7766>] trace_kprobe_create+0x2ca/0x950
>     [<4fc6a02a>] create_or_delete_trace_kprobe+0xf/0x30
>     [<6d1c8a52>] trace_run_command+0x67/0x80
>     [<be812cc0>] trace_parse_run_command+0xa7/0x140
>     [<aecfe401>] probes_write+0x10/0x20
>     [<2027641c>] __vfs_write+0x30/0x1e0
>     [<6a4aeee1>] vfs_write+0x96/0x1b0
>     [<3517fb7d>] ksys_write+0x53/0xc0
>     [<dad91db7>] __ia32_sys_write+0x15/0x20
>     [<da347f64>] do_syscall_32_irqs_on+0x3d/0x260
>     [<fd0b7e7d>] do_fast_syscall_32+0x39/0xb0
>     [<ea5ae810>] entry_SYSENTER_32+0xaf/0x102
> 
> Post parse_probe_arg(), the FETCH_OP_DATA operation type is overwritten
> to FETCH_OP_ST_STRING, as a result memory is never freed since
> traceprobe_free_probe_arg() iterates only over SYMBOL and DATA op types
> 
> Setup fetch string operation correctly after fetch_op_data operation.
> 
> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index b8a928e..d2867cc 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -639,8 +639,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  			ret = -EINVAL;
>  			goto fail;
>  		}
> -		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM) ||
> -		     parg->count) {
> +		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
> +		     code->op == FETCH_OP_DATA) || parg->count) {
>  			/*
>  			 * IMM, DATA and COMM is pointing actual address, those
>  			 * must be kept, and if parg->count != 0, this is an


diff --git a/MAINTAINERS b/MAINTAINERS
index 47873f2e6696..116e5cc7ef95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9229,6 +9229,8 @@ F:	Documentation/kprobes.txt
 F:	include/linux/kprobes.h
 F:	include/asm-generic/kprobes.h
 F:	kernel/kprobes.c
+F:	kernel/trace/trace_kprobe.c
+F:	kernel/trace/trace_probe.c
 
 KS0108 LCD CONTROLLER DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
@@ -16996,6 +16998,16 @@ F:	drivers/mtd/ubi/
 F:	include/linux/mtd/ubi.h
 F:	include/uapi/mtd/ubi-user.h
 
+UPROBES
+M:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
+S:	Maintained
+F:	Documentation/trace/uprobetracer.rst
+F:	Documentation/features/debug/uprobes
+F:	include/linux/uprobes.h
+F:	kernel/events/uprobes.c
+F:	kernel/trace/trace_uprobe.c
+F:	kernel/trace/trace_probe.c
+
 USB "USBNET" DRIVER FRAMEWORK
 M:	Oliver Neukum <oneukum@suse.com>
 L:	netdev@vger.kernel.org


-- Steve
