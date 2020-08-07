Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD87C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F98422C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgHGVJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGVJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:09:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D14122C9F;
        Fri,  7 Aug 2020 21:09:52 +0000 (UTC)
Date:   Fri, 7 Aug 2020 17:09:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Paul <sean@poorly.run>
Subject: [for-linus][PATCH] tracing: Add trace_array_init_printk() to
 initialize instance trace_printk() buffers
Message-ID: <20200807170950.6e389d1e@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hopefully the last patch for this merge window pull request.

-- Steve


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 38ce2a9e33db61a3041840310077072d6210ead4


Steven Rostedt (VMware) (1):
      tracing: Add trace_array_init_printk() to initialize instance trace_printk() buffers

----
 include/linux/trace.h |  1 +
 kernel/trace/trace.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
---------------------------
commit 38ce2a9e33db61a3041840310077072d6210ead4
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Aug 6 12:46:49 2020 -0400

    tracing: Add trace_array_init_printk() to initialize instance trace_printk() buffers
    
    As trace_array_printk() used with not global instances will not add noise to
    the main buffer, they are OK to have in the kernel (unlike trace_printk()).
    This require the subsystem to create their own tracing instance, and the
    trace_array_printk() only writes into those instances.
    
    Add trace_array_init_printk() to initialize the trace_printk() buffers
    without printing out the WARNING message.
    
    Reported-by: Sean Paul <sean@poorly.run>
    Reviewed-by: Sean Paul <sean@poorly.run>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 7fd86d3c691f..36d255d66f88 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -29,6 +29,7 @@ struct trace_array;
 void trace_printk_init_buffers(void);
 int trace_array_printk(struct trace_array *tr, unsigned long ip,
 		const char *fmt, ...);
+int trace_array_init_printk(struct trace_array *tr);
 void trace_array_put(struct trace_array *tr);
 struct trace_array *trace_array_get_by_name(const char *name);
 int trace_array_destroy(struct trace_array *tr);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 06c0feae5ff9..c5f822736261 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3129,6 +3129,9 @@ static int alloc_percpu_trace_buffer(void)
 {
 	struct trace_buffer_struct *buffers;
 
+	if (trace_percpu_buffer)
+		return 0;
+
 	buffers = alloc_percpu(struct trace_buffer_struct);
 	if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
 		return -ENOMEM;
@@ -3331,6 +3334,26 @@ int trace_array_vprintk(struct trace_array *tr,
 	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
 }
 
+/**
+ * trace_array_printk - Print a message to a specific instance
+ * @tr: The instance trace_array descriptor
+ * @ip: The instruction pointer that this is called from.
+ * @fmt: The format to print (printf format)
+ *
+ * If a subsystem sets up its own instance, they have the right to
+ * printk strings into their tracing instance buffer using this
+ * function. Note, this function will not write into the top level
+ * buffer (use trace_printk() for that), as writing into the top level
+ * buffer should only have events that can be individually disabled.
+ * trace_printk() is only used for debugging a kernel, and should not
+ * be ever encorporated in normal use.
+ *
+ * trace_array_printk() can be used, as it will not add noise to the
+ * top level tracing buffer.
+ *
+ * Note, trace_array_init_printk() must be called on @tr before this
+ * can be used.
+ */
 __printf(3, 0)
 int trace_array_printk(struct trace_array *tr,
 		       unsigned long ip, const char *fmt, ...)
@@ -3355,6 +3378,27 @@ int trace_array_printk(struct trace_array *tr,
 }
 EXPORT_SYMBOL_GPL(trace_array_printk);
 
+/**
+ * trace_array_init_printk - Initialize buffers for trace_array_printk()
+ * @tr: The trace array to initialize the buffers for
+ *
+ * As trace_array_printk() only writes into instances, they are OK to
+ * have in the kernel (unlike trace_printk()). This needs to be called
+ * before trace_array_printk() can be used on a trace_array.
+ */
+int trace_array_init_printk(struct trace_array *tr)
+{
+	if (!tr)
+		return -ENOENT;
+
+	/* This is only allowed for created instances */
+	if (tr == &global_trace)
+		return -EINVAL;
+
+	return alloc_percpu_trace_buffer();
+}
+EXPORT_SYMBOL_GPL(trace_array_init_printk);
+
 __printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
