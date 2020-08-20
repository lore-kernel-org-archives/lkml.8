Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C6AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D720207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916493;
	bh=YwCUYJ3M+NOBCMTGQwF6bnEEU2OBYP4CIDFQrvVrv8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ybr8GFqaqRdiUElvQXwXc+iOZgWyhG/usmMY8zYqQPdztf8x9b+4HOZWRrXPeEvlB
	 a1id2h4ClQxDIWkPiDwAIdXAyR047yDvO+Wm77G2glA8hx2IpzEl4uraTI79DkJgJW
	 FcoQqCd7gJdM6BAsn6Mh4aDCRBnspKb5MtZWDH9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgHTJlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgHTJlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:41:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264AD20724;
        Thu, 20 Aug 2020 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916478;
        bh=YwCUYJ3M+NOBCMTGQwF6bnEEU2OBYP4CIDFQrvVrv8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1+4pzc6Gm3C9zwCfAmQqAAsgtXsbgVAA9jfHtrQl1w9v+pDD8Y7fyBMrrTUGaENn
         ZzXLceSHuwGWC3WQXJZiMLk9Za4SPNbtglOvMuSQdp/tngXfjM/G1Hiorjbn3Nj3T6
         RZWKgYXGrRtS1MweUhDiPNlAvq1Cu/6bheaNcep0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 142/204] f2fs: compress: fix to update isize when overwriting compressed file
Date:   Thu, 20 Aug 2020 11:20:39 +0200
Message-Id: <20200820091613.347167633@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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
index 10491ae1cb850..329afa55a581c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3353,6 +3353,10 @@ static int f2fs_write_end(struct file *file,
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



