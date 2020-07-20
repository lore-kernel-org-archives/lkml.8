Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A14F2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQP0zmht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGTAOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 20:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGTAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:14:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C89C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+8KIohn8oTybDj4EKgVF5l5KNyz4huEAk4t5RDm5bJA=; b=IQP0zmhtpzvcJU/JkzWpO+HJSV
        GHi7XB174Vq4IFZi9P7nGj3EmLLmsqCO7mLDGK8q7vwnI+QJ22W2pQWq5nRZQZjGrtnbkr78eu6Az
        Tlf18qGi8Jum2LcM5mDHAwibGC0usaK2/H0/CVFxSGk3L+m4a7r5maz11f7VCgUeMS717FroOD7aG
        nGrHmGkesoWHH17GrMBUAAImB46D+2cv2mqAp2yUVwgddYJKG/0Y6R54ANMglIX7pm6r1EGsCo06D
        zWCiGqo/oAfwCsIx2YHN1aoEMpbGBce0IvPqoBmSZDADj8jJ9TKTdoAOyoIfi5asiS5HGfCWW+qD4
        EWwZbvNQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJRN-0003yN-ML; Mon, 20 Jul 2020 00:13:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH] jfs: delete duplicated words in header files
Date:   Sun, 19 Jul 2020 17:13:53 -0700
Message-Id: <20200720001353.26200-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words "allocation" and "if" in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net
---
 fs/jfs/jfs_extent.h |    2 +-
 fs/jfs/jfs_logmgr.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/fs/jfs/jfs_extent.h
+++ linux-next-20200717/fs/jfs/jfs_extent.h
@@ -5,7 +5,7 @@
 #ifndef	_H_JFS_EXTENT
 #define _H_JFS_EXTENT
 
-/*  get block allocation allocation hint as location of disk inode */
+/*  get block allocation hint as location of disk inode */
 #define	INOHINT(ip)	\
 	(addressPXD(&(JFS_IP(ip)->ixpxd)) + lengthPXD(&(JFS_IP(ip)->ixpxd)) - 1)
 
--- linux-next-20200717.orig/fs/jfs/jfs_logmgr.h
+++ linux-next-20200717/fs/jfs/jfs_logmgr.h
@@ -132,7 +132,7 @@ struct logpage {
  * (this comment should be rewritten !)
  * jfs uses only "after" log records (only a single writer is allowed
  * in a page, pages are written to temporary paging space if
- * if they must be written to disk before commit, and i/o is
+ * they must be written to disk before commit, and i/o is
  * scheduled for modified pages to their home location after
  * the log records containing the after values and the commit
  * record is written to the log on disk, undo discards the copy
