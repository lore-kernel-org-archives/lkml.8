Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB75C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC302075D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbgAYB7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbgAYB7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:59:30 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A732071A;
        Sat, 25 Jan 2020 01:59:28 +0000 (UTC)
Date:   Fri, 24 Jan 2020 20:59:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH] tracing: Decrement trace_array when bootconfig creates an
 instance
Message-ID: <20200124205927.76128804@rorschach.local.home>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The trace_array_get_by_name() creates a ftrace instance and
trace_array_put() is used to remove the reference. Even though the
trace_array_get_by_name() creates the instance, it also adds a reference
count to it, that prevents user space from removing it.

As the bootconfig just creates the instance on boot up, it should still be
used where it can be deleted by user space after boot. A trace_array_put()
is required to let that happen. Otherwise, the created instance can not
be removed.

Also, change the documentation on trace_array_get_by_name() to make this not
be so confusing.

Fixes: 4f712a4d04a4e ("tracing/boot: Add instance node support")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c      | 4 ++++
 kernel/trace/trace_boot.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6fed9b0a8d58..0a5569b1cace 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8602,6 +8602,10 @@ static int instance_mkdir(const char *name)
  * NOTE: This function increments the reference counter associated with the
  * trace array returned. This makes sure it cannot be freed while in use.
  * Use trace_array_put() once the trace array is no longer needed.
+ * If the trace_array is to be freed, trace_array_destroy() needs to
+ * be called after the trace_array_put(), or simply let user space delete
+ * it from the tracefs instances directory. But until the
+ * trace_array_put() is called, user space can not delete it.
  *
  */
 struct trace_array *trace_array_get_by_name(const char *name)
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index cd541ac1cbc1..2f616cd926b0 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -327,6 +327,7 @@ trace_boot_init_instances(struct xbc_node *node)
 			continue;
 		}
 		trace_boot_init_one_instance(tr, inode);
+		trace_array_put(tr);
 	}
 }
 
-- 
2.20.1

