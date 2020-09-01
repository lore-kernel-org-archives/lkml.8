Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0BBC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6B92087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598947011;
	bh=rfxlWXkoFVg1nBhyifXGxOJ6QA+J4LqvbC5/ABiyWGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QdW2O59GxHxCz/7labZONb32cxXDoSP8J7qLX1rp74nMM5rpPOPv/jRL6TXojfpjK
	 HtbBua7J6w+tdoJY6fog94BC5OogyrYTUr6ow/53PIMGdoM9XCQkSPe+DSvJhTO1XW
	 SvlhUyTctszkp7mPJ1HNKNB45JBCUX+FtXecxMyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgIAH4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAH4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:56:46 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D88D2065F;
        Tue,  1 Sep 2020 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598947005;
        bh=rfxlWXkoFVg1nBhyifXGxOJ6QA+J4LqvbC5/ABiyWGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u34VdFazsI0Ubsd1KqLW5mU91j4KnVgtftSHxJ4I+w1/sp8WDGAtsmwHi58zhmfE0
         jHIwTotnvvNfeAZMTs8YTGmFujxy5EneDAZpRlEW8ZmhaWbdi3v+qTo38MjiC90SXB
         KWVpk/lmT6WGcROR5tGdLtFv5rVtB8oFFwhDPcAM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 1/6] kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot
Date:   Tue,  1 Sep 2020 16:56:41 +0900
Message-Id: <159894700101.1478826.3210757333571150353.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159894698993.1478826.2813843560314595660.stgit@devnote2>
References: <159894698993.1478826.2813843560314595660.stgit@devnote2>
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
  Changes in v2:
   - Fix kprobe_free_init_mem() not depending on CONFIG_DEBUG_FS.
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
index 287b263c9cb9..2880cdf37c47 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2452,6 +2452,28 @@ static struct notifier_block kprobe_module_nb = {
 extern unsigned long __start_kprobe_blacklist[];
 extern unsigned long __stop_kprobe_blacklist[];
 
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
 static int __init init_kprobes(void)
 {
 	int i, err = 0;

