Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA15AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CDB20836
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTGvM8hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgCXQ0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:26:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgCXQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tNTshsqUMDvShy2poJR/dA/f+Op0Ioq8L8ZpxTGQOL4=; b=mTGvM8hCGMLtDP8hFus8HXx84O
        CjTZH5PTrpwJm8EMKLbUhQuuHTKv79XnIIgyWOgrKU8oJbrdtHJcNfgL9GfycJqOn8xXLCbQEvgGf
        M3SIWccIlRrzfW1WaUfKCxqETjuIMukYRDFU0WIpy6yrNOoXSGx1KPJ2p2gkabEe+j4XUwJQM6DVU
        5XmDrJTLN8d/SJPdStHS4C+1Td8tpowmn5+fvCmru+PwQJy0Sb+1LQ3RekACffKpco7MipX5/bXGw
        +v2qExcIl29p+vyucTuUg6v8NhEwV/M5Zy17yQdPCZshZwU0K9PfR4vWS51ifSYtxlbSN5kYoBWm4
        v3EcaViQ==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmNx-0007c1-9i; Tue, 24 Mar 2020 16:26:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] sh: remove -Werror from Makefiles
Date:   Tue, 24 Mar 2020 17:26:24 +0100
Message-Id: <20200324162633.754714-2-hch@lst.de>
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

The sh build is full of warnings when building with gcc 9.2.1.  While
fixing those would be great, at least avoid failing the build.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/Makefile | 2 --
 arch/sh/lib/Makefile    | 2 --
 arch/sh/mm/Makefile     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 59673f8a3379..ef65f0625c6c 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
-
-ccflags-y := -Werror
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index d0abbe5e38b0..eb473d373ca4 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -30,5 +30,3 @@ memset-$(CONFIG_CPU_SH4)	:= memset-sh4.o
 lib-$(CONFIG_MMU)		+= copy_page.o __clear_user.o
 lib-$(CONFIG_MCOUNT)		+= mcount.o
 lib-y				+= $(memcpy-y) $(memset-y) $(udivsi3-y)
-
-ccflags-y := -Werror
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 5051b38fd5b6..b461310965b8 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -70,5 +70,3 @@ CFLAGS_tlbex_64.o += -ffixed-r7 \
 	-ffixed-r41 -ffixed-r42 -ffixed-r43  \
 	-ffixed-r60 -ffixed-r61 -ffixed-r62 \
 	-fomit-frame-pointer
-
-ccflags-y := -Werror
-- 
2.25.1

