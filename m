Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4628C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE7E2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGQDEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:27257 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgGQDEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:50 -0400
IronPort-SDR: frDmIyvt8bPd8Bu1l1sgSEV1fJFbP5AxUDFHNtzsL9FmxkTAXN9YCs3ftYXPFn6ZJXpK3TkFSz
 Ni8R8aBkK7zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="214253048"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="214253048"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:47 -0700
IronPort-SDR: uOu7cDqrL7+h5l+5Fn+h1S/hkwpsAu3mNfFB15mMGo34p9NETnRqPy7GMfFMXihLf5C3f6k9GL
 0dvnImOzaUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="286686891"
Received: from pgerasim-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.34.31])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 20:04:43 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH v4 3/7] vmalloc: Add text_alloc() and text_free()
Date:   Fri, 17 Jul 2020 06:04:17 +0300
Message-Id: <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce functions for allocating memory for dynamic trampolines, such
as kprobes. An arch can promote the availability of these functions with
CONFIG_ARCH_HAS_TEXT_ALLOC. Provide default/fallback implementation
wrapping module_alloc() and module_memfree().

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/linux/vmalloc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 0221f852a7e1..e981436e30b6 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -9,6 +9,7 @@
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
+#include <linux/moduleloader.h>
 
 #include <asm/vmalloc.h>
 
@@ -249,4 +250,26 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
+#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
+/*
+ * Allocate memory to be used for dynamic trampoline code.
+ */
+void *text_alloc(unsigned long size);
+
+/*
+ * Free memory returned from text_alloc().
+ */
+void text_free(void *region);
+#else
+static inline void *text_alloc(unsigned long size)
+{
+	return module_alloc(size);
+}
+
+static inline void text_free(void *region)
+{
+	module_memfree(region);
+}
+#endif
+
 #endif /* _LINUX_VMALLOC_H */
-- 
2.25.1

