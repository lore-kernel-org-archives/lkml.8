Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D200FC433FC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C8521D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ib8dutrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgGNTJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgGNTIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:08:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B1C08C5C1;
        Tue, 14 Jul 2020 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WcArS13+FuVWgZpBq2jD9+35A9Hbd1u8/3A+t12Vw84=; b=ib8dutrASdxq5ixAa2izcpGDd8
        E5vpjYNb9eM60YYK0LOg8AhUipNgP6uicqKfI0QWjHtLTK41cTGU94dQnEfFzRkgSizIPRX6jEP+s
        Hw5ez6AwNdcM1gEvNntnm63w7oq3csfsoFpRkRWxL5yqwxWJ3iJRXYQbf5rR/RAWuJGGCFhfXoMwT
        SPJKm4nFVE42oCfwCmXwODGnJLeeF4a9F6JJI/OHiVnKdYBdPNGhbQDaJ3xdji/uoYgzDRGo6BanF
        gHJwGZsTKBDgMVTm1igR4FmT5CexBsZnr3Hr4CB6oKyQDmubOvvbg3XFbdOC1Bq7yaDJLZRdD5F4d
        gkncjQ0Q==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIO-0005pN-He; Tue, 14 Jul 2020 19:08:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/23] init: remove the bstat helper
Date:   Tue, 14 Jul 2020 21:04:07 +0200
Message-Id: <20200714190427.4332-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of the bstat function becomes cleaner and simpler when
open coding the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
---
 init/do_mounts.h    | 10 ----------
 init/do_mounts_md.c |  8 ++++----
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index 0bb0806de4ce2c..7513d1c14d13fe 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -20,16 +20,6 @@ static inline int create_dev(char *name, dev_t dev)
 	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
-static inline u32 bstat(char *name)
-{
-	struct kstat stat;
-	if (vfs_stat(name, &stat) != 0)
-		return 0;
-	if (!S_ISBLK(stat.mode))
-		return 0;
-	return stat.rdev;
-}
-
 #ifdef CONFIG_BLK_DEV_RAM
 
 int __init rd_load_disk(int n);
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index b84031528dd446..359363e85ccd0b 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -138,9 +138,9 @@ static void __init md_setup_drive(void)
 			dev = MKDEV(MD_MAJOR, minor);
 		create_dev(name, dev);
 		for (i = 0; i < MD_SB_DISKS && devname != NULL; i++) {
+			struct kstat stat;
 			char *p;
 			char comp_name[64];
-			u32 rdev;
 
 			p = strchr(devname, ',');
 			if (p)
@@ -150,9 +150,9 @@ static void __init md_setup_drive(void)
 			if (strncmp(devname, "/dev/", 5) == 0)
 				devname += 5;
 			snprintf(comp_name, 63, "/dev/%s", devname);
-			rdev = bstat(comp_name);
-			if (rdev)
-				dev = new_decode_dev(rdev);
+			if (vfs_stat(comp_name, &stat) == 0 &&
+			    S_ISBLK(stat.mode))
+				dev = new_decode_dev(stat.rdev);
 			if (!dev) {
 				printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
 				break;
-- 
2.27.0

