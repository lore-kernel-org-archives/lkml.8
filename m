Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F2C2BBD0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA5E2086A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="blpD3fnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgIERk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIERkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:40:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D978C061258
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 10:40:10 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j3so4652476qvi.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clxiZVTp9IbXkL/ODJWDej3rLeQuCQZfJj2JCOZ4XcQ=;
        b=blpD3fnjIVvM2UjG69yRj3YsVpySHlyRssil72WnBLEgXMyIIgE2fFoHiWmPNv5KfQ
         ZITYlMCVFWQEv1GdzHRxmoCEy/B0MTqX9yk68IsSNZqS75q6ClyWfS4otL6JK08bTcko
         XbSKbb7N3OC2PHCyYzV6wHXyNxG8XXzbON8uVjINd1sBlqg4qiqwfRX+Eg0t7FCNYqtb
         SeotVZ6KCCgexrPc6a1EFS3twfu3vAa+w/rz8OU9K82KJVXjQ4fDdMHIRx1sUinY0+OI
         IeVt0MK6rT6xu92SG7kzODJ4kWv4PfDuuHc6naWm1/eH40hkZK7LDFKi9om9i67vAmBk
         IkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clxiZVTp9IbXkL/ODJWDej3rLeQuCQZfJj2JCOZ4XcQ=;
        b=Py4qLhg3F9bSRzRVKrrji2Siam0nlAXiJ0G/x9te+p1AD7q89d8t9CKQz6DCzQLyrE
         aAehKw0LkddWJrFvAnWuvXElLR0qWJjyZ6zyZWsKnmAyI7I2jtgJKHzUVStFHjfk/JMx
         vZvv2m4BwqDZwuIQe/+Q47VdLnfkInXfkycolz5BO+nPwKiHK9iOJe0iSU5GDdWzJq8t
         LbVB2kRFLZd622zKZV5edbQkcUVlII/m9PuoysK1CY9/dVQIzJgAFkDGc0LrpHKes2fF
         E+qvcMGstprW0tjO3oc9ryXvXaOneSFqAhYmXMBdT0bQ1I5UP39+F+4xIMq3hcLDIFlO
         NpBQ==
X-Gm-Message-State: AOAM530RvAbGKfKighKJ0NW26OrpK7kKAaASIlVlhxIMIvgzfFwKxCAH
        L6s/5Inh4mSUe2Y0gxNvd05NkUGkFUiwhJAeUYE=
X-Google-Smtp-Source: ABdhPJzUx2oIqqILgTzU+sFcy14bKR7Lc4YYcEuNwCsXTBdV0KZMOPD0VXj9GSfNBWcaubjZI7bJtw==
X-Received: by 2002:a0c:edaa:: with SMTP id h10mr12414932qvr.12.1599327608255;
        Sat, 05 Sep 2020 10:40:08 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k22sm4612076qkk.13.2020.09.05.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 10:40:07 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org (moderated list:SOUNDWIRE SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] soundwire: qcom: add support for mmio soundwire master devices
Date:   Sat,  5 Sep 2020 13:39:04 -0400
Message-Id: <20200905173905.16541-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200905173905.16541-1-jonathan@marek.ca>
References: <20200905173905.16541-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for qcom soundwire devices with memory mapped IO registers.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/soundwire/qcom.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6401ad451eee..ff28794868ca 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -34,6 +34,7 @@
 #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
 #define SWRM_INTERRUPT_MASK_ADDR				0x204
 #define SWRM_INTERRUPT_CLEAR					0x208
+#define SWRM_INTERRUPT_CPU_EN					0x210
 #define SWRM_CMD_FIFO_WR_CMD					0x300
 #define SWRM_CMD_FIFO_RD_CMD					0x304
 #define SWRM_CMD_FIFO_CMD					0x308
@@ -90,6 +91,7 @@ struct qcom_swrm_ctrl {
 	struct sdw_bus bus;
 	struct device *dev;
 	struct regmap *regmap;
+	void __iomem *mmio;
 	struct completion *comp;
 	struct work_struct slave_work;
 	/* read/write lock */
@@ -154,6 +156,20 @@ static int qcom_swrm_ahb_reg_write(struct qcom_swrm_ctrl *ctrl,
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
@@ -310,6 +326,12 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
 			SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK |
 			SWRM_COMP_CFG_ENABLE_MSK);
+
+	/* enable CPU IRQs */
+	if (ctrl->mmio) {
+		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN,
+				SWRM_INTERRUPT_STATUS_RMSK);
+	}
 	return 0;
 }
 
@@ -764,8 +786,11 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		if (!ctrl->regmap)
 			return -EINVAL;
 	} else {
-		/* Only WCD based SoundWire controller is supported */
-		return -ENOTSUPP;
+		ctrl->reg_read = qcom_swrm_cpu_reg_read;
+		ctrl->reg_write = qcom_swrm_cpu_reg_write;
+		ctrl->mmio = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(ctrl->mmio))
+			return PTR_ERR(ctrl->mmio);
 	}
 
 	ctrl->irq = of_irq_get(dev->of_node, 0);
-- 
2.26.1

