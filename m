Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CCFC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668EF20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sa3H+P6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgDHJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:02:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39808 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgDHJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586336569; x=1617872569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=e5bUYjWbScbzjft6TEIZiCZRtgYcyyX63Xluh9NgdRM=;
  b=sa3H+P6BiPyoEDoYpnYEyRpglr28XA4GHBMR9exfOegcTlOXwE1iZ93t
   pSrjX+rtE1HHrjmxAlvhhGu6Of/pP9TwlUxd9jhMiyGbyBSLo3Lozs/Xc
   VEctFVYTnas/lV1AnPDcdS5JsGXS8jMMI1ml3yWGC3fpcXxK0YCfTR/Hm
   U=;
IronPort-SDR: Qdq/WKgx+3/4KMPZauL9lu9cgebFhIPEsvD2PmfT9O2ur/M2RKK9iZUY2YmRXFmthaqLeslJLG
 fsqlZDZgJdFw==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="35938265"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Apr 2020 09:02:47 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 3AB0DA18E5;
        Wed,  8 Apr 2020 09:02:47 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:46 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:45 +0000
Received: from localhost (10.85.0.235) by mail-relay.amazon.com (10.43.61.169)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Wed, 8 Apr
 2020 09:02:44 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 1/5] arch/x86/kvm: Refactor l1d flush lifecycle management
Date:   Wed, 8 Apr 2020 19:02:25 +1000
Message-ID: <20200408090229.16467-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408090229.16467-1-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the allocation and free routines to be used in a follow
up set of patches (to reuse for L1D flushing).

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index d6d61c4455fa..48f443e6c2de 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -160,3 +160,4 @@ ifeq ($(CONFIG_X86_64),y)
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
index 91749f1254e8..f40c30f9b4d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -203,14 +203,10 @@ static const struct {
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
@@ -253,24 +249,9 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 
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
@@ -7999,7 +7980,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
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

