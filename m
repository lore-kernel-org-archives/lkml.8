Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6291C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8756920857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="KqSX5xR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407833AbgDPGSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:18:05 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12870 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407332AbgDPGR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:17:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587017875; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Z2cB104A3VarQK23oJ8oGoWJI/nVp7NdgHxvhORaQVM=; b=KqSX5xR3xvzKr13Lr/2Lm0j27V152GjO83fiDYFdINttVGn2+7SzFB1jVCK3E8U962YdGkoR
 rWiWkMwhfvExEv/vQtvTHl5dJljLjNEhPZlxJW+JjSEtlODAEHMmP5uhCQDGpLWN6w2EHnVs
 zYF2NRFAT8ZGyPCzAMwIrvkA9i4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e97f892.7fe93db26928-smtp-out-n05;
 Thu, 16 Apr 2020 06:17:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DC998C44788; Thu, 16 Apr 2020 06:17:54 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BA3BC433F2;
        Thu, 16 Apr 2020 06:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BA3BC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Fix the accounting of dcc->undiscard_blks
Date:   Thu, 16 Apr 2020 11:47:41 +0530
Message-Id: <1587017861-6454-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a discard_cmd needs to be split due to dpolicy->max_requests, then
for the remaining length it will be either merged into another cmd or a
new discard_cmd will be created. In this case, there is double
accounting of dcc->undiscard_blks for the remaining len, due to which
it shows incorrect value in stats.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 728ff6e..1c48ec8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1214,8 +1214,10 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		len = total_len;
 	}
 
-	if (!err && len)
+	if (!err && len) {
+		dcc->undiscard_blks -= len;
 		__update_discard_tree_range(sbi, bdev, lstart, start, len);
+	}
 	return err;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
