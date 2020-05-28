Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66493C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D18208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590697002;
	bh=ZFtNDFUkX5FhGp1GJ9nd7mzQ/8252J+q8Uqx5krh7o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zcvJrdQa+iZYowEs3iQRTcbZZvSA+C0OiuiZUZ7quZcAl8vtCgw9JXtThIw8tAgm9
	 gt1P4IiiUp61fdIISH9BavL1qnmaGyXY6FZOMSKxjK7i1f9pR1k4QB/xU+LPJb3Bsz
	 vDhLFQMYluAZ7TryOa9AMRZ+Ru5PcmHx9dhLIcwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406778AbgE1UQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407014AbgE1UOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E02020C56;
        Thu, 28 May 2020 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696863;
        bh=ZFtNDFUkX5FhGp1GJ9nd7mzQ/8252J+q8Uqx5krh7o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkWZgvMetxlljQNeIKyVd5XK9R+PUaJcMK5SJoQBAu4GcxrWj7xJgjsE/co7kndru
         4LnNufidwJVjSfempbmjj6KNx/zB10Jqmbz9JqyFWrfyehp/dR1c/N09ZKMHcEfduZ
         ZrP753FzXN4cooDUcANHxZ3h0HWCaguKCN+x03eI=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 06/16] x86/process/64: Make save_fsgs() public available
Date:   Thu, 28 May 2020 16:13:52 -0400
Message-Id: <20200528201402.1708239-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/processor.h |  4 +---
 arch/x86/kernel/process_64.c     | 15 +++++++++------
 arch/x86/kvm/vmx/vmx.c           |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3bcf27caf6c9..809bc013db70 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -456,10 +456,8 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
 
-#if IS_ENABLED(CONFIG_KVM)
 /* Save actual FS/GS selectors and bases to current->thread */
-void save_fsgs_for_kvm(void);
-#endif
+void current_save_fsgs(void);
 #else	/* X86_64 */
 #ifdef CONFIG_STACKPROTECTOR
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 85c7f9cabde2..aefb30bc56bc 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -247,18 +247,21 @@ static __always_inline void save_fsgs(struct task_struct *task)
 	}
 }
 
-#if IS_ENABLED(CONFIG_KVM)
 /*
  * While a process is running,current->thread.fsbase and current->thread.gsbase
- * may not match the corresponding CPU registers (see save_base_legacy()). KVM
- * wants an efficient way to save and restore FSBASE and GSBASE.
- * When FSGSBASE extensions are enabled, this will have to use RD{FS,GS}BASE.
+ * may not match the corresponding CPU registers (see save_base_legacy()).
  */
-void save_fsgs_for_kvm(void)
+void current_save_fsgs(void)
 {
+	unsigned long flags;
+
+	/* Interrupts need to be off for FSGSBASE */
+	local_irq_save(flags);
 	save_fsgs(current);
+	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(save_fsgs_for_kvm);
+#if IS_ENABLED(CONFIG_KVM)
+EXPORT_SYMBOL_GPL(current_save_fsgs);
 #endif
 
 static __always_inline void loadseg(enum which_selector which,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 89c766fad889..309e6dc975d5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1167,7 +1167,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 
 	gs_base = cpu_kernelmode_gs_base(cpu);
 	if (likely(is_64bit_mm(current->mm))) {
-		save_fsgs_for_kvm();
+		current_save_fsgs();
 		fs_sel = current->thread.fsindex;
 		gs_sel = current->thread.gsindex;
 		fs_base = current->thread.fsbase;
-- 
2.25.1

