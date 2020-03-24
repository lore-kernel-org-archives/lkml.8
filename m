Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D33C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B07520788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0/givOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgCXQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:27:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgCXQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uC6WZyO2p9fwKKTh7GcMXam2Sn8LrXKsW96hpBKhuNg=; b=D0/givOKXpxiK8ja3UhZTu+rNa
        VcJKY6TLoU8CM0vk3kbgNLrmE/ipNYM6IxGJOsim5tJCmChRTTEDl9pRGVMPYVpbxz7y9+fP5UQqf
        p+aYz8YEWkOpe+B0n80N9AWtvAshc2+7DWrCyxr7zfgkwzOvuZE9jwKDzADIGiBdt3rgSN69/7ptb
        9WC9if0QNNgWSDb8nTgQCjfjp5EH0e2Ow1V6KEuL1tLNlD2T4eFxz5Hcf7cnjEUlcmpIlz1wHZ+sy
        YNu+yHYD819QK6P0xxFlD51vWUhQHhnyQqUOi/564Ljw51FhJaUV/whvFDmRUrAV0V73KUlp19Ljt
        +GRgBk0g==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmOE-0007en-2m; Tue, 24 Mar 2020 16:26:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] dma-mapping: consolidate the NO_DMA definition in kernel/dma/Kconfig
Date:   Tue, 24 Mar 2020 17:26:31 +0100
Message-Id: <20200324162633.754714-9-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
References: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
index 6ad6cdac74b3..8e488369a7e5 100644
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
index c01e103492fd..0b95bc980070 100644
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
index 0917f8443c28..4e92502407df 100644
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
@@ -162,9 +163,6 @@ config MMAPPER
 	  This driver allows a host file to be used as emulated IO memory inside
 	  UML.
 
-config NO_DMA
-	def_bool y
-
 config PGTABLE_LEVELS
 	int
 	default 3 if 3_LEVEL_PGTABLES
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c103a24e380..3df749b1fd23 100644
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
2.25.1

