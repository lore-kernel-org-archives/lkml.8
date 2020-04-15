Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF265C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42CB20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aP0tHhb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDOEGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:06:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28814 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbgDOEG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:06:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586923589; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oLbhlgZzFDibP9R9n4hBuNeeF1cgEDuQEqH3Hj43Rl0=; b=aP0tHhb9InX6jmFOcQwp12MqzeoRPJ8AwuK3sQijNy8bYDFLndO4PtC8sMgMDokCVj+tYKj5
 pI6SJ1lAmu4Jn7fZF2z+GQHKLLDyVuSPU8uphgvgMMhs3IBgM8S89x0awywhV39WM9bxPSTR
 AF/digVaqhduNz5u8JJgDpUlXTM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e968840.7f06d4c1b998-smtp-out-n01;
 Wed, 15 Apr 2020 04:06:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1035BC432C2; Wed, 15 Apr 2020 04:06:23 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F5CFC433CB;
        Wed, 15 Apr 2020 04:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F5CFC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: report the discard cmd errors properly
Date:   Wed, 15 Apr 2020 09:35:54 +0530
Message-Id: <1586923554-30257-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a discard_cmd is split into several bios, the dc->error
must not be overwritten once an error is reported by a bio. Also,
move it under dc->lock.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bd6dd19..745e4dd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1031,9 +1031,9 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
 	unsigned long flags;
 
-	dc->error = blk_status_to_errno(bio->bi_status);
-
 	spin_lock_irqsave(&dc->lock, flags);
+	if (!dc->error)
+		dc->error = blk_status_to_errno(bio->bi_status);
 	dc->bio_ref--;
 	if (!dc->bio_ref && dc->state == D_SUBMIT) {
 		dc->state = D_DONE;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
