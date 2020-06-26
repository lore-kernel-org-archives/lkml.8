Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1095DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB998208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CekBt0vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgFZIHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgFZIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:07:38 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7FC08C5DB;
        Fri, 26 Jun 2020 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zRHjhGZd0E9ykTXG5F+LPgDPCn6bHURcI/gISl6Qpow=; b=CekBt0vZTMxhKwsdHBumKJWuD2
        FrUfmlScGp2Vy2motnpxyHuVUuA08u6X6AhNNE/8QiDY/evCugDDumrDk6foM7ZrUcEInu7/fJ2Zc
        5k6Jo4LPA9fGS1kLERBXKA17B9KFjIxFQAGOrYaX7EIWvt1ldj1LuaqAu55CL2vKrhIFLsXa8WEdY
        E36Krh6YNujco6KDiDmtqdP4/4Y8/CjLQWP079tHcKhVE+ovZEL8HxyPkCXZw8HKzIZkBWW3+Elk9
        HkEhtITu7dzmnnmlqumQBY6wDrihqH/Dh7qRtEKmkF7HqlLN43CMpSXThiulsnUZme/Y4e+WOsbVX
        Hl9SKBwQ==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojOJ-0007t0-8b; Fri, 26 Jun 2020 08:07:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] sh: remove -Werror from Makefiles
Date:   Fri, 26 Jun 2020 10:07:08 +0200
Message-Id: <20200626080717.1999041-2-hch@lst.de>
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

The sh build is full of warnings when building with gcc 9.2.1.  While
fixing those would be great, at least avoid failing the build.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/Makefile | 2 --
 arch/sh/lib/Makefile    | 2 --
 arch/sh/mm/Makefile     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index b0f5574b6228b3..aa0fbc9202b14e 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
-
-ccflags-y := -Werror
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index d0abbe5e38b0f3..eb473d373ca43a 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -30,5 +30,3 @@ memset-$(CONFIG_CPU_SH4)	:= memset-sh4.o
 lib-$(CONFIG_MMU)		+= copy_page.o __clear_user.o
 lib-$(CONFIG_MCOUNT)		+= mcount.o
 lib-y				+= $(memcpy-y) $(memset-y) $(udivsi3-y)
-
-ccflags-y := -Werror
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 487da0ff03b3a7..f69ddc70b14658 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -43,5 +43,3 @@ obj-$(CONFIG_UNCACHED_MAPPING)	+= uncached.o
 obj-$(CONFIG_HAVE_SRAM_POOL)	+= sram.o
 
 GCOV_PROFILE_pmb.o := n
-
-ccflags-y := -Werror
-- 
2.26.2

