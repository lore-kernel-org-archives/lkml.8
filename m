Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8481C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCB2214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443299;
	bh=GjNpput/gcM8jX7KUPi8n1vW83BRAOzjo5dxH0l7Gb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VH0ZTWvVS09D1MLXTS0FZn+1PaMLQYvbF4O/RfKnVz9fbsze+4A8xj3R0jkb6oYTE
	 2dJoMnMuYNbc8yBojhJZLAoiAbnyblORUdpWed0zZN0LkyI6T+zmGOLsRU8fv9ytAm
	 hz3MjKDhgYY2OsAuLn6ciD/Ow3ODe1TtqYD5m3pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgFRBVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbgFRBST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:18:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2384B206F1;
        Thu, 18 Jun 2020 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443098;
        bh=GjNpput/gcM8jX7KUPi8n1vW83BRAOzjo5dxH0l7Gb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhcikRJ2+6C9hEM4B+3IuLVa85jcyZKnZSvwN98Nj7JDQ5tsHC2Layzo4n/WcF3ce
         cOIaokg/NTEChvf45T3JUgTYDymGdG6Tku9YdsDkOghJ+d3jd/kLBIchFX2jhDR3rX
         W08KgGKUFNXAINDdrg1b2lMaomNhJt66MiW+6frs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 078/266] f2fs: handle readonly filesystem in f2fs_ioc_shutdown()
Date:   Wed, 17 Jun 2020 21:13:23 -0400
Message-Id: <20200618011631.604574-78-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 8626441f05dc45a2f4693ee6863d02456ce39e60 ]

If mountpoint is readonly, we should allow shutdowning filesystem
successfully, this fixes issue found by generic/599 testcase of
xfstest.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c3a9da79ac99..5d94abe467a4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2056,8 +2056,15 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	if (in != F2FS_GOING_DOWN_FULLSYNC) {
 		ret = mnt_want_write_file(filp);
-		if (ret)
+		if (ret) {
+			if (ret == -EROFS) {
+				ret = 0;
+				f2fs_stop_checkpoint(sbi, false);
+				set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
+				trace_f2fs_shutdown(sbi, in, ret);
+			}
 			return ret;
+		}
 	}
 
 	switch (in) {
-- 
2.25.1

