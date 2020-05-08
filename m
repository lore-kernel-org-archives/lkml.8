Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3444C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA7F2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588954254;
	bh=CngiETS7U8ogJRzhIAr/EkeUvISa1C5VP4Jj6loUtak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zz5gMDMYI+FrIAKrjsFnBDT/LojKZMjx4fDaK+BcWes/biUyERsejsGedKJ4KO0gz
	 SfT/8jmy5aCyEUXL9Dcc8Z2+coQJG+r8ctutAcQwKdrxzx/l+lxdbISee/chfQ8Ax8
	 Jx0hHEW9nGUjGBZ6LrNhpeuUo2sJnPQIUZs0oBTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEHQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgEHQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:10:53 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A6921473;
        Fri,  8 May 2020 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588954252;
        bh=CngiETS7U8ogJRzhIAr/EkeUvISa1C5VP4Jj6loUtak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oStbxdglOMtUlQGeVwfj1nbCiFYPbNAyqYsWAckLKAfCrntEbOxHnepG8AU/EuuQP
         S9Ys7M4l6CEpsTsKd7OZ5UgO6WuMZhMM73CLZu+avs+f4q6nDVoC6LcqkOORyGx2m4
         yir+WIq2rwTMo5QWsw757cHq67kWjTtLeBKTFl58=
Date:   Fri, 8 May 2020 09:10:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        stummala@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] f2fs: Avoid double lock for cp_rwsem during checkpoint
Message-ID: <20200508161052.GA49579@google.com>
References: <1588244309-1468-1-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588244309-1468-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sayali,

In order to address the perf regression, how about this?

From 48418af635884803ffb35972df7958a2e6649322 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 8 May 2020 09:08:37 -0700
Subject: [PATCH] f2fs: avoid double lock for cp_rwsem during checkpoint

There could be a scenario where f2fs_sync_node_pages gets
called during checkpoint, which in turn tries to flush
inline data and calls iput(). This results in deadlock as
iput() tries to hold cp_rwsem, which is already held at the
beginning by checkpoint->block_operations().

Call stack :

Thread A		Thread B
f2fs_write_checkpoint()
- block_operations(sbi)
 - f2fs_lock_all(sbi);
  - down_write(&sbi->cp_rwsem);

                        - open()
                         - igrab()
                        - write() write inline data
                        - unlink()
- f2fs_sync_node_pages()
 - if (is_inline_node(page))
  - flush_inline_data()
   - ilookup()
     page = f2fs_pagecache_get_page()
     if (!page)
      goto iput_out;
     iput_out:
			-close()
			-iput()
       iput(inode);
       - f2fs_evict_inode()
        - f2fs_truncate_blocks()
         - f2fs_lock_op()
           - down_read(&sbi->cp_rwsem);

Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1db8cabf727ef..626d7daca09de 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1870,8 +1870,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				goto continue_unlock;
 			}
 
-			/* flush inline_data */
-			if (is_inline_node(page)) {
+			/* flush inline_data, if it's not sync path. */
+			if (do_balance && is_inline_node(page)) {
 				clear_inline_node(page);
 				unlock_page(page);
 				flush_inline_data(sbi, ino_of_node(page));
-- 
2.26.2.645.ge9eca65c58-goog

