Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A56C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7CD206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWfnaSFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgGGVAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgGGVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35CC08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:00:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so19672511pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XijBbeKyE9SPoHBAdYK5pDnTOJyJsJjOSAGz5audssw=;
        b=rWfnaSFW15Xw5FIltXzrZKUeN0skrtFSZBNZlW/9z3uCkDSE+53LBP131GuN8DCtPX
         GbCUPrtRoD6+4w7HOp9aYs47bAZ6uSNITfmLhFQAYYgHDu6oj3+4eqTmAk7+ncSEqgzt
         EqfS5+Df5YWsXZdKXQbolUlbAzPBNQCkL8MMww1Kp031zVDjaWucDg88HsTDzkVqJCAJ
         ga5RxaaKnZ0p+CXalBPW3H5kw70E6e5EVkt00KwyiMNeuW0Qe0d/if7nFioS08kfhaI3
         WhrX+d5uV39vUFTxlfuGeYGVI0eHEs5P1qsp3vF4NuWjlPN1lg2U6vYdB/rX82AM4qQX
         mnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XijBbeKyE9SPoHBAdYK5pDnTOJyJsJjOSAGz5audssw=;
        b=tZ+eB3pgQ3+nGfSR4tdPDBOwH2wwyR/+5dYNemVYz1xLvImg9un/RnkE2CcG8IarPT
         QBwunI1KhqDdH1AgYBRJki2RZgkZ2sYyjXyS6DhUc2Gn7VQgnEfEAeEoTc3fmqllPaEe
         AWybcKqEr7n1LnHhE0yNnJrgJ9+TkvuTo9dO5ZAA5m9jARPacnCd+vCJfmsrXHnZYlYJ
         rR4Z9QhIgrjFkTPKpzsKowzaQg7N3XqQyMtuhjNhGRTX3RkH5ZIbL9NGsPi00jrTBjIY
         L88UXkyBIUDVU5M6CM96g/rrLs5Pu5qrCVwZZgMAWCER7xTmRyHBoni70twKSHS20xUQ
         yjFQ==
X-Gm-Message-State: AOAM530ca80BMtM5qEud+YZ+Ir7BktcBTVub2ix4lGpuRnOUoomF+JPS
        Un8gXC7EtM2u1tzOkfIIyiaOPrhmh8M=
X-Google-Smtp-Source: ABdhPJxJfD0Jkh9Hb2JlSArI9twloH94qq4vcsjeQsCvULj9K2kwwtdLJpL4yLB3oPqMKhQvxU5N9g==
X-Received: by 2002:aa7:9542:: with SMTP id w2mr6424266pfq.273.1594155623009;
        Tue, 07 Jul 2020 14:00:23 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm13738061pfb.45.2020.07.07.14.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:00:22 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/9] remoteproc: Refactor function rproc_boot()
Date:   Tue,  7 Jul 2020 15:00:11 -0600
Message-Id: <20200707210014.927691-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707210014.927691-1-mathieu.poirier@linaro.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rproc_boot() to properly deal with scenarios
where the remoteproc core needs to attach with a remote
processor that has already been booted by an external entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ad500c291d5f..caea920ce4b8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1494,7 +1494,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
  */
-static int __maybe_unused rproc_actuate(struct rproc *rproc)
+static int rproc_actuate(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1905,24 +1905,30 @@ int rproc_boot(struct rproc *rproc)
 		goto unlock_mutex;
 	}
 
-	/* skip the boot process if rproc is already powered up */
+	/* skip the boot or attach process if rproc is already powered up */
 	if (atomic_inc_return(&rproc->power) > 1) {
 		ret = 0;
 		goto unlock_mutex;
 	}
 
-	dev_info(dev, "powering up %s\n", rproc->name);
+	if (rproc->state == RPROC_DETACHED) {
+		dev_info(dev, "attaching to %s\n", rproc->name);
 
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto downref_rproc;
-	}
+		ret = rproc_actuate(rproc);
+	} else {
+		dev_info(dev, "powering up %s\n", rproc->name);
 
-	ret = rproc_fw_boot(rproc, firmware_p);
+		/* load firmware */
+		ret = request_firmware(&firmware_p, rproc->firmware, dev);
+		if (ret < 0) {
+			dev_err(dev, "request_firmware failed: %d\n", ret);
+			goto downref_rproc;
+		}
 
-	release_firmware(firmware_p);
+		ret = rproc_fw_boot(rproc, firmware_p);
+
+		release_firmware(firmware_p);
+	}
 
 downref_rproc:
 	if (ret)
-- 
2.25.1

