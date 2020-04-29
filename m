Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B016C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6A12085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fxZ5az4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgD2NmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgD2Ng7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:36:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA62C08E934;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YnI7+Bhh5UkZXE935EtKZ6coz+qLsXX3qU5WuaeRKjg=; b=fxZ5az4CYo0x5qndPDmobRvtOx
        AS6LZ1Flcbd18sjUj6MeEJop9oPMIYLLJBQq9BT3gD7HD4qJ9tEsJaqooNIuJjG0bppg1q5dds3gR
        hI2JwwaChpjpuv0TE3NnSQLsOPJCipAS7I3s7O+y8xD54yRQF4ZWqqHfMETnTZOmj/bg6xmU/v2I0
        5bqB3yesQseeUpEgB7F4tZzOYuByVbeyQJqY5wOGirvvZepVluRDbzFQprt8tOdW+G/SMyTh49mcg
        ksz7oJBU9lLogDh3I/jblyg1sTC2SafRyzyib4kYUBKSo4pkvzWyF+99K5TgRaGN1z+QjJ/Pu8yTP
        TPXZTTvw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005ug-8N; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/25] fs: Add a filesystem flag for large pages
Date:   Wed, 29 Apr 2020 06:36:37 -0700
Message-Id: <20200429133657.22632-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The page cache needs to know whether the filesystem supports pages >
PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 55c743925c40..777783c8760b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2241,6 +2241,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_LARGE_PAGES		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
-- 
2.26.2

