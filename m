Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2993C55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D102F20706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="uU+VPUI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgDVEUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:20:01 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:26751 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgDVET6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:19:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587529198; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CxXWapujNQU/nOx131lQ2pkM22nSN7vNLoN5yDLlLUQ=; b=uU+VPUI6Qf7YBUi7TXS6aJthlM5oKiIpVCm+oPYXD3JdmOcFFmv+OO1PfTYRZPHXF4xqQS4v
 G0XrMtNT2XsRfkzMqVXAKjYSsTCHa1Oirt0s/YyW1dLVvkiAz5Zmih/VnZyqi3g9fC7Y9ClQ
 mAy8EgUUtBJdH3mFie2DC5a6xwA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fc5e8.7f56eb539688-smtp-out-n01;
 Wed, 22 Apr 2020 04:19:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77721C432C2; Wed, 22 Apr 2020 04:19:52 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B8EFC43636;
        Wed, 22 Apr 2020 04:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B8EFC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 8/8] bus: mhi: core: Ensure non-zero session or sequence ID values
Date:   Tue, 21 Apr 2020 21:19:35 -0700
Message-Id: <1587529175-27778-9-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
References: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While writing any sequence or session identifiers, it is possible that
the host could write a zero value, whereas only non-zero values are
supported writes to those registers. Ensure that host does not write a
non-zero value for those cases.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 0bc9c50..c9971d4 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -199,6 +199,9 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
 
 	sequence_id = prandom_u32() & BHIE_TXVECSTATUS_SEQNUM_BMSK;
+	if (unlikely(!sequence_id))
+		sequence_id = 1;
+
 	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
 			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
 			    sequence_id);
@@ -254,6 +257,9 @@ static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
 		      lower_32_bits(dma_addr));
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
 	session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
+	if (unlikely(!session_id))
+		session_id = 1;
+
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
 	read_unlock_bh(pm_lock);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
