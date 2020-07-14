Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB595C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE3621D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EP7bLEu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgGNTJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbgGNTJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F9C061794;
        Tue, 14 Jul 2020 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lispkLvcl0d72F43kCZTUhEngpZlXnmRDqJjVK2IdKY=; b=EP7bLEu8Jz4+SRl3R6LjnAJoWq
        6irdIJMXfaRDyHwBkqq42gUJeMICJPhv7pT+0BSDS7FCtCYNcwEYGhv5na6PEVpZGAFtPls32xOKX
        XLJ4o1gWz1lMJb6AQF2rnyUyKAMYAs+DZ0ga9TRTiH1EZiRd94JZdU/3SWlxKYrp3zf6UMm9iqb3N
        BhcnFcmDwNWOiR/4JYjDUk6j2Wcq/82Ytll2L+fHSodfvjZ7l0+h5BoEb92DFHG3OyTj9UwHviHtY
        GrV2PhMfxMlXIUgkRlrKUZZDqHZlaBHB5Up0tU2zWIty55p5GavRyMw3QuQkgew067u4wKqh4XYfT
        eSoSQh9g==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIU-0005qP-0b; Tue, 14 Jul 2020 19:08:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/23] md: remove the kernel version of md_u.h
Date:   Tue, 14 Jul 2020 21:04:11 +0200
Message-Id: <20200714190427.4332-8-hch@lst.de>
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

mdp_major can just move to drivers/md/md.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
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
2.27.0

