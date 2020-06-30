Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED8120774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lp93DS2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgF3Nxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbgF3NxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:53:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F096C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:53:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so20254341wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxnB/+jd9K34Cor1LzCuenu6MNDDpmb67bTwFlU95v8=;
        b=lp93DS2sHIxQoN8XIXCAD3xBmgtJ5GtaAx/R7gMEB0m+itdKCOCrQxmzgXmFfQo2GL
         AefyU5FbOd2VC0j5VSWX996A0Qzs4U2KlLtTDnH7p49pD0ELrTn9+OgmyJ6v/3X33c/g
         +QCPzf9ixTeQOIlkxpRCQ3vFeE8fWarzXh18afAM2IZKMp10A0VGaLRqBf/1xe73KnQq
         mhbTTBSiRp4qx3x36+sYkeAmGfpYZd22t3y8JOYc3Gg602DpjlGTsT8RFlvgz7iop3JL
         SL/W8xpqd8WFpZRHnl4eh5KGz2NOWltNdQpZV096Th9uVk5BqL5YR7kk72EZ2k+yVy03
         FGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxnB/+jd9K34Cor1LzCuenu6MNDDpmb67bTwFlU95v8=;
        b=k0cz/gKa58c8qSAkOOZTLWdrWAe79bHjkMINJt50VAA4aqg3UaUR99hl4IX45Izb2p
         4PTQmwakoZqmtLocoAHlsong+CR3uim2e42bxZEDeR5Pvj0cwX5aS9YDJjOe9Lu8Vh/t
         y/35eVnRfZ1Ti+kavYy3hmyoximb0+xr0Z1vt7PMMwuOSBAqbO0XkwPxMldO4IQ6Cvlu
         2GhoQKSSUywI/Zl6eMoVVKVkbnW0/osR16oSWSVd8IvV6/VQnT9l1xdip5H1n9fOBaQU
         GqvBFv7Acc6JrGwTWfWSj7aNFLZ42QH2G9tuNP1JndUC+zaUzadW8Y64xTe5/y7VCrDz
         9CUQ==
X-Gm-Message-State: AOAM533WdQD21HVRQcIKmJTpzL0QLcL/xAPMo5lWy4FkFNr9uv+HmSds
        3NlCILQ1Ae/B5fzE4hNVc22xaA==
X-Google-Smtp-Source: ABdhPJxEuNMC7QxxlZ2zequ56A6TqR6yugJ6hWAMSAibHWwFQizQVUK4iqJGcqpsUQIFBaeDZ6zqjg==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr20994274wrp.234.1593525203120;
        Tue, 30 Jun 2020 06:53:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 92sm3972007wrr.96.2020.06.30.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:53:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] nvmem: core: add support to auto devid
Date:   Tue, 30 Jun 2020 14:53:16 +0100
Message-Id: <20200630135317.23163-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nvmem providers which have multiple instances, it is required
to suffix the provider name with proper id, so that they do not
confict for the same name. Currently the core does not handle
this case properly eventhough core already has logic to generate the id.

This patch add new devid type NVMEM_DEVID_AUTO for providers to be
able to allow core to assign id and append it to provier name.

Reported-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/nvmem/core.c           | 10 ++++++++--
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 927eb5f6003f..aa87bd6415ab 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -629,12 +629,18 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!config->no_of_node)
 		nvmem->dev.of_node = config->dev->of_node;
 
-	if (config->id == -1 && config->name) {
+	switch (config->id) {
+	case NVMEM_DEVID_NONE:
 		dev_set_name(&nvmem->dev, "%s", config->name);
-	} else {
+		break;
+	case NVMEM_DEVID_AUTO:
+		dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
+		break;
+	default:
 		dev_set_name(&nvmem->dev, "%s%d",
 			     config->name ? : "nvmem",
 			     config->name ? config->id : nvmem->id);
+		break;
 	}
 
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 6d6f8e5d24c9..06409a6c40bc 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -27,6 +27,9 @@ enum nvmem_type {
 	NVMEM_TYPE_BATTERY_BACKED,
 };
 
+#define NVMEM_DEVID_NONE	(-1)
+#define NVMEM_DEVID_AUTO	(-2)
+
 /**
  * struct nvmem_config - NVMEM device configuration
  *
-- 
2.21.0

