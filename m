Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDBBC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335232137B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VSAnyyWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCYHLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:11:20 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:36617 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585120280; x=1616656280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/wZO16fMeX88PtvMAJUD0Rj77EvwKX+MdjbbIKPC3Dw=;
  b=VSAnyyWxZHh+y1pKM8NmDgLD/Fy++ZzAGb5vlaKIwT41lbG9lp2ElmzO
   +Adlt6D+5EPWmGPAAZ6sn98iVMgZagL5GWrwRd/K2ei2zJlvyC9GCeffn
   MGPj/Roj9XDuSgF56FgPxptapr0+Z5KHT7wmUMuiecblIj1iG9hb2jIJW
   8=;
IronPort-SDR: XoZ6hmaYKpoQ8ZFXm153qDhdew/2NFP4cNJCHUWm3JQDXRnvX3JsXaK26Ux3/pZNDn50g1/U90
 8RlH/5N1MeCw==
X-IronPort-AV: E=Sophos;i="5.72,303,1580774400"; 
   d="scan'208";a="24075045"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 25 Mar 2020 07:11:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id AAF86A237D;
        Wed, 25 Mar 2020 07:11:16 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 07:11:16 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 07:11:15 +0000
Received: from localhost (10.85.0.131) by mail-relay.amazon.com (10.43.60.234)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar
 2020 07:11:14 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <tony.luck@intel.com>, <keescook@chromium.org>, <x86@kernel.org>,
        <benh@kernel.crashing.org>, <dave.hansen@intel.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [RFC PATCH v2 1/4] arch/x86/kvm: Refactor l1d flush lifecycle management
Date:   Wed, 25 Mar 2020 18:10:58 +1100
Message-ID: <20200325071101.29556-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325071101.29556-1-sblbir@amazon.com>
References: <20200325071101.29556-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the allocation and free routines to be used in a follow
up set of patches (to reuse for L1D flushing).

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/cacheflush.h |  3 +++
 arch/x86/kernel/Makefile          |  1 +
 arch/x86/kernel/l1d_flush.c       | 36 +++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c            | 25 +++------------------
 4 files changed, 43 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/kernel/l1d_flush.c

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 63feaf2a5f93..6419a4cef0e8 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -6,6 +6,9 @@
 #include <asm-generic/cacheflush.h>
 #include <asm/special_insns.h>
 
+#define L1D_CACHE_ORDER 4
 void clflush_cache_range(void *addr, unsigned int size);
+void *alloc_l1d_flush_pages(void);
+void cleanup_l1d_flush_pages(void *l1d_flush_pages);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 1ee83df407e3..c382f5824162 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -159,3 +159,4 @@ ifeq ($(CONFIG_X86_64),y)
 endif
 
 obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
+obj-y						+= l1d_flush.o
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
new file mode 100644
index 000000000000..05f375c33423
--- /dev/null
+++ b/arch/x86/kernel/l1d_flush.c
@@ -0,0 +1,36 @@
+#include <linux/mm.h>
+#include <asm/cacheflush.h>
+
+void *alloc_l1d_flush_pages(void)
+{
+	struct page *page;
+	void *l1d_flush_pages = NULL;
+	int i;
+
+	/*
+	 * This allocation for l1d_flush_pages is not tied to a VM/task's
+	 * lifetime and so should not be charged to a memcg.
+	 */
+	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
+	if (!page)
+		return NULL;
+	l1d_flush_pages = page_address(page);
+
+	/*
+	 * Initialize each page with a different pattern in
+	 * order to protect against KSM in the nested
+	 * virtualization case.
+	 */
+	for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
+		memset(l1d_flush_pages + i * PAGE_SIZE, i + 1,
+				PAGE_SIZE);
+	}
+	return l1d_flush_pages;
+}
+EXPORT_SYMBOL_GPL(alloc_l1d_flush_pages);
+
+void cleanup_l1d_flush_pages(void *l1d_flush_pages)
+{
+	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
+}
+EXPORT_SYMBOL_GPL(cleanup_l1d_flush_pages);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4d22b1b5e822..66d798e1a9d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -202,14 +202,10 @@ static const struct {
 	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},
 };
 
-#define L1D_CACHE_ORDER 4
 static void *vmx_l1d_flush_pages;
 
 static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 {
-	struct page *page;
-	unsigned int i;
-
 	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
 		l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
 		return 0;
@@ -252,24 +248,9 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 
 	if (l1tf != VMENTER_L1D_FLUSH_NEVER && !vmx_l1d_flush_pages &&
 	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		/*
-		 * This allocation for vmx_l1d_flush_pages is not tied to a VM
-		 * lifetime and so should not be charged to a memcg.
-		 */
-		page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
-		if (!page)
+		vmx_l1d_flush_pages = alloc_l1d_flush_pages();
+		if (!vmx_l1d_flush_pages)
 			return -ENOMEM;
-		vmx_l1d_flush_pages = page_address(page);
-
-		/*
-		 * Initialize each page with a different pattern in
-		 * order to protect against KSM in the nested
-		 * virtualization case.
-		 */
-		for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
-			memset(vmx_l1d_flush_pages + i * PAGE_SIZE, i + 1,
-			       PAGE_SIZE);
-		}
 	}
 
 	l1tf_vmx_mitigation = l1tf;
@@ -7999,7 +7980,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 static void vmx_cleanup_l1d_flush(void)
 {
 	if (vmx_l1d_flush_pages) {
-		free_pages((unsigned long)vmx_l1d_flush_pages, L1D_CACHE_ORDER);
+		cleanup_l1d_flush_pages(vmx_l1d_flush_pages);
 		vmx_l1d_flush_pages = NULL;
 	}
 	/* Restore state so sysfs ignores VMX */
-- 
2.17.1

