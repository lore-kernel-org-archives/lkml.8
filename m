Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2C0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7576A20776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448446;
	bh=BbJ617bFOG+Jd2fPEGqvE+hziquN3k6VXqs2Y9KUipg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CwFPvZi8ydTdzFoXYk/2LZu6xap1CMCYkN/gcmmfExS4HWFkicCeJ5vVSbPrqrCNT
	 I6o60ExTyvy0MwjNv9Ik72nrliYMt3lD/O8tMkTeaDLohfb2mxOMwJy6WApccDSt8y
	 wdEbFrQ22+grZWEJ2oSF6O4m/tJd9uBB1C+Ca1kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgFRCrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgFRBKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C6F20CC7;
        Thu, 18 Jun 2020 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442621;
        bh=BbJ617bFOG+Jd2fPEGqvE+hziquN3k6VXqs2Y9KUipg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q941rdESgU4LRztrie8L0aE0drD7vLvHqiHCq+8TbJ1JYPfbZkISTHmWmQ5cQrQX4
         ML7Q9U6sZad9VMH9Gpz0/fIOT4eD4j7+swDZYSgGE3PzkcGvankFjOgbtdaPPYMguK
         +ey2uMtitT4hNVsswLdA36s4O/biOe4D/w67URT4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.7 101/388] f2fs: handle readonly filesystem in f2fs_ioc_shutdown()
Date:   Wed, 17 Jun 2020 21:03:18 -0400
Message-Id: <20200618010805.600873-101-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
index 6ab8f621a3c5..30b35915fa3a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2219,8 +2219,15 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
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

