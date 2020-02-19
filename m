Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A8DC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C822465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgBSOet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbgBSOet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:34:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D62C24656;
        Wed, 19 Feb 2020 14:34:47 +0000 (UTC)
Date:   Wed, 19 Feb 2020 09:34:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Message-ID: <20200219093445.386f1c09@gandalf.local.home>
In-Reply-To: <20200219045423.54190-4-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
        <20200219045423.54190-4-natechancellor@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 21:54:20 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns:
> 
> ../kernel/trace/trace.c:9335:33: warning: array comparison always
> evaluates to true [-Wtautological-compare]
>         if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
>                                        ^
> 1 warning generated.
> 
> These are not true arrays, they are linker defined symbols, which are
> just addresses so there is not a real issue here. Use the
> COMPARE_SECTIONS macro to silence this warning by casting the linker
> defined symbols to unsigned long, which keeps the logic the same.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/765
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c797a15a1fc7..e1f3b16e457b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
>  		goto out_free_buffer_mask;
>  
>  	/* Only allocate trace_printk buffers if a trace_printk exists */
> -	if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> +	if (COMPARE_SECTIONS(__stop___trace_bprintk_fmt, !=, __start___trace_bprintk_fmt))

Sorry, but this is really ugly and unreadable. Please find some other
solution to fix this.

NAK-by: Steven Rostedt

-- Steve

>  		/* Must be called before global_trace.buffer is allocated */
>  		trace_printk_init_buffers();
>  

