Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853DAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6442073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MvcO4R7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgCCObG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:31:06 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64110 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729432AbgCCObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:31:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583245865; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=18e/D4/+MM+g0dJtKJ/+1YUnc9WxGhoPmwqIBBQ28ds=; b=MvcO4R7VI4VJkhAvRDwR1MEkus5FHihQ0o+QyOZ2KgWUKQQAz6nExrUA4AogMo9nfgf8Wo/J
 FcwUxSKk02nl1tg6i/Eev2kUm0dHP8cRoIVodYtlCgBK+ejU0fmgdvUi09uLjYB7YxgZlacc
 pu+bH7T6dHeCO2svNpHG4xlZ0Fo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5e6a26.7fb7b2553f80-smtp-out-n02;
 Tue, 03 Mar 2020 14:31:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3926C4479C; Tue,  3 Mar 2020 14:31:02 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44DE0C433A2;
        Tue,  3 Mar 2020 14:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44DE0C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] f2fs: Add a new CP flag to help fsck fix resize SPO issues
Date:   Tue,  3 Mar 2020 19:59:26 +0530
Message-Id: <1583245766-3351-2-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583245766-3351-1-git-send-email-stummala@codeaurora.org>
References: <1583245766-3351-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and set a new CP flag CP_RESIZEFS_FLAG during
online resize FS to help fsck fix the metadata mismatch
that may happen due to SPO during resize, where SB
got updated but CP data couldn't be written yet.

fsck errors -
Info: CKPT version = 6ed7bccb
        Wrong user_block_count(2233856)
[f2fs_do_mount:3365] Checkpoint is polluted

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/checkpoint.c    | 8 ++++++--
 include/linux/f2fs_fs.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fdd7f3d..0bd4cdb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1301,10 +1301,14 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	else
 		__clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
-		is_sbi_flag_set(sbi, SBI_IS_RESIZEFS))
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
 
+	if (is_sbi_flag_set(sbi, SBI_IS_RESIZEFS))
+		__set_ckpt_flags(ckpt, CP_RESIZEFS_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_RESIZEFS_FLAG);
+
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		__set_ckpt_flags(ckpt, CP_DISABLED_FLAG);
 	else
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index ac3f488..3c383dd 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -125,6 +125,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_RESIZEFS_FLAG		0x00004000
 #define CP_DISABLED_QUICK_FLAG		0x00002000
 #define CP_DISABLED_FLAG		0x00001000
 #define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
