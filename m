Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDDC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D3922202
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Blmo1t2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDTXQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726958AbgDTXQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:16:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD052C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v2so4527373plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTEL7VXRuB9x3J7iFIoyLEPVb//XmBZtBUO3PJZONRE=;
        b=Blmo1t2hNA5Nhl8IZ6xC6kLN7I+lNYYXK0HfbLRhutS5ju4VODLBg0UBXqvwCqX+qk
         pog+se1krB7PNztpQiESXBRCogbWO0NNGRWLsxxJvrLf33lYfVw6W9ERJaOIL4fah1md
         B3OHfkrX8m/AeD6MfDWpheDC335+pDKdx0NdbPnvHESilF86+NimM1sMe0GQoHrp+blg
         JwIoMAVJtoykdRTYkJQO/orU9cSZOoxmHUxbt/aGIyiPX8MqXjIhrwg9Zt7CZK6BRaQH
         S2V7lCYD+RouKjUyWyosTcXPI4IiOjcUJpVF/GjNecvg5j0dcYYv0n14ey5PsruVJnCY
         6TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTEL7VXRuB9x3J7iFIoyLEPVb//XmBZtBUO3PJZONRE=;
        b=HI99faJZJxNxRJA0015jTbad7G35wC+ftCPMmvYnLvv7vazyeSpk4ri3Zw2ec2WqK3
         ReJa6LQzpgPP+WZDgOM6Pyjn2n7UVE65kDD1cSD8wPzmbUvVsS6nPzMkcjMLnM8otksq
         egMd2PpFt8pXXi0tGJv42/UCbid75rluYDGVhD4eO1PZogL+E/YiNBl85TCwAzLAgZtb
         INxPNHNk5jGXGeJXGifgRj1LDvGPE0YyCSEXfnTpWM6OzT3c5LIFvPwEA3VLEdKiNafS
         UzdOHG5ke2/IuLPtwxxnlBK205d+DrPOAAEEw4h9mSBInvmllQ9RYMWCvXLsMC25QI/s
         xZ6Q==
X-Gm-Message-State: AGi0PuaabqEZTaDO/tBWM+t5IlNcqdUnf2d3S6CVbrzoi/RKz7PTVCbI
        LB/R/whNQqiftYZtNH1QleopHw==
X-Google-Smtp-Source: APiQypKTEDjpn7IQlVgv8ilHeqpZZwQjxIX0T8CCeJO73IN9hTAqrePdijKOsMIjIyyMhF9c9n6dkg==
X-Received: by 2002:a17:902:d303:: with SMTP id b3mr3324441plc.12.1587424564335;
        Mon, 20 Apr 2020 16:16:04 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l15sm435354pgk.59.2020.04.20.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 16:16:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     elder@linaro.org, s-anna@ti.com, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] remoteproc: Use kstrdup_const() rather than kstrdup()
Date:   Mon, 20 Apr 2020 17:15:58 -0600
Message-Id: <20200420231601.16781-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420231601.16781-1-mathieu.poirier@linaro.org>
References: <20200420231601.16781-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cases where @firmware is declared "const char *", use function
kstrdup_const() to avoid needlessly creating another copy on the
heap.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 8 ++++----
 include/linux/remoteproc.h           | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index d9e6949e4ac1..db8a15fc1e4a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1996,7 +1996,7 @@ static void rproc_type_release(struct device *dev)
 	if (rproc->index >= 0)
 		ida_simple_remove(&rproc_dev_index, rproc->index);
 
-	kfree(rproc->firmware);
+	kfree_const(rproc->firmware);
 	kfree(rproc->ops);
 	kfree(rproc);
 }
@@ -2009,7 +2009,7 @@ static const struct device_type rproc_type = {
 static int rproc_alloc_firmware(struct rproc *rproc,
 				const char *name, const char *firmware)
 {
-	char *p;
+	const char *p;
 
 	if (!firmware)
 		/*
@@ -2018,7 +2018,7 @@ static int rproc_alloc_firmware(struct rproc *rproc,
 		 */
 		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
 	else
-		p = kstrdup(firmware, GFP_KERNEL);
+		p = kstrdup_const(firmware, GFP_KERNEL);
 
 	if (!p)
 		return -ENOMEM;
@@ -2122,7 +2122,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	return rproc;
 
 free_firmware:
-	kfree(rproc->firmware);
+	kfree_const(rproc->firmware);
 free_rproc:
 	kfree(rproc);
 	return NULL;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0547676479d3..800b4f09dc98 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -489,7 +489,7 @@ struct rproc {
 	struct list_head node;
 	struct iommu_domain *domain;
 	const char *name;
-	char *firmware;
+	const char *firmware;
 	void *priv;
 	struct rproc_ops *ops;
 	struct device dev;
-- 
2.20.1

