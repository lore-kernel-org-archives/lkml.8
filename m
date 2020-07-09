Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4DDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182C12073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJd1nQ2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgGIPSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGIPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D6C08C5CE;
        Thu,  9 Jul 2020 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=igmuI7FT2PlLpNvSIQhC5NOf4lwLGTOJ/vt07sRMgDU=; b=YJd1nQ2UE0s3hD7fkUi5YtXUoc
        xPEjsF4aWexDXYsNQgdkGzM1j2Hnarmx7TumUYZXwWRPaaRa9Y834y8R3gcO00uRui+Ct+9N6kkT9
        48nICk3mgKDoIjInbUVTHcsdL526g0HW+6GTjlRfV0+UCDFJPNA/DvKCBPMZFaMMMEVgvL7tif1YZ
        bTskgMFKbylvO96UkojqYXSOqLvPerndbDchHjFIMZv4fqYtrIjjdeCIA95UddHeNE0lhe7x+urMg
        9PmVTP8o5uqCziM2aZlRppjIrgVMTysFuImLfvxZ8pqWezKsF60F9SN0LFA8Ys7pPX7Aq0dZELJzH
        5pairsSg==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJb-0005KV-03; Thu, 09 Jul 2020 15:18:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/17] md: remove the kernel version of md_u.h
Date:   Thu,  9 Jul 2020 17:18:02 +0200
Message-Id: <20200709151814.110422-6-hch@lst.de>
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

mdp_major can just move to drivers/md/md.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.h           |  1 +
 include/linux/raid/md_u.h | 13 -------------
 2 files changed, 1 insertion(+), 13 deletions(-)
 delete mode 100644 include/linux/raid/md_u.h

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 37315a3f28e97d..6f8fff77ce10a5 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -801,6 +801,7 @@ static inline void mddev_check_write_zeroes(struct mddev *mddev, struct bio *bio
 		mddev->queue->limits.max_write_zeroes_sectors = 0;
 }
 
+extern int mdp_major;
 void md_autostart_arrays(int part);
 
 #endif /* _MD_MD_H */
diff --git a/include/linux/raid/md_u.h b/include/linux/raid/md_u.h
deleted file mode 100644
index 8dfec085a20ee1..00000000000000
--- a/include/linux/raid/md_u.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
-   md_u.h : user <=> kernel API between Linux raidtools and RAID drivers
-          Copyright (C) 1998 Ingo Molnar
-	  
-*/
-#ifndef _MD_U_H
-#define _MD_U_H
-
-#include <uapi/linux/raid/md_u.h>
-
-extern int mdp_major;
-#endif 
-- 
2.26.2

