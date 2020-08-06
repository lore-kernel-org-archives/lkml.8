Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C99C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F089F23117
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHFQYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgHFQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251B923134;
        Thu,  6 Aug 2020 15:48:52 +0000 (UTC)
Date:   Thu, 6 Aug 2020 11:48:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     guoren@kernel.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] ftrace: Fixup lockdep assert held of text_mutex
Message-ID: <20200806114850.051f84d0@oasis.local.home>
In-Reply-To: <1596725454-16245-1-git-send-email-guoren@kernel.org>
References: <1596725454-16245-1-git-send-email-guoren@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Aug 2020 14:50:54 +0000
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The function ftrace_process_locs() will modify text code, so we
> should give a text_mutex lock. Because some arch's patch code
> will assert held of text_mutex even during start_kernel->
> ftrace_init().

NAK.

This looks like a bug in the lockdep_assert_held() in whatever arch
(riscv) is running.

> 
> backtrace log:
>    assert by lockdep_assert_held(&text_mutex)
> 0  patch_insn_write (addr=0xffffffe0000010fc <set_reset_devices+10>, insn=0xffffffe001203eb8, len=8) at arch/riscv/kernel/patch.c:63
> 1  0xffffffe0002042ec in patch_text_nosync (addr=<optimized out>, insns=<optimized out>, len=<optimized out>) at arch/riscv/kernel/patch.c:93
> 2  0xffffffe00020628e in __ftrace_modify_call (hook_pos=<optimized out>, target=<optimized out>, enable=<optimized out>) at arch/riscv/kernel/ftrace.c:68
> 3  0xffffffe0002063c0 in ftrace_make_nop (mod=<optimized out>, rec=0xffffffe001221c70 <text_mutex+96>, addr=18446743936272720288) at arch/riscv/kernel/ftrace.c:97
> 4  0xffffffe0002b13f0 in ftrace_init_nop (rec=<optimized out>, mod=<optimized out>) at ./include/linux/ftrace.h:647
> 5  ftrace_nop_initialize (rec=<optimized out>, mod=<optimized out>) at kernel/trace/ftrace.c:2619
> 6  ftrace_update_code (new_pgs=<optimized out>, mod=<optimized out>) at kernel/trace/ftrace.c:3063
> 7  ftrace_process_locs (mod=<optimized out>, start=<optimized out>, end=<optimized out>) at kernel/trace/ftrace.c:6154
> 8  0xffffffe00000b6e6 in ftrace_init () at kernel/trace/ftrace.c:6715
> 9  0xffffffe000001b48 in start_kernel () at init/main.c:888
> 10 0xffffffe0000010a8 in _start_kernel () at arch/riscv/kernel/head.S:247
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/trace/ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1903b80..4b48b88 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -26,6 +26,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/bsearch.h>
>  #include <linux/module.h>
> +#include <linux/memory.h>
>  #include <linux/ftrace.h>
>  #include <linux/sysctl.h>
>  #include <linux/slab.h>
> @@ -6712,9 +6713,11 @@ void __init ftrace_init(void)

ftrace_init() is called before SMP is initialized. Nothing else should
be running here. That means grabbing a mutex is useless.

-- Steve


>  
>  	last_ftrace_enabled = ftrace_enabled = 1;
>  
> +	mutex_lock(&text_mutex);
>  	ret = ftrace_process_locs(NULL,
>  				  __start_mcount_loc,
>  				  __stop_mcount_loc);
> +	mutex_unlock(&text_mutex);
>  
>  	pr_info("ftrace: allocated %ld pages with %ld groups\n",
>  		ftrace_number_of_pages, ftrace_number_of_groups);

