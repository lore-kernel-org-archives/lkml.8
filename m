Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927F620738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkDb2DIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgFVMl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgFVMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:41:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22180C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:41:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so8110486pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSKivOm6p95vIF+xsCRXaxJ3RfMT5lkhjSXb8u6KQ/A=;
        b=NkDb2DIJjstzdPiJdgcoV7o5+9TSMEIkFBQ+LImKCcn68yw1O6jSJ0sJS3RUovdmvJ
         ZhrNk7JcomCIeopxGzxo/wiVYUYeX1Cv/kJoXZz0R+rpgvd1RWiMaOgaRJWIEzBK3n16
         N+dxNCqAhAqJJzL5AFAITBdwNUjof2bNxUUCX5X+7CNtXBmcdO3EgO4/uEsdOTb9oSEC
         pf2XsmG4GkSU2lshTb0Nw++svCUpbOFDqbHUDET+TwZVa4RGien0pdR6mLLpnm5zFKDX
         izayXw0yxcrHkDSDqLYe+aBdXmTfUgFMsjO6XBz5cR4Fbw16ziPdWjH+Z9f1cAnEozOh
         eI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSKivOm6p95vIF+xsCRXaxJ3RfMT5lkhjSXb8u6KQ/A=;
        b=epedPGa7Vy4/ryfnaGFVgjK72NoU7C1jAA8k8jXlZyl2Ty+3k/PSAFVUiJOnMAq44I
         DE/Rx0vQRJtY43ji2KdYk4wFgeFULNNVj+Z99L63BJLJlVy7DXyHHFgyN+ucwDqtnFkN
         v2kPxiSO8LJV9kJLVVFkBYRhz+GZo6JVoMvzKrDvzM3lN+7/+FLc783deQpvXSALu6uT
         MHJ79g3nsDLWkE6a+3mqwAH0xHm7EqHD5P64iM6SgHoVFFEJKsgaQ+0Pw/gudYYlUlYx
         RuXscBypDYvKg8nwKhcUf8uAwZ8lvh37DY83KrYiT9pCEF11jgyvKO0PzcozccZdeqbX
         /zvQ==
X-Gm-Message-State: AOAM533D9UyjXCXY/SZUIt30TuCgllnctONhQh+AlwN/F4kjh2l+pEBB
        EsgcKAPjkBpv3mC6Gtfs2KvhwQ==
X-Google-Smtp-Source: ABdhPJyG2/JwS7bC4HVB0uvJoH/UbZ7OpMiVe3Q06q9v0mo7oPqV1SK3siOBx609yancSdugVYIVTQ==
X-Received: by 2002:a17:902:8694:: with SMTP id g20mr19560597plo.332.1592829684630;
        Mon, 22 Jun 2020 05:41:24 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id i62sm14590581pfg.90.2020.06.22.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:41:24 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v5 1/4] regulator: Allow regulators to verify enabled during enable()
Date:   Mon, 22 Jun 2020 18:11:07 +0530
Message-Id: <20200622124110.20971-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622124110.20971-1-sumit.semwal@linaro.org>
References: <20200622124110.20971-1-sumit.semwal@linaro.org>
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
v3: addressed minor review comments, improved kernel doc
v2: Address review comments, including swapping enable_time and poll_enabled_time.
---
 drivers/regulator/core.c         | 63 +++++++++++++++++++++++++++++++-
 include/linux/regulator/driver.h |  5 +++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03154f5b939f..538a2779986a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2347,6 +2347,37 @@ static void _regulator_enable_delay(unsigned int delay)
 		udelay(us);
 }
 
+/**
+ * _regulator_check_status_enabled
+ *
+ * A helper function to check if the regulator status can be interpreted
+ * as 'regulator is enabled'.
+ * @rdev: the regulator device to check
+ *
+ * Return:
+ * * 1			- if status shows regulator is in enabled state
+ * * 0			- if not enabled state
+ * * Error Value	- as received from ops->get_status()
+ */
+static inline int _regulator_check_status_enabled(struct regulator_dev *rdev)
+{
+	int ret = rdev->desc->ops->get_status(rdev);
+
+	if (ret < 0) {
+		rdev_info(rdev, "get_status returned error: %d\n", ret);
+		return ret;
+	}
+
+	switch (ret) {
+	case REGULATOR_STATUS_OFF:
+	case REGULATOR_STATUS_ERROR:
+	case REGULATOR_STATUS_UNDEFINED:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
 static int _regulator_do_enable(struct regulator_dev *rdev)
 {
 	int ret, delay;
@@ -2407,7 +2438,37 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	 * together.  */
 	trace_regulator_enable_delay(rdev_get_name(rdev));
 
-	_regulator_enable_delay(delay);
+	/* If poll_enabled_time is set, poll upto the delay calculated
+	 * above, delaying poll_enabled_time uS to check if the regulator
+	 * actually got enabled.
+	 * If the regulator isn't enabled after enable_delay has
+	 * expired, return -ETIMEDOUT.
+	 */
+	if (rdev->desc->poll_enabled_time) {
+		unsigned int time_remaining = delay;
+
+		while (time_remaining > 0) {
+			_regulator_enable_delay(rdev->desc->poll_enabled_time);
+
+			if (rdev->desc->ops->get_status) {
+				ret = _regulator_check_status_enabled(rdev);
+				if (ret < 0)
+					return ret;
+				else if (ret)
+					break;
+			} else if (rdev->desc->ops->is_enabled(rdev))
+				break;
+
+			time_remaining -= rdev->desc->poll_enabled_time;
+		}
+
+		if (time_remaining <= 0) {
+			rdev_err(rdev, "Enabled check timed out\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		_regulator_enable_delay(delay);
+	}
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 7eb9fea8e482..436df3ba0b2a 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -305,6 +305,9 @@ enum regulator_type {
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
  *
+ * @poll_enabled_time: The polling interval (in uS) to use while checking that
+ *                     the regulator was actually enabled. Max upto enable_time.
+ *
  * @of_map_mode: Maps a hardware mode defined in a DeviceTree to a standard mode
  */
 struct regulator_desc {
@@ -372,6 +375,8 @@ struct regulator_desc {
 
 	unsigned int off_on_delay;
 
+	unsigned int poll_enabled_time;
+
 	unsigned int (*of_map_mode)(unsigned int mode);
 };
 
-- 
2.27.0

