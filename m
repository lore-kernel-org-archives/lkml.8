Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16BC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF3120768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rutlUbue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgDHJCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:02:52 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:26804 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgDHJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586336572; x=1617872572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=w49rWDMGI638ZJLO3IGaQNtI2SFDquSkQvdPry+bnDA=;
  b=rutlUbueNq9bB6g/S3QFBGVEIPSdG+ELzv5WR5ABdBGCI1+SeqH75Y+h
   Q0spJl5Ez/MJYJnFRQoYJ26BN4HKtm7AZLs1wnLhJjM33rY7klhO2ATaz
   b8wi9SMsl0tawZjfsP+34WUU8RnikW8Ij66xUNFE85wrJMVlgXQifOuSE
   4=;
IronPort-SDR: zEsmko6yPQbfTAE5JbvqbjOzHl5ixzszwuk1G1FP/KgwOm8B/8iIESKuKD4Y9ZWNd1nJFB/Ixd
 1HHkY95m9g0w==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="37342066"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 08 Apr 2020 09:02:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 844FCA071F;
        Wed,  8 Apr 2020 09:02:48 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:47 +0000
Received: from localhost (10.85.0.235) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Apr 2020 09:02:47 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 2/5] arch/x86: Refactor tlbflush and l1d flush
Date:   Wed, 8 Apr 2020 19:02:26 +1000
Message-ID: <20200408090229.16467-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408090229.16467-1-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 05f375c33423..0842369bac26 100644
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
+		return 0;
+	}
+	return -ENOTSUPP;
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
index f40c30f9b4d8..2bb91bfb8f53 100644
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
+	if (flush_l1d_cache_hw() == 0)
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

