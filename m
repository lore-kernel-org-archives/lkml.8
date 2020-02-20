Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C9FC11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B160D20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgBTXWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:22:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:29032 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgBTXWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:22:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 15:22:20 -0800
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="225026469"
Received: from jbrandeb-desk.jf.intel.com ([10.166.244.152])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 15:22:20 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        peterz@infradead.org
Subject: [PATCH v3 1/2] x86: fix bitops.h warning with a moved cast
Date:   Thu, 20 Feb 2020 15:21:54 -0800
Message-Id: <20200220232155.2123827-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix many sparse warnings when building with C=1.

When the kernel is compiled with C=1, there are lots of messages like:
  arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)

CONST_MASK() is using a signed integer "1" to create the mask which
is later cast to (u8) when used. Move the cast to the definition and
clean up the calling sites to prevent sparse from warning.

The reason the warning was occurring is because certain bitmasks that
end with a mask next to a natural boundary like 7, 15, 23, 31, end up
with a mask like 0x7f, which then results in sign extension when doing
an invert (but I'm not a compiler expert). It was really only
"clear_bit" that was having problems, and it was only on bit checks next
to a byte boundary (top bit).

Verified with a test module (see next patch) and assembly inspection
that the patch doesn't introduce any change in generated code.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v3: Clean up
the header file changes as per peterz.

v2: use correct CC: list
---
 arch/x86/include/asm/bitops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 062cdecb2f24..96ef19dcbde6 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -46,7 +46,7 @@
  * a mask operation on a byte.
  */
 #define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
-#define CONST_MASK(nr)			(1 << ((nr) & 7))
+#define CONST_MASK(nr)			((u8)1 << ((nr) & 7))
 
 static __always_inline void
 arch_set_bit(long nr, volatile unsigned long *addr)
@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr))
+			: "iq" (CONST_MASK(nr))
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)~CONST_MASK(nr)));
+			: "iq" (0xff ^ CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");

base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
-- 
2.24.1

