Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D0C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F1D2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vXvwR8E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgDWOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:01:47 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:8602 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgDWOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587650499; x=1619186499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Y/ZwrHvCV6z9KKA0zjPV6afriPZnEEJpv86bwQ5rkj0=;
  b=vXvwR8E42ZpY/E0eg1ZAkKM3bLFihHS22lEP0Hlc2dwr8gLLKlyRfAwy
   swRIL4FZgrIv3fiSX1q0q1fRuWJTVe4o/KBAZDbKzLZGvrhsSzCa1w8zT
   5OLGJDWwIoRtkpOUYttGvkhrbs4VSgzMeCd90F3eLO4OX6xLvLNUbjkgc
   o=;
IronPort-SDR: s1Grh2QwphTfXAxZopPBQkuGbUHo40qjXVv5e1obkjSnNnIzbdMa7buDQgwEEVT149IfWNGAXE
 9i0hTVbb46lA==
X-IronPort-AV: E=Sophos;i="5.73,307,1583193600"; 
   d="scan'208";a="39036396"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 23 Apr 2020 14:01:37 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id DDEC8A240E;
        Thu, 23 Apr 2020 14:01:36 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Apr 2020 14:01:36 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Apr 2020 14:01:36 +0000
Received: from localhost (10.143.207.46) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Apr 2020 14:01:35 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v4 2/6] arch/x86/kvm: Refactor tlbflush and l1d flush
Date:   Fri, 24 Apr 2020 00:01:21 +1000
Message-ID: <20200423140125.7332-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423140125.7332-1-sblbir@amazon.com>
References: <20200423140125.7332-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the existing assembly bits into smaller helper functions
and also abstract L1D_FLUSH into a helper function. Use these
functions in kvm for L1D flushing.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/cacheflush.h |  3 ++
 arch/x86/kernel/l1d_flush.c       | 54 +++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c            | 29 ++---------------
 3 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index bac56fcd9790..21cc3b28fa63 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -8,7 +8,10 @@
 
 #define L1D_CACHE_ORDER 4
 void clflush_cache_range(void *addr, unsigned int size);
+void l1d_flush_populate_tlb(void *l1d_flush_pages);
 void *l1d_flush_alloc_pages(void);
 void l1d_flush_cleanup_pages(void *l1d_flush_pages);
+void l1d_flush_sw(void *l1d_flush_pages);
+int l1d_flush_hw(void);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
index d605878c8f28..5871794f890d 100644
--- a/arch/x86/kernel/l1d_flush.c
+++ b/arch/x86/kernel/l1d_flush.c
@@ -34,3 +34,57 @@ void l1d_flush_cleanup_pages(void *l1d_flush_pages)
 	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
 }
 EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
+
+/*
+ * Not all users of l1d flush would want to populate the TLB first
+ * split out the function so that callers can optionally flush the L1D
+ * cache via sw without prefetching the TLB.
+ */
+void l1d_flush_populate_tlb(void *l1d_flush_pages)
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
+EXPORT_SYMBOL_GPL(l1d_flush_populate_tlb);
+
+int l1d_flush_hw(void)
+{
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		return 0;
+	}
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(l1d_flush_hw);
+
+void l1d_flush_sw(void *l1d_flush_pages)
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
+EXPORT_SYMBOL_GPL(l1d_flush_sw);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 225aa8219bac..786d1615a09f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5983,8 +5983,6 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
  */
 static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
-	int size = PAGE_SIZE << L1D_CACHE_ORDER;
-
 	/*
 	 * This code is only executed when the the flush mode is 'cond' or
 	 * 'always'
@@ -6013,32 +6011,11 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.l1d_flush++;
 
-	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+	if (!l1d_flush_hw())
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
+	l1d_flush_populate_tlb(vmx_l1d_flush_pages);
+	l1d_flush_sw(vmx_l1d_flush_pages);
 }
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
-- 
2.17.1

