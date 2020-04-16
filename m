Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB4D22201
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587073190;
	bh=bAJ7IG5/b71ZJq7XUCtP+ZsmvedloImlFcwjFfbRD3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EQIa5zj5Aw7sEprT7ZHiWAvN8sYtLfPdx+H7SlCChLzjg3UtmzpQU8K9WRKVhzsAw
	 Jt5aTaWQC/LOkw5xZSQsZYq9S2OAJzsnn0unN0aaVuvFhF2shFHHlQ0sIc4TrVhfKn
	 yjPV4FteBMBkGFnNWhaWaBopPQyYpkitgtLeZEf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgDPVjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDPVjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:39:46 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9129A221F9;
        Thu, 16 Apr 2020 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587073186;
        bh=bAJ7IG5/b71ZJq7XUCtP+ZsmvedloImlFcwjFfbRD3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04gKc2LhfSMOyvKmKZq0SLEhPmPuEVxpwNkVjb1PKj/NKhrZHVMz//6eT5Ku9DZ/5
         DW5vSNZJFMMLiGOV8TZIDP7gwJR04xe73MuobgQE2DHQChQ5fKNwJ3yQwHsHpntTb+
         oSUrbcVDny+B15Ypf99H+KdTMJteynxzBR2w/mcY=
Date:   Thu, 16 Apr 2020 14:39:46 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
Message-ID: <20200416213946.GA196168@google.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
f2fs_write_data_page() returns EAGAIN.
Likewise dentry blocks, we can just bypass getting the lock, since quota
blocks are also maintained by checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 - fix multipage write case

 fs/f2fs/compress.c | 2 +-
 fs/f2fs/data.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df7b2d15eacde..faaa358289010 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	if (!f2fs_trylock_op(sbi))
+	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
 		return -EAGAIN;
 
 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index accd28728642a..5c8d3823d7593 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2656,8 +2656,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 			f2fs_available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
-	/* Dentry blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode)) {
+	/* Dentry/quota blocks are controlled by checkpoint */
+	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 		goto done;
-- 
2.26.1.301.g55bc3eb7cb9-goog

