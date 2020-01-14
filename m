Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD30C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F6F2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="l4r9J0yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgANINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:13:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43156 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgANINM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:13:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47xjrP2Dw5z9txpt;
        Tue, 14 Jan 2020 09:13:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=l4r9J0yC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZA4-nlv4eVuX; Tue, 14 Jan 2020 09:13:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47xjrP1BwVz9txpr;
        Tue, 14 Jan 2020 09:13:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1578989589; bh=/7x/mycY9dv8CNXkK/5+j4m894fmSmqk/jtK+1OjjHA=;
        h=From:Subject:To:Cc:Date:From;
        b=l4r9J0yCVpu7NK0emogqymwSAxTQMbXHpQ3o/qn2ZXKGN6eqt6S0WJ7Bt03mSow2P
         zQvXT9F+5CHYFTmMBs30ok3fMKF2jKaLzPoAnw5IVG/PMqMBW9CoYcuNCPRqka/oQL
         89ZpXcThea2AfvixAwxyST5n95cybXvZs9Lk9Agg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 295318B7D1;
        Tue, 14 Jan 2020 09:13:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ipU9AATOC6P7; Tue, 14 Jan 2020 09:13:10 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED3EB8B769;
        Tue, 14 Jan 2020 09:13:09 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C04FD64A20; Tue, 14 Jan 2020 08:13:09 +0000 (UTC)
Message-Id: <0d894839fdbb19070f0e1e4140363be4f2bb62fc.1578989540.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/ptdump: fix W+X verification
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Jan 2020 08:13:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verification cannot rely on simple bit checking because on some
platforms PAGE_RW is 0, checking that a page is not W means
checking that PAGE_RO is set instead of checking that PAGE_RW
is not set.

Use pte helpers instead of checking bits.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
---
 arch/powerpc/mm/ptdump/ptdump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 4af0d5d9589e..206156255247 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -175,10 +175,12 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 
 static void note_prot_wx(struct pg_state *st, unsigned long addr)
 {
+	pte_t pte = __pte(st->current_flags);
+
 	if (!IS_ENABLED(CONFIG_PPC_DEBUG_WX) || !st->check_wx)
 		return;
 
-	if (!((st->current_flags & pgprot_val(PAGE_KERNEL_X)) == pgprot_val(PAGE_KERNEL_X)))
+	if (!pte_write(pte) || !pte_exec(pte))
 		return;
 
 	WARN_ONCE(1, "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",
-- 
2.13.3

