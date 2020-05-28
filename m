Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790FEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D3F207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6fZFOPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404677AbgE1PrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404678AbgE1PrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:47:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5F8C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q9so3261361pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyQEzGyzaYw5IWn5g/75UMLFSkhlAAtyUxzYzVWL1hI=;
        b=B6fZFOPXlINNumfwCvb4M1+Lbl67pHh2jE6GhmJTySjRkf+DhDhRtqbsCH3uHuPArI
         NNdypH3hqwOSn3+AgnW7EdJU6gonFzCjQQeoDNGHRN8Y5zL9d+bjfozfI83PBjSIEiFh
         wcKk/G9OyoVmTtdVNO25Uyn5Ve2jHzU65xddhYSZT/ctnl72a3e3/mEhasjWD9Uj4yWa
         aBxGFqdpDceEnDm4mCrxmEQ3a1j2St1E6gQGtbVNT+RlXnU97aWAlEl0DGVosRGrImiZ
         du8WVebIRNthoE/I9ytP4vciOfDB/VyXzom+emikQzgl5LIk2rO9RRLh6Gy9o3N7fCGC
         js8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyQEzGyzaYw5IWn5g/75UMLFSkhlAAtyUxzYzVWL1hI=;
        b=ROrzo8CJOurUFufMHyFXwypNDqE4bM9Yvx7ammm+/R70lIDsOEtZSARz6Q2z9XdrdH
         nb0efKsseC/GCGWFSgdxVZgTRSKZ1zMQTKC0RNSYvWaYpzhGvi70ajeUfKox0nq1LUZ/
         tZSlx5VzO5UHEeaj/Mx/h76h5yAJ5iN7d4QnK3yaOhaHoPmFSbQoHx60G93LkJbS+yY3
         e6bSaMbWQS3aqqygGC6pY2FV0VUCCt25OVMMbijpB6/O0vC5hy92CIU2EEAe76X/tAtw
         5vThu3w2Xp3+lSqdpXW08WGNGKoSvzF+vciJQS5zT+POGnCvoE9Ef1ggvri3j5EP5zC4
         Z+pg==
X-Gm-Message-State: AOAM533HPZE7KPrzlzXcVaD9/0SrmRPY23y7y03ThWSuC0vvABNAsnAM
        DkG3hIqZFynbTK6z0bhHB7q87g==
X-Google-Smtp-Source: ABdhPJwuG1bZv/tBfujMCsmSXvQMl1Vfa8akWgxhHGSKy4wVvRhdiY4eDH3JPL7Kki/GZrRRFeyvyQ==
X-Received: by 2002:a17:90b:1482:: with SMTP id js2mr4611348pjb.54.1590680823540;
        Thu, 28 May 2020 08:47:03 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id y22sm5212551pfc.132.2020.05.28.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:47:02 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v3 1/5] regulator: Allow regulators to verify enabled during enable()
Date:   Thu, 28 May 2020 21:16:21 +0530
Message-Id: <20200528154625.17742-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528154625.17742-1-sumit.semwal@linaro.org>
References: <20200528154625.17742-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulators might need to verify that they have indeed been enabled
after the enable() call is made and enable_time delay has passed.

This is implemented by repeatedly checking is_enabled() upto
poll_enabled_time, waiting for the already calculated enable delay in
each iteration.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 drivers/regulator/core.c         | 28 ++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7486f6e4e613..06199f182114 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2409,6 +2409,34 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	_regulator_enable_delay(delay);
 
+	/* If set, poll upto poll_enabled_time uS to see if the regulator
+	 * actually got enabled.
+	 * For each iteration, wait for the enable_time delay calculated
+	 * above already.
+	 * If the regulator isn't enabled after poll_enabled_time has
+	 * expired, return -ETIMEDOUT.
+	 */
+	if (rdev->desc->poll_enabled_time) {
+		unsigned int time_remaining = rdev->desc->poll_enabled_time;
+
+		while (time_remaining > 0) {
+			/* We've already waited for enable_time above;
+			 * so we can start with immediate check of the
+			 * status of the regulator.
+			 */
+			if (rdev->desc->ops->is_enabled(rdev))
+				break;
+
+			_regulator_enable_delay(delay);
+			time_remaining -= delay;
+		}
+
+		if (time_remaining <= 0) {
+			rdev_err(rdev, "Enabled check failed.\n");
+			return -ETIMEDOUT;
+		}
+	}
+
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
 	return 0;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 29d920516e0b..bb50e943010f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -322,6 +322,9 @@ enum regulator_type {
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
  *
+ * @poll_enabled_time: Maximum time (in uS) to poll if the regulator is
+ *                          actually enabled, after enable() call
+ *
  * @of_map_mode: Maps a hardware mode defined in a DeviceTree to a standard mode
  */
 struct regulator_desc {
@@ -389,6 +392,8 @@ struct regulator_desc {
 
 	unsigned int off_on_delay;
 
+	unsigned int poll_enabled_time;
+
 	unsigned int (*of_map_mode)(unsigned int mode);
 };
 
-- 
2.26.2

