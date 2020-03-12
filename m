Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7722CC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4435B2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="l3oOOhXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCLLPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:15:05 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:50401 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgCLLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:15:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584011704; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=JvY4YuFQKu3F3qg6UDk12ZxFyQvOOD4Ta+PnExuPT7Y=; b=l3oOOhXEjJEza6v6HJ50yNQuJlrgWoBo21ATD5uR6hkCF2PSw+fFUFD3e+uUXfzbOERG6V7E
 h/jCuK7WzftqhSGTh0FF35d+XhYxoKT0PE899QgxSC+Fk4Rohbd6hY9fRaGuzEv9EmL9i9R+
 U3eCbWq2PKNP8p7XXu2o5GFB1aI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a19a4.7fcdc5e9ae68-smtp-out-n01;
 Thu, 12 Mar 2020 11:14:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6341C433D2; Thu, 12 Mar 2020 11:14:43 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE765C433CB;
        Thu, 12 Mar 2020 11:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE765C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix long latency due to discard during umount
Date:   Thu, 12 Mar 2020 16:44:31 +0530
Message-Id: <1584011671-20939-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2FS already has a default timeout of 5 secs for discards that
can be issued during umount, but it can take more than the 5 sec
timeout if the underlying UFS device queue is already full and there
are no more available free tags to be used. In that case, submit_bio()
will wait for the already queued discard requests to complete to get
a free tag, which can potentially take way more than 5 sec.

Fix this by submitting the discard requests with REQ_NOWAIT
flags during umount. This will return -EAGAIN for UFS queue/tag full
scenario without waiting in the context of submit_bio(). The FS can
then handle these requests by retrying again within the stipulated
discard timeout period to avoid long latencies.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fb3e531..a06bbac 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1124,10 +1124,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	int flag = dpolicy->sync ? REQ_SYNC : 0;
+	int flag;
 	block_t lstart, start, len, total_len;
 	int err = 0;
 
+	flag = dpolicy->sync ? REQ_SYNC : 0;
+	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
+
 	if (dc->state != D_PREP)
 		return 0;
 
@@ -1203,6 +1206,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		bio->bi_end_io = f2fs_submit_discard_endio;
 		bio->bi_opf |= flag;
 		submit_bio(bio);
+		if ((flag & REQ_NOWAIT) && (dc->error == -EAGAIN)) {
+			dc->state = D_PREP;
+			err = dc->error;
+			break;
+		}
 
 		atomic_inc(&dcc->issued_discard);
 
@@ -1510,6 +1518,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			}
 
 			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
+			if (dc->error == -EAGAIN) {
+				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				__relocate_discard_cmd(dcc, dc);
+			}
 
 			if (issued >= dpolicy->max_requests)
 				break;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
