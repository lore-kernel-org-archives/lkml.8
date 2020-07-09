Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD108C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66E82064C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W1TAqgmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGIPSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgGIPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321AC08C5CE;
        Thu,  9 Jul 2020 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mwNQ+ZPrHLyvZ8H22M9evW5mu6OkuaBWEuSC8HmI3Yw=; b=W1TAqgmOv341uGX/IYdHQhHoIa
        sXxuhALEE8UU3dq1YA9YK01cFESwYTmdxPVtFzJ1HY4sjuzWq3ZjUrXQNsOzQuX7zMHFjWgo+IuPY
        HU17cIg9OWdXlYsQ69BNDuwE7ZjiZDLS4J1C4V2CYlLldY5if+akSWZ7Af7cJmBEBukggc0vq5C0w
        L1GvskzNZwuCj8uKnZFxW9ykBZP+6nh1F/OP4h6so6epiIKh3pYJ9JpGFX8GZbx3TOzPr7nvNdBh8
        DXUkq+AfBAGIYjgpQX8kODXxjohSljRhMOqYqRdqwn806D6iwV/mQ0iSzZaD6FjRbD57vwt79diaA
        e+eyhIUA==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJh-0005Lf-3l; Thu, 09 Jul 2020 15:18:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/17] initrd: remove the BLKFLSBUF call in handle_initrd
Date:   Thu,  9 Jul 2020 17:18:06 +0200
Message-Id: <20200709151814.110422-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BLKFLSBUF used to be overloaded for the ramdisk driver to free the whole
ramdisk, which was completely different behavior compared to all other
drivers.  But this magic overload got removed in commit ff26956875c2
("brd: remove support for BLKFLSBUF"), so this call is entirely
pointless now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_initrd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d72beda824aa79..e4f88e9e1c0839 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -115,21 +115,12 @@ static void __init handle_initrd(void)
 	if (!error)
 		printk("okay\n");
 	else {
-		int fd = ksys_open("/dev/root.old", O_RDWR, 0);
 		if (error == -ENOENT)
 			printk("/initrd does not exist. Ignored.\n");
 		else
 			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
 		ksys_umount("/old", MNT_DETACH);
-		printk(KERN_NOTICE "Trying to free ramdisk memory ... ");
-		if (fd < 0) {
-			error = fd;
-		} else {
-			error = ksys_ioctl(fd, BLKFLSBUF, 0);
-			ksys_close(fd);
-		}
-		printk(!error ? "okay\n" : "failed\n");
 	}
 }
 
-- 
2.26.2

