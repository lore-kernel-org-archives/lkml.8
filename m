Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FD9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FB02073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WenEuPK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgFVTT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgFVTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:19:38 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC0FC061798
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a3so16671180oid.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7aDthwfVK4X3zkJhuLT621NaM0SCkvfXrIC1UxtpAo=;
        b=WenEuPK6bKXoYKUBm6U9eecNOGvp86TCjIZoXl3kBie5ZlBhBi3X9FaoFd37hzOryK
         OVZlz5nI+SiAwjF8/4hP409pvaRsGuQWHCSWwt8YSFLg8iRRlT9T0XVMW3qWtzB4GhFb
         Uer2+myuvaAUczwiSayX0x23mbIqILkrv+M4ixrOZVQpYCqI0oUeI6j1CzOivKnRtU0k
         DqrPipdWM+uuuzFRghGAoqzCLO5nGhWaFvyGyDf7se1G0OUTigri/GRNOF9cLe95WbpO
         LTUp6XaxBfkDE8cIFp3yW+qFWJUF3Gme3V8f2ZCfVJO35BcLi1YAw+Qx9trEa9mHkPm1
         7+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7aDthwfVK4X3zkJhuLT621NaM0SCkvfXrIC1UxtpAo=;
        b=mZAQV/adNn1OpqOCdDp+QUVZAWDbxhx+qAqXQf59at77+n6TprUUzmdkRWwy73bjnd
         sFgPwole84gQzFsPvpUKCTviQYpRx7YXoOhh3DsMW1dANIPntnrwEW7hoFQFASDvJ1k4
         mzA7sJTowZapX12dKzwE6WNcHdTMXtHdA2QbhzxBNLfQ678Z07UgOVY5F3u3Ga+ZqSjj
         1uQJBtOfn/mi+SCYaxZKeE/Kmr7p//qHo88YzQtHGOT72QHSadz4sf0q4vPVyTtg02+Y
         H7c8FBIMNiqDDK3xvOW0UblKq273qXzm2wpoSc+9HM4OmhpkpU2A5ymPjzWaaOREV5Mi
         ZXsA==
X-Gm-Message-State: AOAM5329h5LbH+kZeZddPS7VUsnHkXISk76Pxy06qFb6RceKATg8ZwF5
        ldG7zxliBRRFmF6Vo468IuiMWw==
X-Google-Smtp-Source: ABdhPJypJOLGJL50IlRQ9kZNx8lrF9IJzBPVgdagxePgmBlwtc4cYdaVKa1B37z2K17mhRjOEy9wOQ==
X-Received: by 2002:a05:6808:6d9:: with SMTP id m25mr12862254oih.111.1592853577397;
        Mon, 22 Jun 2020 12:19:37 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m84sm3348294oif.32.2020.06.22.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:19:36 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v7 3/5] remoteproc: qcom: Update PIL relocation info on load
Date:   Mon, 22 Jun 2020 12:19:40 -0700
Message-Id: <20200622191942.255460-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622191942.255460-1-bjorn.andersson@linaro.org>
References: <20200622191942.255460-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the PIL relocation information in IMEM with information about
where the firmware for various remoteprocs are loaded.

Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- None

 drivers/remoteproc/Kconfig          |  5 +++++
 drivers/remoteproc/qcom_q6v5_adsp.c | 16 +++++++++++++---
 drivers/remoteproc/qcom_q6v5_mss.c  |  3 +++
 drivers/remoteproc/qcom_q6v5_pas.c  | 15 ++++++++++++---
 drivers/remoteproc/qcom_q6v5_wcss.c | 14 +++++++++++---
 drivers/remoteproc/qcom_wcnss.c     | 14 +++++++++++---
 6 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index f4bd96d1a1a3..3e8d5d1a2b9e 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -135,6 +135,7 @@ config QCOM_Q6V5_ADSP
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
@@ -151,6 +152,7 @@ config QCOM_Q6V5_MSS
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
 	select QCOM_MDT_LOADER
+	select QCOM_PIL_INFO
 	select QCOM_Q6V5_COMMON
 	select QCOM_Q6V5_IPA_NOTIFY
 	select QCOM_RPROC_COMMON
@@ -167,6 +169,7 @@ config QCOM_Q6V5_PAS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
@@ -185,6 +188,7 @@ config QCOM_Q6V5_WCSS
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
 	select QCOM_MDT_LOADER
+	select QCOM_PIL_INFO
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
@@ -218,6 +222,7 @@ config QCOM_WCNSS_PIL
 	depends on QCOM_SMEM
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select QCOM_MDT_LOADER
+	select QCOM_PIL_INFO
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index d2a2574dcf35..efb2c1aa80a3 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -26,6 +26,7 @@
 #include <linux/soc/qcom/smem_state.h>
 
 #include "qcom_common.h"
