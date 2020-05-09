Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A192C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FB02192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589045858;
	bh=/Y6JDEC90w0GBqbdeWrZTksp0NgWDLpS8ypWQddiY5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2wG8dGSEsDDP/qGtBZYpVjBEF38/8QHDLfC5yj/USQtYSlJLTjcAtV0mLG2gw+qG1
	 vNADasBDYGK8riSaIXTgmelXdpmiMvunXsTYA16po8rgutv8uujwmlEQM2GmCYTZvZ
	 Fnzo8DOesdkef3JB/8Oe1nvE3+b3Fqa3bk9aZ0S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgEIRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgEIRhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:37:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4749420A8B;
        Sat,  9 May 2020 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589045835;
        bh=/Y6JDEC90w0GBqbdeWrZTksp0NgWDLpS8ypWQddiY5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxzhRnhXhtQM6aIIKoTpf3aoCQ6MsdQvBTCvJKlppbU3SoSYsKh/EUeg0F2RnHl8p
         df7jC2YJaZjYrEkvQvcIyyXI+M/Ue4xTB1WeoKli7/ANYUQ4HGNGUaVohQysRtg2jn
         fwCjwZCKyz1e+1xIdXFVj7kmjXsLC0Yb+wdiNGfY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v11 11/18] x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
Date:   Sat,  9 May 2020 13:36:48 -0400
Message-Id: <20200509173655.13977-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509173655.13977-1-sashal@kernel.org>
References: <20200509173655.13977-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

With the new FSGSBASE instructions, FS/GS base can be efficiently read
and written in __switch_to(). Use that capability to preserve the full
state.

This will enable user code to do whatever it wants with the new
instructions without any kernel-induced gotchas.  (There can still be
architectural gotchas: movl %gs,%eax; movl %eax,%gs may change GS base
if WRGSBASE was used, but users are expected to read the CPU manual
before doing things like that.)

This is a considerable speedup. It seems to save about 100 cycles per
context switch compared to the baseline 4.6-rc1 behavior on a Skylake
laptop.

[ chang: 5~10% performance improvements were seen by a context switch
  benchmark that ran threads with different FS/GS base values (to the
  baseline 4.16). ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/process_64.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index aaa65f284b9b9..e066750be89a0 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -199,8 +199,18 @@ static __always_inline void save_fsgs(struct task_struct *task)
 {
 	savesegment(fs, task->thread.fsindex);
 	savesegment(gs, task->thread.gsindex);
-	save_base_legacy(task, task->thread.fsindex, FS);
-	save_base_legacy(task, task->thread.gsindex, GS);
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
 }
 
 #if IS_ENABLED(CONFIG_KVM)
@@ -279,10 +289,22 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 					      struct thread_struct *next)
 {
-	load_seg_legacy(prev->fsindex, prev->fsbase,
-			next->fsindex, next->fsbase, FS);
-	load_seg_legacy(prev->gsindex, prev->gsbase,
-			next->gsindex, next->gsbase, GS);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/* Update the FS and GS selectors if they could have changed. */
+		if (unlikely(prev->fsindex || next->fsindex))
+			loadseg(FS, next->fsindex);
+		if (unlikely(prev->gsindex || next->gsindex))
+			loadseg(GS, next->gsindex);
+
+		/* Update the bases. */
+		wrfsbase(next->fsbase);
+		x86_gsbase_write_cpu_inactive(next->gsbase);
+	} else {
+		load_seg_legacy(prev->fsindex, prev->fsbase,
+				next->fsindex, next->fsbase, FS);
+		load_seg_legacy(prev->gsindex, prev->gsbase,
+				next->gsindex, next->gsbase, GS);
+	}
 }
 
 static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-- 
2.20.1

