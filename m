Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C8C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CD12074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXFFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:05:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:41004 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgGXFFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:05:18 -0400
IronPort-SDR: h7T7qyBMr7Vqb84TmknVje3wHUbyMgfWYn5dlZcg0XuuIGvkQiBm7puGpQYU+rzeSqar5saUFb
 jm7HLl2UUDNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150645714"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="150645714"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 22:05:18 -0700
IronPort-SDR: qY/icntTHNX8zoRFkoNoJ9PavRZVse1JH+1/o2alo5VC1HFLRyNHZrsE1xfYPp1L/E2n4a6MXl
 Bw89swfNwqww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="302553101"
Received: from itopinsk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.36.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2020 22:05:15 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 2/6] vmalloc: Add text_alloc() and text_free()
Date:   Fri, 24 Jul 2020 08:04:56 +0300
Message-Id: <20200724050501.1723315-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724050501.1723315-1-jarkko.sakkinen@linux.intel.com>
References: <20200724050501.1723315-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce functions for allocating memory for dynamic trampolines, such
as kprobes. An arch can promote the availability of these functions with
CONFIG_ARCH_HAS_TEXT_ALLOC.

Cc: linux-mm@kvack.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/linux/vmalloc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 0221f852a7e1..6c151a0ac02a 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -249,4 +249,21 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
+/*
+ * These functions can be optionally implemented by an arch in order to
+ * provide specialized functions for allocating trampoline code.
+ */
+
+#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
+/*
+ * Allocate memory to be used for trampoline code.
+ */
+void *text_alloc(unsigned long size);
+
+/*
+ * Free memory returned from text_alloc().
+ */
+void text_free(void *region);
+#endif /* CONFIG_ARCH_HAS_TEXT_ALLOC */
+
 #endif /* _LINUX_VMALLOC_H */
-- 
2.25.1

