Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A33C2BA14
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B102078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sfjbF8lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgDBG0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:26:43 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:31710 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgDBG0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585808800; x=1617344800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PAC33jTjkn1bt/6i6MXvdH7zVJo/4mG6UCzWWxpTL9g=;
  b=sfjbF8lAOxFa8/mwOUa6cifhWBmz63UnSasSw2IFqn7hR5nXHw92c8tx
   zt5mfi4nckPAiVis34uzpWFlfBVMDq8kZMFihEsnQMl94XawEe1kcj7ej
   iESn0dd/Oj6Wz06jLGXI3soG8ry8ROuTCDWh9S1FSFBZ3kQfoQ0PXCTvT
   c=;
IronPort-SDR: YJSCW8mY1qurpIyA3T0VEuTxeIIrWf/C09iz707cp6EWBwXrGltxo+h+SDkFnLlNcWm9CSVBhB
 1+0L6yelw3hQ==
X-IronPort-AV: E=Sophos;i="5.72,334,1580774400"; 
   d="scan'208";a="23915798"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Apr 2020 06:26:28 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 2CFE7244159;
        Thu,  2 Apr 2020 06:26:25 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Apr 2020 06:26:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 06:26:25 +0000
Received: from localhost (10.85.6.202) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Apr 2020 06:26:24 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <tony.luck@intel.com>, <keescook@chromium.org>, <x86@kernel.org>,
        <benh@kernel.crashing.org>, <dave.hansen@intel.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH 2/3] arch/x86: Refactor tlbflush and l1d flush
Date:   Thu, 2 Apr 2020 17:24:00 +1100
Message-ID: <20200402062401.29856-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402062401.29856-1-sblbir@amazon.com>
References: <20200402062401.29856-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the existing assembly bits into smaller helper functions
and also abstract L1D_FLUSH into a helper function. Use these
functions in kvm for L1D flushing.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/cacheflush.h |  3 ++
 arch/x86/kernel/l1d_flush.c       | 49 +++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c            | 31 ++++---------------
 3 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 6419a4cef0e8..66a46db7aadd 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -10,5 +10,8 @@
 void clflush_cache_range(void *addr, unsigned int size);
 void *alloc_l1d_flush_pages(void);
 void cleanup_l1d_flush_pages(void *l1d_flush_pages);
+void populate_tlb_with_flush_pages(void *l1d_flush_pages);
+void flush_l1d_cache_sw(void *l1d_flush_pages);
+int flush_l1d_cache_hw(void);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
index 05f375c33423..60499f773046 100644
--- a/arch/x86/kernel/l1d_flush.c
+++ b/arch/x86/kernel/l1d_flush.c
@@ -34,3 +34,52 @@ void cleanup_l1d_flush_pages(void *l1d_flush_pages)
 	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
 }
 EXPORT_SYMBOL_GPL(cleanup_l1d_flush_pages);
+
+void populate_tlb_with_flush_pages(void *l1d_flush_pages)
+{
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	asm volatile(
+		/* First ensure the pages are in the TLB */
+		"xorl	%%eax, %%eax\n"
+		".Lpopulate_tlb:\n\t"
+		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
+		"addl	$4096, %%eax\n\t"
+		"cmpl	%%eax, %[size]\n\t"
+		"jne	.Lpopulate_tlb\n\t"
+		"xorl	%%eax, %%eax\n\t"
+		"cpuid\n\t"
+		:: [flush_pages] "r" (l1d_flush_pages),
+		    [size] "r" (size)
+		: "eax", "ebx", "ecx", "edx");
+}
+EXPORT_SYMBOL_GPL(populate_tlb_with_flush_pages);
+
+int flush_l1d_cache_hw(void)
+{
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(flush_l1d_cache_hw);
+
+void flush_l1d_cache_sw(void *l1d_flush_pages)
+{
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	asm volatile(
+			/* Fill the cache */
+			"xorl	%%eax, %%eax\n"
+			".Lfill_cache:\n"
+			"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
+			"addl	$64, %%eax\n\t"
+			"cmpl	%%eax, %[size]\n\t"
+			"jne	.Lfill_cache\n\t"
+			"lfence\n"
+			:: [flush_pages] "r" (l1d_flush_pages),
+			[size] "r" (size)
+			: "eax", "ecx");
+}
+EXPORT_SYMBOL_GPL(flush_l1d_cache_sw);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 209e63798435..29dc5a5bb6ab 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5956,8 +5956,6 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
  */
 static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
-	int size = PAGE_SIZE << L1D_CACHE_ORDER;
-
 	/*
 	 * This code is only executed when the the flush mode is 'cond' or
 	 * 'always'
@@ -5986,32 +5984,13 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.l1d_flush++;
 
-	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+	if (flush_l1d_cache_hw())
 		return;
-	}
 
-	asm volatile(
-		/* First ensure the pages are in the TLB */
-		"xorl	%%eax, %%eax\n"
-		".Lpopulate_tlb:\n\t"
-		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
-		"addl	$4096, %%eax\n\t"
-		"cmpl	%%eax, %[size]\n\t"
-		"jne	.Lpopulate_tlb\n\t"
-		"xorl	%%eax, %%eax\n\t"
-		"cpuid\n\t"
-		/* Now fill the cache */
-		"xorl	%%eax, %%eax\n"
-		".Lfill_cache:\n"
-		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
-		"addl	$64, %%eax\n\t"
-		"cmpl	%%eax, %[size]\n\t"
-		"jne	.Lfill_cache\n\t"
-		"lfence\n"
-		:: [flush_pages] "r" (vmx_l1d_flush_pages),
-		    [size] "r" (size)
-		: "eax", "ebx", "ecx", "edx");
+	preempt_disable();
+	populate_tlb_with_flush_pages(vmx_l1d_flush_pages);
+	flush_l1d_cache_sw(vmx_l1d_flush_pages);
+	preempt_enable();
 }
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
-- 
2.17.1

