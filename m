Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F7C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BB2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkChly/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgD0QAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:30 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191D8C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:30 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h1so21026146qtu.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VMU4Dxx5VtpJ9uKOr46aqgBjHsAjXld8C2DfnSdv8zo=;
        b=pkChly/MR4gg1F/vqNKdS/sRvRHC9h2GTUAegFBSMak98utNlZ3ShOdFIbT8e3bAOS
         Qw8Q9Bej6lzq2ZoUHa9FOdVh6GHVnGPiKRrlCRqY56CqAwxR1tVy2B5KvqLQKlfr44mJ
         XzWmpehjC2j7wr+O0l2nKdIuS+q5brNPlRPb9CkFAGjYfLQjvqvg3b+3drlHjancStvP
         peyjrnBzg7WUQqKDslZ8rxgMPATe+dCJ7ChBdJXxt4UTJg1AoT2va9kPF7K74NEZshI8
         Tnhnhsr1OmuzskrQ5UhyDnyxXZggId4mQCkOufqIWd4kL7UJZzZOREaJQ/QmsfCBs6xr
         5oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VMU4Dxx5VtpJ9uKOr46aqgBjHsAjXld8C2DfnSdv8zo=;
        b=U8/TXfODtow6nQuQ7PDsJpo5wF1LzA4/wIBhx+9epgxZTjYIBZDK1lAirmipbokSKE
         XD2BNOW2bSlv6CtRLK1jlsNtp9FkNe6U01P52NlfOAsRAIy+P+Zj5IjifrzRERxin77p
         4n4ZwaNA6ruowso6zkDNvT0thvxh7366n4R9JBHJ9mZth4TDvj5c9h2WgqHacrKWDQSf
         H76H3slF+zZDxEXK80z3vR63q5p5uPgyLMsNqij8WvRNTN5cuR/Z92kEUGZyReMjJvBW
         5iXKxB3SrOnyI9yVvOH5JVI8UAkdcSKqypLVIwZBo3t3wvw2tl6GaKEw2Cg0Q1GdwKP7
         GyeA==
X-Gm-Message-State: AGi0PuYCnUzAIko+aXR8aUf+72hRmxuBATaD1LNZi/F1P+izgVba8u+U
        fL1OH8KUeSbe9rzBQYghPb3y3A4nQA19+KklNso=
X-Google-Smtp-Source: APiQypIyrY142CMDGq82JJi1Gkln1wo6uLkxCKbOaTA9gyTh2SBuyrZ7K/0KHyeX6IkZStbpWE1vne7HEdDXyYcdEfs=
X-Received: by 2002:ad4:4b6b:: with SMTP id m11mr22911491qvx.130.1588003229016;
 Mon, 27 Apr 2020 09:00:29 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:08 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 02/12] scs: add accounting
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds accounting for the memory allocated for shadow stacks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/base/node.c    |  6 ++++++
 fs/proc/meminfo.c      |  4 ++++
 include/linux/mmzone.h |  3 +++
 kernel/scs.c           | 15 +++++++++++++++
 mm/page_alloc.c        |  6 ++++++
 mm/vmstat.c            |  3 +++
 6 files changed, 37 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 10d7e818e118..50b8c0d43859 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -415,6 +415,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d AnonPages:      %8lu kB\n"
 		       "Node %d Shmem:          %8lu kB\n"
 		       "Node %d KernelStack:    %8lu kB\n"
+#ifdef CONFIG_SHADOW_CALL_STACK
+		       "Node %d ShadowCallStack:%8lu kB\n"
+#endif
 		       "Node %d PageTables:     %8lu kB\n"
 		       "Node %d NFS_Unstable:   %8lu kB\n"
 		       "Node %d Bounce:         %8lu kB\n"
@@ -438,6 +441,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 		       nid, K(i.sharedram),
 		       nid, sum_zone_node_page_state(nid, NR_KERNEL_STACK_KB),
