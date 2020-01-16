Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB30C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E0020730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vI7ntw2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbgAPREz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:04:55 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:19036 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388270AbgAPREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:04:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579194290; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UfFifIJGILW8fksowAx6Kk3INRhbwc4+MMjSyJxB8xw=; b=vI7ntw2/WQr4RidiWTlyhtW6ThJYLBUH+wyO5g5htniy0Cs6JQLpIkELb8l5wmO6OXRc75IV
 Wnw4QuBz1Er6Jcl9OhU3o8qnRmCcl1qge0Zbzm0u1/RlRYF90cHef39QA7cmJUBjgh7mZv2Z
 4tqyVTf5eyJdZ7kXYD03Fox9o8U=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2097b1.7fd1ec3b7ea0-smtp-out-n02;
 Thu, 16 Jan 2020 17:04:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79440C447A9; Thu, 16 Jan 2020 17:04:48 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B4E0C447AE;
        Thu, 16 Jan 2020 17:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B4E0C447AE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 1/2] mmc: sdhci: Let a vendor driver supply and update ADMA descriptor size
Date:   Thu, 16 Jan 2020 22:33:10 +0530
Message-Id: <1579194192-7942-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579194192-7942-1-git-send-email-vbadigan@codeaurora.org>
References: <1579194192-7942-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let a vendor driver supply the maximum descriptor size that it
can operate on. ADMA descriptor table would be allocated using this
supplied size.
If any SD Host controller is of version prior to v4.10 spec
but supports 16byte descriptor, this change allows them to supply
correct descriptor size for ADMA table allocation.

Also let a vendor driver update the descriptor size by overriding
sdhc_host->desc_size if it has to operates on a different descriptor
sizes in different conditions.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 7 +++++--
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3140fe2..19a5ad3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3822,9 +3822,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 		void *buf;
 
 		if (host->flags & SDHCI_USE_64_BIT_DMA) {
+			if (!host->alloc_desc_sz)
+				host->alloc_desc_sz =
+					SDHCI_ADMA2_64_DESC_SZ(host);
+			host->desc_sz = host->alloc_desc_sz;
 			host->adma_table_sz = host->adma_table_cnt *
-					      SDHCI_ADMA2_64_DESC_SZ(host);
-			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ(host);
+					      host->desc_sz;
 		} else {
 			host->adma_table_sz = host->adma_table_cnt *
 					      SDHCI_ADMA2_32_DESC_SZ;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0ed3e0e..8e7c77d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -555,6 +555,7 @@ struct sdhci_host {
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
 
 	unsigned int desc_sz;	/* ADMA descriptor size */
+	unsigned int alloc_desc_sz;	/* ADMA descr. max size host supports */
 
 	struct workqueue_struct *complete_wq;	/* Request completion wq */
 	struct work_struct	complete_work;	/* Request completion work */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
