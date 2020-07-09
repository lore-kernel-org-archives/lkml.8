Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E8DC433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA72F20767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzMaMQeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGIOwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgGIOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:52:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DF1C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:52:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so1125841pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OZwHLoYsPLolEThueb6jXCR0eyEx+KYOX1qxj6/d78=;
        b=hzMaMQeQi9gW0maVN9OGPwk4TP11tQbVOIpNbdkviJCng9GMMFffAQP0Kn3xJuLIlK
         SUX4HGmcxYJgra7Tt4oe2ETOCgqy6cvWRKQxT1U4MoAHQ/m4tLVOXKhaFyNshvWCm5GW
         dSc8ushh/CrcbG/RPjoCN8daHVnRmaA21D7II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OZwHLoYsPLolEThueb6jXCR0eyEx+KYOX1qxj6/d78=;
        b=giXfXa8C7CKN7W4FnNrdRrqMgIQfsfkOo2PDNka+G4Apw1XUNEOAb1jDR2UE407U5w
         n/k3TBpYcnt8g8MolRQYfFXAp2LwUk+t2Z1Hq1y1OmTw2vEcLzKOuE2lkgXDGNU33fOP
         vVyiB6iysk4Zc0P/ZImjnKqbiz9pJlaeK/xterCz+kXAY/Zegr29rRGDBFW6gyhI++S0
         4VFSt05eKwIHRrqafZ2tSuwmkvDngu2rRrrQSLmCUD6m8c0DfG7gzMidYkakBo302hiz
         OEokIupBBwSLiPhB42kfoSkuiIUTIvWXmsAdQ8+RocisUqWXiX1XUOco0S9p4AlsJZyi
         /VfQ==
X-Gm-Message-State: AOAM531yz0hB5H6FnmN8mpOrVK0XnaUJF93ZMW4KI4W0anZJmtRNwa0m
        /GdPhwjcw4NQNF8POlpVTtsotQ==
X-Google-Smtp-Source: ABdhPJxo2fY03UIp9g9JN7ruFlVqnEdXAfP9zDDltq2IXBQ+V7n2/VIEDErhN8r4qwBedTc96l2AyQ==
X-Received: by 2002:a62:37c6:: with SMTP id e189mr17800645pfa.207.1594306319627;
        Thu, 09 Jul 2020 07:51:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m1sm2791322pjy.0.2020.07.09.07.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:51:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, georgi.djakov@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 1/2] spi: spi-qcom-qspi: Avoid clock setting if not needed
Date:   Thu,  9 Jul 2020 07:51:44 -0700
Message-Id: <20200709075113.v2.1.Ia7cb4f41ce93d37d0a764b47c8a453ce9e9c70ef@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709145145.4055619-1-dianders@chromium.org>
References: <20200709145145.4055619-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per recent changes to the spi-qcom-qspi, now when we set the clock
we'll call into the interconnect framework and also call the OPP API.
Those are expensive operations.  Let's avoid calling them if possible.
This has a big impact on getting transfer rates back up to where they
were (or maybe slightly better) before those patches landed.

Fixes: cff80645d6d3 ("spi: spi-qcom-qspi: Add interconnect support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
---
This applies atop the Qualcomm tree after Rajendra's ("spi:
spi-qcom-qspi: Use OPP API to set clk/perf state") patch and I'd hope
it could land there with Mark's Ack just like the patch it Fixes did.

Changes in v2:
- Return error from runtime resume if dev_pm_opp_set_rate() fails.

 drivers/spi/spi-qcom-qspi.c | 41 ++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 18a59aa23ef8..8fedc605ab7f 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -144,6 +144,7 @@ struct qcom_qspi {
 	struct icc_path *icc_path_cpu_to_qspi;
 	struct opp_table *opp_table;
 	bool has_opp_table;
+	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
 };
@@ -226,19 +227,13 @@ static void qcom_qspi_handle_err(struct spi_master *master,
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 }
 
-static int qcom_qspi_transfer_one(struct spi_master *master,
-				  struct spi_device *slv,
-				  struct spi_transfer *xfer)
+static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 {
-	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 	int ret;
-	unsigned long speed_hz;
-	unsigned long flags;
 	unsigned int avg_bw_cpu;
 
-	speed_hz = slv->max_speed_hz;
-	if (xfer->speed_hz)
-		speed_hz = xfer->speed_hz;
+	if (speed_hz == ctrl->last_speed)
+		return 0;
 
 	/* In regular operation (SBL_EN=1) core must be 4x transfer clock */
 	ret = dev_pm_opp_set_rate(ctrl->dev, speed_hz * 4);
@@ -259,6 +254,28 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		return ret;
 	}
 
+	ctrl->last_speed = speed_hz;
+
+	return 0;
+}
+
+static int qcom_qspi_transfer_one(struct spi_master *master,
+				  struct spi_device *slv,
+				  struct spi_transfer *xfer)
+{
+	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	int ret;
+	unsigned long speed_hz;
+	unsigned long flags;
+
+	speed_hz = slv->max_speed_hz;
+	if (xfer->speed_hz)
+		speed_hz = xfer->speed_hz;
+
+	ret = qcom_qspi_set_speed(ctrl, speed_hz);
+	if (ret)
+		return ret;
+
 	spin_lock_irqsave(&ctrl->lock, flags);
 
 	/* We are half duplex, so either rx or tx will be set */
@@ -602,7 +619,11 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	return clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
+	ret = clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
+	if (ret)
+		return ret;
+
+	return dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
 }
 
 static int __maybe_unused qcom_qspi_suspend(struct device *dev)
-- 
2.27.0.383.g050319c2ae-goog

