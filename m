Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C4C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4E208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VaFoXg18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCISXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:23:32 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43393 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgCISXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:23:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583778210; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5pJKzeW4cHTF7+UFcjOH7U5y2zK8JxKCVKx6r3Uqg0I=; b=VaFoXg18mx+eIU6/tGJmMxCvtCaJd13WqGR7Cb9ywNEmfU7tAq8PKLdLR3UuPirQ9SrsgFUN
 HacxZbIodk2diw1xndeVN6BGZknLPgQ2Dfw7dtq2oih3cKSsqbwySxIVnhwRoSOY2I/qz7/o
 2Df79MZUu74UHieRN+zH6W6wANg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e66899d.7f98a0d85b58-smtp-out-n03;
 Mon, 09 Mar 2020 18:23:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DC64C44791; Mon,  9 Mar 2020 18:23:25 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85160C43636;
        Mon,  9 Mar 2020 18:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85160C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, joro@8bytes.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/3] iommu: Export "iommu_request_dm_for_dev"
Date:   Mon,  9 Mar 2020 23:52:53 +0530
Message-Id: <20200309182255.20142-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309182255.20142-1-sibis@codeaurora.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export "iommu_request_dm_for_dev" to allow for modular builds of
drivers requesting for direct mapping.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b2..06a36230fe22d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2353,6 +2353,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 {
 	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_IDENTITY);
 }
+EXPORT_SYMBOL_GPL(iommu_request_dm_for_dev);
 
 /* Request that a device can't be direct mapped by the IOMMU */
 int iommu_request_dma_domain_for_dev(struct device *dev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
