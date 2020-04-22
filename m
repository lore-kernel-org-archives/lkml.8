Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C9C38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F93820706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qy7iQExj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgDVEUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:20:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18549 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbgDVEUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:20:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587529200; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9ajINjyxVnZz0xrqD52l756TPDsznJMo9dg0aqFR6yM=; b=qy7iQExjREr2AxZ/Gd4BG6xJUE5pf03dTdLkXNeDLNy1S4rxGcozoPpgM3vcPxUeXW96zoL8
 3DUi6CTu5yD3qv+Ic41u6G2Op449fnH+N2vXcPIJ5hzPWN7Wmi+TtHUI7YjfQsHlFwL/kAyj
 jZtfR5l9aEf7KhlszR0si5lz2pc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fc5e6.7fc3729ee8f0-smtp-out-n03;
 Wed, 22 Apr 2020 04:19:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 548A7C433F2; Wed, 22 Apr 2020 04:19:50 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9DE9C433D2;
        Wed, 22 Apr 2020 04:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9DE9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 1/8] bus: mhi: core: Cache intmod from mhi event to mhi channel
Date:   Tue, 21 Apr 2020 21:19:28 -0700
Message-Id: <1587529175-27778-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
References: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Driver is using zero initialized intmod value from mhi channel when
configuring TRE for bei field. This prevents interrupt moderation to
take effect in case it is supported by an event ring. Fix this by
copying intmod value from associated event ring to mhi channel upon
registering mhi controller.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 4 ++++
 drivers/bus/mhi/core/main.c | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index b38359c..4dc7f22 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -864,6 +864,10 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 		mutex_init(&mhi_chan->mutex);
 		init_completion(&mhi_chan->completion);
 		rwlock_init(&mhi_chan->lock);
+
+		/* used in setting bei field of TRE */
+		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+		mhi_chan->intmod = mhi_event->intmod;
 	}
 
 	if (mhi_cntrl->bounce_buf) {
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index eb4256b..23154f1 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -929,7 +929,7 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
 	struct mhi_buf_info *buf_info;
 	struct mhi_tre *mhi_tre;
-	int ret;
+	int ret, bei;
 
 	/* If MHI host pre-allocates buffers then client drivers cannot queue */
 	if (mhi_chan->pre_alloc)
@@ -966,10 +966,11 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 		goto map_error;
 
 	mhi_tre = tre_ring->wp;
+	bei = !!(mhi_chan->intmod);
 
 	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
 	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
-	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, 1, 0, 0);
 
 	/* increment WP */
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
@@ -1006,6 +1007,7 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
 	struct mhi_buf_info *buf_info;
 	struct mhi_tre *mhi_tre;
+	int bei;
 
 	/* If MHI host pre-allocates buffers then client drivers cannot queue */
 	if (mhi_chan->pre_alloc)
@@ -1043,10 +1045,11 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	buf_info->len = len;
 
 	mhi_tre = tre_ring->wp;
+	bei = !!(mhi_chan->intmod);
 
 	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
 	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
-	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, 1, 0, 0);
 
 	/* increment WP */
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
