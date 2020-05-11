Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E02C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3D120820
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172841;
	bh=Cpeq8BTPLVSwmsx8ZNMVkOr4GPcFGydAh+FmNcyX5NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KAENyoygXYwRYG8ww25LqWLIPK75/Qjw2fyRMBFHAmbJTk9zshdFOBwglub0kffJy
	 ZCsCE2ykPEkFgnl0HEyR6g14zBhWKb31Fem2LNak2zuzVaN35AXs5/yzjMTE68LYW9
	 Lds5xhzbAL21xHTrifFXEtzNdz4tz/yO8569oBKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgEKExt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbgEKExo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D062192A;
        Mon, 11 May 2020 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172823;
        bh=Cpeq8BTPLVSwmsx8ZNMVkOr4GPcFGydAh+FmNcyX5NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hu1kEMipQMAr9zsOt9SqEoOaki/+bINbDzjCbTisoOg7HYj/KhD941FycSZMQ9nYv
         CbRxoC9Ru+ZbuhEYrxzUgz+WThydKwDjE6KFeHfwxSIk1PEel0QuX6UAuWEo7CmWm/
         /jG5LMb2HUBPfueeEnQWQFEMvFnF8C3HJGoB4WSU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 12/18] x86/fsgsbase/64: move save_fsgs to header file
Date:   Mon, 11 May 2020 00:53:05 -0400
Message-Id: <20200511045311.4785-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given copy_thread_tls() is now shared between 32 and 64 bit and we need
to use save_fsgs() there, move it to a header file.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/process.h    | 72 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/process_64.c | 68 ----------------------------------
 2 files changed, 72 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 1d0797b2338a2..2360d340cbf00 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -37,3 +37,75 @@ static inline void switch_to_extra(struct task_struct *prev,
 		     prev_tif & _TIF_WORK_CTXSW_PREV))
 		__switch_to_xtra(prev, next);
 }
+
+#ifdef CONFIG_X86_64
+
+enum which_selector {
+	FS,
+	GS
+};
+
+/*
+ * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
+ * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
+ * It's forcibly inlined because it'll generate better code and this function
+ * is hot.
+ */
+static __always_inline void save_base_legacy(struct task_struct *prev_p,
+                                             unsigned short selector,
+                                             enum which_selector which)
+{
+	if (likely(selector == 0)) {
+		/*
+		 * On Intel (without X86_BUG_NULL_SEG), the segment base could
+		 * be the pre-existing saved base or it could be zero.  On AMD
+		 * (with X86_BUG_NULL_SEG), the segment base could be almost
+		 * anything.
+		 *
+		 * This branch is very hot (it's hit twice on almost every
+		 * context switch between 64-bit programs), and avoiding
+		 * the RDMSR helps a lot, so we just assume that whatever
+		 * value is already saved is correct.  This matches historical
+		 * Linux behavior, so it won't break existing applications.
+		 *
+		 * To avoid leaking state, on non-X86_BUG_NULL_SEG CPUs, if we
+		 * report that the base is zero, it needs to actually be zero:
+		 * see the corresponding logic in load_seg_legacy.
+		 */
+	} else {
+		/*
+		 * If the selector is 1, 2, or 3, then the base is zero on
+		 * !X86_BUG_NULL_SEG CPUs and could be anything on
+		 * X86_BUG_NULL_SEG CPUs.  In the latter case, Linux
+		 * has never attempted to preserve the base across context
+		 * switches.
+		 *
+		 * If selector > 3, then it refers to a real segment, and
+		 * saving the base isn't necessary.
+		 */
+		if (which == FS)
+			prev_p->thread.fsbase = 0;
+		else
+			prev_p->thread.gsbase = 0;
+	}
+}
+
+static __always_inline void save_fsgs(struct task_struct *task)
+{
+	savesegment(fs, task->thread.fsindex);
+	savesegment(gs, task->thread.gsindex);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/*
+		 * If FSGSBASE is enabled, we can't make any useful guesses
+		 * about the base, and user code expects us to save the current
+		 * value.  Fortunately, reading the base directly is efficient.
+		 */
+		task->thread.fsbase = rdfsbase();
+		task->thread.gsbase = x86_gsbase_read_cpu_inactive();
+	} else {
+		save_base_legacy(task, task->thread.fsindex, FS);
+		save_base_legacy(task, task->thread.gsindex, GS);
+	}
+}
+
+#endif
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e066750be89a0..4be88124d81ea 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -145,74 +145,6 @@ void release_thread(struct task_struct *dead_task)
 	WARN_ON(dead_task->mm);
 }
 
-enum which_selector {
-	FS,
-	GS
-};
-
-/*
- * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
- * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
- * It's forcibly inlined because it'll generate better code and this function
- * is hot.
- */
-static __always_inline void save_base_legacy(struct task_struct *prev_p,
-					     unsigned short selector,
-					     enum which_selector which)
-{
-	if (likely(selector == 0)) {
-		/*
-		 * On Intel (without X86_BUG_NULL_SEG), the segment base could
-		 * be the pre-existing saved base or it could be zero.  On AMD
-		 * (with X86_BUG_NULL_SEG), the segment base could be almost
-		 * anything.
-		 *
-		 * This branch is very hot (it's hit twice on almost every
-		 * context switch between 64-bit programs), and avoiding
-		 * the RDMSR helps a lot, so we just assume that whatever
-		 * value is already saved is correct.  This matches historical
-		 * Linux behavior, so it won't break existing applications.
-		 *
-		 * To avoid leaking state, on non-X86_BUG_NULL_SEG CPUs, if we
-		 * report that the base is zero, it needs to actually be zero:
-		 * see the corresponding logic in load_seg_legacy.
-		 */
-	} else {
-		/*
-		 * If the selector is 1, 2, or 3, then the base is zero on
-		 * !X86_BUG_NULL_SEG CPUs and could be anything on
-		 * X86_BUG_NULL_SEG CPUs.  In the latter case, Linux
-		 * has never attempted to preserve the base across context
-		 * switches.
-		 *
-		 * If selector > 3, then it refers to a real segment, and
-		 * saving the base isn't necessary.
-		 */
-		if (which == FS)
-			prev_p->thread.fsbase = 0;
-		else
-			prev_p->thread.gsbase = 0;
-	}
-}
-
-static __always_inline void save_fsgs(struct task_struct *task)
-{
-	savesegment(fs, task->thread.fsindex);
-	savesegment(gs, task->thread.gsindex);
-	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
-		/*
-		 * If FSGSBASE is enabled, we can't make any useful guesses
-		 * about the base, and user code expects us to save the current
-		 * value.  Fortunately, reading the base directly is efficient.
-		 */
-		task->thread.fsbase = rdfsbase();
-		task->thread.gsbase = x86_gsbase_read_cpu_inactive();
-	} else {
-		save_base_legacy(task, task->thread.fsindex, FS);
-		save_base_legacy(task, task->thread.gsindex, GS);
-	}
-}
-
 #if IS_ENABLED(CONFIG_KVM)
 /*
  * While a process is running,current->thread.fsbase and current->thread.gsbase
-- 
2.20.1

