Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA3C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25892075A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588602941;
	bh=/ng91w5ahKiTgqOAq3EhJa/UEnoAexrnPLSisjkQuAo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ecm0LYMNg4oX+ooOUoBuUxumKlAw365ndvCtnFzbru+7bsl8bygRT3URu4VKcxVJj
	 v9S/p665v9NNOj17epWFt6ZyR7WN8L6rS5efYnUlF9gEa0/oP9JLAYogXR+kgcvbLO
	 VOOAHESxYl4yA1RzaiNKTywL/sZWsocxYGyuy85A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgEDOfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgEDOfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:35:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37AD120757;
        Mon,  4 May 2020 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588602940;
        bh=/ng91w5ahKiTgqOAq3EhJa/UEnoAexrnPLSisjkQuAo=;
        h=From:To:Cc:Subject:Date:From;
        b=2NcGhs1lltWrZgLGFr9nyV1si7PFTUah17Dv93Gy3acgY/eVNgCK175zt9ULoQb/V
         m7zmQId2X1c5b8NAC3lqZzGj/vy8Hw1j6pcFD5S5ZRoB9VZaS995y7lW1cNSbLcYq8
         E4dBOHOZcFo9eV6uZzbtp7zHTiF73MzO/LoHhj1A=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remove redundant check in f2fs_force_buffered_io
Date:   Mon,  4 May 2020 07:35:38 -0700
Message-Id: <20200504143538.159967-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We already checked whether the file is compressed or not in
f2fs_post_read_required(). So removed f2fs_compressed_file()
in f2fs_force_buffered_io().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6b7b963641696..01a00fc808361 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4064,8 +4064,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-	if (f2fs_compressed_file(inode))
-		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
-- 
2.26.2.526.g744177e7f7-goog

