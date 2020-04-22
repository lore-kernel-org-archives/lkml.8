Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C2C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6243E20706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="v8iQQC30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgDVEUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:20:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11146 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbgDVEUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:20:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587529203; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MHoovFjqIgRjM0iNs1686zpLeAHruEipp19zTMHZoiI=; b=v8iQQC30H2Mm8eChrOJsQZnRo/YQ8Ut/N8+ReWhh6vNAeXTuW11firVW8bXuz3R3wiVM8Pm6
 iOYXEW0RZ27iVl3aYncx1giAs+YsjTkCEqOvYZUcTAxS+c6BG5SQKk4HHY7fM9uV1UZ1Y+5n
 4YOy+ZMQs2aFKjso0Bhg6/+WH90=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fc5e8.7f003bbc3998-smtp-out-n01;
 Wed, 22 Apr 2020 04:19:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D72CC4478C; Wed, 22 Apr 2020 04:19:52 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AC8BC432C2;
        Wed, 22 Apr 2020 04:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AC8BC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 3/8] bus: mhi: core: Read transfer length from an event properly
Date:   Tue, 21 Apr 2020 21:19:30 -0700
Message-Id: <1587529175-27778-4-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
References: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
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
 drivers/bus/mhi/core/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index ba8afa7..3802d3b 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -521,7 +521,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
 
 			result.buf_addr = buf_info->cb_buf;
-			result.bytes_xferd = xfer_len;
+			result.bytes_xferd =
+				min_t(u16, xfer_len, buf_info->len);
 			mhi_del_ring_element(mhi_cntrl, buf_ring);
 			mhi_del_ring_element(mhi_cntrl, tre_ring);
 			local_rp = tre_ring->rp;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
