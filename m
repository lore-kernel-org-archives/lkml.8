Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D17C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649CD20A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDZSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726312AbgDZSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C8C061A41;
        Sun, 26 Apr 2020 11:42:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEr-0007AT-Qh; Sun, 26 Apr 2020 20:42:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AFE61C0330;
        Sun, 26 Apr 2020 20:42:49 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move cr4_set_bits_and_update_boot() to the usage site
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.940978251@linutronix.de>
References: <20200421092559.940978251@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792656896.28353.4608428211231788854.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     96f59fe291d2cdc0fcb6f5f2f4b7c9cea9533fc3
Gitweb:        https://git.kernel.org/tip/96f59fe291d2cdc0fcb6f5f2f4b7c9cea9533fc3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 18:39:48 +02:00

x86/tlb: Move cr4_set_bits_and_update_boot() to the usage site

No point in having this exposed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.940978251@linutronix.de
---
 arch/x86/include/asm/tlbflush.h | 14 --------------
 arch/x86/mm/init.c              | 13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index c22fc72..917deea 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -322,23 +322,9 @@ static inline void cr4_clear_bits(unsigned long mask)
 	local_irq_restore(flags);
 }
 
-/*
- * Save some of cr4 feature set we're using (e.g.  Pentium 4MB
- * enable and PPro Global page enable), so that any CPU's that boot
- * up after us can get the correct flags.  This should only be used
- * during boot on the boot cpu.
- */
 extern unsigned long mmu_cr4_features;
 extern u32 *trampoline_cr4_features;
 
-static inline void cr4_set_bits_and_update_boot(unsigned long mask)
-{
-	mmu_cr4_features |= mask;
-	if (trampoline_cr4_features)
-		*trampoline_cr4_features = mmu_cr4_features;
-	cr4_set_bits(mask);
-}
-
 extern void initialize_tlbstate_and_flush(void);
 
 #define TLB_FLUSH_ALL	-1UL
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 71720dd..d37e816 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -194,6 +194,19 @@ struct map_range {
 
 static int page_size_mask;
 
+/*
+ * Save some of cr4 feature set we're using (e.g.  Pentium 4MB
+ * enable and PPro Global page enable), so that any CPU's that boot
+ * up after us can get the correct flags. Invoked on the boot CPU.
+ */
+static inline void cr4_set_bits_and_update_boot(unsigned long mask)
+{
+	mmu_cr4_features |= mask;
+	if (trampoline_cr4_features)
+		*trampoline_cr4_features = mmu_cr4_features;
+	cr4_set_bits(mask);
+}
+
 static void __init probe_page_size_mask(void)
 {
 	/*
