Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A90C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B8208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P86071V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEQwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:52:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44634 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCEQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:52:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id n7so7852216wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okCxADSi/XY9CnlYiTmN0nDKDcnaKRsPlFnUGxBGBDw=;
        b=P86071V0lLLIljNo2bRtNtc+CevjRLr9BZPf9ogbVLMbsgiY2pzed/yMW71FucMhYQ
         gPlqsEw5om+Bn+B0KISIxzHV/NcJZZq8dbyB1+u8hGpEcaH+fgXSoRBHgvXHkFMo2p2t
         6MWsg5/Qh2qabxtx9vauxbteOXR+gTqAiHgFztJW0pcQCEatBI5p10dfWEHCquBJaaSX
         VqlsBkxBmwerKDZVkjceiDp8xC3yXMNnoxMbSt1V4SOtrvW65khoopyfLubxLj7G0N1Y
         SrHlP2WPVe/iGZ2996L4vSfWubsVvN24Ahl2zhovkkPcD10DH82xjtq9FGkfmtwqp+Rd
         tynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okCxADSi/XY9CnlYiTmN0nDKDcnaKRsPlFnUGxBGBDw=;
        b=IymyM9aTqFrecgKCQjb8HgsowUVxB0Oaw3APm9vOUsASuc32hftqfDzDw8vch+TmNR
         4njPOH5p16ykCvk4qSqw35j3ivvc7htryNMmFymW4Ui7yDL01+NulxJFOcvV6o45xgir
         pyOzOZ1ahpW76geNnupkM2+X4SvKPKwc/bBBGHbGyzWvRQk3wge7/2LKNDs5pyqy/w1a
         QmMj1CJE1Xo1gZBcWc3yrv6PldU3ruOIQZALopYJEK6FPqARmwjCxsZ+jXwwQtwL3WQ5
         vxE3kaqm4/7FhooyvZlOpq/HY4p+UXe5Tr4Y2pQidfUUYCsBZJwoKc4wX/GcMKo66FNd
         BAAA==
X-Gm-Message-State: ANhLgQ0UZP7x6H4139n4kooUMgA0bRmwW/iLHdZRv1cYWhR8RPphTtgp
        MHYFHFQ1Xp+FpkdT38XvYr1pIw==
X-Google-Smtp-Source: ADFU+vsXV4mCLrfRyf2z3uo3kGyUR05feC6JrvWPvGqxsCAU5I8Y73jIv4EYZQE2CykTtulgynK2yA==
X-Received: by 2002:adf:914e:: with SMTP id j72mr11213015wrj.109.1583427140244;
        Thu, 05 Mar 2020 08:52:20 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id x8sm34019834wro.55.2020.03.05.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 08:52:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: core: validate nvmem config before parsing
Date:   Thu,  5 Mar 2020 16:52:12 +0000
Message-Id: <20200305165212.26525-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem provider has to provide either reg_read/write, add a check
to enforce this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c05c4f4a7b9e..77d890d3623d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -339,6 +339,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!config->dev)
 		return ERR_PTR(-EINVAL);
 
+	if (!config->reg_read && !config->reg_write)
+		return ERR_PTR(-EINVAL);
+
 	nvmem = kzalloc(sizeof(*nvmem), GFP_KERNEL);
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
-- 
2.21.0

