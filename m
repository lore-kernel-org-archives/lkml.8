Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2046AC43457
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6120C22D6E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oT6asMAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgHFKMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbgHFKM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:12:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEABC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9dX/bRSkZ53qhCOq8/7508fbRufKnExby3lIfqewQ/k=; b=oT6asMAWUevoGmLuxn2iarS9l/
        UgaQ6ZDHg/+xij+wXVy8oAhgVCD9nouYVrBc+rV/DNnG9FtHCX6vMi0E1O5tJPKehtK0rBDPG0mbu
        86VJbBQnZn8RhOsnRZ67KnEkEuhnzKKTU2VP4HBQgIehtotTUcbY0Hq5lnjLU8eKLqxt2NqLmiECH
        c7kTyiLlF1V9CS6oDrxjGHadEH1+KOijMnMzhov74wDhlJYoukOf1lLgQSqvtVBZThWJJV+I62mQK
        xVjQMSddlC6RSSTG6ivVwTeHTJK9mrBULj7GLRcSvlyHT8g5TfuwaGnkwZtmJ0g3Olj1Mc8E8RvuR
        1BETifbA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58866 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1k3csp-0004V7-76; Thu, 06 Aug 2020 11:12:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1k3cso-0007LC-VJ; Thu, 06 Aug 2020 11:12:23 +0100
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
Subject: [PATCH 1/2] ARM: add TEXT_OFFSET to decompressor kexec image
 structure
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1k3cso-0007LC-VJ@rmk-PC.armlinux.org.uk>
Date:   Thu, 06 Aug 2020 11:12:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TEXT_OFFSET to the decompressor's kexec image structure to
kexec knows what offset to use.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Makefile                      | 3 +++
 arch/arm/boot/compressed/Makefile      | 1 +
 arch/arm/boot/compressed/vmlinux.lds.S | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 01ed27a538b4..ab2d66e40b7f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -139,6 +139,9 @@ head-y		:= arch/arm/kernel/head$(MMUEXT).o
 
 # Text offset. This list is sorted numerically by address in order to
 # provide a means to avoid/resolve conflicts in multi-arch kernels.
+# Note: the 32kB below this value is reserved for use by the kernel
+# during boot, and this offset is critical to the functioning of
+# kexec-tools.
 textofs-y	:= 0x00008000
 # We don't want the htc bootloader to corrupt kernel during resume
 textofs-$(CONFIG_PM_H1940)      := 0x00108000
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 433fb7f04aa5..0890d82b8cf4 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -70,6 +70,7 @@ ZBSSADDR	:= ALIGN(8)
 endif
 
 CPPFLAGS_vmlinux.lds := -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)"
+CPPFLAGS_vmlinux.lds += -DTEXT_OFFSET="$(TEXT_OFFSET)"
 
 compress-$(CONFIG_KERNEL_GZIP) = gzip
 compress-$(CONFIG_KERNEL_LZO)  = lzo
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 09ac33f52814..da1f6fa5345b 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -42,10 +42,11 @@ SECTIONS
   }
   .table : ALIGN(4) {
     _table_start = .;
-    LONG(ZIMAGE_MAGIC(4))
+    LONG(ZIMAGE_MAGIC(5))
     LONG(ZIMAGE_MAGIC(0x5a534c4b))
     LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
     LONG(ZIMAGE_MAGIC(_kernel_bss_size))
+    LONG(ZIMAGE_MAGIC(TEXT_OFFSET))
     LONG(0)
     _table_end = .;
   }
-- 
2.20.1

