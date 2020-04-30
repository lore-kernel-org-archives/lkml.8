Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1498C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B004F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGfETTCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD3TGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgD3TGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:06:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3CC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r4so3259280pgg.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zx0E+HqaN1bUC1TO1dtOQ7VQXn9VN+e8/WjHREoxvcw=;
        b=pGfETTCUGJ1eplG30Gh134q0RJpVt2LEqKse+6q9W9S31dTzgSwHfioljRBmVjtup6
         K+Z9SU8M2FodJMg1JhhKs18gVO4xC1z+Vo79wh/+K9RYUoH5cd3LKWKw09QWmvhjC6Z/
         K5/OUPMjTqydRKN53yusuaggvVJ0gVZgjzvt5UyKdz0upTJplIJYPUP6jpcllIvFOJ4J
         q3FazBste8FZQJvxSc6zCQwN/jHQfqP39vgbHdMxz4mdj3GNnhFWB5qqLCcul8nAY8sZ
         1gr+7UfyZ8T4lEaM/hPDv9tl1KY5MBoBJz8ISvTBM5x/TpdgtTwUKjHT9qIRfAm6+ya6
         DEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zx0E+HqaN1bUC1TO1dtOQ7VQXn9VN+e8/WjHREoxvcw=;
        b=V/bZosmMpeD+LRnPrM4/dzD1KR9NiZThtr611r7H/9eJKXdqi/iPmJBXAzdZbGiwx5
         eTxxN5dJG9nQ5HFxa2qAJ7t0N+YM9ThKTyYw9qgijXRiJvMZ0jUifBVm0wW2nijsdK1W
         +EsJ/KrJElCv0B148CbADt+2Ai8qBEnOLLoI9jw82WVcaVzJhQwgIMWwvXZia0z8tB6X
         RZXJhPYAPeLnc+6I9RcCcqvr/a37wSECUaNUcoAMG/uUyhJVO2g3MS8oddyDNjkFtENo
         A2d67pKaje9lxEGGkR+OA3w+P43zx0y74ISvxKdd1cQLKu7Dn0MxBvIH1VK4nwgXLw+f
         DuUg==
X-Gm-Message-State: AGi0PuZF68XWk91xDRWfb3wxxUR2ktmsDRLHSqx1W/bnLFSBKPbRVG1z
        6fUzi6dhkk5ft4Ppf3aYf8NP
X-Google-Smtp-Source: APiQypIz7M4XRoff71ERL1h7ZhbbJwJXnruE5yMtB50LeY3NFYKPbTHrJ6OexVFO51GAQqylNa670Q==
X-Received: by 2002:a63:de49:: with SMTP id y9mr349872pgi.435.1588273575577;
        Thu, 30 Apr 2020 12:06:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id l37sm467863pje.12.2020.04.30.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:06:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/6] bus: mhi: core: Make sure to powerdown if mhi_sync_power_up fails
Date:   Fri,  1 May 2020 00:35:51 +0530
Message-Id: <20200430190555.32741-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
References: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

Powerdown is necessary if mhi_sync_power_up fails due to a timeout, to
clean up the resources.  Otherwise a BUG could be triggered when
attempting to clean up MSIs because the IRQ is still active from a
request_irq().

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 3529419d076b..e7c831867a23 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -1045,7 +1045,11 @@ int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
 			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
 			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
 
-	return (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -EIO;
+	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
+	if (ret)
+		mhi_power_down(mhi_cntrl, false);
+
+	return ret;
 }
 EXPORT_SYMBOL(mhi_sync_power_up);
 
-- 
2.17.1

