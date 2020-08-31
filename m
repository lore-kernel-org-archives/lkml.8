Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF5BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665E5206E3
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598877942;
	bh=e5EIMOJeKMi9b6keZiVq/cO923LLR8io6+rzRzIKcFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k5JLINJgms8q1HCb485q8m1bpaDwrRO7JUc/SeF31umoWKhERMGLTiuEEa4HRQFqD
	 BaEyvdQ+/X0r8cvno4sx73bEdcUO62VeruOFg09KeJeis4PG7TIOsVb+GZef+IGthX
	 kXch7QvSOw86Lq3f+iIGzVqaQHGcWJL+3ANJjhOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgHaMpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaMpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:45:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F222068E;
        Mon, 31 Aug 2020 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598877937;
        bh=e5EIMOJeKMi9b6keZiVq/cO923LLR8io6+rzRzIKcFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bldEqf0IwY78tuQzH3HT5Hrfjo28N/H8Q7/wuilbVU9t+aVahDJqsRbVSiM12Qbp2
         KxehqKFpG2TUHAUYdOaG64j5AYhIeHtMzTaa8lldq649M9dgPBCNI1t3A3OhwQELQc
         rA+aZI3PWIiYAj81OxuvAK1pNyHniZtIZ3iLE57M=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/6] kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot
Date:   Mon, 31 Aug 2020 21:45:34 +0900
Message-Id: <159887793377.1330989.1807362919167072561.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159887792384.1330989.5993224243767476896.stgit@devnote2>
References: <159887792384.1330989.5993224243767476896.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kprobe_event= cmdline option allows user to put kprobes on the
functions in initmem, kprobe has to make such probes gone after boot.
Currently the probes on the init functions in modules will be handled
by module callback, but the kernel init text isn't handled.
Without this, kprobes may access non-exist text area to disable or
remove it.

Fixes: 970988e19eb0 ("tracing/kprobe: Add kprobe_event= boot parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    5 +++++
 init/main.c             |    2 ++
 kernel/kprobes.c        |   22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9be1bff4f586..8aab327b5539 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -373,6 +373,8 @@ void unregister_kretprobes(struct kretprobe **rps, int num);
 void kprobe_flush_task(struct task_struct *tk);
 void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
 
+void kprobe_free_init_mem(void);
+
 int disable_kprobe(struct kprobe *kp);
 int enable_kprobe(struct kprobe *kp);
 
@@ -435,6 +437,9 @@ static inline void unregister_kretprobes(struct kretprobe **rps, int num)
 static inline void kprobe_flush_task(struct task_struct *tk)
 {
 }
+static inline void kprobe_free_init_mem(void)
+{
+}
 static inline int disable_kprobe(struct kprobe *kp)
 {
 	return -ENOSYS;
diff --git a/init/main.c b/init/main.c
index ae78fb68d231..038128b2a755 100644
--- a/init/main.c
+++ b/init/main.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/kmod.h>
+#include <linux/kprobes.h>
 #include <linux/vmalloc.h>
 #include <linux/kernel_stat.h>
 #include <linux/start_kernel.h>
@@ -1402,6 +1403,7 @@ static int __ref kernel_init(void *unused)
 	kernel_init_freeable();
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
+	kprobe_free_init_mem();
 	ftrace_free_init_mem();
 	free_initmem();
 	mark_readonly();
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263c9cb9..48747bd60295 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2726,6 +2726,28 @@ static int disarm_all_kprobes(void)
 	return ret;
 }
 
+void kprobe_free_init_mem(void)
+{
+	void *start = (void *)(&__init_begin);
+	void *end = (void *)(&__init_end);
+	struct hlist_head *head;
+	struct kprobe *p;
+	int i;
+
+	mutex_lock(&kprobe_mutex);
+
+	/* Kill all kprobes on initmem */
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		head = &kprobe_table[i];
+		hlist_for_each_entry(p, head, hlist) {
+			if (start <= (void *)p->addr && (void *)p->addr < end)
+				kill_kprobe(p);
+		}
+	}
+
+	mutex_unlock(&kprobe_mutex);
+}
+
 /*
  * XXX: The debugfs bool file interface doesn't allow for callbacks
  * when the bool state is switched. We can reuse that facility when

