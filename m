Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9D7C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B9C207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3mWvNpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgBRAUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:20:22 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36782 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgBRAUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:20:22 -0500
Received: by mail-pf1-f201.google.com with SMTP id 6so12255745pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YRPZpfQbdrPNL4yfIRzFV+frczdg6cm306DfFTZlymM=;
        b=N3mWvNpKqTQK2/o+g6oZ4VD8DJT/x/hGJV4bTDcyVobhiM3givqkxCx8zZAF/h/6Le
         dqy5BefW45m2OgYYqdvFfKe27S2kE+kYdAj5hOWqo+ulXZxewvRjY4E3I3i/zK11BtMp
         UCvrL6Ni52HI/cWegoO+/SJJejNfctRPZJVXU/+s2UWeuEcvBJqdgSxto25Y9ADhKQKL
         Oc/ZY7hzqZSEO9BxD78eUpoKieHhthE85p3i9DcofrbPYxxmArZlp5irug437honhsTV
         uMR/sJPCYUxyMV/dFO5dEmk7g02oAIc/PbVtaBZ5VUk2drRMGMNOem2HIv6+hTaHxlhD
         ubhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YRPZpfQbdrPNL4yfIRzFV+frczdg6cm306DfFTZlymM=;
        b=RcL5mHgytGX/q4UmCS/QlDaSdloFl7gQNQVKFXvEa92sdrf0+7HX8yIoJzy/rixncc
         Xk/N6CsZrU+6E9ZGSWJGw9MSJsqO7DEm5+T6J1GIGOAWvzzJfgbujwrxf+GSnaHR01b+
         7S2nBeB8AolkStKPEmk7Ozgdwvy9pmBSzKDy2jvxhbkOQOjBg8PE0Q6RDeaXtw6wmTFx
         J3rJLlvHgbA5Z9LEITSGdRk4K2G6LnhdE/TAZCbh4DSi3vcDpHcJu5AUdrtZr5pOsDEi
         eORC7zwG1Obx8jJZ7kCQK6r8+gdPpChTjGyzeVB9y5umZwP0NPh4Zy0l5ptxbmUnX9nL
         8p7g==
X-Gm-Message-State: APjAAAXF97IEWxY5D/j/7DTbcHLYSHpeSalgzhKqF2zfAZTV1NeQLc4e
        ps7c/PuP+9//pHTruAtH1weEI1q9mxt3f6/E7srmK76bQCRB3SbByHAxJ0wHt9Cl18na8FtclgR
        EjEIBe7ja9J2U+VBSq/AcLt7pJAE9Cx704V8aTTneta/i13lG4ZySQPMrIUr4lfiOJ2pctA==
X-Google-Smtp-Source: APXvYqy5t2nHyENXUOrhmE30pbDQhIJQ5dKVPA8HObMKD1RGgLR42mtJYG2ihJpk6LPF5210wnuzcGvgxiY=
X-Received: by 2002:a65:404d:: with SMTP id h13mr19366231pgp.156.1581985221249;
 Mon, 17 Feb 2020 16:20:21 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:20:15 -0800
Message-Id: <20200218002015.204302-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] kretprobe: percpu support
From:   Luigi Rizzo <lrizzo@google.com>
To:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, gregkh@linuxfoundation.org
Cc:     Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kretprobe uses a list protected by a single lock to allocate a
kretprobe_instance in pre_handler_kretprobe(). This works poorly with
concurrent calls.

This patch offers a simplified fix: the percpu_instance flag indicates
that we allocate one instance per CPU, and the allocation is contention
free, but we allow only have one pending entry per CPU (this could be
extended to a small constant number without much trouble).

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/kprobes.h | 10 ++++++++--
 kernel/kprobes.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/test_kprobes.c   | 18 +++++++++++++-----
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 04bdaf01112cb..5c549d6a599b9 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -142,7 +142,8 @@ static inline int kprobe_ftrace(struct kprobe *p)
  * can be active concurrently.
  * nmissed - tracks the number of times the probed function's return was
  * ignored, due to maxactive being too low.
- *
+ * percpu_instance - if set, uses one instance per cpu instead of allocating
+ * from the list protected by lock.
  */
 struct kretprobe {
 	struct kprobe kp;
@@ -151,8 +152,13 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct hlist_head free_instances;
+	union {
+		struct kretprobe_instance __percpu *pcpu;
+		struct hlist_head free_instances;
+	};
 	raw_spinlock_t lock;
+	u32 percpu_instance:1;
+	u32 unused:31;
 };
 
 struct kretprobe_instance {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00f..590b534ec2bf0 100644
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
@@ -1874,6 +1883,26 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
 	hash = hash_ptr(current, KPROBE_HASH_BITS);
+	if (rp->percpu_instance) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		ri = this_cpu_ptr(rp->pcpu);
+		if (!ri || ri->rp) { /* already in use */
+			local_irq_restore(flags);
+			rp->nmissed++;
+			return 0;
+		}
+		ri->rp = rp;
+		ri->task = current;
+		local_irq_restore(flags);
+
+		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
+			ri->rp = NULL;	/* failed */
+			return 0;
+		}
+		goto good;
+	}
 	raw_spin_lock_irqsave(&rp->lock, flags);
 	if (!hlist_empty(&rp->free_instances)) {
 		ri = hlist_entry(rp->free_instances.first,
@@ -1891,6 +1920,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 			return 0;
 		}
 
+good:
 		arch_prepare_kretprobe(ri, regs);
 
 		/* XXX(hch): why is there no hlist_move_head? */
@@ -1951,6 +1981,15 @@ int register_kretprobe(struct kretprobe *rp)
 	rp->kp.fault_handler = NULL;
 
 	/* Pre-allocate memory for max kretprobe instances */
+	if (rp->maxactive < 0) {	/* alloc percpu */
+		rp->pcpu = __alloc_percpu(sizeof(*rp->pcpu) + rp->data_size,
+					  __alignof__(*rp->pcpu));
+		if (rp->pcpu)
+			goto finalize;
+		free_rp_inst(rp);
+		return -ENOMEM;
+	}
+
 	if (rp->maxactive <= 0) {
 #ifdef CONFIG_PREEMPTION
 		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
@@ -1971,6 +2010,7 @@ int register_kretprobe(struct kretprobe *rp)
 		hlist_add_head(&inst->hlist, &rp->free_instances);
 	}
 
+finalize:
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index 76c997fdbc9da..22b734fb8bcb2 100644
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
+		pr_err("kretprobe handler2 $snot called\n", mode);
 		handler_errors++;
 	}
 	unregister_kretprobes(rps, 2);
@@ -297,7 +302,10 @@ int init_test_probes(void)
 		errors++;
 
 	num_tests++;
-	ret = test_kretprobes();
+	ret = test_kretprobes(false);
+	if (ret < 0)
+		errors++;
+	ret = test_kretprobes(true);
 	if (ret < 0)
 		errors++;
 #endif /* CONFIG_KRETPROBES */
-- 
2.25.0.265.gbab2e86ba0-goog