+#include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 #include "remoteproc_internal.h"
 
@@ -82,6 +83,7 @@ struct qcom_adsp {
 	unsigned int halt_lpass;
 
 	int crash_reason_smem;
+	const char *info_name;
 
 	struct completion start_done;
 	struct completion stop_done;
@@ -164,10 +166,17 @@ static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
 static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	int ret;
+
+	ret = qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
+				    adsp->mem_region, adsp->mem_phys,
+				    adsp->mem_size, &adsp->mem_reloc);
+	if (ret)
+		return ret;
+
+	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
 
-	return qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
-			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
-			     &adsp->mem_reloc);
+	return 0;
 }
 
 static int adsp_start(struct rproc *rproc)
@@ -436,6 +445,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp = (struct qcom_adsp *)rproc->priv;
 	adsp->dev = &pdev->dev;
 	adsp->rproc = rproc;
+	adsp->info_name = desc->sysmon_name;
 	platform_set_drvdata(pdev, adsp);
 
 	ret = adsp_alloc_memory_region(adsp);
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 903b2bb97e12..4b8567f970f9 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -30,6 +30,7 @@
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
+#include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 
 #include <linux/qcom_scm.h>
@@ -1190,6 +1191,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	else if (ret < 0)
 		dev_err(qproc->dev, "MPSS authentication failed: %d\n", ret);
 
+	qcom_pil_info_store("modem", qproc->mpss_phys, qproc->mpss_size);
+
 release_firmware:
 	release_firmware(fw);
 out:
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 61791a03f648..3837f23995e0 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -25,6 +25,7 @@
 #include <linux/soc/qcom/smem_state.h>
 
 #include "qcom_common.h"
+#include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 #include "remoteproc_internal.h"
 
@@ -64,6 +65,7 @@ struct qcom_adsp {
 	int pas_id;
 	int crash_reason_smem;
 	bool has_aggre2_clk;
+	const char *info_name;
 
 	struct completion start_done;
 	struct completion stop_done;
@@ -117,11 +119,17 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
 static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	int ret;
 
-	return qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
-			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
-			     &adsp->mem_reloc);
+	ret = qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
+			    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
+			    &adsp->mem_reloc);
+	if (ret)
+		return ret;
 
+	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
+
+	return 0;
 }
 
 static int adsp_start(struct rproc *rproc)
@@ -405,6 +413,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->rproc = rproc;
 	adsp->pas_id = desc->pas_id;
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
+	adsp->info_name = desc->sysmon_name;
 	platform_set_drvdata(pdev, adsp);
 
 	device_wakeup_enable(adsp->dev);
diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index 88c76b9417fa..8846ef0b0f1a 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -14,6 +14,7 @@
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include "qcom_common.h"
+#include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 
 #define WCSS_CRASH_REASON		421
@@ -424,10 +425,17 @@ static void *q6v5_wcss_da_to_va(struct rproc *rproc, u64 da, size_t len)
 static int q6v5_wcss_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct q6v5_wcss *wcss = rproc->priv;
+	int ret;
+
+	ret = qcom_mdt_load_no_init(wcss->dev, fw, rproc->firmware,
+				    0, wcss->mem_region, wcss->mem_phys,
+				    wcss->mem_size, &wcss->mem_reloc);
+	if (ret)
+		return ret;
+
+	qcom_pil_info_store("wcnss", wcss->mem_phys, wcss->mem_size);
 
-	return qcom_mdt_load_no_init(wcss->dev, fw, rproc->firmware,
-				     0, wcss->mem_region, wcss->mem_phys,
-				     wcss->mem_size, &wcss->mem_reloc);
+	return ret;
 }
 
 static const struct rproc_ops q6v5_wcss_ops = {
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 5d65e1a9329a..e2573f79a137 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -27,6 +27,7 @@
 
 #include "qcom_common.h"
 #include "remoteproc_internal.h"
+#include "qcom_pil_info.h"
 #include "qcom_wcnss.h"
 
 #define WCNSS_CRASH_REASON_SMEM		422
@@ -145,10 +146,17 @@ void qcom_wcnss_assign_iris(struct qcom_wcnss *wcnss,
 static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	int ret;
+
+	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
+			    wcnss->mem_region, wcnss->mem_phys,
+			    wcnss->mem_size, &wcnss->mem_reloc);
+	if (ret)
+		return ret;
+
+	qcom_pil_info_store("wcnss", wcnss->mem_phys, wcnss->mem_size);
 
-	return qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
-			     wcnss->mem_region, wcnss->mem_phys,
-			     wcnss->mem_size, &wcnss->mem_reloc);
+	return 0;
 }
 
 static void wcnss_indicate_nv_download(struct qcom_wcnss *wcnss)
-- 
2.26.2

