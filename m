Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C36C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA752082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgEKL04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:26:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39938 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgEKL0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJXN67bmz9ty3h;
        Mon, 11 May 2020 13:25:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FMgpJPev0u1O; Mon, 11 May 2020 13:25:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXN5GRCz9ty3g;
        Mon, 11 May 2020 13:25:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CD078B7B1;
        Mon, 11 May 2020 13:26:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9u1V3hauYpeT; Mon, 11 May 2020 13:26:03 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 313398B7AD;
        Mon, 11 May 2020 13:26:03 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 155AE65A09; Mon, 11 May 2020 11:26:03 +0000 (UTC)
Message-Id: <907ff427c28e765d031687ef4eaf5667d73ea622.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 36/45] powerpc/mm: Don't be too strict with _etext
 alignment on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:26:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to PPC64, accept to map RO data as ROX as a trade off between
between security and memory usage.

Having RO data executable is not a high risk as RO data can't be
modified to forge an exploit.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig              | 26 --------------------------
 arch/powerpc/kernel/vmlinux.lds.S |  3 +--
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f552726c9de2..970a5802850f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -777,32 +777,6 @@ config THREAD_SHIFT
 	  Used to define the stack size. The default is almost always what you
 	  want. Only change this if you know what you are doing.
 
-config ETEXT_SHIFT_BOOL
-	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && \
-					     (PPC_BOOK3S_32 || PPC_8xx)
-	depends on ADVANCED_OPTIONS
-	help
-	  This option allows you to set the kernel end of text alignment. When
-	  RAM is mapped by blocks, the alignment needs to fit the size and
-	  number of possible blocks. The default should be OK for most configs.
-
-	  Say N here unless you know what you are doing.
-
-config ETEXT_SHIFT
-	int "_etext shift" if ETEXT_SHIFT_BOOL
-	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
-	range 19 23 if STRICT_KERNEL_RWX && PPC_8xx
-	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
-	default 19 if STRICT_KERNEL_RWX && PPC_8xx
-	default PPC_PAGE_SHIFT
-	help
-	  On Book3S 32 (603+), IBATs are used to map kernel text.
-	  Smaller is the alignment, greater is the number of necessary IBATs.
-
-	  On 8xx, large pages (512kb or 8M) are used to map kernel linear
-	  memory. Aligning to 8M reduces TLB misses as only 8M pages are used
-	  in that case.
-
 config DATA_SHIFT_BOOL
 	bool "Set custom data alignment" if STRICT_KERNEL_RWX && \
 					    (PPC_BOOK3S_32 || PPC_8xx)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 31a0f201fb6f..54f23205c2b9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -15,7 +15,6 @@
 #include <asm/thread_info.h>
 
 #define STRICT_ALIGN_SIZE	(1 << CONFIG_DATA_SHIFT)
-#define ETEXT_ALIGN_SIZE	(1 << CONFIG_ETEXT_SHIFT)
 
 ENTRY(_stext)
 
@@ -116,7 +115,7 @@ SECTIONS
 
 	} :text
 
-	. = ALIGN(ETEXT_ALIGN_SIZE);
+	. = ALIGN(PAGE_SIZE);
 	_etext = .;
 	PROVIDE32 (etext = .);
 
-- 
2.25.0

