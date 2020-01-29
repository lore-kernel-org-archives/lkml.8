Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF7C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6231720702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="l3nV9ySF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgA2Mej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:34:39 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59177 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgA2Mej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:34:39 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4872x84Y4Lz9tx92;
        Wed, 29 Jan 2020 13:34:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=l3nV9ySF; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uH-i69bvoEWL; Wed, 29 Jan 2020 13:34:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4872x83HG1z9tx91;
        Wed, 29 Jan 2020 13:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580301276; bh=pguVXdOhkyypdIZhHe1n3i7XEXX+yG1raLA7WsBiY2c=;
        h=From:Subject:To:Cc:Date:From;
        b=l3nV9ySFTQoaYWheRtSLpxXQWqDGTF+7CTkVzroN17yb2abpx51Sg/dbEkTnsIVbk
         GtQOxks2plKz5QZekbeokoSW1Bnpd8AO3Xe8erFZ1ECC8pknxQ0FATIm6ekInrAo1a
         WTX3EkLwQWhOYOha5WxJJc1ramrscA9+ArL7eUBw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCB268B81C;
        Wed, 29 Jan 2020 13:34:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id buSXGuoXKh3u; Wed, 29 Jan 2020 13:34:37 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F00F8B815;
        Wed, 29 Jan 2020 13:34:37 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 05B396523E; Wed, 29 Jan 2020 12:34:36 +0000 (UTC)
Message-Id: <fc8390a33c2a470105f01abbcbdc7916c30c0a54.1580301269.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: Fix kasan_early_hash_table() for
 CONFIG_VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 29 Jan 2020 12:34:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On book3s/32 CPUs that are handling MMU through a hash table,
MMU_init_hw() function was adapted for VMAP_STACK in order to
handle virtual addresses instead of physical addresses in the
low level hash functions.

When using KASAN, the same adaptations are required for the
early hash table set up by kasan_early_hash_table() function.

Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index d3cacd462560..16dd95bd0749 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -185,8 +185,11 @@ u8 __initdata early_hash[256 << 10] __aligned(256 << 10) = {0};
 
 static void __init kasan_early_hash_table(void)
 {
-	modify_instruction_site(&patch__hash_page_A0, 0xffff, __pa(early_hash) >> 16);
-	modify_instruction_site(&patch__flush_hash_A0, 0xffff, __pa(early_hash) >> 16);
+	unsigned int hash = IS_ENABLED(CONFIG_VMAP_STACK) ? (unsigned int)early_hash :
+							    __pa(early_hash);
+
+	modify_instruction_site(&patch__hash_page_A0, 0xffff, hash >> 16);
+	modify_instruction_site(&patch__flush_hash_A0, 0xffff, hash >> 16);
 
 	Hash = (struct hash_pte *)early_hash;
 }
-- 
2.25.0

