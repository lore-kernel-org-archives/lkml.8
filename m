Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C828FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9083020702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029103;
	bh=wWypa74ApxnbJrtT25Hj2RfEkG8HY3F1rSeh2fTUozo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ndNICg8AKa3N4Q2Cavkw6ABdHPA6t6VyER7RFEWpH5pMCVlMESfkKySf3fitFvWi5
	 IUu+jqhzxXRJEbkVqoed8JgcYmGtQ93K6KiB8162dm9oVY1qKq1auT5fnoOpMzg6Ku
	 Eb0CKSb4/UFXXenAtnG0kl6hJDWXevHedqePHo3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgHUQ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgHUQTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:19:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5763A22D3E;
        Fri, 21 Aug 2020 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026725;
        bh=wWypa74ApxnbJrtT25Hj2RfEkG8HY3F1rSeh2fTUozo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzlVBmI17jbS8pTdYpdzoJltmUjsQ1JDGQpGUEJfZYQYPt5PgYrFRAE81qnlzK18S
         MII43YMI3kt8UhWaY0HgzOMTVwAFkIpmhHDU/JZVJ6DHOAboPiZ77saB3iKnUrKjuO
         ZBAoAofbRPI84VLVmODplVVJPR+PiDbNAbr6eRm4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 29/38] f2fs: fix use-after-free issue
Date:   Fri, 21 Aug 2020 12:17:58 -0400
Message-Id: <20200821161807.348600-29-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161807.348600-1-sashal@kernel.org>
References: <20200821161807.348600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Guifu <bluce.liguifu@huawei.com>

[ Upstream commit 99c787cfd2bd04926f1f553b30bd7dcea2caaba1 ]

During umount, f2fs_put_super() unregisters procfs entries after
f2fs_destroy_segment_manager(), it may cause use-after-free
issue when umount races with procfs accessing, fix it by relocating
f2fs_unregister_sysfs().

[Chao Yu: change commit title/message a bit]

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9782250c98156..161ce0eb8891a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1004,6 +1004,9 @@ static void f2fs_put_super(struct super_block *sb)
 	int i;
 	bool dropped;
 
+	/* unregister procfs/sysfs entries in advance to avoid race case */
+	f2fs_unregister_sysfs(sbi);
+
 	f2fs_quota_off_umount(sb);
 
 	/* prevent remaining shrinker jobs */
@@ -1067,8 +1070,6 @@ static void f2fs_put_super(struct super_block *sb)
 
 	kfree(sbi->ckpt);
 
-	f2fs_unregister_sysfs(sbi);
-
 	sb->s_fs_info = NULL;
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-- 
2.25.1

