Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F6FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8213320775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5nLXbZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgFZMuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgFZMuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:50:09 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40BC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:50:09 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w18so6298726qvd.16
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WKhKgNFFiDRIRCfQcIC/1NT6EzoOyImEXLP9eqrvZ6Y=;
        b=T5nLXbZF9pc9kYrae6kOeupEHWwwV4k46/cfEIRTnZertZSQU7oZEilca8JO2ip7ib
         IyLyUKhg59sGsTpzGbDMRjkzsQE+3xkLJD3gXhhCGiwQ8DVmJbc9EjS/1o713f/bhuCp
         SUMjWICzYMPvVznZ3uoEY5iBAOgu/DJuXZDZhd23H076GfBJqffuGgCGwiCS3mRrh7XE
         n6SYa8VyPKSVsC6b2NKWj82LZLlVdFQBHtT2kTUqz0wVnnNFZlreRYGMhC7nEUGk74Kr
         3r5Qrt/y8MlFK2NOsXlMamTJEZeZXQpKiPQK3ocOf4Tey+1x3083zenJe3nkKuelWNsj
         h0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WKhKgNFFiDRIRCfQcIC/1NT6EzoOyImEXLP9eqrvZ6Y=;
        b=Xf34EV2jj2DUSuji5iYVVn+NME88zFhR1G87VpMlq5L6zYpsYB0Qk0ulvvHT5JldLn
         jaQYmCSmv+UCjQBOgVR3pfm4HvN5GCXMCwL2rm/BxjOEyDiVeZ8ulGtsbZmvuBDZFG0R
         YkJWEqp4N7zqo1KkYHaZCqUZi7SD1kqj712+wJlmhyyoCyhO8YwPWThdGSoNLXZ/mwQM
         EHh9GmG/ck2YZu/5EXOYC2Sv8CwLV+BThDccFwO4BszNY93GS3RBI/GoMK6MRfxLJyNr
         BtDceTMANznkKIVAh7Z14+H5+qbM72ToWldG2njPU2nwNdzZiXqzIqLcy2EBV4BWggS/
         fc1g==
X-Gm-Message-State: AOAM531KDfif+LKVHHN3fnVVvrqxOJelIEisELsRu+6K6L2QBy/wBVGS
        T1+rMA8KZDJ0cGQ9CpQIm1WIgAdU3EI=
X-Google-Smtp-Source: ABdhPJwFJutKIRKx0fzvzBEtwYcWv7isBew8f7hpfWe5Rc/JQv0WBDklJAxvVzGqCO9NspoJpGuz//CUSfo=
X-Received: by 2002:a0c:d442:: with SMTP id r2mr2880640qvh.59.1593175808590;
 Fri, 26 Jun 2020 05:50:08 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:48:06 +0200
Message-Id: <20200626124808.1886430-1-darekm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3] media: cros-ec-cec: do not bail on device_init_wakeup failure
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Cc:     gwendal@chromium.org, Dariusz Marcinkiewicz <darekm@google.com>,
        stable@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dariusz Marcinkiewicz <darekm@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not fail probing when device_init_wakeup fails. Also clear wakeup
on remove.

device_init_wakeup fails when the device is already enabled as wakeup
device. Hence, the driver fails to probe the device if:
- The device has already been enabled for wakeup (via /proc/acpi/wakeup)
- The driver has been unloaded and is being loaded again.

This goal of the patch is to fix the above cases.

Overwhelming majority of the drivers do not consider device_init_wakeup
failure as a fatal error and proceed regardless of whether it succeeds
or not.

Changes since v2:
 - disabled wakeup in remove
 - CC'ing stable
 - description fixed
Changes since v1:
 - added Fixes tag

Fixes: cd70de2d356ee ("media: platform: Add ChromeOS EC CEC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 0e7e2772f08f..3881ed7bc3d9 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -277,12 +277,6 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, cros_ec_cec);
 	cros_ec_cec->cros_ec = cros_ec;
 
-	ret = device_init_wakeup(&pdev->dev, 1);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize wakeup\n");
-		return ret;
-	}
-
 	cros_ec_cec->adap = cec_allocate_adapter(&cros_ec_cec_ops, cros_ec_cec,
 						 DRV_NAME,
 						 CEC_CAP_DEFAULTS |
@@ -310,6 +304,8 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_probe_notify;
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	return 0;
 
 out_probe_notify:
@@ -339,6 +335,8 @@ static int cros_ec_cec_remove(struct platform_device *pdev)
 					 cros_ec_cec->adap);
 	cec_unregister_adapter(cros_ec_cec->adap);
 
+	device_init_wakeup(&pdev->dev, 0);
+
 	return 0;
 }
 
-- 
2.27.0.212.ge8ba1cc988-goog

