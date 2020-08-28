Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65EEC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC76320684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwLq5JbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgH1DuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgH1DuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:50:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A0C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:50:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g207so1077641pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ril6mM8eHq++BAUOfHk3aWEeikdrpFxtZWvZ7zO9QRg=;
        b=PwLq5JbY5jLfQxWzR9cG/5+zL7h9uYDDkawWkmdLX5CcG2vSWFtp4TR2MxB4Mb4aVl
         xzqC+6pIWigkjb2mtxatGMiiWe+T9FIDqD6wjwZVgiIGARNUhOk/f0UW/pIwQWJupSnB
         ASScs20C3ryf30Rhyvdaq0THE96xQcvRU9qRGPOwz7wX5VjIhZtQJSVBPRqT05eOKHxS
         Eb5/ArjtyFpM7HCi7G7LQhBsZ4DLrwPW9/OAckiY1aW6mhK4POUzGl6V9K5oDBFyv//j
         XfqwUeQZxZ+PwX1wTn+BfIMIgrdwHOs1gYH1fJPXIJeyNQhuAQ8ZszkkRU/mdbp5phHy
         qyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ril6mM8eHq++BAUOfHk3aWEeikdrpFxtZWvZ7zO9QRg=;
        b=a1V/5vrSVDcffXgnim+MVp/j42Gb1F9E53YouYIaqCNevTJSr4Wkp6viSUVfGlJ/GA
         /rY/z/FX0ZXVjjwqwOOI+qn6zpyZL3jui2PWzpXzU5Knl6fcHtSGu2w9iUwryrUk2vTz
         i40F9h7OrQQuo8RmV6SBbYhsmS+CxHdvQmOxKnQSxzfqi8tNG/xwzmr5jhlR8r2nW20d
         J0Wu7fP9MDSlXWnVpsiyLxRv9tjaWGHCLuh81s3G9hImiL5DY6dGWiNvnMRPo9iBX/1/
         4VQp+/XfZLWlN8LFpQtwfHLypm3N/Wp80em6NjNJfHh2j/z7SziRKUJVhwvrKGaxD+x4
         bXSA==
X-Gm-Message-State: AOAM531TJDey0KdUkO8YNpzijy1eAmx/31vbunKkr6U2RTDKnQNTKewm
        IBY6XMTmu/fAjxPDl/pldOuIoceQ5rA=
X-Google-Smtp-Source: ABdhPJykyulWdg7Brj9+hcRFRnuiRui2vd+PyMnAaNGqaM5ee1pPQhyFXHFwS5lhCvyjtsSY7+EX0Q==
X-Received: by 2002:a63:f09:: with SMTP id e9mr3706068pgl.334.1598586600598;
        Thu, 27 Aug 2020 20:50:00 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id il13sm3271523pjb.0.2020.08.27.20.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 20:49:59 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: make fibmap consistent with fiemap for compression chunk
Date:   Fri, 28 Aug 2020 12:49:53 +0900
Message-Id: <20200828034953.354267-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Currently fibmap returns zero address for compression chunk. But it
is not consistent with the output of fiemap, since fiemap returns
real pysical block address related to the compression chunk. Therefore
I suggest fibmap returns the same output with fiemap.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c1b676be67b9..8c26c5d0c778 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3708,36 +3708,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	return 0;
 }
 
-
-static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
-{
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	struct dnode_of_data dn;
-	sector_t start_idx, blknr = 0;
-	int ret;
-
-	start_idx = round_down(block, F2FS_I(inode)->i_cluster_size);
-
-	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	ret = f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
-	if (ret)
-		return 0;
-
-	if (dn.data_blkaddr != COMPRESS_ADDR) {
-		dn.ofs_in_node += block - start_idx;
-		blknr = f2fs_data_blkaddr(&dn);
-		if (!__is_valid_data_blkaddr(blknr))
-			blknr = 0;
-	}
-
-	f2fs_put_dnode(&dn);
-	return blknr;
-#else
-	return 0;
-#endif
-}
-
-
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
@@ -3753,9 +3723,6 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		filemap_write_and_wait(mapping);
 
-	if (f2fs_compressed_file(inode))
-		blknr = f2fs_bmap_compress(inode, block);
-
 	if (!get_data_block_bmap(inode, block, &tmp, 0))
 		blknr = tmp.b_blocknr;
 out:
-- 
2.28.0.402.g5ffc5be6b7-goog

