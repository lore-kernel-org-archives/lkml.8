Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B468C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BA122464
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBEWjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:39:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:60116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBEWji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:39:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 14:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="225092452"
Received: from unknown (HELO localhost.jf.intel.com) ([10.54.75.26])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2020 14:39:36 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org
Cc:     rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [RFC PATCH 06/11] x86: make sure _etext includes function sections
Date:   Wed,  5 Feb 2020 14:39:45 -0800
Message-Id: <20200205223950.1212394-7-kristen@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205223950.1212394-1-kristen@linux.intel.com>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be using -ffunction-sections to place each function in
it's own text section so it can be randomized at load time. The
linker considers these .text.* sections "orphaned sections", and
will place them after the first similar section (.text). However,
we need to move _etext so that it is after both .text and .text.*
We also need to calculate text size to include .text AND .text.*

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/kernel/vmlinux.lds.S     | 18 +++++++++++++++++-
 include/asm-generic/vmlinux.lds.h |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a1a819da137..e54e9ac5b429 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -146,8 +146,24 @@ SECTIONS
 #endif
 	} :text =0xcccc
 
-	/* End of text section, which should occupy whole number of pages */
+#ifdef CONFIG_FG_KASLR
+	/*
+	 * -ffunction-sections creates .text.* sections, which are considered
+	 * "orphan sections" and added after the first similar section (.text).
+	 * Adding this ALIGN statement causes the address of _etext
+	 * to be below that of all the .text.* orphaned sections
+	 */
+	. = ALIGN(PAGE_SIZE);
+#endif
 	_etext = .;
+
+	/*
+	 * the size of the .text section is used to calculate the address
+	 * range for orc lookups. If we just use SIZEOF(.text), we will
+	 * miss all the .text.* sections. Calculate the size using _etext
+	 * and _stext and save the value for later.
+	 */
+	text_size = _etext - _stext;
 	. = ALIGN(PAGE_SIZE);
 
 	X86_ALIGN_RODATA_BEGIN
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..edf19f4296e2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -798,7 +798,7 @@
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
 		orc_lookup = .;						\
-		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
+		. += (((text_size + LOOKUP_BLOCK_SIZE - 1) /	\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
 		orc_lookup_end = .;					\
 	}
-- 
2.24.1

