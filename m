Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E3C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C64A2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="txnSveMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgDWOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:01:53 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:6920 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgDWOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587650506; x=1619186506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=f3snJgTnmBO8PbV2Q0WMVuNQT9obU/m2sjWKpYpCIXw=;
  b=txnSveMzrElWd7gFYq8gBLy67ThoOBHABUY+ex+0kWstOh/E0ZijNDMF
   GF1e7OKp1M27jREyRJN3qprkLQSpV0lABkoJAgd3uCDUwZkIkmj6rN2KD
   +ks2lfdaicZPW5mVMrRCeM1N4tfOpwA48Jr5cHBXjKWKfg6efsj7JBOgf
   Q=;
IronPort-SDR: ZgRF0izE03FLM/pNsniUZjoZdrNjg5inI6M2vxEG13Z3wnzBsR2NG+SxyRdaVVWvsTfTiBLT+E
 28uifrW/TkYA==
X-IronPort-AV: E=Sophos;i="5.73,307,1583193600"; 
   d="scan'208";a="40451037"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Apr 2020 14:01:45 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 8F71CA2120;
        Thu, 23 Apr 2020 14:01:41 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Apr 2020 14:01:40 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Apr 2020 14:01:40 +0000
Received: from localhost (10.143.207.46) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Apr 2020 14:01:39 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v4 4/6] arch/x86/kvm: Refactor L1D flushing
Date:   Fri, 24 Apr 2020 00:01:23 +1000
Message-ID: <20200423140125.7332-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423140125.7332-1-sblbir@amazon.com>
References: <20200423140125.7332-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move out the initialization function to l1d_flush_init_once()
so that it can be reused for subsequent patches. The side-effect
of this patch is that the memory allocated for l1d flush pages
is no longer freed up and the memory allocated once is shared
amongst callers.

l1d_flush_sw/hw() are now abstracted under arch_l1d_flush().
vmx_l1d_flush_mutex however continues to exist as it also used
from other code paths.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/cacheflush.h | 12 ++++---
 arch/x86/kernel/l1d_flush.c       | 53 +++++++++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.c            | 20 ++----------
 3 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 21cc3b28fa63..851d8f1ab827 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -7,11 +7,13 @@
 #include <asm/special_insns.h>
 
 #define L1D_CACHE_ORDER 4
+
+enum l1d_flush_options {
+	L1D_FLUSH_POPULATE_TLB = 0x1,
+};
+
 void clflush_cache_range(void *addr, unsigned int size);
-void l1d_flush_populate_tlb(void *l1d_flush_pages);
-void *l1d_flush_alloc_pages(void);
-void l1d_flush_cleanup_pages(void *l1d_flush_pages);
-void l1d_flush_sw(void *l1d_flush_pages);
-int l1d_flush_hw(void);
+int l1d_flush_init_once(void);
+void arch_l1d_flush(enum l1d_flush_options options);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
index 5871794f890d..a754b6c288a9 100644
--- a/arch/x86/kernel/l1d_flush.c
+++ b/arch/x86/kernel/l1d_flush.c
@@ -1,7 +1,7 @@
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
 
-void *l1d_flush_alloc_pages(void)
+static void *l1d_flush_alloc_pages(void)
 {
 	struct page *page;
 	void *l1d_flush_pages = NULL;
@@ -27,20 +27,14 @@ void *l1d_flush_alloc_pages(void)
 	}
 	return l1d_flush_pages;
 }
-EXPORT_SYMBOL_GPL(l1d_flush_alloc_pages);
 
-void l1d_flush_cleanup_pages(void *l1d_flush_pages)
-{
-	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
-}
-EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
 
 /*
  * Not all users of l1d flush would want to populate the TLB first
  * split out the function so that callers can optionally flush the L1D
  * cache via sw without prefetching the TLB.
  */
-void l1d_flush_populate_tlb(void *l1d_flush_pages)
+static void l1d_flush_populate_tlb(void *l1d_flush_pages)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
@@ -58,9 +52,8 @@ void l1d_flush_populate_tlb(void *l1d_flush_pages)
 		    [size] "r" (size)
 		: "eax", "ebx", "ecx", "edx");
 }
-EXPORT_SYMBOL_GPL(l1d_flush_populate_tlb);
 
-int l1d_flush_hw(void)
+static int l1d_flush_hw(void)
 {
 	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
 		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
@@ -68,9 +61,8 @@ int l1d_flush_hw(void)
 	}
 	return -ENOTSUPP;
 }
-EXPORT_SYMBOL_GPL(l1d_flush_hw);
 
-void l1d_flush_sw(void *l1d_flush_pages)
+static void l1d_flush_sw(void *l1d_flush_pages)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
@@ -87,4 +79,39 @@ void l1d_flush_sw(void *l1d_flush_pages)
 			[size] "r" (size)
 			: "eax", "ecx");
 }
-EXPORT_SYMBOL_GPL(l1d_flush_sw);
+
+static void *l1d_flush_pages;
+static DEFINE_MUTEX(l1d_flush_mutex);
+
+/*
+ * Initialize and setup L1D flush once, each caller will reuse the
+ * l1d_flush_pages for flushing, no per CPU allocations or NUMA aware
+ * allocations at the moment.
+ */
+int l1d_flush_init_once(void)
+{
+	int ret = 0;
+
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D) || l1d_flush_pages)
+		return ret;
+
+	mutex_lock(&l1d_flush_mutex);
+	if (!l1d_flush_pages)
+		l1d_flush_pages = l1d_flush_alloc_pages();
+	ret = l1d_flush_pages ? 0 : -ENOMEM;
+	mutex_unlock(&l1d_flush_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(l1d_flush_init_once);
+
+void arch_l1d_flush(enum l1d_flush_options options)
+{
+	if (!l1d_flush_hw())
+		return;
+
+	if (options & L1D_FLUSH_POPULATE_TLB)
+		l1d_flush_populate_tlb(l1d_flush_pages);
+
+	l1d_flush_sw(l1d_flush_pages);
+}
+EXPORT_SYMBOL_GPL(arch_l1d_flush);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 786d1615a09f..d489234c4d5a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -203,8 +203,6 @@ static const struct {
 	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},
 };
 
-static void *vmx_l1d_flush_pages;
-
 static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
@@ -247,12 +245,9 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		l1tf = VMENTER_L1D_FLUSH_ALWAYS;
 	}
 
-	if (l1tf != VMENTER_L1D_FLUSH_NEVER && !vmx_l1d_flush_pages &&
-	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		vmx_l1d_flush_pages = l1d_flush_alloc_pages();
-		if (!vmx_l1d_flush_pages)
+	if (l1tf != VMENTER_L1D_FLUSH_NEVER)
+		if (l1d_flush_init_once())
 			return -ENOMEM;
-	}
 
 	l1tf_vmx_mitigation = l1tf;
 
@@ -6010,12 +6005,7 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 	}
 
 	vcpu->stat.l1d_flush++;
-
-	if (!l1d_flush_hw())
-		return;
-
-	l1d_flush_populate_tlb(vmx_l1d_flush_pages);
-	l1d_flush_sw(vmx_l1d_flush_pages);
+	arch_l1d_flush(L1D_FLUSH_POPULATE_TLB);
 }
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
@@ -7983,10 +7973,6 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 
 static void vmx_cleanup_l1d_flush(void)
 {
-	if (vmx_l1d_flush_pages) {
-		l1d_flush_cleanup_pages(vmx_l1d_flush_pages);
-		vmx_l1d_flush_pages = NULL;
-	}
 	/* Restore state so sysfs ignores VMX */
 	l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 }
-- 
2.17.1

