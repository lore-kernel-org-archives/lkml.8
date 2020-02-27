Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5305CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B4F24680
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JkJhXN+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgB0Kj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:39:56 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:22690 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbgB0Kjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:39:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582799995; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ohDNCMzAy83upjfyUzJEOTExlxxIJl91j/cton1k8WU=; b=JkJhXN+Jp0KASkmCMQQkl04gvZcoDRECHZjjyAoNJ62RFiv46uju/QdhGkmiA+bMGUyR89En
 Obq3nUaqeXTbdBx/SBz5I7Hv9WpeD6rzsutKoPX8Wkh9SfOfYrs9tLxHvRGrcJqgKsYl72hO
 FYl/WLMQv5O6eJB+A0zgTQ0hfLY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e579c77.7f08f1739e68-smtp-out-n01;
 Thu, 27 Feb 2020 10:39:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42428C4479F; Thu, 27 Feb 2020 10:39:51 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10D07C433A2;
        Thu, 27 Feb 2020 10:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10D07C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] f2fs: Fix mount failure due to SPO after a successful online resize FS
Date:   Thu, 27 Feb 2020 16:09:37 +0530
Message-Id: <1582799978-22277-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though online resize is successfully done, a SPO immediately
after resize, still causes below error in the next mount.

[   11.294650] F2FS-fs (sda8): Wrong user_block_count: 2233856
[   11.300272] F2FS-fs (sda8): Failed to get valid F2FS checkpoint

This is because after FS metadata is updated in update_fs_metadata()
if the SBI_IS_DIRTY is not dirty, then CP will not be done to reflect
the new user_block_count.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a92fa49..a14a75f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1577,6 +1577,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 
 	update_fs_metadata(sbi, -secs);
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
+	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	err = f2fs_sync_fs(sbi->sb, 1);
 	if (err) {
 		update_fs_metadata(sbi, secs);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
