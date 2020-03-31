Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48193C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E092207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dsK++CkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgCaQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:03:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63917 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731205AbgCaQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDdn22Hjz9twdb;
        Tue, 31 Mar 2020 18:03:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dsK++CkO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9Zz3L44BCPIq; Tue, 31 Mar 2020 18:03:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDdn0bVXz9twdT;
        Tue, 31 Mar 2020 18:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670621; bh=pFa685KlyWN06RXEcsNIfZ77QAkrvTD2C1XmlgN6mts=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=dsK++CkOlYibJbMVX8NFiMu/TUejAXt0mqm8IyGN3TqNoLurJ6RbC3vYXjq/0nLZr
         eu7K5u0DjjBmuHS0vDVKRmNmY3oUifncDNzd42opm5S/kb4J6Xfq71RsZYYldsjHiG
         LqS8jevI44HlMkh+igGFoAh0t6bJfCjmXk+TQnAc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B69488B86A;
        Tue, 31 Mar 2020 18:03:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rx_Q8XDoQ7PK; Tue, 31 Mar 2020 18:03:42 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DC8A8B868;
        Tue, 31 Mar 2020 18:03:42 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6D6DA656AC; Tue, 31 Mar 2020 16:03:42 +0000 (UTC)
Message-Id: <dabed523c1b8955dd425152ce260b390053e727a.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/12] powerpc/32s: Blacklist functions running with MMU
 disabled for kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/mm/book3s32/hash_low.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 2afa3fa2012d..f5f836477009 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -163,6 +163,7 @@ _GLOBAL(hash_page)
 	stw	r0, (mmu_hash_lock - PAGE_OFFSET)@l(r8)
 	blr
 #endif /* CONFIG_SMP */
+_ASM_NOKPROBE_SYMBOL(hash_page)
 
 /*
  * Add an entry for a particular page to the hash table.
@@ -267,6 +268,7 @@ _GLOBAL(add_hash_page)
 	lwz	r0,4(r1)
 	mtlr	r0
 	blr
+_ASM_NOKPROBE_SYMBOL(add_hash_page)
 
 /*
  * This routine adds a hardware PTE to the hash table.
@@ -472,6 +474,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 
 	sync		/* make sure pte updates get to memory */
 	blr
+_ASM_NOKPROBE_SYMBOL(create_hpte)
 
 	.section .bss
 	.align	2
@@ -628,6 +631,7 @@ _GLOBAL(flush_hash_pages)
 	isync
 	blr
 EXPORT_SYMBOL(flush_hash_pages)
+_ASM_NOKPROBE_SYMBOL(flush_hash_pages)
 
 /*
  * Flush an entry from the TLB
@@ -665,6 +669,7 @@ _GLOBAL(_tlbie)
 	sync
 #endif /* CONFIG_SMP */
 	blr
+_ASM_NOKPROBE_SYMBOL(_tlbie)
 
 /*
  * Flush the entire TLB. 603/603e only
@@ -706,3 +711,4 @@ _GLOBAL(_tlbia)
 	isync
 #endif /* CONFIG_SMP */
 	blr
+_ASM_NOKPROBE_SYMBOL(_tlbia)
-- 
2.25.0

