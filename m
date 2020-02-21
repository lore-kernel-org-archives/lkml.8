Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C312C35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE52207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuQeiZ/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgBUVRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:17:11 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51708 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:17:10 -0500
Received: by mail-pg1-f202.google.com with SMTP id m18so1844556pgn.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K4tNaEmDx+Ph11O0pjEd4zXcCn7oG4j1jkP43LLel9s=;
        b=tuQeiZ/kp8Faio8+Pn8ldF4tDBlXZie8EiltVeeW1G/hcm40iXo9fmdr1lIc8ZKoaj
         sCexltfOHXbcqlzcTnzPAEEyim+an4B8+wCqdKaFQBH+jm7m3o4ga0dBWxioarx8fcoN
         HwEVw+MZV6j4FBMOA9GLvWQg+QsmmkbkFam74s257GHWvaVgOxuocZ8LL5FXUwv5RvAI
         +oVMvoa23iVbh/euJg8MiU3AC5SDXigzJhx0EzpuBLc+KBIBdTpJqm/b80SaKT/AXkxg
         cfiKBAw6ZQXp20YTw70T7ymZFC8ztrY1KQljhx6pF+x9wmHz0lNOge7SrAJMw0UH7l7N
         wQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K4tNaEmDx+Ph11O0pjEd4zXcCn7oG4j1jkP43LLel9s=;
        b=jRaOMRAmnnkJ+Mw7VuACnKtp9osS4nn/+4xYSMS8+q81rUuLno8yVv/ul191zW8GFi
         fwzRsj33JIsOoPcvbWcL0hCVwFykKiIu9FqV3UsuLbX5PQanH+CyDVHu0cGQRptbxFD7
         31AyX+E/utNBC2yH0TyW5XqCySG2bnvUxdwpwVolmK8AmHc95WcipVq0jN5j3eJ2mfOs
         YAgcxuaUfZ52HuwbmjOdmgbR7KxoiGXpscgD86hx9lmyFN0ff3smcxGcCvTO5Z4Oc4oJ
         1ojHuyfT3XJkJakhotBU+OfBhhXl6TFeC0qb8gBmIyUAVHvKuukj56AXsC269YJsa004
         5djQ==
X-Gm-Message-State: APjAAAWSwNBlPq/TAWEXEnYXwyruZJLZAkgkkrm1uMJwEgV9bf2WFP+B
        1moz/D7OZ973w8ALxxERf3RNPQq6QSUSuSolUWIz2LvdJ7K+yC7YIprl16RY8eKepOGLZb7HWmZ
        tlV2VEkIgspW8MYfXrzNhx/VIKg28JpYVe96k2ZL3KZFQcYiJmsEgKzMn5qwiwH3bhs122Q==
X-Google-Smtp-Source: APXvYqyHhi9otFVJsXYhNRMPjldqE6Nv8EP02/2DYOzoCgYweFCXlVVj0f/5ZqHPrZv6ntn9nyW9xw11msw=
X-Received: by 2002:a63:306:: with SMTP id 6mr39932785pgd.337.1582319828170;
 Fri, 21 Feb 2020 13:17:08 -0800 (PST)
Date:   Fri, 21 Feb 2020 13:16:57 -0800
Message-Id: <20200221211657.147250-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v4] kretprobe: percpu support
From:   Luigi Rizzo <lrizzo@google.com>
To:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, gregkh@linuxfoundation.org
Cc:     rizzo@iet.unipi.it, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kretprobe uses a list protected by a single lock to allocate a
kretprobe_instance in pre_handler_kretprobe(). This works poorly with
concurrent calls.

This patch offers a simplified fix: the percpu_instance flag indicates
that kretprobe_instance's are per CPU, which makes allocation lock free.

As part of this patch, we factor out the code to allocate instances in
get_pcpu_rp_instance() and get_rp_instance().

At the moment we only allow one pending kretprobe per CPU. This can be
extended to a small constant number of entries, but finding a free entry
would either bring back the lock, or require scanning an array, which can
be expensive (especially if callers block and migrate).

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/kprobes.h |   8 +++-
 kernel/kprobes.c        | 102 +++++++++++++++++++++++++++++++---------
 kernel/test_kprobes.c   |  20 ++++++--
 3 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 04bdaf01112cb..c5894f4c5c26c 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -142,6 +142,8 @@ static inline int kprobe_ftrace(struct kprobe *p)
  * can be active concurrently.
  * nmissed - tracks the number of times the probed function's return was
  * ignored, due to maxactive being too low.
+ * percpu_instance - if set, uses one instance per cpu instead of allocating
+ * from the list protected by lock.
  *
  */
 struct kretprobe {
@@ -151,8 +153,12 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct hlist_head free_instances;
+	union {
+		struct kretprobe_instance __percpu *pcpu;
+		struct hlist_head free_instances;
+	};
 	raw_spinlock_t lock;
+	bool percpu_instance;
 };
 
 struct kretprobe_instance {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00f..46018a4a76178 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1184,6 +1184,10 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
 	hlist_del(&ri->hlist);
 	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
+		if (rp->percpu_instance) {
+			ri->rp = NULL;
+			return;
+		}
 		raw_spin_lock(&rp->lock);
 		hlist_add_head(&ri->hlist, &rp->free_instances);
 		raw_spin_unlock(&rp->lock);
@@ -1274,6 +1278,11 @@ static inline void free_rp_inst(struct kretprobe *rp)
 	struct kretprobe_instance *ri;
 	struct hlist_node *next;
 
+	if (rp->percpu_instance) {
+		free_percpu(rp->pcpu);
+		return;
+	}
+
 	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
@@ -1851,6 +1860,46 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 }
 
 #ifdef CONFIG_KRETPROBES
