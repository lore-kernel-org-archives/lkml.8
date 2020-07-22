Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F18C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E28E206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dU63nrG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbgGVKIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbgGVKI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B9EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so1430965wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gY9Xz1b3hxtJwHsxB5opm7y/1T5Sf2OUR7Nr1mwtjs=;
        b=dU63nrG8GxOtfLcB/9q/SoMW237Sgf2oDNEAJ4G9kBmTWhK/l4eNxP5IVohk9oA554
         3Rg5em++QvjT3ihAV+6fBNf36USInKU8hog7ZyzD2TbVheqFI00Y0Aap6y2+TSNRV1Zw
         UaH59eJn4StncCzGD5h63tvJNINr3heiI04XN0Z3WSojSv2b0suSJmplx9A2GLA4gJaq
         FheaCZc4Hdbj8tGOzEEmH5AzJV4/Q784WdibgehpGUCA4ReRbWD4NKme202MMjlmxO7B
         I3hSNiqn2iJFuUcI33IH0QpcPuNV6qOJAHYzVXs4CKtp1DqDbRFlL0qrZ2vw29+zb6gX
         DNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gY9Xz1b3hxtJwHsxB5opm7y/1T5Sf2OUR7Nr1mwtjs=;
        b=r2S8D0jHSDNYOk+66+9uydMpc0bMsW/NFz7d8ONKLPHI1wrIC2eK6gzcNOLzQL7+jP
         MHZudcbeKg/Ltyeb1w3885EcB8f/Ky8ylfdCH33LlBf/drlI/aAo+gDpaOZ5y4Y+7Cyk
         I7vND/pb/TJrDl0m9SpLlWB+0YvJGs2JIetZbfOEKPy3YYAL9zpwyL/m5Xdqup4BuuNS
         qwA70a63Xz8I8cnreBQhmINfUDQUkCGNbzn9Qz3mL8D2CoO9OkaKD9ruSmayWcWL3k19
         8yjZS1rDBEawmCc2YJsCaKFDT3zx7oS+pD0Dn1KCxldViy5UOd1O0x/pq/TnwA0qnS3T
         z6Xg==
X-Gm-Message-State: AOAM533MVKRIEYMJICWP4zkJtiz438ywxbQM7AzomE0YN5C6EIlPCS1f
        /eosZ1oQs6p4hPSBA/1vu9eiBw==
X-Google-Smtp-Source: ABdhPJwPBcg2OXIW9gKUFMZ4tq+/d9mc63cIXd6nJyJgTC/kVTlH98ykPtimCKP1IEmYSHE0+y/chQ==
X-Received: by 2002:a05:600c:20d3:: with SMTP id y19mr8384930wmm.10.1595412506655;
        Wed, 22 Jul 2020 03:08:26 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/14] nvmem: qcom-spmi-sdam: Enable multiple devices
Date:   Wed, 22 Jul 2020 11:07:05 +0100
Message-Id: <20200722100705.7772-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guru Das Srinagesh <gurus@codeaurora.org>

Using pdev->id as the nvmem's config ID (which, by default, is
NVMEM_DEVID_NONE) prevents multiple instances of this driver from
probing because of the following error:

  sysfs: cannot create duplicate filename '/bus/nvmem/devices/spmi_sdam'

Use NVMEM_DEVID_AUTO as the NVMEM config ID to fix the issue.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 8682cda448d6..a72704cd0468 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2017 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017, 2020 The Linux Foundation. All rights reserved.
  */
 
 #include <linux/device.h>
@@ -141,7 +141,7 @@ static int sdam_probe(struct platform_device *pdev)
 
 	sdam->sdam_config.dev = &pdev->dev;
 	sdam->sdam_config.name = "spmi_sdam";
-	sdam->sdam_config.id = pdev->id;
+	sdam->sdam_config.id = NVMEM_DEVID_AUTO;
 	sdam->sdam_config.owner = THIS_MODULE,
 	sdam->sdam_config.stride = 1;
 	sdam->sdam_config.word_size = 1;
-- 
2.21.0

