Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D90206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bcG2zv61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgFARZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:25:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57873 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFARZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:25:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591032299; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Hi0C0mZan+3QLEFxLhKYYooAuOtgtwF2alU1JfOuQlE=; b=bcG2zv61U+BDuJj5j7QIzGNgU/Ra7Zb1gP67SuncplMeGuvm1+5d/XVwTuBV1lxfePu4Tz2B
 H30yctQkqdeOlgdAVgjGoSvh4JelVaTPM6avBFKz6q9ajhSg9TUPvCoXfiHvvE8pzc5yoBOG
 owrGKzj454NC+mDH3oA5B16oIAE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ed539d42c54998475a1e180 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Jun 2020 17:24:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79189C43391; Mon,  1 Jun 2020 17:24:35 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA803C433C9;
        Mon,  1 Jun 2020 17:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA803C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv2] coresight: tmc: Add shutdown callback for TMC ETR/ETF
Date:   Mon,  1 Jun 2020 22:54:24 +0530
Message-Id: <20200601172424.21131-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a shutdown callback to ensure ETR/ETF hardware is
properly shutdown in reboot/shutdown path. This is required
for ETR/ETF which has SMMU address translation enabled like
on SC7180 SoC and few others. If the hardware is still accessing
memory after SMMU translation is disabled as part of SMMU
shutdown callback in system reboot or shutdown path, then
IOVAs(I/O virtual address) which it was using will go on the bus
as the physical addresses which might result in unknown crashes
(NoC/interconnect errors). So we make sure from this shutdown
callback that the ETR/ETF is shutdown before SMMU translation is
disabled and device_link in SMMU driver will take care of ordering
of shutdown callbacks such that SMMU shutdown callback is not
called before any of its consumer shutdown callbacks.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---

Changes since v1:
 * Use mode flag and drop enable flag as Mike suggested.
 * Use spinlock before tmc hw disable as Mike suggested.

---
 .../hwtracing/coresight/coresight-tmc-etf.c   |  4 +--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   | 33 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  3 ++
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 36cce2bfb744..cba3e7592820 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -85,7 +85,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	__tmc_etb_disable_hw(drvdata);
 	coresight_disclaim_device(drvdata->base);
@@ -118,7 +118,7 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	return 0;
 }
 
-static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
+void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 625882bc8b08..b29c2db94d96 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1110,7 +1110,7 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 }
 
-static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 39fba1d16e6e..c7902ce0bd3b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -538,6 +538,38 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static void tmc_shutdown(struct amba_device *adev)
+{
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = amba_get_drvdata(adev);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	if (drvdata->mode == CS_MODE_DISABLED)
+		goto out;
+
+	/*
+	 * We do not care about the active trace sessions here
+	 * since the system is going down unlike remove callback,
+	 * just make sure that the hardware is shutdown.
+	 */
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
+		tmc_etb_disable_hw(drvdata);
+		break;
+	case TMC_CONFIG_TYPE_ETF:
+		tmc_etf_disable_hw(drvdata);
+		break;
+	case TMC_CONFIG_TYPE_ETR:
+		tmc_etr_disable_hw(drvdata);
+	}
+
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	misc_deregister(&drvdata->miscdev);
+	coresight_unregister(drvdata->csdev);
+}
+
 static const struct amba_id tmc_ids[] = {
 	CS_AMBA_ID(0x000bb961),
 	/* Coresight SoC 600 TMC-ETR/ETS */
@@ -556,6 +588,7 @@ static struct amba_driver tmc_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= tmc_probe,
+	.shutdown	= tmc_shutdown,
 	.id_table	= tmc_ids,
 };
 builtin_amba_driver(tmc_driver);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 71de978575f3..0a77f2f25090 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -260,6 +260,8 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata);
+void tmc_etb_disable_hw(struct tmc_drvdata *drvdata);
+void tmc_etf_disable_hw(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etb_cs_ops;
 extern const struct coresight_ops tmc_etf_cs_ops;
 
@@ -268,6 +270,7 @@ ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
 /* ETR functions */
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
+void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etr_cs_ops;
 ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 				loff_t pos, size_t len, char **bufpp);

base-commit: 059e38815950dbec65beafe03757bce9436e89a4
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

