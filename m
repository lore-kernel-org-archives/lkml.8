Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F1C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAD1214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qNwQ3uC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgD0SdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:33:01 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58322 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgD0Scc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:32:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588012352; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AVtHSmM65NemhBiR570J5CFVZSoe+CaOJF5K6Fa9wIU=; b=qNwQ3uC6+Z42mVN78Sd8x1fH09HW6G3Fn24gP79Pza3ZDUcgHZG9l7xiMXLcx4exL8PsN86n
 spW489zZ0scsNxqQ9apLp+kRKoFOGLOWwIzcgQXCEYu8YIArZreh0lZ0O4eLNFEZfuvbXmiU
 oBszMuWrER+5YrHGCp7YeEm0YFs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7253e.7f19ca052fb8-smtp-out-n04;
 Mon, 27 Apr 2020 18:32:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDA4CC433F2; Mon, 27 Apr 2020 18:32:30 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43DC5C433CB;
        Mon, 27 Apr 2020 18:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43DC5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
Subject: [PATCH v1 3/8] bus: mhi: core: Read transfer length from an event properly
Date:   Mon, 27 Apr 2020 11:32:17 -0700
Message-Id: <1588012342-4995-4-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588012342-4995-1-git-send-email-bbhatt@codeaurora.org>
References: <1588012342-4995-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

When MHI Driver receives an EOT event, it reads xfer_len from the
event in the last TRE. The value is under control of the MHI device
and never validated by Host MHI driver. The value should never be
larger than the real size of the buffer but a malicious device can
set the value 0xFFFF as maximum. This causes device to memory
overflow (both read or write). Fix this issue by reading minimum of
transfer length from event and the buffer length provided.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index ba8afa7..196908d0 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -521,7 +521,10 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
 
 			result.buf_addr = buf_info->cb_buf;
-			result.bytes_xferd = xfer_len;
+
+			/* truncate to buf len if xfer_len is larger */
+			result.bytes_xferd =
+				min_t(u16, xfer_len, buf_info->len);
 			mhi_del_ring_element(mhi_cntrl, buf_ring);
 			mhi_del_ring_element(mhi_cntrl, tre_ring);
 			local_rp = tre_ring->rp;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
