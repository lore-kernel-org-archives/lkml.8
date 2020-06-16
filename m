Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F74FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0832074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JeGw9guT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFPE5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:57:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:51803 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgFPE5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:57:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592283433; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=xj0QXgPdzyD1jjd0ssAYzkZjR6nTCw3RYzCQM0RrXN4=; b=JeGw9guT7XsuLnaG0XzEDrT+pUV6YC1GpI7tw3OOfa9EP5SCAsZ1qtb8Pl6tulMNIdvjm87z
 EveaB91PQzSIqiVa74O4w0zPy1lT1TUNL3ua8pQ1lQdScIe6ZajU724+gl8g4Rh7FwEBF0HM
 yvzYl2myOfHIZz1bFjobeQcDAEc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5ee8510c3a8a8b20b8a74f97 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 04:56:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3DCCBC433CB; Tue, 16 Jun 2020 04:56:44 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A0CFC433CA;
        Tue, 16 Jun 2020 04:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A0CFC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv3] coresight: tmc: Add shutdown callback for TMC ETR
Date:   Tue, 16 Jun 2020 10:26:23 +0530
Message-Id: <20200616045623.27549-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a shutdown callback to ensure ETR hardware is
properly shutdown in reboot/shutdown path. This is required
for ETR which has SMMU address translation enabled like on
SC7180 SoC and few others. If the hardware is still accessing
memory after SMMU translation is disabled as part of SMMU
shutdown callback in system reboot or shutdown path, then
IOVAs(I/O virtual address) which it was using will go on the
bus as the physical addresses which might result in unknown
crashes (NoC/interconnect errors). So we make sure from this
shutdown callback that the ETR is shutdown before SMMU translation
is disabled and device_link in SMMU driver will take care of
ordering of shutdown callbacks such that SMMU shutdown callback
is not called before any of its consumer shutdown callbacks.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---

Changes since v2:
 * Remove ETF/ETB disable as suggested by Mathieu and Mike since they are
   not really affected.
 * Remove coresight and misc device unregister since it is not required
   for shutdown callback unlike remove callback and userspace is long gone
   by this time.

Changes since v1:
 * Use mode flag and drop enable flag as Mike suggested.
 * Use spinlock before tmc hw disable as Mike suggested.

---
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   | 23 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

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
index 39fba1d16e6e..b13ce0daa572 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -538,6 +538,28 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
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
+	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
+		tmc_etr_disable_hw(drvdata);
+
+	/*
+	 * We do not care about coresight unregister here unlike remove
+	 * callback which is required for making coresight modular since
+	 * the system is going down after this.
+	 */
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+}
+
 static const struct amba_id tmc_ids[] = {
 	CS_AMBA_ID(0x000bb961),
 	/* Coresight SoC 600 TMC-ETR/ETS */
@@ -556,6 +578,7 @@ static struct amba_driver tmc_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= tmc_probe,
+	.shutdown	= tmc_shutdown,
 	.id_table	= tmc_ids,
 };
 builtin_amba_driver(tmc_driver);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 71de978575f3..6e8d2dc33d17 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -268,6 +268,7 @@ ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
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

