Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD92B20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLI75zhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgFVLqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgFVLqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:46:52 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC0C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:46:52 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v1so12436043qvx.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j19qINoTS0ZUB5VmYI6tnBHGsC7YwPPKrYVY46VAbqw=;
        b=TLI75zhb3hcV71NRaoY51FnnY5U5mwBw4h8IRj01n/GB6WFaLkNAhOJ8mnrRi3Kt3U
         D5/gxSxGrus9cNQo5m1Gcy6XqXBDCOw3JYI8VmnY7KeZnA7NkePDxNoyI09U/OSYdl2+
         hZ/u5zK+54x66LU6Nq3QU4GNpunW1AZfRo/MZdfk+il4B1WHnDB1+DQ7fPll1n+1XZ+L
         y6GDaAQ/h9xMJ4jkd550Ctde6Of3UWj0ud5H+4FdWvJ7l8GD/L64pmBh0KUAiTwOsVGu
         PIXKyL4z1yLzsRB7rNwGrL+OhEOFvq49zwARR2aWdduxZjBc784HqWV1e9Xm+McOFmSC
         UTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j19qINoTS0ZUB5VmYI6tnBHGsC7YwPPKrYVY46VAbqw=;
        b=egZ7OXYElDOd6i54z1Q+pw50pRAAX7YigI6cV3ZlMB4FQq6j3HQUn6MwhUYmthvycE
         erejC+WgUX3OTG41xFRiNQWzNMZKwRGMSHVzYcSBFyPZlPL7Aw/xKt52i7SbkXImq3hI
         SVmXIhoa0MWE9bPWnYD1EClVm76DR1CAE9fUo3scWPYeCOBrd1i7FGQpT5pQpd9IryqV
         sUHmiejxJGcZqKDZBJW2FcosQx2VYPU48ztO0/hV9EhZmDHwgC7+io6oKX7F4EC/JArd
         0gpbdPYSgFikaBeMG9PEYG1jTLD80Mw091Zs8I3JFLSYYc2V5ThGoFHdG3CFcoRdUgkb
         oQPg==
X-Gm-Message-State: AOAM5331ed1vfGRwF9/mP4K3Jj+C3AKoeRkZk8b8ZvVd3aNDeYK/JHrP
        pNJpJL+DP+Ov9BnMyIz9sxhCzmcEFLI=
X-Google-Smtp-Source: ABdhPJxtMErmxXcluP2xrN//Yw4g53tHUvtp06FFk3nIs69FZwkQ9eA3ZuOzcfzQAtTaVbdUTCxXPynvXwE=
X-Received: by 2002:a0c:8d46:: with SMTP id s6mr21215475qvb.241.1592826411606;
 Mon, 22 Jun 2020 04:46:51 -0700 (PDT)
Date:   Mon, 22 Jun 2020 13:46:36 +0200
Message-Id: <20200622114639.165874-1-darekm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2] media: cros-ec-cec: do not bail on device_init_wakeup failure
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org
Cc:     narmstrong@baylibre.com, Dariusz Marcinkiewicz <darekm@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
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
- The device has already been enabled for wakeup (by e.g. sysfs)
- The driver has been unloaded and is being loaded again.

This goal of the patch is to fix the above cases.

Overwhelming majority of the drivers do not check device_init_wakeup
return code.

v2: add Fixes tags

Fixes: cd70de2d356ee ("media: platform: Add ChromeOS EC CEC driver")
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
2.27.0.111.gc72c7da667-goog

