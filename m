Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E47C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C812080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHLMGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:06:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47077 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgHLMGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1f6cDPzB09Zb;
        Wed, 12 Aug 2020 14:05:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qCZBi18W7s9n; Wed, 12 Aug 2020 14:05:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1f5rLKzB09ZZ;
        Wed, 12 Aug 2020 14:05:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4225D8B826;
        Wed, 12 Aug 2020 14:06:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vNdbFWqAKa5y; Wed, 12 Aug 2020 14:06:00 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D78EB8B7FC;
        Wed, 12 Aug 2020 14:05:59 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B178E65C34; Wed, 12 Aug 2020 12:05:59 +0000 (UTC)
Message-Id: <0eec85fb314d26159cb75600a4b39985d393ccf8.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 08/19] powerpc/signal: Remove get_clean_sp()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:05:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_clean_sp() is only used once in kernel/signal.c .

And GCC is smart enough to see that x & 0xffffffff is a nop
calculation on PPC32, no need of a special PPC32 trivial version.

Include the logic from the PPC64 version of get_clean_sp() directly
in get_sigframe()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/processor.h | 14 --------------
 arch/powerpc/kernel/signal.c         |  5 ++++-
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e20b0c5abe62..8320aedbdca3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -406,20 +406,6 @@ static inline void prefetchw(const void *x)
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
-#ifdef CONFIG_PPC64
-static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
-{
-	if (is_32)
-		return sp & 0x0ffffffffUL;
-	return sp;
-}
-#else
-static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
-{
-	return sp;
-}
-#endif
-
 /* asm stubs */
 extern unsigned long isa300_idle_stop_noloss(unsigned long psscr_val);
 extern unsigned long isa300_idle_stop_mayloss(unsigned long psscr_val);
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 1be5fd01f866..a295d482adec 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -150,7 +150,10 @@ void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
         unsigned long oldsp, newsp;
 
         /* Default to using normal stack */
-        oldsp = get_clean_sp(sp, is_32);
+	if (is_32)
+		oldsp = sp & 0x0ffffffffUL;
+	else
+		oldsp = sp;
 	oldsp = sigsp(oldsp, ksig);
 	newsp = (oldsp - frame_size) & ~0xFUL;
 
-- 
2.25.0

