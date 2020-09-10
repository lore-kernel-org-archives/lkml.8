Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B34C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B020809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utjF/eg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgIJHx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbgIJHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:53:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FACDC061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:53:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so7329127ejf.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QM0o+rVzX3uPzdClaXq4cvOE98Cu7/fWdyVNqeP9dm8=;
        b=utjF/eg5YPe5nbhcIOF5tQlQtWPCjtGTK8ZA6cyO9peRb1+AsJ9ABldRh7kaDScqAD
         Jrq6+arYgOeJ5ykRuBsdYrW9VMbCnuHkMuXgSn7EzRzlG5vDidkh9+EuchObnU6qplQR
         KKXdgISb6vhsH2U3YI04TBqA58ASzbiurG0BdgcMpSxFcWZ9nQX7H6zgXlzfKqyyFzd9
         dO31+ZF6G99eJLEzefX3/Z6nSFswMWOIv2P4yrvZSCwpFstQEAGHWSY0OAvv/AF7QCm5
         BntVnDhCKM8uuRUvXPHKvoFPfJ2AMwI8LAnIoPKqiguBFkVtxJWenUusx+wldxWAYoTo
         pstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QM0o+rVzX3uPzdClaXq4cvOE98Cu7/fWdyVNqeP9dm8=;
        b=oYw0THaFsDEA6vvzoYjrw4Ky6nV1Sl/I2bTFqKl0vi8jNWFuGeU6pBfx4EBczwWmOc
         FTbvdblfvT1uy2LYMWmpu/VsEcDsygY3N/376p0Zt61mEc18b9SnspcDbum+MPf4NjR9
         WFTRf6b4aP8fuIVlBF/iLFSpr3eN86hI/u4EUf5IUvL1f8kEjbmMzFi8hU8f0FHermq/
         76pOChzNqMC1JSecAWomYAhFSXnqVR0P9fBXT3BRMU7PHFMIRUd62w3JwDcqo8J114wx
         T3N096Ro1CbVjk3ePnc2rZtMBcgAjyFUH3lRGXwTw5Q04rZLsHpVsG4KhFWcF03MpvyW
         M7lg==
X-Gm-Message-State: AOAM5303LwL+Aw+P2bbtmk9Txl4FMBrGCPma8DiTH8pJ1CM5JgYWkRSr
        vyjQLL1hV2VahONcjefdciyZ4kujnP5xLGj3
X-Google-Smtp-Source: ABdhPJwFgl91HQI5KPYNpoHEEW6Ht3uLFBFfrWNK9m0dn0oQ/6u16x/WKIp7+5p5drchm/+2Az3+qg==
X-Received: by 2002:a17:906:cb92:: with SMTP id mf18mr7839719ejb.485.1599724378737;
        Thu, 10 Sep 2020 00:52:58 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id q26sm5742838ejr.97.2020.09.10.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:52:58 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 2/2] venus: firmware: Set virtual address ranges
Date:   Thu, 10 Sep 2020 10:52:27 +0300
Message-Id: <20200910075227.950-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910075227.950-1-stanimir.varbanov@linaro.org>
References: <20200910075227.950-1-stanimir.varbanov@linaro.org>
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
 drivers/media/platform/qcom/venus/firmware.c | 19 ++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index c5af42873aed..3549a094e860 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -540,6 +540,10 @@ static const struct venus_resources sdm845_res_v2 = {
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
index 1a7aee7ee628..3e3f0138e3c3 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -77,6 +77,10 @@ struct venus_resources {
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
index 8801a6a7543d..1db64a854b88 100644
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
@@ -200,7 +201,23 @@ int venus_boot(struct venus_core *core)
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
+			qcom_scm_pas_shutdown(VENUS_PAS_ID);
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

