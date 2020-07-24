Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08189206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGXFGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:06:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:62116 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgGXFGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:06:38 -0400
IronPort-SDR: zoWxoue24zaIdgmfZeN3BniqhlRwrW3bP547jdW5OXtr9FKXcQLva6wG4M91SKbdLDGz0as8SL
 M7ogvcK3X4EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="151951863"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="151951863"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 22:06:38 -0700
IronPort-SDR: Y745JBr6aV5Cuf4jsX3nKNPk6MjsigD/X68qgg7p4Wds3octHlH+g1sNv9NhVt3hjgBoYUFMjd
 TFgDaLoCIY0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="432970205"
Received: from itopinsk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.36.179])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2020 22:06:34 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Date:   Fri, 24 Jul 2020 08:05:52 +0300
Message-Id: <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use text_alloc() and text_free() instead of module_alloc() and
module_memfree() when an arch provides them.

Cc: linux-mm@kvack.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 kernel/kprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4e46d96d4e16..611fcda9f6bf 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -40,6 +40,7 @@
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <linux/uaccess.h>
+#include <linux/vmalloc.h>
 
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
@@ -111,12 +112,20 @@ enum kprobe_slot_state {
 
 void __weak *alloc_insn_page(void)
 {
+#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
+	return text_alloc(PAGE_SIZE);
+#else
 	return module_alloc(PAGE_SIZE);
+#endif
 }
 
 void __weak free_insn_page(void *page)
 {
+#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
+	text_free(page);
+#else
 	module_memfree(page);
+#endif
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
-- 
2.25.1

