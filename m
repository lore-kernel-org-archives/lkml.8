Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED621C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE5A2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l+opO6kD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgFZIHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgFZIHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:07:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98304C08C5DC;
        Fri, 26 Jun 2020 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F5t08S17TNAQZ0hoTyqURteeYL9jc3muUnkET1f/mJ8=; b=l+opO6kDvzbTbbSfN3k0s6Oydj
        x8pURVGEPaOaEJsdoMk7b1nyAmUoGSFWjtvUu0L4tuKH66YRkyS/TdJThOJ55GMhHd7S7Y9KlIg2/
        sjiuEPm0macps7/NF9qolEHPuCAoXhOnJCV3sxYfR81F8m7/X5uyUPRTEkLB81lZQNrdKoJ74BiqF
        Q1cxZufnoWB3M2feKSnvhMfF9nPeUdnR7UV3EUKv3z5MChFdTdrlUJG1XBqT5IJoen1WfgcT64/GN
        ajcMcbiuURjNnZvJddxxJ/pOt3awDkuWhM6oUURaTjeK4TL+L+CLtJPhsiu2SoI1/2SP6OewVJQSh
        2AR20W8g==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojOR-0007tn-P2; Fri, 26 Jun 2020 08:07:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] dma-mapping: consolidate the NO_DMA definition in kernel/dma/Kconfig
Date:   Fri, 26 Jun 2020 10:07:15 +0200
Message-Id: <20200626080717.1999041-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080717.1999041-1-hch@lst.de>
References: <20200626080717.1999041-1-hch@lst.de>
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
index a0ce3c1494fdd2..cb05247804d9f3 100644
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

