Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2CC4345C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C11206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="upCuG2h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgHFKNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgHFKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:12:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABFBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JuJ7hgPBB8WM+74fvD+8nmdghHy8m43xA0A2njv6ZAM=; b=upCuG2h1jNpj0z9rwLiVvmcROf
        Jt4mP+RhEBElrEtKRSvtAIQ3UGkklCkF80xn5fkwrTYOtksndAndNWWrph6iomIsNADBD9R1Ti3Ph
        FflQ+7qg45SrlXhInumr8lu6RiBdFLFoHvMh1YxT8yJUHI2sW6ncYzWuFTnSIMvwzw2//uu7KcIo+
        N1NqAgTwIC2IeTQocnCMRlcyiaUBu/LyT3mxXZd5iKYNShpbnmxy5BBgoVLVmGJtlLQDlTPN1a9cX
        nEr+wBd9sf0R4apq9lTkYcJONBN4eDyJPPwnSp0l/XBspjpYt/EdL29JzcI68qH341hcIjRVdcyyh
        U75RtnIQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58870 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1k3csu-0004VL-BW; Thu, 06 Aug 2020 11:12:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1k3csu-0007LV-4C; Thu, 06 Aug 2020 11:12:28 +0100
In-Reply-To: <20200806101145.GC1551@shell.armlinux.org.uk>
References: <20200806101145.GC1551@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Norbert Lange <nolange79@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Petr Malat <oss@malat.biz>, Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: add malloc size to decompressor kexec size structure
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1k3csu-0007LV-4C@rmk-PC.armlinux.org.uk>
Date:   Thu, 06 Aug 2020 11:12:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required malloc size to the decompressor kexec size structure.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/compressed/Makefile      | 5 ++++-
 arch/arm/boot/compressed/head.S        | 4 ++--
 arch/arm/boot/compressed/vmlinux.lds.S | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 0890d82b8cf4..432af49ddbcb 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -7,7 +7,6 @@
 
 OBJS		=
 
-AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
@@ -69,8 +68,12 @@ ZTEXTADDR	:= 0
 ZBSSADDR	:= ALIGN(8)
 endif
 
+MALLOC_SIZE	:= 65536
+
+AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET) -DMALLOC_SIZE=$(MALLOC_SIZE)
 CPPFLAGS_vmlinux.lds := -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)"
 CPPFLAGS_vmlinux.lds += -DTEXT_OFFSET="$(TEXT_OFFSET)"
+CPPFLAGS_vmlinux.lds += -DMALLOC_SIZE="$(MALLOC_SIZE)"
 
 compress-$(CONFIG_KERNEL_GZIP) = gzip
 compress-$(CONFIG_KERNEL_LZO)  = lzo
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 7f24f0852a94..2ea4521bf7df 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -299,7 +299,7 @@ restart:	adr	r0, LC1
 
 #ifndef CONFIG_ZBOOT_ROM
 		/* malloc space is above the relocated stack (64k max) */
-		add	r10, sp, #0x10000
+		add	r10, sp, #MALLOC_SIZE
 #else
 		/*
 		 * With ZBOOT_ROM the bss/stack is non relocatable,
@@ -610,7 +610,7 @@ not_relocated:	mov	r0, #0
  */
 		mov	r0, r4
 		mov	r1, sp			@ malloc space above stack
-		add	r2, sp, #0x10000	@ 64k max
+		add	r2, sp, #MALLOC_SIZE	@ 64k max
 		mov	r3, r7
 		bl	decompress_kernel
 
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index da1f6fa5345b..0ed4d82d3782 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -42,11 +42,12 @@ SECTIONS
   }
   .table : ALIGN(4) {
     _table_start = .;
-    LONG(ZIMAGE_MAGIC(5))
+    LONG(ZIMAGE_MAGIC(6))
     LONG(ZIMAGE_MAGIC(0x5a534c4b))
     LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
     LONG(ZIMAGE_MAGIC(_kernel_bss_size))
     LONG(ZIMAGE_MAGIC(TEXT_OFFSET))
+    LONG(ZIMAGE_MAGIC(MALLOC_SIZE))
     LONG(0)
     _table_end = .;
   }
-- 
2.20.1

