Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB7220748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="doQRivr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCZKiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:38:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45753 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgCZKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:38:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585219131; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ZvQ1jdFwqw7szV2N4aXKvGSeJpZKMjp8kiQ4LNqos/M=; b=doQRivr6mmeg5GsKW57Zb7umDIg0NV6NOmiVNnVWSSrWiQwWwlHsWI1KA/RMqf9rXIYKjRaD
 eArD76kh87lwFiQsjEVvlU4ujKuqSoFsWD5GF7cNxbzw6/39c37U1UQ5CTKsA4ryRXCB7WqJ
 9DLry68T62uQRWjdZjMOBs10XnA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c8634.7f0d2d2b5260-smtp-out-n02;
 Thu, 26 Mar 2020 10:38:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FFD8C43637; Thu, 26 Mar 2020 10:38:43 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2808C433D2;
        Thu, 26 Mar 2020 10:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2808C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: prevent meta updates while checkpoint is in progress
Date:   Thu, 26 Mar 2020 16:06:59 +0530
Message-Id: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allocate_segment_for_resize() can cause metapage updates if
it requires to change the current node/data segments for resizing.
Stop these meta updates when there is a checkpoint already
in progress to prevent inconsistent CP data.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5bca560..6122bad 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1399,8 +1399,10 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
 	int err = 0;
 
 	/* Move out cursegs from the target range */
+	f2fs_lock_op(sbi);
 	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
 		allocate_segment_for_resize(sbi, type, start, end);
+	f2fs_unlock_op(sbi);
 
 	/* do GC to move out valid blocks in the range */
 	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
