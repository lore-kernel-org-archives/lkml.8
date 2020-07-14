Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A0722453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u37hdr34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgGNMcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGNMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:32:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15806C061755;
        Tue, 14 Jul 2020 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BktVmUQwJDMdFvTqNfIGD9S059ZhXdxHkBq9VGVsX10=; b=u37hdr34IkQBIw3zL4SUnRXans
        E8qGS6pIRhI3UCJTqpkM8yVZ18+t1k9NdJynJFnBaK0atAzYWLqid3MM75V19MAaUsHRBZky7f3f8
        yt2QQoR7EPloIiv6GPX4guCEqMVrg5DFFWRcXVJGl2KIt3nVWrDEPN1c0ZNVLu5qOKeeETqeliXHy
        NUm+LZrTd28QKwkpL/QT6mp1viRo45rnkceWFQGUjPQvSodnrzI+YcjDWuxfS2BzjN/BTOiRlenUD
        t4W5uQWxfHw8dV6pM0kbq+93/QCbPRTpsA7kD5XI7obD1cw4Ai40xPM/IxdRyQBXF33KQRvM355UQ
        grcHI0zA==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvK6R-000269-TF; Tue, 14 Jul 2020 12:32:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] sh: don't include <asm/io_trapped.h> in <asm/io.h>
Date:   Tue, 14 Jul 2020 14:18:52 +0200
Message-Id: <20200714121856.955680-7-hch@lst.de>
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

