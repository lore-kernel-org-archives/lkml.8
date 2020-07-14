Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9471EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3E722453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C+t+5z3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGNMcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGNMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:32:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30223C061755;
        Tue, 14 Jul 2020 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Mz4iPOSTi0MKJkJuTz6uYQXM5bqJr5sHOTzKFdJbzDI=; b=C+t+5z3g7Gd/ar3gLiCIY/v87t
        vYwvMiGhrBkcou54DUSU0hvvGlGj1EM8aQmW0h0cRTkqKntimf1v3zGW++D5r3dhhhpIlifgZL1Nh
        yjcGKyr2AZpI/nTR7tL0Gdey/FFMJLXGQYp7W9pYM8J+rlmvCkhZLsMhWK2GXs57Jlw7kW+iydBVZ
        c+Y/jEQnETjRaavRNPMeXyNjpd2UrVAPXiUk0D49LoobLYiJeQYOVnvGCVlAcDzzO6DaIARpy8Kaa
        VCTjDslY439lYFbMNdF4cedXFX3vvFKi8IIdalTeoqtgOqwRO65H5Du3+AZW8lOupw36cSiKNjVbU
        fX880UyQ==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvK6U-00026M-AG; Tue, 14 Jul 2020 12:32:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] dma-mapping: consolidate the NO_DMA definition in kernel/dma/Kconfig
Date:   Tue, 14 Jul 2020 14:18:54 +0200
Message-Id: <20200714121856.955680-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
References: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have a single definition that architetures can select.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig         | 4 +---
 arch/m68k/Kconfig.machine | 1 +
 arch/um/Kconfig           | 4 +---
 kernel/dma/Kconfig        | 3 +++
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6ad6cdac74b3dc..8e488369a7e55a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -17,6 +17,7 @@ config M68K
 	select HAVE_COPY_THREAD_TLS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_ATOMIC64
+	select NO_DMA if !MMU && !COLDFIRE
 	select HAVE_UID16
 	select VIRT_TO_BUS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
@@ -60,9 +61,6 @@ config TIME_LOW_RES
 config NO_IOPORT_MAP
 	def_bool y
 
-config NO_DMA
-	def_bool (MMU && SUN3) || (!MMU && !COLDFIRE)
-
 config ZONE_DMA
 	bool
 	default y
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index a82651d58af483..17e8c3a292d770 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -126,6 +126,7 @@ config SUN3
 	depends on MMU
 	depends on !MMU_MOTOROLA
 	select MMU_SUN3 if MMU
+	select NO_DMA
 	select M68020
 	help
 	  This option enables support for the Sun 3 series of workstations
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9318dc6d1a0cee..32c1d1945033ec 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -15,6 +15,7 @@ config UML
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_COPY_THREAD_TLS
+	select NO_DMA
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
@@ -168,9 +169,6 @@ config MMAPPER
 	  This driver allows a host file to be used as emulated IO memory inside
 	  UML.
 
-config NO_DMA
-	def_bool y
-
 config PGTABLE_LEVELS
 	int
 	default 3 if 3_LEVEL_PGTABLES
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 1da3f44f2565b4..57533d07676f4a 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config NO_DMA
+	bool
+
 config HAS_DMA
 	bool
 	depends on !NO_DMA
-- 
2.26.2

