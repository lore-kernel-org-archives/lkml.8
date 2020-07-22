Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466FAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1120729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErqMyEJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbgGVKI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbgGVKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA3C0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so1311673wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Btc0g5x84xxnafSkEaCj9XqLxAIyY2p5cpnuhdTuhb0=;
        b=ErqMyEJUREbiw53rbZz/8AVYs2B+ZLfxstvCL67hKDuFCai1+OxL5vF7kGs639VPQk
         y1+snnyo09vSGwyT0OLAl7StW8zCuN/n2J8HULQs7T86xGm4jCdwEMJDNDvpq/zmWDOk
         I+DqXFPDNU1qgknu6G31IhUqjGk62In0XT11SlaFQPNOAP5cS10UNLGmCtkoE2kyPoi2
         Pr5DuNkOkwrfGX4sFgjFk5XzsHw13L4ES67CKizqZpfyfuStuqNoU6R7kkfH5SEJBaQI
         3NVnRHn6KFKRtk5VdxARugjlkWdbkSNTAYcJ1SsFBM69jfVOChAnCgmQ3EfmzPw+tWjX
         egmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Btc0g5x84xxnafSkEaCj9XqLxAIyY2p5cpnuhdTuhb0=;
        b=Vw+fLa2LqDjIqtaxzht4sSEgCEKOdDyTHaOVGYTqyyMew+FoukeXofXNJrH097d+JR
         P4FrJ4wT9bWuo3+z8u+Oxe0LCiBfIFGvhNJuhjXjXNCqpzCabaSSS3JrsT84LuVxGHA+
         sHjDAnQ5d0HRtLRuQ0um81qqX4+VMTX99lv1u77DTWdOEY2mPzJwBUvj9mcK0r2cLI4j
         9pA9nIH8+ejCoYqrAqp5nKnSieP+e7WK2fDvBWlFRt/VVXTojnuEY1s0lFWt8YYsYmbt
         vEtX6qTOhm0QPmoOklI0q80EnFkFsL0N1c/sdF5LMSAKPPPcTPzAb4SN9fHWGrpTYeEr
         8Pdg==
X-Gm-Message-State: AOAM533zEdbd0PY9JycmRxjUa8kNk+haEJ32aUU6Kz7h0/n3uACHIM1+
        6CClUN9mC0BgybqvGQVFCQNmZQ==
X-Google-Smtp-Source: ABdhPJz8zKglWWc2vlh6Bm7ka33YAunUiFuw+0mrl4YxSZ5wXKZQ+kNwk/rcQt/1XPC/GOe4CucZcA==
X-Received: by 2002:adf:a299:: with SMTP id s25mr16235958wra.106.1595412498194;
        Wed, 22 Jul 2020 03:08:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 07/14] nvmem: core: add support to auto devid
Date:   Wed, 22 Jul 2020 11:06:58 +0100
Message-Id: <20200722100705.7772-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
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
index d6bacc878500..6cd3edb2eaf6 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -635,12 +635,18 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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

