Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A32920838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgG3N6p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgG3N6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:58:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C062074B;
        Thu, 30 Jul 2020 13:58:43 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:58:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, chunyan.zhang@unisoc.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace : use kvmalloc instead of kmalloc
Message-ID: <20200730095842.3e438960@oasis.local.home>
In-Reply-To: <1596107052-25682-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1596107052-25682-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 19:04:12 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> High order memory stuff within trace could introduce OOM, use kvmalloc instead.
> 
> Please find the bellowing for the call stack we run across in an android system. The scenario happens when traced_probes is woken up to get a large quantity of trace even if free memory is even higher than watermark_low. 

Please limit your column width in the description of patches to 76
characters.

> 
> traced_probes invoked oom-killer: gfp_mask=0x140c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),  order=2, oom_score_adj=-1
> 

What does this traced_probes thing do?

> traced_probes cpuset=system-background mems_allowed=0
> CPU: 3 PID: 588 Comm: traced_probes Tainted: G        W  O    4.14.181 #1
> Hardware name: Generic DT based system
> (unwind_backtrace) from [<c010d824>] (show_stack+0x20/0x24)
> (show_stack) from [<c0b2e174>] (dump_stack+0xa8/0xec)
> (dump_stack) from [<c027d584>] (dump_header+0x9c/0x220)
> (dump_header) from [<c027cfe4>] (oom_kill_process+0xc0/0x5c4)
> (oom_kill_process) from [<c027cb94>] (out_of_memory+0x220/0x310)
> (out_of_memory) from [<c02816bc>] (__alloc_pages_nodemask+0xff8/0x13a4)
> (__alloc_pages_nodemask) from [<c02a6a1c>] (kmalloc_order+0x30/0x48)
> (kmalloc_order) from [<c02a6a64>] (kmalloc_order_trace+0x30/0x118)
> (kmalloc_order_trace) from [<c0223d7c>] (tracing_buffers_open+0x50/0xfc)
> (tracing_buffers_open) from [<c02e6f58>] (do_dentry_open+0x278/0x34c)
> (do_dentry_open) from [<c02e70d0>] (vfs_open+0x50/0x70)
> (vfs_open) from [<c02f7c24>] (path_openat+0x5fc/0x169c)
> (path_openat) from [<c02f75c4>] (do_filp_open+0x94/0xf8)
> (do_filp_open) from [<c02e7650>] (do_sys_open+0x168/0x26c)
> (do_sys_open) from [<c02e77bc>] (SyS_openat+0x34/0x38)
> (SyS_openat) from [<c0108bc0>] (ret_fast_syscall+0x0/0x28)
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> changes since v1: change kfree to kvfree
> ---
>  kernel/trace/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ca1ee65..8d70c79 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6891,7 +6891,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
>  	if (trace_array_get(tr) < 0)
>  		return -ENODEV;
>  
> -	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	info = kvmalloc(sizeof(*info), GFP_KERNEL);

The above is a bug. It converts kzalloc() to kvmalloc() instead of
kvzalloc().

-- Steve



>  	if (!info) {
>  		trace_array_put(tr);
>  		return -ENOMEM;
> @@ -7017,7 +7017,7 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
>  	if (info->spare)
>  		ring_buffer_free_read_page(iter->trace_buffer->buffer,
>  					   info->spare_cpu, info->spare);
> -	kfree(info);
> +	kvfree(info);
>  
>  	mutex_unlock(&trace_types_lock);
>  

