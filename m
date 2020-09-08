Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82580C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1942074B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbgIHR4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:56:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:60797 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgIHRzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:55:31 -0400
IronPort-SDR: e1Ra0MqOoKHlNj6C+OBRtGp9aN+HUIMi96YsStJhj2NTkcIHY/UadyX8a4/k6GuaIW5lL8xKJR
 MmBvXrNDSyfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145907151"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="145907151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
IronPort-SDR: /Vvl22s+UFsmOsphh6Norgu6rHcITefB76S1D7xbDrJEkNIQM0W/vTlNyJsGjzxNHAiW5uTcTk
 qyzhcOw3V5fw==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480125762"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:27 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] x86/mce: Add _ASM_EXTABLE_CPY for copy user access
Date:   Tue,  8 Sep 2020 10:55:15 -0700
Message-Id: <20200908175519.14223-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200908175519.14223-1-tony.luck@intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

_ASM_EXTABLE_UA is a general exception entry to record the exception fixup
for all exception spots between kernel and user space access.

To enable recovery from machine checks while coping data from user
addresses we need to be able to distinguish the places that are
looping copying data from those that copy a single byte/word/etc.

Add a new macro _ASM_EXTABLE_CPY and use it in place of _ASM_EXTABLE_UA
in the copy functions.

Record the exception reason number to regs->ax at
ex_handler_uaccess which is used to check MCE triggered.

The new fixup routine ex_handler_copy() is almost an exact copy of
ex_handler_uaccess() The difference is that it sets regs->ax to the trap
number. Following patches use this to avoid trying to copy remaining
bytes from the tail of the copy and possibly hitting the poison again.

New mce.kflags bit MCE_IN_KERNEL_COPYIN will be used by mce_severity()
calculation to indicate that a machine check is recoverable because the
kernel was copying from user space.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/asm.h  |  6 +++
 arch/x86/include/asm/mce.h  |  1 +
 arch/x86/lib/copy_user_64.S | 96 ++++++++++++++++++-------------------
 arch/x86/mm/extable.c       | 14 +++++-
 4 files changed, 68 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 5c15f95b1ba7..0359cbbd0f50 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -135,6 +135,9 @@
 # define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
 
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
@@ -160,6 +163,9 @@
 # define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
 
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cf503824529c..6ea141f91163 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -137,6 +137,7 @@
 #define	MCE_HANDLED_EDAC	BIT_ULL(4)
 #define	MCE_HANDLED_MCELOG	BIT_ULL(5)
 #define MCE_IN_KERNEL_RECOV	BIT_ULL(6)
