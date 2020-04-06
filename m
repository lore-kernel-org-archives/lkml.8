Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61250C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F25E20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="D2shqFan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgDFSQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:16:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3974 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgDFSQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzJc2djQz9v09G;
        Mon,  6 Apr 2020 20:16:48 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=D2shqFan; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fxS0gBU9cqes; Mon,  6 Apr 2020 20:16:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzJc1YWwz9v016;
        Mon,  6 Apr 2020 20:16:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197008; bh=stu09CrU2mn4pu91S8qHPEGE3iMjq1lNwJ59R5Er1jA=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=D2shqFanYO3jeQCNd9F05YYrZvMIoUWebmPaVR8JSNvO64GH35WBrf02totANfcAA
         oIQocUF8whPNmg99bmVdPvH9olf+e4xcV8PvyTt16yHfBqlY39Pl7rb/4l4JP2lx5Z
         1CA2L1ewfKanaEwJWrqy9+V2dxCsEBvUsGAGPIAM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1ADD38B784;
        Mon,  6 Apr 2020 20:16:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RzjwhyypyaS7; Mon,  6 Apr 2020 20:16:48 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 91C7A8B775;
        Mon,  6 Apr 2020 20:16:47 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 633ED656E9; Mon,  6 Apr 2020 18:16:47 +0000 (UTC)
Message-Id: <6f5cb16636ee153a43e0ca77a7b1cdfaa2d98355.1586196948.git.christophe.leroy@c-s.fr>
In-Reply-To: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
References: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 11/15] powerpc/syscall: Save r3 in regs->orig_r3
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 Apr 2020 18:16:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save r3 in regs->orig_r3 in system_call_exception()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_64.S | 1 -
 arch/powerpc/kernel/syscall.c  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 63f0a4414618..5ccb65f75712 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -114,7 +114,6 @@ END_BTB_FLUSH_SECTION
 	std	r10,_LINK(r1)
 	std	r11,_TRAP(r1)
 	std	r12,_CCR(r1)
-	std	r3,ORIG_GPR3(r1)
 	addi	r10,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r10)		/* "regshere" marker */
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 0ad4250d2ce8..dfd7b28239b8 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -27,6 +27,8 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	unsigned long ti_flags;
 	syscall_fn f;
 
+	regs->orig_gpr3 = r3;
+
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
 		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
 
-- 
2.25.0

