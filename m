Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC194C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A73E2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Cnke/Mfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgDFSRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:17:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55285 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgDFSQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzJZ6xMvz9v01d;
        Mon,  6 Apr 2020 20:16:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Cnke/Mfk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lBUjCPEtHUUr; Mon,  6 Apr 2020 20:16:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzJZ5vmrz9v016;
        Mon,  6 Apr 2020 20:16:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197006; bh=0j3hOrbvEk3Zbyix6RZBgRHtJ/5NMgVMdR+vPChRnNU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Cnke/Mfk5kgfOenVLOnMcjQwtqc9FjYcftCjHfOgenLKvt40WFpfcnxrsJ5BYnBCS
         y9USSTqfMoWG6fsHbh/8RP8HEG/BLLmBID9ywVmSFiWXMrQ7PLXGzQUNnsv/P5B0Cl
         tBn+awiqTRNaKfJeiaKIs8bh62OnB28HFsqSb8rQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C2C848B784;
        Mon,  6 Apr 2020 20:16:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4Bfv1h5Un9Xk; Mon,  6 Apr 2020 20:16:46 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 85F3B8B775;
        Mon,  6 Apr 2020 20:16:46 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5CB1C656E9; Mon,  6 Apr 2020 18:16:46 +0000 (UTC)
Message-Id: <cf734b91ac02321aef67428f82d76d055feba5f7.1586196948.git.christophe.leroy@c-s.fr>
In-Reply-To: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
References: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 10/15] powerpc/syscall: Use is_compat_task()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 Apr 2020 18:16:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hard comparing task flags with _TIF_32BIT, use
is_compat_task(). The advantage is that it returns 0 on PPC32
allthough _TIF_32BIT is always set.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 98c98ce12f7d..0ad4250d2ce8 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/err.h>
+#include <linux/compat.h>
+
 #include <asm/asm-prototypes.h>
 #include <asm/kup.h>
 #include <asm/cputime.h>
@@ -86,7 +88,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	/* May be faster to do array_index_nospec? */
 	barrier_nospec();
 
-	if (unlikely(ti_flags & _TIF_32BIT)) {
+	if (is_compat_task()) {
 		f = (void *)compat_sys_call_table[r0];
 
 		r3 &= 0x00000000ffffffffULL;
-- 
2.25.0

