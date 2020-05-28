Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54714C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C94208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696881;
	bh=iU9LWSJ5Vw8e1tY/J5Ku+EAQF/rbekFaByBUmBynFA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tw0lufIkBH2JgMIH+LpYWUfBN73cHzgNFbSXf0p+tuksFMyQeZ6HQENEGE4qEysma
	 CYu0vKZjgL4gkjZajmqHDTZ/PDTYAl15JtPk7DkkOM4ajaD/mLxoaBSH35dDj/ChTr
	 4Ct8+hck7bO4PXveVjnKIbXVzHRR/Xt9wuBc1WdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407050AbgE1UOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407008AbgE1UOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3AAF20B80;
        Thu, 28 May 2020 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696859;
        bh=iU9LWSJ5Vw8e1tY/J5Ku+EAQF/rbekFaByBUmBynFA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9Fvr+PlRCyIAqxQgBPrRZb89K7suMo51m7JARIGJWT/v91JQ3e9FculK2x0HNzmm
         rRDNzo/VbWdr9jIQLf5vQdMcA8oQdF/dY6d2RZ8EguY+pR9O5IQjjCXRXl5ccHebIJ
         yt9YkEnTwomvgP4mK95/U/VBEz5xmwDAp6s6z+5A=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 04/16] x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
Date:   Thu, 28 May 2020 16:13:50 -0400
Message-Id: <20200528201402.1708239-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

Add cpu feature conditional FSGSBASE access to the relevant helper
functions. That allows to accelerate certain FS/GS base operations in
subsequent changes.

Note, that while possible, the user space entry/exit GSBASE operations are
not going to use the new FSGSBASE instructions. The reason is that it would
require additional storage for the user space value which adds more
complexity to the low level code and experiments have shown marginal
benefit. This may be revisited later but for now the SWAPGS based handling
in the entry code is preserved except for the paranoid entry/exit code.

To preserve the SWAPGS entry mechanism introduce __[rd|wr]gsbase_inactive()
helpers. Note, for Xen PV, paravirt hooks can be added later as they might
allow a very efficient but different implementation.

[ tglx: Massaged changelog ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-7-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h | 27 +++++++-------
 arch/x86/kernel/process_64.c    | 64 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index fdd1177499b4..aefd53767a5d 100644
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
index 5ef9d8f25b0e..0624689825a3 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -150,6 +150,40 @@ enum which_selector {
 	GS
 };
 
+/*
+ * Out of line to be protected from kprobes. It is not used on Xen
+ * paravirt. When paravirt support is needed, it needs to be renamed
+ * with native_ prefix.
+ */
+static noinline unsigned long __rdgsbase_inactive(void)
+{
+	unsigned long gsbase;
+
+	lockdep_assert_irqs_disabled();
+
+	native_swapgs();
+	gsbase = rdgsbase();
+	native_swapgs();
+
+	return gsbase;
+}
+NOKPROBE_SYMBOL(__rdgsbase_inactive);
+
+/*
+ * Out of line to be protected from kprobes. It is not used on Xen
+ * paravirt. When paravirt support is needed, it needs to be renamed
+ * with native_ prefix.
+ */
+static noinline void __wrgsbase_inactive(unsigned long gsbase)
+{
+	lockdep_assert_irqs_disabled();
+
+	native_swapgs();
+	wrgsbase(gsbase);
+	native_swapgs();
+}
+NOKPROBE_SYMBOL(__wrgsbase_inactive);
+
 /*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
@@ -328,6 +362,36 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		gsbase = __rdgsbase_inactive();
+		local_irq_restore(flags);
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
+		unsigned long flags;
+
+		local_irq_save(flags);
+		__wrgsbase_inactive(gsbase);
+		local_irq_restore(flags);
+	} else {
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+}
+
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
-- 
2.25.1

