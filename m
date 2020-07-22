Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5090BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EEC207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgGVP21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgGVP20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:28:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE94207DD;
        Wed, 22 Jul 2020 15:28:24 +0000 (UTC)
Date:   Wed, 22 Jul 2020 11:28:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>, kernel <kernel@axis.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200722112823.3ba72d31@oasis.local.home>
In-Reply-To: <20200722144952.2mewrgebgkyr2zyf@axis.com>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
        <20200721173045.540ae500@oasis.local.home>
        <87eep3zmg9.fsf@jogness.linutronix.de>
        <20200722144952.2mewrgebgkyr2zyf@axis.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 16:49:52 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

>  Do we really need a separate tracing event for this? Why not just:
> > 
> >                 ftrace_vprintk(fmt + strlen(KERN_DEBUG), args);  
> 
> Thanks, I tried that out now and it seems to work, but it results in the
> trace_printk() splat (even if the feature is not used), though:
> 
>  **********************************************************
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **                                                      **
>  ** trace_printk() being used. Allocating extra memory.  **
>  **                                                      **
>  ** This means that this is a DEBUG kernel and it is     **
>  ** unsafe for production use.                           **
>  **                                                      **
>  ** If you see this message and you are not debugging    **
>  ** the kernel, report this immediately to your vendor!  **
>  **                                                      **
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **********************************************************

And that is done purposely. No DO NOT USE ftrace_vprintk()!!!

I explained why to John.

For you, I made this quick patch. If this works for you, I can make it
into a formal patch. It includes a test use case in do_sys_openat2() to
show the file name and file descriptor. Obviously, that wont be part of
the final patch.

Thoughts?

-- Steve

diff --git a/fs/open.c b/fs/open.c
index b69d6eed67e6..ea19478a2220 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -32,6 +32,7 @@
 #include <linux/ima.h>
 #include <linux/dnotify.h>
 #include <linux/compat.h>
+#include <trace/events/printk.h>
 
 #include "internal.h"
 
@@ -1127,6 +1128,15 @@ struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(file_open_root);
 
+static void do_trace_vprintk(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace_vprintk(fmt, ap);
+	va_end(ap);
+}
+
 static long do_sys_openat2(int dfd, const char __user *filename,
 			   struct open_how *how)
 {
@@ -1141,6 +1151,8 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
+	do_trace_vprintk("file=%s fd=%d\n", tmp->name, fd);
+
 	fd = get_unused_fd_flags(how->flags);
 	if (fd >= 0) {
 		struct file *f = do_filp_open(dfd, tmp, &op);
diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
index 13d405b2fd8b..60d9ca21acf9 100644
--- a/include/trace/events/printk.h
+++ b/include/trace/events/printk.h
@@ -31,6 +31,53 @@ TRACE_EVENT(console,
 
 	TP_printk("%s", __get_str(msg))
 );
+
+#ifndef __FIND_VPRINTK_LEN_H
+#define __FIND_VPRINTK_LEN_H
+/* The header is called multiple times, but this should not be */
+static inline int find_vprintk_len(const char *fmt, va_list args)
+{
+	va_list va;
+	int len;
+
+	va_copy(va, args);
+	len = vsnprintf(NULL, 0, fmt, va);
+	va_end(va);
+	return len + 1;
+}
+#endif
+
+TRACE_EVENT(vprintk,
+	TP_PROTO(const char *fmt, va_list args),
+
+	TP_ARGS(fmt, args),
+
+	TP_STRUCT__entry(
+		__dynamic_array(char, msg, find_vprintk_len(fmt, args))
+	),
+
+	TP_fast_assign(
+		va_list ap;
+		int len = find_vprintk_len(fmt, args);
+
+		va_copy(ap, args);
+		len = vsnprintf(__get_str(msg), len, fmt, ap);
+		va_end(ap);
+		/*
+		 * Each trace entry is printed in a new line.
+		 * If the msg finishes with '\n', cut it off
+		 * to avoid blank lines in the trace.
+		 */
+		if ((len > 0) && (__get_str(msg)[len-1] == '\n'))
+			len -= 1;
+
+		__get_str(msg)[len] = 0;
+	),
+
+	TP_printk("%s", __get_str(msg))
+);
+
+
 #endif /* _TRACE_PRINTK_H */
 
 /* This part must be outside protection */
