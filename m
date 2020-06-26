Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7802082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cFpcU+eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgFZIIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbgFZIHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:07:48 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A05AC08C5DC;
        Fri, 26 Jun 2020 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vxsAwsLR9Ng86EmjXAj4oPak8ui2caJnN1kRrf8YMkM=; b=cFpcU+eHvnSM2qCuf91vLIb1Fx
        anoFL9E4Vkd4hPwyWej6Afg1YiVZBWGhJrCPpGFIFVJSz4Q76ngAPy12orssjbJNMIats6RsFgXpb
        8iYqGq5xKN/Bh3VFiiYO7+VOFqGPFQXVMymKDP53RHfzHWYomigNsZIAlVeV3Pkp+S14UlDdN/VqL
        dkXjnEH95K1XlDfoSJGUIJ9O5H7NC8nXNyImcRPqndQXLuDuZ1dp82U3W/Nl7RSdBNlDISrgxPFy2
        wzWHFwQN5Tr4ola8eMjfzQCnEB9ZXIJcBW3yRHC95SnG/2CUpZjtx8YZmPukLOsaa0Rdf/XojpV1k
        qZ8cwtIw==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojOS-0007tv-TH; Fri, 26 Jun 2020 08:07:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Date:   Fri, 26 Jun 2020 10:07:16 +0200
Message-Id: <20200626080717.1999041-10-hch@lst.de>
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

The code handling non-coherent DMA depends on being able to remap code
as non-cached.  But that can't be done without an MMU, so using this
option on NOMMU builds is broken.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f8027eee08edae..337eb496c45a0a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -61,6 +61,7 @@ config SUPERH
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
+	select NO_DMA if !MMU && !DMA_COHERENT
 	select NO_GENERIC_PCI_IOPORT_MAP if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND
@@ -135,7 +136,7 @@ config DMA_COHERENT
 	bool
 
 config DMA_NONCOHERENT
-	def_bool !DMA_COHERENT
+	def_bool !NO_DMA && !DMA_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 
 config PGTABLE_LEVELS
-- 
2.26.2

