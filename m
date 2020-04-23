Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104EC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126FC20784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684187;
	bh=g/GBnDliB//bhWBmJ6kKV3RtUiv2G0d9s8tpHD4NzUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=src+RLZx3UjR0t0I4VEp8L88pXina7pANNnnob5W+PI58vGZXbQ1VfMdo/4q3Je+W
	 npfyXqnR618A6DqOUsxYyZOUf+hsWG5J70765Unml2IB7y3ZZwyLkuhmV+qo+guKWN
	 EoshF1YOy92IULGK/aBATPUq/gDUvXBB20cWw0F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgDWXXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgDWXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57BA2214AF;
        Thu, 23 Apr 2020 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684145;
        bh=g/GBnDliB//bhWBmJ6kKV3RtUiv2G0d9s8tpHD4NzUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNG+PUaZ9tAdUDABL/7C/hAbwbceqab1B0HVyXf616/jYns+37OxeeCXPpHDOTFy3
         fvdScaXvsiQ1lhrMShs4AfZr2BnGRNUHmuks6ZQ2FQ1Jzakc2107y7qW7RedzLuBVm
         JDT8ITYSkdNrRIL/qkX9HrcAUTmXsYWZEttirM/U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
Date:   Thu, 23 Apr 2020 19:21:59 -0400
Message-Id: <20200423232207.5797-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

Add CPU feature conditional FS/GS base access to the relevant helper
functions. That allows accelerating certain FS/GS base operations in
subsequent changes.

Note, that while possible, the user space entry/exit GS base operations are
not going to use the new FSGSBASE instructions. The reason is that it would
require additional storage for the user space value which adds more
complexity to the low level code and experiments have shown marginal
benefit. This may be revisited later but for now the SWAPGS based handling
in the entry code is preserved except for the paranoid entry/exit code.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h | 27 +++++++--------
 arch/x86/kernel/process_64.c    | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index fdd1177499b40..aefd53767a5d4 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -49,35 +49,32 @@ static __always_inline void wrgsbase(unsigned long gsbase)
 	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
 }
 
+#include <asm/cpufeature.h>
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long x86_fsbase_read_cpu(void)
 {
 	unsigned long fsbase;
 
-	rdmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		fsbase = rdfsbase();
+	else
+		rdmsrl(MSR_FS_BASE, fsbase);
 
 	return fsbase;
 }
 
-static inline unsigned long x86_gsbase_read_cpu_inactive(void)
-{
-	unsigned long gsbase;
-
-	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
-
-	return gsbase;
-}
-
 static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	wrmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		wrfsbase(fsbase);
+	else
+		wrmsrl(MSR_FS_BASE, fsbase);
 }
 
-static inline void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
-{
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
-}
+extern unsigned long x86_gsbase_read_cpu_inactive(void);
+extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5ef9d8f25b0e8..aaa65f284b9b9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -328,6 +328,64 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		bool need_restore = false;
+		unsigned long flags;
+
+		/*
+		 * We read the inactive GS base value by swapping
+		 * to make it the active one. But we cannot allow
+		 * an interrupt while we switch to and from.
+		 */
+		if (!irqs_disabled()) {
+			local_irq_save(flags);
+			need_restore = true;
+		}
+
+		native_swapgs();
+		gsbase = rdgsbase();
+		native_swapgs();
+
+		if (need_restore)
+			local_irq_restore(flags);
+	} else {
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+
+	return gsbase;
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		bool need_restore = false;
+		unsigned long flags;
+
+		/*
+		 * We write the inactive GS base value by swapping
+		 * to make it the active one. But we cannot allow
+		 * an interrupt while we switch to and from.
+		 */
+		if (!irqs_disabled()) {
+			local_irq_save(flags);
+			need_restore = true;
+		}
+
+		native_swapgs();
+		wrgsbase(gsbase);
+		native_swapgs();
+
+		if (need_restore)
+			local_irq_restore(flags);
+	} else {
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+}
+
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
-- 
2.20.1

