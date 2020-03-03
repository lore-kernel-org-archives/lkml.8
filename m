Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714D5C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BA320838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jMUin6d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgCCOaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:30:14 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64110 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbgCCOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:30:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583245813; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xsbiGq1xvCtzwgAoGazDTb4j+X7Ez28B5pIvo1OsgbI=; b=jMUin6d0BWSngPdY+o/VagXqq1osVqsaMSJxZbHMZvEfFI74Y5qDQvkbvXMICgjxN0Qw5kMO
 XfFnxvwbMfzjrDfhqDaRR05Va3XmRBUvWju7sPr+GWtvRsoCI2I69wZ5+mUuFECmfIWsaihs
 KP12Qsj2KayfQl6PFyxR+7x+LMo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5e69e3.7fd8bd2a34c8-smtp-out-n02;
 Tue, 03 Mar 2020 14:29:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA9C6C447A0; Tue,  3 Mar 2020 14:29:54 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C346C43383;
        Tue,  3 Mar 2020 14:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C346C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] f2fs: Fix mount failure due to SPO after a successful online resize FS
Date:   Tue,  3 Mar 2020 19:59:25 +0530
Message-Id: <1583245766-3351-1-git-send-email-stummala@codeaurora.org>
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
v2:
add cp_mutex to protect update_fs_metadata()

 fs/f2fs/gc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a92fa49..9b6640a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1575,11 +1575,17 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		goto out;
 	}
 
+	mutex_lock(&sbi->cp_mutex);
 	update_fs_metadata(sbi, -secs);
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
+	set_sbi_flag(sbi, SBI_IS_DIRTY);
+	mutex_unlock(&sbi->cp_mutex);
+
 	err = f2fs_sync_fs(sbi->sb, 1);
 	if (err) {
+		mutex_lock(&sbi->cp_mutex);
 		update_fs_metadata(sbi, secs);
+		mutex_unlock(&sbi->cp_mutex);
 		update_sb_metadata(sbi, secs);
 		f2fs_commit_super(sbi, false);
 	}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
