Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8FD207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbgE1KRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:17:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27694 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387677AbgE1KRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:17:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49XkC35QDRz9v2VX;
        Thu, 28 May 2020 12:17:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vKnYqLkA819M; Thu, 28 May 2020 12:17:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49XkC34Wf4z9v2Tv;
        Thu, 28 May 2020 12:17:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DE918B797;
        Thu, 28 May 2020 12:17:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gQVUZ4WXfqwl; Thu, 28 May 2020 12:17:05 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E56B68B794;
        Thu, 28 May 2020 12:17:04 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 55AF565A60; Thu, 28 May 2020 10:17:04 +0000 (UTC)
Message-Id: <7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: disable KASAN with pages bigger than 16k
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 28 May 2020 10:17:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping of early shadow area is implemented by using a single static
page table having all entries pointing to the same early shadow page.
The shadow area must therefore occupy full PGD entries.

The shadow area has a size of 128Mbytes starting at 0xf8000000.
With 4k pages, a PGD entry is 4Mbytes
With 16k pages, a PGD entry is 64Mbytes
With 64k pages, a PGD entry is 256Mbytes which is too big.

Until we rework the early shadow mapping, disable KASAN when the
page size is too big.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1dfa59126fcf..066b36bf9efa 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -169,8 +169,8 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
 	select HAVE_ARCH_JUMP_LABEL
-	select HAVE_ARCH_KASAN			if PPC32
-	select HAVE_ARCH_KASAN_VMALLOC		if PPC32
+	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
+	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
-- 
2.25.0

