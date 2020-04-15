Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF6C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6A8206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EcKwGjHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408301AbgDOJIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:08:15 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42851 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408281AbgDOJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:08:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586941686; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zS4c6L0D9jU2WBM14Jk1In+hYKeTXj+XmH473wOiYXQ=; b=EcKwGjHHKnalna0q/Sb1Cn+1jJXG3ZpOiS+rCDL+oF9jAvslWGFYXCd+nDDJITHY0y9St0Sf
 q0f+euySs9sdfwi7c+aejMD4VwG8q7bYh2PGsNfyDAwjxdzPQCIumleRa7DjLpulII7bBRf1
 V+dyQI1JILsoWSW72LVsauwTg9g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96cef6.7f37d1eac500-smtp-out-n02;
 Wed, 15 Apr 2020 09:08:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EDD4C433CB; Wed, 15 Apr 2020 09:08:05 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC877C433F2;
        Wed, 15 Apr 2020 09:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC877C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] f2fs: fix long latency due to discard during umount
Date:   Wed, 15 Apr 2020 14:37:53 +0530
Message-Id: <1586941673-4296-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2FS already has a default timeout of 5 secs for discards that
can be issued during umount, but it can take more than the 5 sec
timeout if the underlying UFS device queue is already full and there
are no more available free tags to be used. Fix this by submitting a
small batch of discard requests so that it won't cause the device
queue to be full at any time and thus doesn't incur its wait time
in the umount context.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v5:
- rebase on Jaegeuk's dev branch.
- add a missing change to fix compilation issue.

 fs/f2fs/segment.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b7a9421..90c7582 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1101,7 +1101,6 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	} else if (discard_type == DPOLICY_FSTRIM) {
 		dpolicy->io_aware = false;
 	} else if (discard_type == DPOLICY_UMOUNT) {
-		dpolicy->max_requests = UINT_MAX;
 		dpolicy->io_aware = false;
 		/* we need to issue all to keep CP_TRIMMED_FLAG */
 		dpolicy->granularity = 1;
@@ -1463,6 +1462,8 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 
 	return issued;
 }
+static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
+					struct discard_policy *dpolicy);
 
 static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy)
@@ -1471,12 +1472,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	int i, issued = 0;
+	int i, issued;
 	bool io_interrupted = false;
 
 	if (dpolicy->timeout)
 		f2fs_update_time(sbi, UMOUNT_DISCARD_TIMEOUT);
 
+retry:
+	issued = 0;
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (dpolicy->timeout &&
 				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
@@ -1523,6 +1526,11 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 	}
 
+	if (dpolicy->type == DPOLICY_UMOUNT && issued) {
+		__wait_all_discard_cmd(sbi, dpolicy);
+		goto retry;
+	}
+
 	if (!issued && io_interrupted)
 		issued = -1;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
