Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B227C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5090420752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCRWAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:00:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:00:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEgjP-0002kT-P7; Wed, 18 Mar 2020 23:00:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8769E1C228C;
        Wed, 18 Mar 2020 22:59:59 +0100 (CET)
Date:   Wed, 18 Mar 2020 21:59:59 -0000
From:   "tip-bot2 for Jesse Brandeburg" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86: Fix bitops.h warning with a moved cast
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Message-ID: <158456879920.28353.9358875954563849711.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     1651e700664b4597ddf4f8adfe435252a0d11277
Gitweb:        https://git.kernel.org/tip/1651e700664b4597ddf4f8adfe435252a0d11277
Author:        Jesse Brandeburg <jesse.brandeburg@intel.com>
AuthorDate:    Tue, 10 Mar 2020 15:17:46 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Mar 2020 12:30:19 +01:00

x86: Fix bitops.h warning with a moved cast

Fix many sparse warnings when building with C=1. These are useless noise
from the bitops.h file and getting rid of them helps developers make
more use of the tools and possibly find real bugs.

When the kernel is compiled with C=1, there are lots of messages like:

  arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)

CONST_MASK() is using a signed integer "1" to create the mask which is
later cast to (u8), in order to yield an 8-bit value for the assembly
instructions to use. Simplify the expressions used to clearly indicate
they are working on 8-bit values only, which still keeps sparse happy
without an accidental promotion to a 32 bit integer.

The warning was occurring because certain bitmasks that end with a bit
set next to a natural boundary like 7, 15, 23, 31, end up with a mask
like 0x7f, which then results in sign extension due to the integer type
promotion rules[1]. It was really only clear_bit() that was having
problems, and it was only on some bit checks that resulted in a mask
like 0xffffff7f being generated after the inversion.

Verify with a test module (see next patch) and assembly inspection that
the fix doesn't introduce any change in generated code.

 [ bp: Massage. ]

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://stackoverflow.com/questions/46073295/implicit-type-promotion-rules [1]
Link: https://lkml.kernel.org/r/20200310221747.2848474-1-jesse.brandeburg@intel.com
---
 arch/x86/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 062cdec..53f246e 100644
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
