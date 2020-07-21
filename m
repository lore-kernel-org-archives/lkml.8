Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFA120729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgGUVau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbgGUVau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:30:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A07120717;
        Tue, 21 Jul 2020 21:30:47 +0000 (UTC)
Date:   Tue, 21 Jul 2020 17:30:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <jbaron@akamai.com>, <mingo@redhat.com>, <kernel@axis.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200721173045.540ae500@oasis.local.home>
In-Reply-To: <20200721141105.16034-1-vincent.whitchurch@axis.com>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Added printk maintainers to get their thoughts.


On Tue, 21 Jul 2020 16:11:05 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> When debugging device drivers, I've found it very useful to be able to
> redirect existing pr_debug()/dev_dbg() prints to the trace buffer
> instead of dmesg.  Among the many advantages of the trace buffer is that
> it can be dynamically resized, allows these prints to combined with
> other trace events, and doesn't fill up system logs.
> 
> Since dynamic debug already has hooks in these call sites, getting these
> prints into the ftrace buffer is straightforward if we have dynamic
> debug do it.
> 
> Add an "x" flag to make the dynamic debug call site print to a new
> printk:dynamic trace event.  The trace event can be emitted instead of
> or in addition to the printk().  The print buffer is placed on the stack
> and is limited to a somewhat arbitrarily chosen 256 bytes; anything
> larger will be truncated.

Is it safe to have a 256 byte string on the stack? That's quite a bit.
How deep is the stack when this is called?

You could run vsnprintf() with a zero length to get the size, and then
just allocate that from the ring buffer. How critical is the performance?

-- Steve


> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../admin-guide/dynamic-debug-howto.rst       |   1 +
>  include/linux/dynamic_debug.h                 |   7 +-
>  include/trace/events/printk.h                 |  16 +++
>  lib/dynamic_debug.c                           | 124 ++++++++++++++----
>  4 files changed, 120 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 1012bd9305e9..b235327fbb53 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -224,6 +224,7 @@ of the characters::
>  The flags are::
>  
>    p    enables the pr_debug() callsite.
> +  x    enables trace to the printk:dynamic event
>    f    Include the function name in the printed message
>    l    Include line number in the printed message
>    m    Include module name in the printed message
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index abcd5fde30eb..9dee405985c4 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -27,13 +27,16 @@ struct _ddebug {
>  	 * writes commands to <debugfs>/dynamic_debug/control
>  	 */
>  #define _DPRINTK_FLAGS_NONE	0
> -#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
> +#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */
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
> index 13d405b2fd8b..696d6e19a9b7 100644
> --- a/include/trace/events/printk.h
> +++ b/include/trace/events/printk.h
> @@ -31,6 +31,22 @@ TRACE_EVENT(console,
>  
>  	TP_printk("%s", __get_str(msg))
>  );
> +
> +TRACE_EVENT(dynamic,
> +	TP_PROTO(const char *message),
> +
> +	TP_ARGS(message),
> +
> +	TP_STRUCT__entry(
> +		__string(message, message)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(message, message);
> +	),
> +
> +	TP_printk("%s", __get_str(message))
> +);
>  #endif /* _TRACE_PRINTK_H */
>  
>  /* This part must be outside protection */
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 321437bbf87d..9f6d8867af7c 100644
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
> @@ -79,11 +80,12 @@ static inline const char *trim_prefix(const char *path)
>  }
>  
>  static struct { unsigned flag:8; char opt_char; } opt_array[] = {
> -	{ _DPRINTK_FLAGS_PRINT, 'p' },
> +	{ _DPRINTK_FLAGS_PRINTK, 'p' },
>  	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
>  	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
>  	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
>  	{ _DPRINTK_FLAGS_INCL_TID, 't' },
> +	{ _DPRINTK_FLAGS_TRACE, 'x' },
>  	{ _DPRINTK_FLAGS_NONE, '_' },
>  };
>  
> @@ -550,6 +552,65 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
>  	return buf;
>  }
>  
> +static void dynamic_trace(const char *fmt, va_list args)
> +{
> +	char buf[256];
> +	int len;
> +
> +	len = vscnprintf(buf, sizeof(buf), fmt, args);
> +	if (!len)
> +		return;
> +
> +	if (buf[len - 1] == '\n')
> +		buf[len - 1] = '\0';
> +
> +	trace_dynamic(buf);
> +}
> +
> +static void dynamic_printk(unsigned int flags, const char *fmt, ...)
> +{
> +	if (flags & _DPRINTK_FLAGS_TRACE) {
> +		va_list args;
> +
> +		va_start(args, fmt);
> +		/*
> +		 * All callers include the KERN_DEBUG prefix to keep the
> +		 * vprintk case simple; strip it out for tracing.
> +		 */
> +		dynamic_trace(fmt + strlen(KERN_DEBUG), args);
> +		va_end(args);
> +	}
> +
> +	if (flags & _DPRINTK_FLAGS_PRINTK) {
> +		va_list args;
> +
> +		va_start(args, fmt);
> +		vprintk(fmt, args);
> +		va_end(args);
> +	}
> +}
> +
> +static void dynamic_dev_printk(unsigned int flags, const struct device *dev,
> +			       const char *fmt, ...)
> +{
> +
> +	if (flags & _DPRINTK_FLAGS_TRACE) {
> +		va_list args;
> +
> +		va_start(args, fmt);
> +		dynamic_trace(fmt, args);
> +		va_end(args);
> +	}
> +
> +	if (flags & _DPRINTK_FLAGS_PRINTK) {
> +		va_list args;
> +
> +		va_start(args, fmt);
> +		dev_vprintk_emit(LOGLEVEL_DEBUG, dev, fmt, args);
> +		va_end(args);
> +	}
> +}
> +
>  void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
>  {
>  	va_list args;
> @@ -564,7 +625,8 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
> +	dynamic_printk(descriptor->flags, KERN_DEBUG "%s%pV",
> +		       dynamic_emit_prefix(descriptor, buf), &vaf);
>  
>  	va_end(args);
>  }
> @@ -574,6 +636,7 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
>  		      const struct device *dev, const char *fmt, ...)
>  {
>  	struct va_format vaf;
> +	unsigned int flags;
>  	va_list args;
>  
>  	BUG_ON(!descriptor);
> @@ -583,16 +646,18 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
>  
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> +	flags = descriptor->flags;
>  
>  	if (!dev) {
> -		printk(KERN_DEBUG "(NULL device *): %pV", &vaf);
> +		dynamic_printk(flags, KERN_DEBUG "(NULL device *): %pV",
> +			      &vaf);
>  	} else {
>  		char buf[PREFIX_SIZE];
>  
> -		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
> -				dynamic_emit_prefix(descriptor, buf),
> -				dev_driver_string(dev), dev_name(dev),
> -				&vaf);
> +		dynamic_dev_printk(flags, dev, "%s%s %s: %pV",
> +				   dynamic_emit_prefix(descriptor, buf),
> +				   dev_driver_string(dev), dev_name(dev),
> +				   &vaf);
>  	}
>  
>  	va_end(args);
> @@ -605,6 +670,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
>  			  const struct net_device *dev, const char *fmt, ...)
>  {
>  	struct va_format vaf;
> +	unsigned int flags;
>  	va_list args;
>  
>  	BUG_ON(!descriptor);
> @@ -614,22 +680,24 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
>  
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> +	flags = descriptor->flags;
>  
>  	if (dev && dev->dev.parent) {
>  		char buf[PREFIX_SIZE];
>  
> -		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
> -				"%s%s %s %s%s: %pV",
> -				dynamic_emit_prefix(descriptor, buf),
> -				dev_driver_string(dev->dev.parent),
> -				dev_name(dev->dev.parent),
> -				netdev_name(dev), netdev_reg_state(dev),
> -				&vaf);
> +		dynamic_dev_printk(flags, dev->dev.parent,
> +				   "%s%s %s %s%s: %pV",
> +				   dynamic_emit_prefix(descriptor, buf),
> +				   dev_driver_string(dev->dev.parent),
> +				   dev_name(dev->dev.parent),
> +				   netdev_name(dev), netdev_reg_state(dev),
> +				   &vaf);
>  	} else if (dev) {
> -		printk(KERN_DEBUG "%s%s: %pV", netdev_name(dev),
> -		       netdev_reg_state(dev), &vaf);
> +		dynamic_printk(flags, KERN_DEBUG "%s%s: %pV",
> +			       netdev_name(dev), netdev_reg_state(dev), &vaf);
>  	} else {
> -		printk(KERN_DEBUG "(NULL net_device): %pV", &vaf);
> +		dynamic_printk(flags, KERN_DEBUG "(NULL net_device): %pV",
> +			       &vaf);
>  	}
>  
>  	va_end(args);
> @@ -644,27 +712,31 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  			 const struct ib_device *ibdev, const char *fmt, ...)
>  {
>  	struct va_format vaf;
> +	unsigned int flags;
>  	va_list args;
>  
>  	va_start(args, fmt);
>  
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> +	flags = descriptor->flags;
>  
>  	if (ibdev && ibdev->dev.parent) {
>  		char buf[PREFIX_SIZE];
>  
> -		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
> -				"%s%s %s %s: %pV",
> -				dynamic_emit_prefix(descriptor, buf),
> -				dev_driver_string(ibdev->dev.parent),
> -				dev_name(ibdev->dev.parent),
> -				dev_name(&ibdev->dev),
> -				&vaf);
> +		dynamic_dev_printk(flags, ibdev->dev.parent,
> +				   "%s%s %s %s: %pV",
> +				   dynamic_emit_prefix(descriptor, buf),
> +				   dev_driver_string(ibdev->dev.parent),
> +				   dev_name(ibdev->dev.parent),
> +				   dev_name(&ibdev->dev),
> +				   &vaf);
>  	} else if (ibdev) {
> -		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
> +		dynamic_printk(flags, KERN_DEBUG "%s: %pV",
> +			       dev_name(&ibdev->dev), &vaf);
>  	} else {
> -		printk(KERN_DEBUG "(NULL ib_device): %pV", &vaf);
> +		dynamic_printk(flags, KERN_DEBUG "(NULL ib_device): %pV",
> +			       &vaf);
>  	}
>  
>  	va_end(args);

