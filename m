Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DD720853
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="wRgDcxO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgFHUos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgFHUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:44:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C5C08C5C7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:44:14 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g62so12348698qtd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONkKk00wU6bNoQuWZM5ia2OqgRGBJA5uMULpx0HvSVs=;
        b=wRgDcxO8BCqt6sdiblcfLzl4rgLVW/62I97WXOlaKayAc75G8dB2ExJqPheT4ByLEt
         6cxtXG71WJOpGNCGV31RXojBl3HEazQ29hOJXTVdPdB13J3HwUTQfXi29Zq/YWVPLmCI
         Wjc0KEVayWJwjxHtT7veElQlljIyAMaJKwQHnTip2cpx71fX7nyG72RpYkLJoK6qlOCL
         tN+1/Olm0Xt53eSz3slJZ47LEfZL6KEVA12NLG5qdwzbLQGhNc11JI48dxrVF1XeoMX9
         b+XX4TW7K0e/R2gSg9vVBsveDp9Zpv8P94+TU6lp3CGs89n0l0Li3vwl9bWg13u6kr9L
         pd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONkKk00wU6bNoQuWZM5ia2OqgRGBJA5uMULpx0HvSVs=;
        b=Qh08kWtIftcHElS1+WcRchoGKu+5pQoWzwCP24u+fUN4fD7RirUjz7MXl6xnCIJ+ht
         F0UTppKojg8hMpEBfs+7hKPnVOftGAjOVnzC8liTslyn0CemspBq0knb4/nd51E+VhQ8
         DpdlU/PBg5FRIGwzNSpxMHC1kT02CGjbtkKMR8sD8jYeKkNs9WRrZzpzv5PQJrI4GOg9
         ZAszMum73zGp1/XH2HZMMzSQILvCnbo7hqRM6GRdwnDbjs4sKoABKDxdQU61Xz59I0me
         vSLxp3KQ/Mv3mjqUFOJkP03n+PuzyEME/Dx1BZY17mFcVO9Igaw6ORv5erA/gn9n0D6N
         nYnw==
X-Gm-Message-State: AOAM531h6MTzcatxb5t51BrUwYBV7zcBnBBU4pV/3TEFZiBgDhludJJ4
        BatcRYVZDw5bEWafFRcO3MOGOA==
X-Google-Smtp-Source: ABdhPJxFZ1JGmX+g9epu/PQEnKM/WSRYvOq/NrosWYsQIOnyJyLKXgl4JFeGXodB4BO3846UKpvcBg==
X-Received: by 2002:ac8:176f:: with SMTP id u44mr26539726qtk.0.1591649053340;
        Mon, 08 Jun 2020 13:44:13 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y16sm8895565qty.1.2020.06.08.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:44:12 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] soundwire: qcom: add support for mmio soundwire devices
Date:   Mon,  8 Jun 2020 16:43:43 -0400
Message-Id: <20200608204347.19685-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200608204347.19685-1-jonathan@marek.ca>
References: <20200608204347.19685-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for qcom soundwire devices with memory mapped IO registers.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/soundwire/qcom.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index f38d1fd3679f..628747df1c75 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -90,6 +90,7 @@ struct qcom_swrm_ctrl {
 	struct sdw_bus bus;
 	struct device *dev;
 	struct regmap *regmap;
+	void __iomem *mmio;
 	struct completion *comp;
 	struct work_struct slave_work;
 	/* read/write lock */
@@ -154,6 +155,20 @@ static int qcom_swrm_ahb_reg_write(struct qcom_swrm_ctrl *ctrl,
 	return SDW_CMD_OK;
 }
 
+static int qcom_swrm_cpu_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
+				  u32 *val)
+{
+	*val = readl(ctrl->mmio + reg);
+	return SDW_CMD_OK;
+}
+
+static int qcom_swrm_cpu_reg_write(struct qcom_swrm_ctrl *ctrl, int reg,
+				   int val)
+{
+	writel(val, ctrl->mmio + reg);
+	return SDW_CMD_OK;
+}
+
 static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
 				     u8 dev_addr, u16 reg_addr)
 {
@@ -746,6 +761,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	struct sdw_master_prop *prop;
 	struct sdw_bus_params *params;
 	struct qcom_swrm_ctrl *ctrl;
+	struct resource *res;
 	int ret;
 	u32 val;
 
@@ -760,8 +776,13 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		if (!ctrl->regmap)
 			return -EINVAL;
 	} else {
-		/* Only WCD based SoundWire controller is supported */
-		return -ENOTSUPP;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+		ctrl->reg_read = qcom_swrm_cpu_reg_read;
+		ctrl->reg_write = qcom_swrm_cpu_reg_write;
+		ctrl->mmio = devm_ioremap_resource(dev, res);
+		if (IS_ERR(ctrl->mmio))
+			return PTR_ERR(ctrl->mmio);
 	}
 
 	ctrl->irq = of_irq_get(dev->of_node, 0);
-- 
2.26.1

