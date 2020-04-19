Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F92C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B3E221F4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDSUgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgDSUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2423C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfm-0007N9-OD; Sun, 19 Apr 2020 22:36:14 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4AE89100EA1;
        Sun, 19 Apr 2020 22:36:14 +0200 (CEST)
Message-Id: <20200419203336.731736462@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 11/15] x86/tlb: Move cr4_set_bits_and_update_boot() to the usage site
References: <20200419203137.214111265@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in having this exposed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/tlbflush.h |   14 --------------
 arch/x86/mm/init.c              |   13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -332,23 +332,9 @@ static inline void cr4_clear_bits(unsign
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
 
 /*
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -172,6 +172,19 @@ struct map_range {
 
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