+#ifdef CONFIG_SHADOW_CALL_STACK
+		       nid, sum_zone_node_page_state(nid, NR_KERNEL_SCS_KB),
+#endif
 		       nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
 		       nid, K(node_page_state(pgdat, NR_UNSTABLE_NFS)),
 		       nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 8c1f1bb1a5ce..09cd51c8d23d 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -103,6 +103,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
 		   global_zone_page_state(NR_KERNEL_STACK_KB));
+#ifdef CONFIG_SHADOW_CALL_STACK
+	seq_printf(m, "ShadowCallStack:%8lu kB\n",
+		   global_zone_page_state(NR_KERNEL_SCS_KB));
+#endif
 	show_val_kb(m, "PageTables:     ",
 		    global_zone_page_state(NR_PAGETABLE));
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1b9de7d220fb..acffc3bc6178 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -156,6 +156,9 @@ enum zone_stat_item {
 	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
 	NR_PAGETABLE,		/* used for pagetables */
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
+#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
+	NR_KERNEL_SCS_KB,	/* measured in KiB */
+#endif
 	/* Second 128 byte cacheline */
 	NR_BOUNCE,
 #if IS_ENABLED(CONFIG_ZSMALLOC)
diff --git a/kernel/scs.c b/kernel/scs.c
index 43624be9ad90..8769016c714c 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -6,8 +6,10 @@
  */
 
 #include <linux/kasan.h>
+#include <linux/mm.h>
 #include <linux/scs.h>
 #include <linux/slab.h>
+#include <linux/vmstat.h>
 #include <asm/scs.h>
 
 static struct kmem_cache *scs_cache;
@@ -40,6 +42,17 @@ void __init scs_init(void)
 	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, 0, 0, NULL);
 }
 
+static struct page *__scs_page(struct task_struct *tsk)
+{
+	return virt_to_page(task_scs(tsk));
+}
+
+static void scs_account(struct task_struct *tsk, int account)
+{
+	mod_zone_page_state(page_zone(__scs_page(tsk)), NR_KERNEL_SCS_KB,
+		account * (SCS_SIZE / 1024));
+}
+
 int scs_prepare(struct task_struct *tsk, int node)
 {
 	void *s;
@@ -50,6 +63,7 @@ int scs_prepare(struct task_struct *tsk, int node)
 
 	task_scs(tsk) = s;
 	task_scs_offset(tsk) = 0;
+	scs_account(tsk, 1);
 
 	return 0;
 }
@@ -64,5 +78,6 @@ void scs_release(struct task_struct *tsk)
 
 	WARN_ON(scs_corrupted(tsk));
 
+	scs_account(tsk, -1);
 	scs_free(s);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..83743d7a6177 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5411,6 +5411,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" managed:%lukB"
 			" mlocked:%lukB"
 			" kernel_stack:%lukB"
+#ifdef CONFIG_SHADOW_CALL_STACK
+			" shadow_call_stack:%lukB"
+#endif
 			" pagetables:%lukB"
 			" bounce:%lukB"
 			" free_pcp:%lukB"
@@ -5433,6 +5436,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),
 			zone_page_state(zone, NR_KERNEL_STACK_KB),
+#ifdef CONFIG_SHADOW_CALL_STACK
+			zone_page_state(zone, NR_KERNEL_SCS_KB),
+#endif
 			K(zone_page_state(zone, NR_PAGETABLE)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 96d21a792b57..2435d2c24657 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1119,6 +1119,9 @@ const char * const vmstat_text[] = {
 	"nr_mlock",
 	"nr_page_table_pages",
 	"nr_kernel_stack",
+#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
+	"nr_shadow_call_stack",
+#endif
 	"nr_bounce",
 #if IS_ENABLED(CONFIG_ZSMALLOC)
 	"nr_zspages",
-- 
2.26.2.303.gf8c07b1a785-goog

