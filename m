Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D8FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C842076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJwRQNTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGIL7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgGIL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:59:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F422C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:59:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so1482847wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zcfJN5PzuB9k5TgpYnzCkxNELSw0Z0tfL9cbkN0RIAE=;
        b=fJwRQNTMBNmDim0Hlmq+EPHYf0L4aBACOkST0gdSFrk5ErnIkYtEB6/X33rf5PshRF
         K0O3M6MDvxUYCzL+61sx+/KSk5FF0dFEaHzQI/xnr7d7KosigyuAyWaG7sVkscIdlCnC
         FqrRS/kRnZKMljSgJobQJZ89JG/r7secpKDZYPw8yajO9CImC8gR1il7ci9S9DScqS2x
         ndRlrzW2AlEqaZDjzM5QPReEe/KwiAqBw0LPGogK3gOV0+NkN70WXEvzuKB3TkRnOluy
         AS6abkq+IV2uTmwQw6OAHqOIqi0CUteOCManHQT660YL+U8z1J82XaykeEottgD5GG/u
         zAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zcfJN5PzuB9k5TgpYnzCkxNELSw0Z0tfL9cbkN0RIAE=;
        b=UXfn42n9DM/85dz4mMA++1jAx9eBS7Un3fdwia2x6Iz5YeBLSNvlh3oF7OJimw81wH
         rHL7Sjs37pDSNR8xyD2ae3Q4AlYfA7vPjwGYiQKFrZx/2GDmsc/jdFy9ygM5MdRcko1X
         ZRiT7oDqdxnE1ITwieJ9xA41eszZsIcm55Zyo5vSeOuA2Vu6H3DI2v3F7mv67Tslbs06
         cY1eQGDokcBYgrHzBBtL4HS7EJsCLcw2re+qTY2RK2EXSHm/TFCsWpKmErG/qVZqB8bJ
         EVUCzpCjYFFMlTJEIXg1nc3f2p4iKPxRcTE/2PpRTLAx1YSO+8rioRJsDHeJhRr8wzEd
         JFnA==
X-Gm-Message-State: AOAM532WaKMw1BgXoV69lauDO7k5HvRkAMWOcZ1q9vLK+Uedp8YGPXG/
        9Znwb217aKXqFlxawrmiruHhMA==
X-Google-Smtp-Source: ABdhPJxU3M6MXPX7D0iPepfCyWsGPL+DqDWriB9veEsCLFC0X3m8qTWeyIx/dja2bs9QTgd6OmVe+A==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr13705700wma.8.1594295941743;
        Thu, 09 Jul 2020 04:59:01 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-112.ip.btc-net.bg. [212.5.158.112])
        by smtp.gmail.com with ESMTPSA id v7sm5140737wrp.45.2020.07.09.04.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 04:59:01 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 2/2] venus: firmware: Set virtual address ranges
Date:   Thu,  9 Jul 2020 14:58:29 +0300
Message-Id: <20200709115829.8194-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709115829.8194-1-stanimir.varbanov@linaro.org>
References: <20200709115829.8194-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to boot some of the new Venus firmware versions TZ call to set
virtual address ranges is needed. Add virtual address ranges for CP and
CP_NONPIX in resource structure and use them when loading and booting
the firmware on remote processor.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c     |  4 ++++
 drivers/media/platform/qcom/venus/core.h     |  4 ++++
 drivers/media/platform/qcom/venus/firmware.c | 18 +++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 203c6538044f..5f8f7b72731c 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -527,6 +527,10 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
+	.cp_start = 0,
+	.cp_size = 0x70800000,
+	.cp_nonpixel_start = 0x1000000,
+	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.2/venus.mdt",
 };
 
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 7118612673c9..8c88516e4694 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -68,6 +68,10 @@ struct venus_resources {
 	unsigned int vmem_id;
 	u32 vmem_size;
 	u32 vmem_addr;
+	u32 cp_start;
+	u32 cp_size;
+	u32 cp_nonpixel_start;
+	u32 cp_nonpixel_size;
 	const char *fwname;
 };
 
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 8801a6a7543d..ac906ffc608f 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -181,6 +181,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 int venus_boot(struct venus_core *core)
 {
 	struct device *dev = core->dev;
+	const struct venus_resources *res = core->res;
 	phys_addr_t mem_phys;
 	size_t mem_size;
 	int ret;
@@ -200,7 +201,22 @@ int venus_boot(struct venus_core *core)
 	else
 		ret = venus_boot_no_tz(core, mem_phys, mem_size);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	if (core->use_tz && res->cp_size) {
+		ret = qcom_scm_mem_protect_video_var(res->cp_start,
+						     res->cp_size,
+						     res->cp_nonpixel_start,
+						     res->cp_nonpixel_size);
+		if (ret) {
+			dev_err(dev, "set virtual address ranges fail (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 int venus_shutdown(struct venus_core *core)
-- 
2.17.1

