Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F89C433FB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87F1206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bElg8rDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgGULab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:30:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46084 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgGULab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:30:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595331030; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nrkNuNw1lRRN+p0ZtQbqwTSh1esmGCxh/ZiccjsxXhU=; b=bElg8rDWFHHxBMox9PurwWQyfhZxBsQpBFF0wWxCTT16CWLntbldj6y1s7KsSzpWKKlLYo/f
 YTn6TaO6/1P9iNVh/W6Bc6CFq82WJw7NOFU1ryfBVafaFs/gKPA9/ZLDhd0QUbg3gxqDWhiN
 5ty+N9akSaWrk/tku5phcZncpP0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f16d1b4e3bee12510e68887 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 11:29:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 012ECC43395; Tue, 21 Jul 2020 11:29:56 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B9B9C43391;
        Tue, 21 Jul 2020 11:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B9B9C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, ohad@wizery.com,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 1/2] remoteproc: qcom_q6v5_mss: Add modem debug policy support
Date:   Tue, 21 Jul 2020 16:59:34 +0530
Message-Id: <20200721112935.25716-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721112935.25716-1-sibis@codeaurora.org>
References: <20200721112935.25716-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add modem debug policy support which will enable coredumps and live
debug support when the msadp firmware is present on secure devices.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v2:
 * Use request_firmware_direct [Bjorn]
 * Use Bjorn's template to show if debug policy is present
 * Add size check to prevent memcpy out of bounds [Bjorn]

 drivers/remoteproc/qcom_q6v5_mss.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 0b6f260eb5349..49cd16e050533 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -189,6 +189,7 @@ struct q6v5 {
 	phys_addr_t mba_phys;
 	void *mba_region;
 	size_t mba_size;
+	size_t dp_size;
 
 	phys_addr_t mpss_phys;
 	phys_addr_t mpss_reloc;
@@ -408,6 +409,14 @@ static int q6v5_xfer_mem_ownership(struct q6v5 *qproc, int *current_perm,
 static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct q6v5 *qproc = rproc->priv;
+	const struct firmware *dp_fw;
+
+	if (!request_firmware_direct(&dp_fw, "msadp", qproc->dev) && fw->size <= SZ_1M &&
+	    (SZ_1M + dp_fw->size) <= qproc->mba_size) {
+		memcpy(qproc->mba_region + SZ_1M, dp_fw->data, dp_fw->size);
+		qproc->dp_size = dp_fw->size;
+		release_firmware(dp_fw);
+	}
 
 	memcpy(qproc->mba_region, fw->data, fw->size);
 
@@ -896,6 +905,10 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 	}
 
 	writel(qproc->mba_phys, qproc->rmb_base + RMB_MBA_IMAGE_REG);
+	if (qproc->dp_size) {
+		writel(qproc->mba_phys + SZ_1M, qproc->rmb_base + RMB_PMI_CODE_START_REG);
+		writel(qproc->dp_size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
+	}
 
 	ret = q6v5proc_reset(qproc);
 	if (ret)
@@ -1257,7 +1270,8 @@ static int q6v5_start(struct rproc *rproc)
 	if (ret)
 		return ret;
 
-	dev_info(qproc->dev, "MBA booted, loading mpss\n");
+	dev_info(qproc->dev, "MBA booted with%s debug policy, loading mpss\n",
+		 qproc->dp_size ? "" : "out");
 
 	ret = q6v5_mpss_load(qproc);
 	if (ret)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

