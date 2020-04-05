Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B5C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AF720659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cpg2PhiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgDERon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:44:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63633 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgDERok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:44:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wLdw1v3qz9ty3M;
        Sun,  5 Apr 2020 19:44:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cpg2PhiG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IaekJmipcYYf; Sun,  5 Apr 2020 19:44:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wLdw0l9Qz9ty2y;
        Sun,  5 Apr 2020 19:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586108676; bh=F2/RVlouzPGEXiwWmPWSCHuMmTRF+zWBqELEpJbUcas=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=cpg2PhiGQgPo9UXrjpkhr/HficJpXMWctMEdHjOxwPgbY9M318g2ZRkYmeb46sooe
         EzPhduP2Mjv/S0kuYgXGW78pFUUzg6K2ubcsNOJNFG7kxa6DVJRHhYUSep5W3J/PQ8
         QxFJuAyABv7tL69F1hpsrjNVU2p3k81q6cxdf9gM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B18DF8B783;
        Sun,  5 Apr 2020 19:44:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Vc7s3mfu--yN; Sun,  5 Apr 2020 19:44:39 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D84F8B774;
        Sun,  5 Apr 2020 19:44:39 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 52B8F6571C; Sun,  5 Apr 2020 17:44:39 +0000 (UTC)
Message-Id: <be1e4e10a2f3699e2478fc736cbcdef380736859.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 04/13] powerpc/irq: Add new helpers to play with MSR_EE
 and MSR_RI on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  5 Apr 2020 17:44:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting PPC32 to C syscall entry/exit,
add PPC32 version of following helpers:
	__hard_irq_enable()
	__hard_irq_disable()
	__hard_EE_RI_disable()
	__hard_RI_enable()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hw_irq.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e0e71777961f..6ccf07de6665 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -321,6 +321,16 @@ static inline void arch_local_irq_disable(void)
 		mtmsr(mfmsr() & ~MSR_EE);
 }
 
+static inline void arch_local_recovery_disable(void)
+{
+	if (IS_ENABLED(CONFIG_BOOKE))
+		wrtee(0);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_NRI);
+	else
+		mtmsr(mfmsr() & ~(MSR_EE | MSR_RI));
+}
+
 static inline void arch_local_irq_enable(void)
 {
 	if (IS_ENABLED(CONFIG_BOOKE))
@@ -343,6 +353,11 @@ static inline bool arch_irqs_disabled(void)
 
 #define hard_irq_disable()		arch_local_irq_disable()
 
+#define __hard_irq_enable()		arch_local_irq_enable()
+#define __hard_irq_disable()		arch_local_irq_disable()
+#define __hard_EE_RI_disable()		arch_local_recovery_disable()
+#define __hard_RI_enable()		arch_local_irq_disable()
+
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
 	return !(regs->msr & MSR_EE);
-- 
2.25.0

