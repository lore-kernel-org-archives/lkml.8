Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A26020674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930298;
	bh=rOZmfox11fUmQvakmoBgObEEml7gBuYfZpBmV3cPfbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rs1SU5Wg1HkNn6sQcYLYtF7I0coksNNl/RFSCusI1WxaLdSyPrgfI3P8Aqj+geqk6
	 fAvvYD2DOEQq4EpVZ6Yl6efhmGOPpJHGzocnPia3O4HOA/P/yJ7deH1yO4R7Hy9YzT
	 8ZKepoij/RelncaQpqJpExCfTlAnzevob67aKRRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHTNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbgHTJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:32:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FB822BEF;
        Thu, 20 Aug 2020 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915954;
        bh=rOZmfox11fUmQvakmoBgObEEml7gBuYfZpBmV3cPfbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuFN5He1zIBZY4WzSuACAmtTyZjGfLjXGK3nxX4XfH0719iQjm3KnI3Nr20Ol/5Wr
         xbFw2UkudGAYMiZ5ir2TJJhmv0Jkz9gPMQ3cMo8DI6JVEujHD9wCuY7ei6zHQg5PaT
         MStcHyHllepw4lFM4l/mv/D1B1g8NXCiRvIk0nxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 163/232] f2fs: compress: fix to update isize when overwriting compressed file
Date:   Thu, 20 Aug 2020 11:20:14 +0200
Message-Id: <20200820091620.706719697@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 944dd22ea4475bd11180fd2f431a4a547ca4d8f5 ]

We missed to update isize of compressed file in write_end() with
below case:

cluster size is 16KB

- write 14KB data from offset 0
- overwrite 16KB data from offset 0

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 326c63879ddc8..6e9017e6a8197 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3432,6 +3432,10 @@ static int f2fs_write_end(struct file *file,
 	if (f2fs_compressed_file(inode) && fsdata) {
 		f2fs_compress_write_end(inode, fsdata, page->index, copied);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+
+		if (pos + copied > i_size_read(inode) &&
+				!f2fs_verity_in_progress(inode))
+			f2fs_i_size_write(inode, pos + copied);
 		return copied;
 	}
 #endif
-- 
2.25.1



