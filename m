Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBA4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59CE2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JxO0tHdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgFZRxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:53:11 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51043 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgFZRxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:53:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593193989; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xlfKejIeWCNOCmR4gQB4q+2NKMCwGd3A49MjSQpPeyE=; b=JxO0tHdCyTUgpy2qftxuiM+Omztzusx09aL6hCTAABnXQc5ITJ8RgmXjlu8cQ64WF1AJZO4r
 ZqcJ2ptFHgqZqAKTdOL/Y/5JgEx5pTdGCrqKhEJ1EXpbsENetPr8cqqNdYZfs3fgi6i6Jk/j
 vvr8UT5lKmZICpGD14FoGf35Hws=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ef6360586de6ccd44c0c04c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 17:53:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C991C433C6; Fri, 26 Jun 2020 17:53:08 +0000 (UTC)
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BE87C433C8;
        Fri, 26 Jun 2020 17:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BE87C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH] ath10k: Register shutdown handler
Date:   Fri, 26 Jun 2020 23:23:01 +0530
Message-Id: <1593193981-30161-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of device shutdown the smmu driver will be
stopped and henceforth any IOVA address translation
will not be done. The wlan driver, being one of the
smmu driver consumer, should stop all the dma related
activity as a part of shutdown, and thereby ensuring
that no dma activity is done once the smmu driver
shuts down.

During the device shutdown, the smmu calls shutdown
for all its consumers in order to indicate them to
stop all their dma activities.

Register the shutdown handler to stop the wlan
driver and avoid any dma operations.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 354d49b..645ed5f 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1772,9 +1772,18 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void ath10k_snoc_shutdown(struct platform_device *pdev)
+{
+	struct ath10k *ar = platform_get_drvdata(pdev);
+
+	ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc shutdown\n");
+	ath10k_snoc_remove(pdev);
+}
+
 static struct platform_driver ath10k_snoc_driver = {
 	.probe  = ath10k_snoc_probe,
 	.remove = ath10k_snoc_remove,
+	.shutdown =  ath10k_snoc_shutdown,
 	.driver = {
 		.name   = "ath10k_snoc",
 		.of_match_table = ath10k_snoc_dt_match,
-- 
2.7.4

