Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB4520836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H05WGHFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgFZIHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgFZIHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:07:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96674C08C5DB;
        Fri, 26 Jun 2020 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BktVmUQwJDMdFvTqNfIGD9S059ZhXdxHkBq9VGVsX10=; b=H05WGHFMgHp+CwdGdiMdPr2gkj
        W+ocIXHfXW/EYZEYwaL7RxTOjKieiY40T1fvrTQ7Noe+At7PLcpSQ7JNTbgSV4RR2rjepaHLFqJ6N
        93etcQ2WHVcHifDScuEyWuuoIQ7WDSoP8Bl1ZkAnRRCyQi37/H2qMls7Ur4U0hPvXyIIxaI00eS4a
        PXwtiQtnjhYfq1dFnZ2c1ZY6LeHCzqNoYnIvZoNulRPSk8bRJBPXsdqWwSQQij5CgKJzaxK0ZcslF
        TNUbiJJGcgZfqrOyxxtvXR1j5f/ut453fTTMasBiIsZZdMNiZyfZ8u5KEnAD2BFu1gLjXeLUfN5vu
        VoZKzFEA==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojOP-0007ta-FM; Fri, 26 Jun 2020 08:07:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] sh: don't include <asm/io_trapped.h> in <asm/io.h>
Date:   Fri, 26 Jun 2020 10:07:13 +0200
Message-Id: <20200626080717.1999041-7-hch@lst.de>
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

No need to expose the details of trapped I/O to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h | 1 -
 arch/sh/kernel/ioport.c  | 1 +
 arch/sh/mm/ioremap.c     | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index da08a61a2f7dae..873f1399fa5962 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -22,7 +22,6 @@
 
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
-#include <asm/io_trapped.h>
 #include <asm-generic/pci_iomap.h>
 #include <mach/mangle-port.h>
 
diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
index 34f8cdbbcf0bee..f39446a658bdb8 100644
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -7,6 +7,7 @@
  */
 #include <linux/module.h>
 #include <linux/io.h>
+#include <asm/io_trapped.h>
 
 unsigned long sh_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(sh_io_port_base);
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 69e55939e48a6f..21342581144dee 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/io.h>
+#include <asm/io_trapped.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/addrspace.h>
-- 
2.26.2

