Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D16C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6355E20774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iq5xDJyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbgDODb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:31:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28015 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgDODby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:31:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586921513; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MKy8Tu7gkaN05KHcqWvWLn00l3sUgPhsFIeSFjRZ1ZY=; b=iq5xDJyJl6SM10eT3ZznTtO2pkgC0UZXZPjSDiHH+ms13tMaZZinGEFSJqZFn43TVW9NXTAu
 BvwWAo1iE2a/73zk5eVrsyorDIRGaJxVjF2z46yjLHHH9pXe7rfsJ9YnVkrNCJj5zeprR5Co
 D0HusCF0SyI5vcxu5oWiIK0Xgms=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e968009.7f330a46ca78-smtp-out-n05;
 Wed, 15 Apr 2020 03:31:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 458E1C43636; Wed, 15 Apr 2020 03:31:20 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2789C433F2;
        Wed, 15 Apr 2020 03:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2789C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] f2fs: fix long latency due to discard during umount
Date:   Wed, 15 Apr 2020 09:01:02 +0530
Message-Id: <1586921462-12972-1-git-send-email-stummala@codeaurora.org>
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
v4:
-Implement as per Jaegeuk's Suggestion to control the number of
outstanding discard requests.

 fs/f2fs/segment.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1a62b27..764bab5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1099,7 +1099,6 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	} else if (discard_type == DPOLICY_FSTRIM) {
 		dpolicy->io_aware = false;
 	} else if (discard_type == DPOLICY_UMOUNT) {
-		dpolicy->max_requests = UINT_MAX;
 		dpolicy->io_aware = false;
 		/* we need to issue all to keep CP_TRIMMED_FLAG */
 		dpolicy->granularity = 1;
@@ -1470,12 +1469,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	int i, issued = 0;
+	int i, issued;
 	bool io_interrupted = false;
 
 	if (dpolicy->timeout != 0)
 		f2fs_update_time(sbi, dpolicy->timeout);
 
+retry:
+	issued = 0;
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (dpolicy->timeout != 0 &&
 				f2fs_time_over(sbi, dpolicy->timeout))
@@ -1522,6 +1523,11 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
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