+#define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
 
 /*
  * This structure contains all data related to the MCE log.  Also
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 816f128a6d52..5b68e945bf65 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -36,8 +36,8 @@
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(100b, 103b)
-	_ASM_EXTABLE_UA(101b, 103b)
+	_ASM_EXTABLE_CPY(100b, 103b)
+	_ASM_EXTABLE_CPY(101b, 103b)
 	.endm
 
 /*
@@ -116,26 +116,26 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 30b)
-	_ASM_EXTABLE_UA(2b, 30b)
-	_ASM_EXTABLE_UA(3b, 30b)
-	_ASM_EXTABLE_UA(4b, 30b)
-	_ASM_EXTABLE_UA(5b, 30b)
-	_ASM_EXTABLE_UA(6b, 30b)
-	_ASM_EXTABLE_UA(7b, 30b)
-	_ASM_EXTABLE_UA(8b, 30b)
-	_ASM_EXTABLE_UA(9b, 30b)
-	_ASM_EXTABLE_UA(10b, 30b)
-	_ASM_EXTABLE_UA(11b, 30b)
-	_ASM_EXTABLE_UA(12b, 30b)
-	_ASM_EXTABLE_UA(13b, 30b)
-	_ASM_EXTABLE_UA(14b, 30b)
-	_ASM_EXTABLE_UA(15b, 30b)
-	_ASM_EXTABLE_UA(16b, 30b)
-	_ASM_EXTABLE_UA(18b, 40b)
-	_ASM_EXTABLE_UA(19b, 40b)
-	_ASM_EXTABLE_UA(21b, 50b)
-	_ASM_EXTABLE_UA(22b, 50b)
+	_ASM_EXTABLE_CPY(1b, 30b)
+	_ASM_EXTABLE_CPY(2b, 30b)
+	_ASM_EXTABLE_CPY(3b, 30b)
+	_ASM_EXTABLE_CPY(4b, 30b)
+	_ASM_EXTABLE_CPY(5b, 30b)
+	_ASM_EXTABLE_CPY(6b, 30b)
+	_ASM_EXTABLE_CPY(7b, 30b)
+	_ASM_EXTABLE_CPY(8b, 30b)
+	_ASM_EXTABLE_CPY(9b, 30b)
+	_ASM_EXTABLE_CPY(10b, 30b)
+	_ASM_EXTABLE_CPY(11b, 30b)
+	_ASM_EXTABLE_CPY(12b, 30b)
+	_ASM_EXTABLE_CPY(13b, 30b)
+	_ASM_EXTABLE_CPY(14b, 30b)
+	_ASM_EXTABLE_CPY(15b, 30b)
+	_ASM_EXTABLE_CPY(16b, 30b)
+	_ASM_EXTABLE_CPY(18b, 40b)
+	_ASM_EXTABLE_CPY(19b, 40b)
+	_ASM_EXTABLE_CPY(21b, 50b)
+	_ASM_EXTABLE_CPY(22b, 50b)
 SYM_FUNC_END(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
@@ -180,8 +180,8 @@ SYM_FUNC_START(copy_user_generic_string)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 11b)
-	_ASM_EXTABLE_UA(3b, 12b)
+	_ASM_EXTABLE_CPY(1b, 11b)
+	_ASM_EXTABLE_CPY(3b, 12b)
 SYM_FUNC_END(copy_user_generic_string)
 EXPORT_SYMBOL(copy_user_generic_string)
 
@@ -213,7 +213,7 @@ SYM_FUNC_START(copy_user_enhanced_fast_string)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 12b)
+	_ASM_EXTABLE_CPY(1b, 12b)
 SYM_FUNC_END(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
@@ -237,7 +237,7 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	ASM_CLAC
 	ret
 
-	_ASM_EXTABLE_UA(1b, 2b)
+	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
 /*
@@ -366,27 +366,27 @@ SYM_FUNC_START(__copy_user_nocache)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(2b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(3b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(4b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(5b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(6b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(7b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(8b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(9b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(10b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(11b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(12b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(13b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(14b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(15b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(16b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(20b, .L_fixup_8b_copy)
-	_ASM_EXTABLE_UA(21b, .L_fixup_8b_copy)
-	_ASM_EXTABLE_UA(30b, .L_fixup_4b_copy)
-	_ASM_EXTABLE_UA(31b, .L_fixup_4b_copy)
-	_ASM_EXTABLE_UA(40b, .L_fixup_1b_copy)
-	_ASM_EXTABLE_UA(41b, .L_fixup_1b_copy)
+	_ASM_EXTABLE_CPY(1b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(2b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(3b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(4b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(5b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(6b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(7b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(8b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(9b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(10b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(11b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(12b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(13b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(14b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(15b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(16b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(20b, .L_fixup_8b_copy)
+	_ASM_EXTABLE_CPY(21b, .L_fixup_8b_copy)
+	_ASM_EXTABLE_CPY(30b, .L_fixup_4b_copy)
+	_ASM_EXTABLE_CPY(31b, .L_fixup_4b_copy)
+	_ASM_EXTABLE_CPY(40b, .L_fixup_1b_copy)
+	_ASM_EXTABLE_CPY(41b, .L_fixup_1b_copy)
 SYM_FUNC_END(__copy_user_nocache)
 EXPORT_SYMBOL(__copy_user_nocache)
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 969dd15bb2fe..0c6c2e098397 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -80,6 +80,18 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
 
+__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int trapnr,
+			       unsigned long error_code,
+			       unsigned long fault_addr)
+{
+	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
+	regs->ip = ex_fixup_addr(fixup);
+	regs->ax = trapnr;
+	return true;
+}
+EXPORT_SYMBOL(ex_handler_copy);
+
 __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
 				       struct pt_regs *regs, int trapnr,
 				       unsigned long error_code,
@@ -136,7 +148,7 @@ __visible enum handler_type ex_fault_handler_type(unsigned long ip)
 	handler = ex_fixup_handler(e);
 	if (handler == ex_handler_fault)
 		return HANDLER_FAULT;
-	else if (handler == ex_handler_uaccess)
+	else if (handler == ex_handler_uaccess || handler == ex_handler_copy)
 		return HANDLER_UACCESS;
 	else
 		return HANDLER_OTHER;
-- 
2.21.1

