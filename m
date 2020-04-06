Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE658C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA50220780
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nK7TDjGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgDFSRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:17:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15039 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgDFSQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzJT6GJFz9v00v;
        Mon,  6 Apr 2020 20:16:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=nK7TDjGl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HrI85LxZSqs0; Mon,  6 Apr 2020 20:16:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzJT5DcBz9tycr;
        Mon,  6 Apr 2020 20:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197001; bh=nNmDTQngYBaiiBXdSBbHyZYIJ761JnkGOMCLyZOpnRo=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=nK7TDjGlouQy5ftOoz+4/msT3hYRX+0YYMDTxPZSK11tURYpKcZ8Bm2s6jTADNkMy
         T8+s4XXXAHQQdK1wXR7DzZoNqa/uguWeGcHH300ZaL/inY4vFSAcs1CNQtdoD3Kgjb
         FWAsLcmVvkEhBrwkgJnmBAtrB8+Ha1nBZYzZU8Hw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 976C28B784;
        Mon,  6 Apr 2020 20:16:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id o__FePgGPPOz; Mon,  6 Apr 2020 20:16:41 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 625E58B775;
        Mon,  6 Apr 2020 20:16:41 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 383CC656E9; Mon,  6 Apr 2020 18:16:41 +0000 (UTC)
Message-Id: <f9f0bd58f9e75e8e3826f25d9db9ff2c6ad9c84b.1586196948.git.christophe.leroy@c-s.fr>
In-Reply-To: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
References: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 05/15] powerpc/irq: Add helpers to get and set
 regs->softe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 Apr 2020 18:16:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regs->softe doesn't exist on PPC32.

Add helpers to get and set regs->softe.
Those helpers will void on PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hw_irq.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e0e71777961f..e69466867d5f 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -39,6 +39,8 @@
 #define PACA_IRQ_MUST_HARD_MASK	(PACA_IRQ_EE)
 #endif
 
+#endif /* CONFIG_PPC64 */
+
 /*
  * flags for paca->irq_soft_mask
  */
@@ -47,8 +49,6 @@
 #define IRQS_PMI_DISABLED	2
 #define IRQS_ALL_DISABLED	(IRQS_DISABLED | IRQS_PMI_DISABLED)
 
-#endif /* CONFIG_PPC64 */
-
 #ifndef __ASSEMBLY__
 
 extern void replay_system_reset(void);
@@ -282,6 +282,15 @@ extern void irq_set_pending_from_srr1(unsigned long srr1);
 
 extern void force_external_irq_replay(void);
 
+static inline unsigned long get_softe(struct pt_regs *regs)
+{
+	return regs->softe;
+}
+
+static inline void set_softe(struct pt_regs *regs, unsigned long val)
+{
+	regs->softe = val;
+}
 #else /* CONFIG_PPC64 */
 
 static inline unsigned long arch_local_save_flags(void)
@@ -350,6 +359,14 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 
 static inline void may_hard_irq_enable(void) { }
 
+static inline unsigned long get_softe(struct pt_regs *regs)
+{
+	return 0;
+}
+
+static inline void set_softe(struct pt_regs *regs, unsigned long val)
+{
+}
 #endif /* CONFIG_PPC64 */
 
 #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
-- 
2.25.0

