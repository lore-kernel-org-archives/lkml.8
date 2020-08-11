Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357EEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083EE206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGsV5i7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgHKCSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHKCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:18:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26069C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 19:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=35rIoic2RaljV90uQazpFvWWHqyuAWfy8NLUV+yKOas=; b=EGsV5i7hHMPe/VNse/n+yA2hjC
        5pihFVmHF3/DYlklltybJjlxTOzBCTlfeYmEaj6V/HbtjMQi5gnWqJQdzf0Ul/Mm14AyXlqW8XFrd
        8un2zW3ARZudkoFepwWVzUCFgYvqzJD+VMhnGIJViQBdpJk7xeCwScpsmxXgrKQ8JXvy/R7GVZTKd
        StHVALSS1BzqMqla88GXVVX2E96PIy4EskLRCrSNXUP4i/vw+l9MzXENqoustewHWis60IDRadEju
        xyzBO6dtwdsEGHlW21b/0pruVWGVoZvI8TAxF4u5iEm8e9lAcAYvp72oJDuu2/fwx6TZpVebLhONT
        N5Lndz7A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Jrx-0006pJ-P0; Tue, 11 Aug 2020 02:18:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] fs: configfs: delete repeated words in comments
Date:   Mon, 10 Aug 2020 19:18:26 -0700
Message-Id: <20200811021826.25032-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words {the, that} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/configfs/dir.c  |    2 +-
 fs/configfs/file.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/fs/configfs/dir.c
+++ linux-next-20200807/fs/configfs/dir.c
@@ -1168,7 +1168,7 @@ EXPORT_SYMBOL(configfs_depend_item);
 
 /*
  * Release the dependent linkage.  This is much simpler than
- * configfs_depend_item() because we know that that the client driver is
+ * configfs_depend_item() because we know that the client driver is
  * pinned, thus the subsystem is pinned, and therefore configfs is pinned.
  */
 void configfs_undepend_item(struct config_item *target)
--- linux-next-20200807.orig/fs/configfs/file.c
+++ linux-next-20200807/fs/configfs/file.c
@@ -267,7 +267,7 @@ flush_write_buffer(struct file *file, st
  *	There is no easy way for us to know if userspace is only doing a partial
  *	write, so we don't support them. We expect the entire buffer to come
  *	on the first write.
- *	Hint: if you're writing a value, first read the file, modify only the
+ *	Hint: if you're writing a value, first read the file, modify only
  *	the value you're changing, then write entire buffer back.
  */
 
