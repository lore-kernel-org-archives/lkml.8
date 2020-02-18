Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CCC34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918AF20836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFdrVx8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgBRA5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:57:05 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:54412 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgBRA5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:57:05 -0500
Received: by mail-pj1-f73.google.com with SMTP id a31so389802pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 16:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UWOivOqvvKnnG9YpQAwFVSpkmhSp9gpofcG/6/xewVk=;
        b=dFdrVx8KZ5kYYfVfjrA7D44Z9E/BRkzVZbmxU0Dan5MH1YoxkgQlU8BPU373KWuC6I
         Qr7vV6zEPS9uOdjtgJuIZsO6CGrf0QIdzujpHXXGZjvunOqzhDPcE50bJscbQ9jv3eBo
         QCMJwgo4T2OgiWSjZqWoTtLHU3RdEHG+Ox8EJqF2p/P86KB9BDuXeEfYw4eOWfG5okSh
         fH7Wf7o91LzZl8bO1b6nCOJvRzVrpN3bBtPlhPgElE1Ae1G1/RnCIS+3LIiwRUdrR5rK
         GwRFXOo62bEfQOO/X2N/d8LmisGBArPIjaqh8YnWOEc4yFPbHoBVNR0SpEUV2XkMzdT8
         LQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UWOivOqvvKnnG9YpQAwFVSpkmhSp9gpofcG/6/xewVk=;
        b=Lwhu8iT767Hwgv4R6J6xcVvYG3f6AhagerAdvxrw16vMdu1cwBDFmiATYkD2zyZGzG
         LOZG9nw+WEIJErBUDFjE/Xak8u7SghRUzzlJulv02N7Xou160C8d16BCdLSyWqe1ZOr5
         /mmervC5BgviPNkW5qNodldDkEMg9jV9eErp/4QvH9w1LRjJ9Q8hcbdmiIkQwlA9zqOl
         +s27g/U3QCFFwnTyKbWgBgzf8ptOr3pJbjdEQupQ3Snc6J1MKL//U4psJpWWvwIz+Wqf
         h8XZjJMhTv4O0BH3kEo5nQbgkiCour6nRdn8wfESACkxyYAn1vuLTR/L3Of0vzwbWUZl
         7yww==
X-Gm-Message-State: APjAAAVbZ7yTMgW+rNYIY2YYs29XeYlfREDV6UjkszqbgyaSStm83bC7
        nHpCqaCw8ppnipAWwOKwqYnmKik/xGMcudeABnvhcbgJfuiUiPt9tmm+D8chLb3+de9AuKYOzQ1
        qMlWEZR4UA2tUiHfN7Rj8/JcPAnPndFGAU0VDjTT1LRS/8zxWoZGdR+YIvbq9fNLRpmJb0g==
X-Google-Smtp-Source: APXvYqyALFXLr3ct+zvMLF0E2xgzv1jQXH0uE/mQ4XM6P1a3brLyYAFXlhyKIntbSpt2zsoB298QwTvWeLs=
X-Received: by 2002:a65:40c8:: with SMTP id u8mr16965521pgp.188.1581987424436;
 Mon, 17 Feb 2020 16:57:04 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:56:59 -0800
Message-Id: <20200218005659.91318-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3] kretprobe: percpu support
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
 kernel/kprobes.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/test_kprobes.c   | 18 +++++++++++++-----
 3 files changed, 62 insertions(+), 7 deletions(-)

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
index 2625c241ac00f..12ca682083ffc 100644
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
@@ -1874,6 +1883,27 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
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
+		INIT_HLIST_NODE(&ri->hlist);
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
@@ -1891,6 +1921,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 			return 0;
 		}
 
+good:
 		arch_prepare_kretprobe(ri, regs);
 
 		/* XXX(hch): why is there no hlist_move_head? */
@@ -1950,6 +1981,15 @@ int register_kretprobe(struct kretprobe *rp)
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
@@ -1971,6 +2011,7 @@ int register_kretprobe(struct kretprobe *rp)
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
+		pr_err("kretprobe handler2 mode %s not called\n", mode);
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

