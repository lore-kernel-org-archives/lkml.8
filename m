Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB8C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9C9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgCJWSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:18:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:2024 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJWSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:18:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:18:00 -0700
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="277130847"
Received: from jbrandeb-desk.jf.intel.com ([10.166.244.152])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:17:59 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        peterz@infradead.org
Subject: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
Date:   Tue, 10 Mar 2020 15:17:46 -0700
Message-Id: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix many sparse warnings when building with C=1. These are useless
noise from the bitops.h file and getting rid of them helps devs
make more use of the tools and possibly find real bugs.

When the kernel is compiled with C=1, there are lots of messages like:
  arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)

CONST_MASK() is using a signed integer "1" to create the mask which is
later cast to (u8), in order to yield an 8-bit value for the assembly
instructions to use. Simplify the expressions used to clearly indicate
they are working on 8-bit values only, which still keeps sparse happy
without an accidental promotion to a 32 bit integer.

The warning was occurring because certain bitmasks that end with a bit
set next to a natural boundary like 7, 15, 23, 31, end up with a mask
like 0x7f, which then results in sign extension due to the integer
type promotion rules[1]. It was really only "clear_bit" that was
having problems, and it was only on some bit checks that resulted in a
mask like 0xffffff7f being generated after the inversion.

Verified with a test module (see next patch) and assembly inspection
that the patch doesn't introduce any change in generated code.

[1] https://stackoverflow.com/questions/46073295/implicit-type-promotion-rules

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v6: reworded commit message, enhanced explanation
v5: changed code to use simple AND and XOR, updated commit message
v4: reverse argument order as suggested by David Laight, added reviewed-by
v3: Clean up the header file changes as per peterz.
v2: use correct CC: list
---
 arch/x86/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 062cdecb2f24..53f246e9df5a 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr))
+			: "iq" (CONST_MASK(nr) & 0xff)
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)~CONST_MASK(nr)));
+			: "iq" (CONST_MASK(nr) ^ 0xff));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");

base-commit: 8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238
-- 
2.24.1

