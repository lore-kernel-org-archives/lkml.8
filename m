Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D40C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF34020723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj56ULPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgFFOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgFFOju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:39:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDDC03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:39:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 23so5488368pfw.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQtShVWRbRV3vDwG2MUTjwFzTibMeozspEDCmK0TQQY=;
        b=Oj56ULPGaz66CE8lVQtuuiU9Z+YALKkHNGtBqomALKQ9XR5zma2jjWXZs+9VIqaql/
         duhC8Odx6uNYhTme6vqZYT+xJmDMzE2ednBkTfqzuhsFe37bn9eXLy86XtZ3+BCDzgJk
         GYJcRgItdMVRWgulhJPOLg1aJ4U5OqeIcipxHVm/9J2QJVDHvnjrRYGj7Gzp0TkdZ0sl
         svQbqlgMkSHOkR24fDI+As8PZ26wxHQnIExfaMI4KMmFlO2mUOGhAckGJJkp3uG71RsB
         9KNT0rmp+Eb837kTALL3WJ/vEJOtnMf1ndaOX6pPLs90/35c91lOsq0l7QsPHg/tgkB6
         FUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQtShVWRbRV3vDwG2MUTjwFzTibMeozspEDCmK0TQQY=;
        b=SxD3iANFx6oSyd0x2cXetBc9oW1+mRdhYLKK/Gb+qBEga9LAj+N7oUPl6kgWIyAoky
         2ODh+oCaNfMVJxNzbvFRrpZrokNwTVhuePJW42SvVPsxtfXUUo5GfA1PXNQJ3N++d1iD
         iC1Ys8FcULyh7RgO4DrBKUGYnEJta2D3aIP+givE/Dwl2fe/ds432ovbMX3tYXb0t5ue
         tLF6n1M4VXw6NNcOe4pDk7ETXgYnJwYXCvgMFQlK+RFA3p6pE3VDCU3U3cuBKINLFizl
         1VQuSTLhWkG8QTIE55zAnww3WIirojpJyetOiL4nnzwOWJfx290Gjjud+8hsYHJH1zlQ
         U6hQ==
X-Gm-Message-State: AOAM533qZjgickjLia3ToC9V84FDKhrVAx9f4VdyebHkZAPj4nvcKBk2
        jOb+Pc33yOVRBbhRNI/5wdc=
X-Google-Smtp-Source: ABdhPJwP4glFkSUhej2ZQC5gO9u9guBkgKYNiD/VR66L7SisOLQoldYfLWtGFzunssNN+0QaphNvSQ==
X-Received: by 2002:a63:658:: with SMTP id 85mr13331078pgg.181.1591454390416;
        Sat, 06 Jun 2020 07:39:50 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id p14sm10938108pju.7.2020.06.06.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:39:49 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sundar Iyer <sundar.iyer@stericsson.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mfd: tc3589x: Use devm_request_threaded_irq() to fix  the missing undo bug
Date:   Sat,  6 Jun 2020 22:39:41 +0800
Message-Id: <20200606143941.2869594-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver calls request_threaded_irq() in probe, but it misses calling
free_irq() in probe's error handler and remove.
Replace request_threaded_irq() with the devm version to fix it.

Fixes: 20406ebff4a2 ("mfd/tc3589x: rename tc35892 structs/registers to tc359x")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mfd/tc3589x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 67c9995bb1aa..0fd8ba1c68d0 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -412,9 +412,9 @@ static int tc3589x_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	ret = request_threaded_irq(tc3589x->i2c->irq, NULL, tc3589x_irq,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "tc3589x", tc3589x);
+	ret = devm_request_threaded_irq(&i2c->dev, tc3589x->i2c->irq, NULL,
+					tc3589x_irq, IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT, "tc3589x", tc3589x);
 	if (ret) {
 		dev_err(tc3589x->dev, "failed to request IRQ: %d\n", ret);
 		return ret;
-- 
2.26.2

