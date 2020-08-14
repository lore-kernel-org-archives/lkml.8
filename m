Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3273C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E86620774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHNRPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgHNRPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:15:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20253206B6;
        Fri, 14 Aug 2020 17:15:33 +0000 (UTC)
Date:   Fri, 14 Aug 2020 13:15:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <jbaron@akamai.com>, <mingo@redhat.com>, <kernel@axis.com>,
        <corbet@lwn.net>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dynamic debug: allow printing to trace event
Message-ID: <20200814131531.01b43c91@oasis.local.home>
In-Reply-To: <20200814133151.7759-1-vincent.whitchurch@axis.com>
References: <20200814133151.7759-1-vincent.whitchurch@axis.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 15:31:51 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> index aa9ff9e1c0b3..f599ed21ecc5 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -27,13 +27,16 @@ struct _ddebug {
>  	 * writes commands to <debugfs>/dynamic_debug/control
>  	 */
>  #define _DPRINTK_FLAGS_NONE	0
> -#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
> +#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */

The above looks like a cleanup unrelated to this patch, and probably
should be on its own.

>  #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
>  #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
>  #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
>  #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
> +#define _DPRINTK_FLAGS_TRACE		(1<<5)	
> +#define _DPRINTK_FLAGS_PRINT		(_DPRINTK_FLAGS_PRINTK | \
> +					 _DPRINTK_FLAGS_TRACE)
>  #if defined DEBUG
> -#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
> +#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
>  #else
>  #define _DPRINTK_FLAGS_DEFAULT 0
>  #endif
> diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
> index 13d405b2fd8b..6c89121a1669 100644
> --- a/include/trace/events/printk.h
> +++ b/include/trace/events/printk.h
> @@ -7,7 +7,7 @@
>  
>  #include <linux/tracepoint.h>
>  
> -TRACE_EVENT(console,
> +DECLARE_EVENT_CLASS(printk,
>  	TP_PROTO(const char *text, size_t len),
>  
>  	TP_ARGS(text, len),
> @@ -31,6 +31,16 @@ TRACE_EVENT(console,
>  
>  	TP_printk("%s", __get_str(msg))
>  );
> +
> +DEFINE_EVENT(printk, console,
> +	TP_PROTO(const char *text, size_t len),
> +	TP_ARGS(text, len)
> +);
> +
> +DEFINE_EVENT(printk, dynamic,

Can we call this "dynamic_printk" or "printk_dynamic", as
trace_dynamic() is too generic.

> +	TP_PROTO(const char *text, size_t len),
> +	TP_ARGS(text, len)
> +);
>  #endif /* _TRACE_PRINTK_H */
>  
>  /* This part must be outside protection */
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 1d012e597cc3..76fc3e33fe41 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -36,6 +36,7 @@
>  #include <linux/sched.h>
>  #include <linux/device.h>
>  #include <linux/netdevice.h>
> +#include <trace/events/printk.h>
>  
>  #include <rdma/ib_verbs.h>
>  
> @@ -84,11 +85,12 @@ static inline const char *trim_prefix(const char *path)
>  }
>  
>  static struct { unsigned flag:8; char opt_char; } opt_array[] = {
> -	{ _DPRINTK_FLAGS_PRINT, 'p' },
> +	{ _DPRINTK_FLAGS_PRINTK, 'p' },

Again, this looks unrelated, and shouldn't be part of this patch.

>  	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
>  	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
>  	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
>  	{ _DPRINTK_FLAGS_INCL_TID, 't' },
> +	{ _DPRINTK_FLAGS_TRACE, 'x' },
>  	{ _DPRINTK_FLAGS_NONE, '_' },
>  };
>  

Other then the two comments above, I'm fine with this change.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
