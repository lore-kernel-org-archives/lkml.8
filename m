Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8458C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 03:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677AC20675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 03:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbgDCDc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 23:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388951AbgDCDc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 23:32:58 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C4420675;
        Fri,  3 Apr 2020 03:32:56 +0000 (UTC)
Date:   Thu, 2 Apr 2020 23:32:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH][for-next] tracing: One last update before sending a pull
 request
Message-ID: <20200402233255.1dd3a5e8@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 75b564fe13f10b4ba1500c4022396b56befa489f


Steven Rostedt (VMware) (1):
      tracing: Do not allocate buffer in trace_find_next_entry() in atomic

----
 kernel/trace/trace.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)
---------------------------
commit 75b564fe13f10b4ba1500c4022396b56befa489f
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed Apr 1 22:44:46 2020 -0400

    tracing: Do not allocate buffer in trace_find_next_entry() in atomic
    
    When dumping out the trace data in latency format, a check is made to peek
    at the next event to compare its timestamp to the current one, and if the
    delta is of a greater size, it will add a marker showing so. But to do this,
    it needs to save the current event otherwise peeking at the next event will
    remove the current event. To save the event, a temp buffer is used, and if
    the event is bigger than the temp buffer, the temp buffer is freed and a
    bigger buffer is allocated.
    
    This allocation is a problem when called in atomic context. The only way
    this gets called via atomic context is via ftrace_dump(). Thus, use a static
    buffer of 128 bytes (which covers most events), and if the event is bigger
    than that, simply return NULL. The callers of trace_find_next_entry() need
    to handle a NULL case, as that's what would happen if the allocation failed.
    
    Link: https://lore.kernel.org/r/20200326091256.GR11705@shao2-debian
    
    Fixes: ff895103a84ab ("tracing: Save off entry when peeking at next entry")
    Reported-by: kernel test robot <rong.a.chen@intel.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6519b7afc499..4b7bbfe7f809 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3472,6 +3472,9 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
 	return next;
 }
 
+#define STATIC_TEMP_BUF_SIZE	128
+static char static_temp_buf[STATIC_TEMP_BUF_SIZE];
+
 /* Find the next real entry, without updating the iterator itself */
 struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 					  int *ent_cpu, u64 *ent_ts)
@@ -3480,13 +3483,26 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 	int ent_size = iter->ent_size;
 	struct trace_entry *entry;
 
+	/*
+	 * If called from ftrace_dump(), then the iter->temp buffer
+	 * will be the static_temp_buf and not created from kmalloc.
+	 * If the entry size is greater than the buffer, we can
+	 * not save it. Just return NULL in that case. This is only
+	 * used to add markers when two consecutive events' time
+	 * stamps have a large delta. See trace_print_lat_context()
+	 */
+	if (iter->temp == static_temp_buf &&
+	    STATIC_TEMP_BUF_SIZE < ent_size)
+		return NULL;
+
 	/*
 	 * The __find_next_entry() may call peek_next_entry(), which may
 	 * call ring_buffer_peek() that may make the contents of iter->ent
 	 * undefined. Need to copy iter->ent now.
 	 */
 	if (iter->ent && iter->ent != iter->temp) {
-		if (!iter->temp || iter->temp_size < iter->ent_size) {
+		if ((!iter->temp || iter->temp_size < iter->ent_size) &&
+		    !WARN_ON_ONCE(iter->temp == static_temp_buf)) {
 			kfree(iter->temp);
 			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
 			if (!iter->temp)
@@ -9203,6 +9219,8 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
+	/* Can not use kmalloc for iter.temp */
+	iter.temp = static_temp_buf;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
