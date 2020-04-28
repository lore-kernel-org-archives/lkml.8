Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B54C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF021206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kvnxvffz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgD1FRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD1FRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:17:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5996BC03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 22:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cEar+zqt8/rWTMwPsOLAgxNJZuhcRfnzHqxHT5fj98I=; b=KvnxvffzPgrYzIy4kvtQ0NDscS
        vp3TMzdPvgthpcYUJI9uJV5LKiiKBK5dpp6794Vn6m9mwqhivkol0uHQ3c4j+dRfwWwe+GLykM2h0
        3uv12c3Cdn6TkgQzSUsyo0KtVUHd9E1+VPpwEXOK4oTR8yviTgP0gOxyABMOHPFSc3O4xD3g9nGNP
        /muQ5joP9Po6yhDdrLl7BfJia9Knegyx3wYcIS9ovraRFJpFjcSMdLNZDg2nWrZNBLBrxBmYMqLyW
        rGRS9zZ99YbtkLPCYJ5niLdkppOXzlFsG8u371lA3htqQ0OCB8t7habAM69yQirJakfx1yhtOgM2J
        tU4KHa9g==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTIcD-0004SU-1E; Tue, 28 Apr 2020 05:17:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     ning.sun@intel.com, x86@kernel.org
Cc:     tboot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tboot: Mark tboot static
Date:   Tue, 28 Apr 2020 07:17:03 +0200
Message-Id: <20200428051703.1625952-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This structure is only really used in tboot.c.  The only exception
is a single tboot_enabled check, but for that we don't need an inline
function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/tboot.c | 8 ++++++--
 include/linux/tboot.h   | 8 +-------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index b89f6ac6a0c01..b2942b2dbfcfc 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -35,8 +35,7 @@
 #include "../realmode/rm/wakeup.h"
 
 /* Global pointer to shared data; NULL means no measured launch. */
-struct tboot *tboot __read_mostly;
-EXPORT_SYMBOL(tboot);
+static struct tboot *tboot __read_mostly;
 
 /* timeout for APs (in secs) to enter wait-for-SIPI state during shutdown */
 #define AP_WAIT_TIMEOUT		1
@@ -46,6 +45,11 @@ EXPORT_SYMBOL(tboot);
 
 static u8 tboot_uuid[16] __initdata = TBOOT_UUID;
 
+bool tboot_enabled(void)
+{
+	return tboot != NULL;
+}
+
 void __init tboot_probe(void)
 {
 	/* Look for valid page-aligned address for shared page. */
diff --git a/include/linux/tboot.h b/include/linux/tboot.h
index 5424bc6feac88..c7e4247663602 100644
--- a/include/linux/tboot.h
+++ b/include/linux/tboot.h
@@ -121,13 +121,7 @@ struct tboot {
 #define TBOOT_UUID	{0xff, 0x8d, 0x3c, 0x66, 0xb3, 0xe8, 0x82, 0x4b, 0xbf,\
 			 0xaa, 0x19, 0xea, 0x4d, 0x5, 0x7a, 0x8}
 
-extern struct tboot *tboot;
-
-static inline int tboot_enabled(void)
-{
-	return tboot != NULL;
-}
-
+bool tboot_enabled(void);
 extern void tboot_probe(void);
 extern void tboot_shutdown(u32 shutdown_type);
 extern struct acpi_table_header *tboot_get_dmar_table(
-- 
2.26.1

