Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A634EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D12920708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0J1aiih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgFVKFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgFVKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:05:30 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:05:30 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l19so12858304qtp.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sQYJaI8jg1FtyXfRAOTpTGsgFbeCT3+ddgfcyrzmU3I=;
        b=I0J1aiihsil5wiQkU7K7GOmQMprk6kzkAPOpm7BzCcZt690scULxje2gJ3fDfIgAxa
         MWc0es5FO8cmJuKtRnb2TB3vDqAjqnxi6o80+WZMCQwfILSRuk0o9p0IYdcd0jDqBD29
         x2ZCsGXW7CtNrz/YiRg8PNiO5kTUSRcZ5ELAHt1xsPVxqOPZmmw1wyyrn+MNtSlb/K2j
         wbPHq3KmTNF+Jg+U1RiElmcYTgKgL/RGpbhBwdg+yv6483AwR/lFXX4GllTKWZhT78P9
         GyivcgSvh1DyzmGEqSnBgX2gDyAJ+EN8QsfGLZCEup5tpgAR5gJl5wbSsm4SkTFQNdS/
         589A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sQYJaI8jg1FtyXfRAOTpTGsgFbeCT3+ddgfcyrzmU3I=;
        b=mUEdqA1GlwBVOa63ySl8Er0koLxo5Kuhbh6Z5xuDLxkeOBvReA5QAa08TRF8KGA3H8
         iUzQbrGipiXXMcOJk8N+AEXSFdzWz2DRt8zACIQZLY+7xxETIMHh+wmQnGYdQ1zzY1R6
         dNi4V9NPZT7G5zUEMWFwpeQXlbAMD1CAcOevPnxFmx3ozw3/3E4+7wEoT/vbRyz6nkqC
         Mc7y7vD+LdC57kQdPCNM4tB1VuBlsrcprY9+yFgGtFPCU+WZrGg0Fdyr3mdRsTZV1vTH
         r8fcRIynYLkl541FvhvRsMoH69gYtiLO4J/1yNLjRon7ecHjQXeJ3YCzTX7LpUP1Yriw
         7lBQ==
X-Gm-Message-State: AOAM5315YvsKtfaSGVe3Iy+DIXKhgD1CaWGtcLQMhwba1JqlO9K1+LMx
        bXcwmtf29GkqdEENsk8cUpBKgjo6MNM=
X-Google-Smtp-Source: ABdhPJxAEWerQnOAJjx0E0aofyvX8NhI7hAhGKb8LWZHdGGcfiJVHCpCSo39/WHBIA2aXaM2hsS1TasI6P4=
X-Received: by 2002:a0c:c249:: with SMTP id w9mr20533684qvh.149.1592820329627;
 Mon, 22 Jun 2020 03:05:29 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:05:18 +0200
Message-Id: <20200622100520.143622-1-darekm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH RESEND] media: cros-ec-cec: do not bail on device_init_wakeup failure
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org
Cc:     narmstrong@baylibre.com, Dariusz Marcinkiewicz <darekm@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dariusz Marcinkiewicz <darekm@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not fail probing when device_init_wakeup fails.

device_init_wakeup fails when the device is already enabled as wakeup
device. Hence, the driver fails to probe the device if:
- The device has already been enabled for wakeup (via e.g. sysfs)
- The driver has been unloaded and is being loaded again.

This goal of the patch is to fix the above cases.

Overwhelming majority of the drivers do not check device_init_wakeup
return value.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 0e7e2772f08f..2d95e16cd248 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -277,11 +277,7 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, cros_ec_cec);
 	cros_ec_cec->cros_ec = cros_ec;
 
-	ret = device_init_wakeup(&pdev->dev, 1);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize wakeup\n");
-		return ret;
-	}
+	device_init_wakeup(&pdev->dev, 1);
 
 	cros_ec_cec->adap = cec_allocate_adapter(&cros_ec_cec_ops, cros_ec_cec,
 						 DRV_NAME,
-- 
2.27.0.290.gba653c62da-goog

