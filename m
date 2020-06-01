Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB3CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA00E206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsMA2JyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgFARv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgFARvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:51:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B237C08C5C9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:51:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so251396plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4kQzqlSCAiGDPrwPoS10a6NS/WJiGKixInVwf23N/g=;
        b=jsMA2JyGDIA2nuPm/U8Q8emjpcS27scT4vh7LMJR8IPXxQsLi1oUbUHzimNDNTqPIa
         b1isEdpMDotZ0t9TLHTxyFpsHUX8Zf90IRJh6BKLJ9m5rgS7x5dFu3MnvbbD+ev0L+HQ
         ZVYTUKwVibT61Pv5o1OT4DhH8GY3h8Ux6dlxSO26HZZGpNf2OLWdpvyFpzLMd3P1dO6r
         ZvxhQirCPqo7fCWMMMZCGjhuPTgh3STIZwlyKSdVsosdrccbn0bZCxYBYQomYci+X08O
         cAOrV/Smjbyqm34RyA+QlZbH9QQHsFUS+OfqYVNjqzcpPZMUgY93oj14gxO/Hso1Jv2e
         4xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4kQzqlSCAiGDPrwPoS10a6NS/WJiGKixInVwf23N/g=;
        b=fkPAhpLBIBskzcMzXEfoPu25QIyz3BnNXqoUBcExgFGv1/AcJt3TxIuYt93Yk6kYW7
         5rDeOKCEwCW9vtMue0wjSev1ZJsxTEwQLxIDyX4PwCP4/xfCCsF+CSQtmiiY3EDNATIw
         zek9ONJOqOFz+N7//aWh3hM+YaIFxkMscJGsvj2wZ13BtOJlrLoGNuT1zUz7JzP2hKmM
         O8wHji6OW7zengDbfzS4GcQudVFhV88dM5+4nG5wh+r3sJ875qBAd+gVe8SMsDouzYW+
         9mpa4Ys8YoOq2kiYZh5JPtOOO+0xSkflv6QkTEprENk5c+F73RpLN/Vfv/qFh8lwUHJq
         9gmA==
X-Gm-Message-State: AOAM533UULlwjTNWKnUB7LfbP3r5zm9XjxwuRbKYUyDd56IRfF46eWcd
        dfu6OBTAs84NvOcEPE0PKSdeMw==
X-Google-Smtp-Source: ABdhPJzgGKvoHRtBwkv2pzmRwy7lyhLJmxlvRmupu2umM7NcN6smBZrrcXePAmh3ySolMbCMraLA/Q==
X-Received: by 2002:a17:902:6b0a:: with SMTP id o10mr19376036plk.121.1591033907658;
        Mon, 01 Jun 2020 10:51:47 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k12sm58219pfg.177.2020.06.01.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:51:47 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com
Subject: [PATCH v4 6/9] remoteproc: Refactor function rproc_boot()
Date:   Mon,  1 Jun 2020 11:51:36 -0600
Message-Id: <20200601175139.22097-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175139.22097-1-mathieu.poirier@linaro.org>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
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
---
 drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0be8343dd851..48ddc29814be 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1503,7 +1503,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
  */
-static int __maybe_unused rproc_actuate(struct rproc *rproc)
+static int rproc_actuate(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1923,24 +1923,30 @@ int rproc_boot(struct rproc *rproc)
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
2.20.1

