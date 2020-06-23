Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F96C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C032072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948291;
	bh=xgwZj8gIUGzkapX5cKJY29Sr1V/4lZzfioa+JJYQN3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpM6OsGIBkdpmzWDUDnv3bc6GSuH09FGM7q72BEk/xk72yWLR53MBVVNzj9Tu3E6y
	 ojDyyYw5q/ZURzh5FQAAQVV0EX0KZ1v1aaDyTx/Kb4cGSHadS4TK6NfLlizHsD3jPo
	 LCiQXd7tNwVpW9KdUCwSKwOjUzcvkA/Xcl+AAqD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393779AbgFWViI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388080AbgFWUId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:08:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076B52064B;
        Tue, 23 Jun 2020 20:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942912;
        bh=xgwZj8gIUGzkapX5cKJY29Sr1V/4lZzfioa+JJYQN3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iNVnRJM445IMiYpGYqH5VDv8RASVd+tBR04Z3IqcpEyvXc/q2sQ5PYveqyt0dFC1
         UUtFzIKW1w788UmBosjtVq85/ko2OWv/W1MUkCxFB5+qGbhia9PaqD/x3dBoq7qJez
         jpJ8j2Nx5hXxccH9ziBCZqk+0xsyeW9ay4hok/DU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 185/477] f2fs: Fix wrong stub helper update_sit_info
Date:   Tue, 23 Jun 2020 21:53:02 +0200
Message-Id: <20200623195416.331292884@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 48abe91ac1ad27cd5a5709f983dcf58f2b9a6b70 ]

update_sit_info should be f2fs_update_sit_info,
otherwise build fails while no CONFIG_F2FS_STAT_FS.

Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7c5dd7f666a01..a15e93f15b6ac 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3656,7 +3656,7 @@ static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
 static inline void __init f2fs_create_root_stats(void) { }
 static inline void f2fs_destroy_root_stats(void) { }
-static inline void update_sit_info(struct f2fs_sb_info *sbi) {}
+static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
 
 extern const struct file_operations f2fs_dir_operations;
-- 
2.25.1



