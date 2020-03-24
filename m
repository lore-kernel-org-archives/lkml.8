Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73242076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjWU8qZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCXRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:16:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbgCXRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so4444012wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRGTc9IAY79JGkxpMI7o35GI//PMDT5D2HixNe1aVms=;
        b=NjWU8qZYawyV+2qEJBBMHOfkbMLTpxRR98WLKLPc0II5PXuprwHYmIK8qaZSoMN1If
         wFfFVKd24L9ijVXMW31gGDJsw/jjPmo3sekPgaQt904VXyyu80UMcH9glvkfzuXMBc9M
         N5AWLwdfhCTz/H5J8HlhW6kQzAVkqAhu6byMYACQtynlNUZZvMUIc1qvYEdSGw/vhoOY
         ASQpWsphLM+EYfg/PM4fqsnzlNbp8QtCPwDVto1Tma9rGcqln+HpjISjO0Wcand7hay2
         lyjoptpDU7ahPv9GEaKOcWMPTjL/vVyS4YgIh1Yg9GdU/MOTRIQygr7MBelzdxJWBQyB
         elJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRGTc9IAY79JGkxpMI7o35GI//PMDT5D2HixNe1aVms=;
        b=G3LXY5f7zHjpNboed0hiCjGGaf8ZrXfhsANzcd5WM2fev+eDaypsmkmZZSH93n7Ywq
         Nl4Kz8xWZSLM9qzbn0IzQvn9BUrmrDkM8BX6KdQBL3z8K1CkIgCPxOTRQWfImOKngrSw
         /DKtVb1Lo/sj8pi+gHToSjSaNNLwTqO/4ivbYLQmZM7LTRc49Zpc2T0uRm3DynKgnpKb
         IbyVsQiOEwGoJIIb4PO221V1d5K+gz4UkIR1niN5nzwoVArMY4NRq7sZDRjJfQ3ctYik
         hDKuxEtskeJHFuUpV0K3myXV62gpUkgyb3BBdIC5f/b+WAr16Zz58SveymxUTfzzDlDY
         sPWQ==
X-Gm-Message-State: ANhLgQ1e1QulMnrckZ7Eqm31s0eImyn+MSTXTL+oaeTGbV/ImRGWz6ZD
        nipJlfv0CfYaFzpJif1w8XQARQ==
X-Google-Smtp-Source: ADFU+vsd/oT2fspHScHAAtwcf0fZG0zaoER91AqIsPIMI0i8I4DVNOs9QBj7uQK3jGUpDBBka1zJUA==
X-Received: by 2002:a05:600c:22c1:: with SMTP id 1mr6335694wmg.29.1585070175124;
        Tue, 24 Mar 2020 10:16:15 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m11sm5269514wmf.9.2020.03.24.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 10:16:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] nvmem: core: use device_register and device_unregister
Date:   Tue, 24 Mar 2020 17:15:58 +0000
Message-Id: <20200324171600.15606-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use device_register/unregister instead of spliting them with no use.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 77d890d3623d..e8f7bea93abf 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -397,11 +397,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
 
-	device_initialize(&nvmem->dev);
-
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
-	rval = device_add(&nvmem->dev);
+	rval = device_register(&nvmem->dev);
 	if (rval)
 		goto err_put_device;
 
@@ -455,8 +453,7 @@ static void nvmem_device_release(struct kref *kref)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
 	nvmem_device_remove_all_cells(nvmem);
-	device_del(&nvmem->dev);
-	put_device(&nvmem->dev);
+	device_unregister(&nvmem->dev);
 }
 
 /**
-- 
2.21.0

