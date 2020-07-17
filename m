Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63345C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F5F2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGQDFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:05:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:34469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgGQDFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:05:17 -0400
IronPort-SDR: iFHLKXZEivAk4YyN3xB/FM922iUYcN8KLUH6v74I63UcCJ6OsvoXZ2O9g9h4IJ3DROIW6kE+tr
 UEjp+ZDw4lrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="149517125"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="149517125"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:05:17 -0700
IronPort-SDR: iA2rxIOZMLWnMWbqtUtWyipKMRAGGYYOTnx1CB2W1XNNkBVU4nEozgVCikbn28wmqgrALtb/8U
 Ee4h8tRxeq+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="286687051"
Received: from pgerasim-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.34.31])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 20:05:14 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 6/7] kprobes: Use text_alloc() and text_free()
Date:   Fri, 17 Jul 2020 06:04:20 +0300
Message-Id: <20200717030422.679972-7-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use text_alloc() and text_free(). Those arch's that provide their
allocators will benefit from this because they can provide their custom
allocator and render out the compile time dep to the module subsystem.
Other arch's will continue to work as the fallback implementations call
module_alloc() and module_memfree().

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 kernel/kprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4e46d96d4e16..f73cf71ef47d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -40,6 +40,7 @@
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <linux/uaccess.h>
+#include <linux/vmalloc.h>
 
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
@@ -111,12 +112,12 @@ enum kprobe_slot_state {
 
 void __weak *alloc_insn_page(void)
 {
-	return module_alloc(PAGE_SIZE);
+	return text_alloc(PAGE_SIZE);
 }
 
 void __weak free_insn_page(void *page)
 {
-	module_memfree(page);
+	text_free(page);
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
-- 
2.25.1

