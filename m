Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E16C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E884C2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QNM+PNv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgFOMzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbgFOMxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2393C05BD43;
        Mon, 15 Jun 2020 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EhX9Q3ZGDojbQvb1EzGZvSpfqH7btOJeCuQpHhIypuc=; b=QNM+PNv5TL/xfc/qy6VG1JvXSd
        334iLjBwacUD0ZdFB/OnW/whYemVPNhOKvj6ze7fbxVyM3LmFIvwK6YmqLHGKzEavSpcurft27Wz2
        cK3tMm7W80b7Y/7C6zvTUIiPWBIKbTYV1P4h//mpnmd0AQAALFqKPQvNdyokLe6FERqVRu8RDovpD
        aWYsOtBZs1FkcX3qdYw5oE1NUo0d2rwcP2bQXtLVkNGPJzFdq/BVHhlQJC5wxSQ5Wy9aM3im/sAVJ
        Yb4IB6wSK8o3x3RVAUvdI2X3DOX1D4MXQCpCoecu8OKswg9eQE36tRCY5D9NYfUbZGuTlnOD+BNFp
        75TO9yQQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkocJ-0000ps-AN; Mon, 15 Jun 2020 12:53:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/16] md: remove the autoscan partition re-read
Date:   Mon, 15 Jun 2020 14:53:11 +0200
Message-Id: <20200615125323.930983-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615125323.930983-1-hch@lst.de>
References: <20200615125323.930983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devfs is long gone, and autoscan works just fine without this these days.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-autodetect.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 0eb746211ed53c..6bc9b734eee6ff 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -240,16 +240,6 @@ static void __init md_setup_drive(void)
 			err = ksys_ioctl(fd, RUN_ARRAY, 0);
 		if (err)
 			printk(KERN_WARNING "md: starting md%d failed\n", minor);
-		else {
-			/* reread the partition table.
-			 * I (neilb) and not sure why this is needed, but I cannot
-			 * boot a kernel with devfs compiled in from partitioned md
-			 * array without it
-			 */
-			ksys_close(fd);
-			fd = ksys_open(name, 0, 0);
-			ksys_ioctl(fd, BLKRRPART, 0);
-		}
 		ksys_close(fd);
 	}
 }
-- 
2.26.2

