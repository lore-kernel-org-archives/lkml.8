Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E2E206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbgFWRYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:24:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:61940 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733146AbgFWRYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:24:43 -0400
IronPort-SDR: YBsuKuWcgSbw/0Rd/oxW8g4E38jeuWJyj5YE7LM3BgTb2IvAhsBuZFouYLb/AU3b30ydIFbLK3
 MzOl/gDvZpEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="142391509"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="142391509"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 10:24:42 -0700
IronPort-SDR: PaPYECkHgeUaHkq7lCdP3ZCwMEDmqppl050a2yO2NE/0anFX160pq3w5j+HZVq7ZsApUZPE8Oq
 /vsOK4Gq1YYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="423080114"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.213.182.184])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2020 10:24:40 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v3 07/10] x86/boot/compressed: change definition of STATIC
Date:   Tue, 23 Jun 2020 10:23:24 -0700
Message-Id: <20200623172327.5701-8-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623172327.5701-1-kristen@linux.intel.com>
References: <20200623172327.5701-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for changes to the upcoming fgkaslr commit, change misc.c
to not define STATIC as static, but instead set STATIC to "". This allows
memptr to become accessible to multiple files.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/boot/compressed/kaslr.c | 4 ----
 arch/x86/boot/compressed/misc.c  | 7 ++++---
 arch/x86/boot/compressed/misc.h  | 6 ++++++
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..6f596bd5b6e5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -39,10 +39,6 @@
 #include <generated/utsrelease.h>
 #include <asm/efi.h>
 
-/* Macros used by the included decompressor code below. */
-#define STATIC
-#include <linux/decompress/mm.h>
-
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled;
 unsigned int pgdir_shift __ro_after_init = 39;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 9652d5c2afda..a55a4ec48422 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -26,9 +26,6 @@
  * it is not safe to place pointers in static structures.
  */
 
-/* Macros used by the included decompressor code below. */
-#define STATIC		static
-
 /*
  * Use normal definitions of mem*() from string.c. There are already
  * included header files which expect a definition of memset() and by
@@ -49,6 +46,10 @@ struct boot_params *boot_params;
 
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
+#ifdef CONFIG_FG_KASLR
+unsigned long malloc_ptr;
+int malloc_count;
+#endif
 
 static char *vidmem;
 static int vidport;
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264410ff..d2ec7c745cfa 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -39,6 +39,12 @@
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+#define STATIC
+#ifdef CONFIG_FG_KASLR
+#define STATIC_RW_DATA extern
+#endif
+#include <linux/decompress/mm.h>
+
 extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
-- 
2.20.1

