Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC06C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA8218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8JNf4WQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgIIQMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbgIIQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:09:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79051C061798
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:09:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so3534315wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRY48n4o7lqyeOMqHNi/gjEPBgAxUiFR7TIRFWcKW3c=;
        b=G8JNf4WQ/NztVBWlPjOiBhrUInzg7S3HLCwKjVB79t6IN1kv/KTDuJ7JOib17cMbeB
         F1j/eZYhusposXKnVMPoIIVHEYO1O5ScnP9VZTdWHQvvBQV6bH6xBB5spC1+azLQrbz4
         yh8mDJUodv981BuP8jff/59jVf5SNu6pLSHuiQaYutcuAtNhIn9d07271/HxvFA9fGaa
         gRXLbtW1wSxVXNG98pj4PjzTM8U66A2czIUJA+G/hhVvS+Dwiyg+7co5+zfV8dwox5jc
         A734D3jLZB0//+yl+KG+aRHR9cA2QP//KHVns451RxFLpsO28Pj5sIgh211EXji0pVpa
         78lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRY48n4o7lqyeOMqHNi/gjEPBgAxUiFR7TIRFWcKW3c=;
        b=tR7XTe0UPGd8b/t/yw0P2S0jilzeFopAUNi2lNtLBYMH027H97GmMq9Haz6vdwhsHN
         19WkH1kyH3tW1Dbga3WGqlSXzTnpyU8KAvPiwEXaB5DyyF+NvV4qrhrbHHAaN0PsBkwY
         aFS2suJNidcMRKe5zfpyVi1wz5Xl+DZZ947QyJHxjPOu+S0vnm+4ctozObkGhUQE6Sk3
         bKat7ij6g1iZnpPLGdANRQV665m7DfiZ/kG/lobGucq6U9BO5qsq5mMpqoTmLqzMsUMg
         YpKMRpuSQwvNPJaVeXk2VsqHpD/3M9b0XKTcmAYjxbkX8BIWKiVaOyHvsnbz78qnMNBr
         DNGw==
X-Gm-Message-State: AOAM531m9HwuxNFY0toE0HhLOyeDZew//KFnmWx7WJH4Cn9MUHGGltEx
        Vq9XNU5t1mcMF0DJw02jzc2/kA==
X-Google-Smtp-Source: ABdhPJzszX7vpVkDZmwOXwkOKo3BLLvvvjBzsK0OfJGSUU4rR98MFT+i0aT0tcOF+WZqRguFRNzg3w==
X-Received: by 2002:adf:db48:: with SMTP id f8mr4969370wrj.144.1599667768139;
        Wed, 09 Sep 2020 09:09:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id k22sm4900824wrd.29.2020.09.09.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:09:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] soundwire: qcom: get max rows and cols info from compatible
Date:   Wed,  9 Sep 2020 17:09:12 +0100
Message-Id: <20200909160912.3656-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
References: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently the max rows and cols values are hardcoded. In reality
these values depend on the IP version. So get these based on
device tree compatible strings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 46 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 1ec0ee931f5b..03c5bc05fc6e 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -69,11 +69,6 @@
 #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
 			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
 
-#define SWRM_MAX_ROW_VAL	0 /* Rows = 48 */
-#define SWRM_DEFAULT_ROWS	48
-#define SWRM_MIN_COL_VAL	0 /* Cols = 2 */
-#define SWRM_DEFAULT_COL	16
-#define SWRM_MAX_COL_VAL	7
 #define SWRM_SPECIAL_CMD_ID	0xF
 #define MAX_FREQ_NUM		1
 #define TIMEOUT_MS		(2 * HZ)
@@ -107,6 +102,8 @@ struct qcom_swrm_ctrl {
 	unsigned int version;
 	int num_din_ports;
 	int num_dout_ports;
+	int cols_index;
+	int rows_index;
 	unsigned long dout_port_mask;
 	unsigned long din_port_mask;
 	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
@@ -116,6 +113,21 @@ struct qcom_swrm_ctrl {
 	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
 };
 
+struct qcom_swrm_data {
+	int default_cols;
+	int default_rows;
+};
+
+static struct qcom_swrm_data swrm_v1_3_data = {
+	.default_rows = 48,
+	.default_cols = 16,
+};
+
+static struct qcom_swrm_data swrm_v1_5_data = {
+	.default_rows = 50,
+	.default_cols = 16,
+};
+
 #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
 
 static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
@@ -302,8 +314,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32 val;
 
 	/* Clear Rows and Cols */
-	val = (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
-	       SWRM_MIN_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
+	val = ctrl->rows_index << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
+		ctrl->cols_index << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT;
 
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
@@ -382,8 +394,8 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
 	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
 	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
 
-	val |= (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
-		SWRM_MAX_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
+	val |= ctrl->rows_index << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
+	       ctrl->cols_index << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT;
 
 	return ctrl->reg_write(ctrl, reg, val);
 }
@@ -784,6 +796,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	struct sdw_master_prop *prop;
 	struct sdw_bus_params *params;
 	struct qcom_swrm_ctrl *ctrl;
+	const struct qcom_swrm_data *data;
 	struct resource *res;
 	int ret;
 	u32 val;
@@ -792,6 +805,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	if (!ctrl)
 		return -ENOMEM;
 
+	data = of_device_get_match_data(dev);
+	ctrl->rows_index = sdw_find_row_index(data->default_rows);
+	ctrl->cols_index = sdw_find_col_index(data->default_cols);
 #ifdef CONFIG_SLIMBUS
 	if (dev->parent->bus == &slimbus_bus) {
 #else
@@ -844,8 +860,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	params = &ctrl->bus.params;
 	params->max_dr_freq = DEFAULT_CLK_FREQ;
 	params->curr_dr_freq = DEFAULT_CLK_FREQ;
-	params->col = SWRM_DEFAULT_COL;
-	params->row = SWRM_DEFAULT_ROWS;
+	params->col = data->default_cols;
+	params->row = data->default_rows;
 	ctrl->reg_read(ctrl, SWRM_MCP_STATUS, &val);
 	params->curr_bank = val & SWRM_MCP_STATUS_BANK_NUM_MASK;
 	params->next_bank = !params->curr_bank;
@@ -855,8 +871,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	prop->num_clk_gears = 0;
 	prop->num_clk_freq = MAX_FREQ_NUM;
 	prop->clk_freq = &qcom_swrm_freq_tbl[0];
-	prop->default_col = SWRM_DEFAULT_COL;
-	prop->default_row = SWRM_DEFAULT_ROWS;
+	prop->default_col = data->default_cols;
+	prop->default_row = data->default_rows;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
 
@@ -907,8 +923,8 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_swrm_of_match[] = {
-	{ .compatible = "qcom,soundwire-v1.3.0", },
-	{ .compatible = "qcom,soundwire-v1.5.1", },
+	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
+	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
 	{/* sentinel */},
 };
 
-- 
2.21.0