+struct kretprobe_instance *get_pcpu_rp_instance(struct kretprobe *rp)
+{
+	struct kretprobe_instance *ri;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ri = this_cpu_ptr(rp->pcpu);
+	if (!ri || ri->rp) { /* already in use */
+		local_irq_restore(flags);
+		rp->nmissed++;
+		return NULL;
+	}
+	INIT_HLIST_NODE(&ri->hlist);
+	ri->rp = rp;
+	ri->task = current;
+	local_irq_restore(flags);
+	return ri;
+}
+
+struct kretprobe_instance *get_rp_instance(struct kretprobe *rp)
+{
+	struct kretprobe_instance *ri;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rp->lock, flags);
+	if (hlist_empty(&rp->free_instances)) {
+		rp->nmissed++;
+		raw_spin_unlock_irqrestore(&rp->lock, flags);
+		return NULL;
+	}
+	ri = hlist_entry(rp->free_instances.first, struct kretprobe_instance,
+			 hlist);
+	hlist_del(&ri->hlist);
+	raw_spin_unlock_irqrestore(&rp->lock, flags);
+
+	ri->rp = rp;
+	ri->task = current;
+	return ri;
+}
+
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.
@@ -1873,35 +1922,32 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 	}
 
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
-	hash = hash_ptr(current, KPROBE_HASH_BITS);
-	raw_spin_lock_irqsave(&rp->lock, flags);
-	if (!hlist_empty(&rp->free_instances)) {
-		ri = hlist_entry(rp->free_instances.first,
-				struct kretprobe_instance, hlist);
-		hlist_del(&ri->hlist);
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
-
-		ri->rp = rp;
-		ri->task = current;
-
-		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
+	if (rp->percpu_instance) {
+		ri = get_pcpu_rp_instance(rp);
+	} else {
+		ri = get_rp_instance(rp);
+	}
+	if (!ri)
+		return 0;
+	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
+		if (rp->percpu_instance) {
+			ri->rp = NULL;
+		} else {
 			raw_spin_lock_irqsave(&rp->lock, flags);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
 			raw_spin_unlock_irqrestore(&rp->lock, flags);
-			return 0;
 		}
+		return 0;
+	}
+	arch_prepare_kretprobe(ri, regs);
 
-		arch_prepare_kretprobe(ri, regs);
+	/* XXX(hch): why is there no hlist_move_head? */
+	INIT_HLIST_NODE(&ri->hlist);
+	hash = hash_ptr(current, KPROBE_HASH_BITS);
+	kretprobe_table_lock(hash, &flags);
+	hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
+	kretprobe_table_unlock(hash, &flags);
 
-		/* XXX(hch): why is there no hlist_move_head? */
-		INIT_HLIST_NODE(&ri->hlist);
-		kretprobe_table_lock(hash, &flags);
-		hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
-		kretprobe_table_unlock(hash, &flags);
-	} else {
-		rp->nmissed++;
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
-	}
 	return 0;
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
@@ -1950,6 +1996,15 @@ int register_kretprobe(struct kretprobe *rp)
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
 
+	if (rp->percpu_instance) {
+		rp->pcpu = __alloc_percpu(sizeof(*rp->pcpu) + rp->data_size,
+					  __alignof__(*rp->pcpu));
+		if (rp->pcpu)
+			goto finalize;
+		free_rp_inst(rp);
+		return -ENOMEM;
+	}
+
 	/* Pre-allocate memory for max kretprobe instances */
 	if (rp->maxactive <= 0) {
 #ifdef CONFIG_PREEMPTION
@@ -1971,6 +2026,7 @@ int register_kretprobe(struct kretprobe *rp)
 		hlist_add_head(&inst->hlist, &rp->free_instances);
 	}
 
+finalize:
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index 76c997fdbc9da..4ebe48301d743 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -236,31 +236,36 @@ static struct kretprobe rp2 = {
 	.kp.symbol_name = "kprobe_target2"
 };
 
-static int test_kretprobes(void)
+static int test_kretprobes(bool percpu_instance)
 {
 	int ret;
 	struct kretprobe *rps[2] = {&rp, &rp2};
+	const char *mode = percpu_instance ? "percpu " : "normal";
 
 	/* addr and flags should be cleard for reusing kprobe. */
 	rp.kp.addr = NULL;
 	rp.kp.flags = 0;
+	rp.percpu_instance = percpu_instance;
+	rp2.kp.addr = NULL;
+	rp2.kp.flags = 0;
+	rp2.percpu_instance = percpu_instance;
 	ret = register_kretprobes(rps, 2);
 	if (ret < 0) {
-		pr_err("register_kretprobe returned %d\n", ret);
+		pr_err("register_kretprobe mode %s returned %d\n", mode, ret);
 		return ret;
 	}
 
 	krph_val = 0;
 	ret = target(rand1);
 	if (krph_val != rand1) {
-		pr_err("kretprobe handler not called\n");
+		pr_err("kretprobe handler mode %s not called\n", mode);
 		handler_errors++;
 	}
 
 	krph_val = 0;
 	ret = target2(rand1);
 	if (krph_val != rand1) {
-		pr_err("kretprobe handler2 not called\n");
+		pr_err("kretprobe handler2 mode %s not called\n", mode);
 		handler_errors++;
 	}
 	unregister_kretprobes(rps, 2);
@@ -297,7 +302,12 @@ int init_test_probes(void)
 		errors++;
 
 	num_tests++;
-	ret = test_kretprobes();
+	ret = test_kretprobes(false);
+	if (ret < 0)
+		errors++;
+
+	num_tests++;
+	ret = test_kretprobes(true);
 	if (ret < 0)
 		errors++;
 #endif /* CONFIG_KRETPROBES */
-- 
2.25.0.265.gbab2e86ba0-goog

