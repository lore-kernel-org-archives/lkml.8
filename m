Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE9C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9983F20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK8kOjm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgICScH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgICSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:31:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55879C061244;
        Thu,  3 Sep 2020 11:31:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so3819556wme.5;
        Thu, 03 Sep 2020 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9ZH/j53GXlXtOl/BQ9uwkwhVkecvfT9moRmFWFXpuI=;
        b=jK8kOjm7roy6BVmdk2I0XcrgumAoHriXRTAEgOCIaT9dR3afbgSoRBjZVnmUDCrq3R
         IIZVjTH25331ZhAQyTN130aLDIbO6PZBuA925HlsU2WLY3OK/BHhWLDBKkBAslBfose1
         PPiaM/39Zwc99SpbyZgoP8Kc18EbUClUXly9A66ALGnHqfaQyswKoKIjWUL2yOfzUagb
         hA7SBuYCWnOKLXhb/+I0jTK/7S25+cfXORgM8BkQZEIdpsiu9hwejBV7nxqa420fgDYp
         FG3RtoPpGtcVj++3YHkp3gR8XejAouFJgMgZtNmJC2K+wT/N7MHOSk02vpJJ8zEaqDer
         wuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9ZH/j53GXlXtOl/BQ9uwkwhVkecvfT9moRmFWFXpuI=;
        b=s67gVzMtPKFZ6oDmQUKr7q99JXPaiLvIfeKAM4q5nCTnoIH+bAu0O2tHD+b4Ox4yYN
         0bfxQAPoA5aVBQB23vWEYuVJ4Y6zIm81Dz+R6lxKDqxSOv6dls8YOLCTTP180sjjCNky
         LIEX2t14QgHvyhLUC0F9vJQPiItC/ep3dX9PySvAmAwR3uUCst96C52Pu0CCwtZaYCVp
         k3z3FRcF/SnQR4ZyIn6/KUhzHPK1SDNUmYh0CN0YDNgVyTF4qTNmg2TlwIPnQkQImp6W
         rQoMECNjLc6DFNT2k7WjM6Wc+7102tNreUPmmvCHZmxHCTJ956qBuYvTRwTP31kiJhQh
         0IgA==
X-Gm-Message-State: AOAM5323ktyH5YIpIrzAuxR5pQN+1VQYtRAFqbxQOhj2wWJp8lmkf+3U
        qQ4Zj0pMcf5p3OtsDCSHv8w=
X-Google-Smtp-Source: ABdhPJzFLj4rL1qlEO5LjfwC8tHQ4tlonDMT7uuWHldstzL2iP6tKtqQyVv/6QQ/mqzxzfy+2TiOeg==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr3770562wmb.82.1599157913902;
        Thu, 03 Sep 2020 11:31:53 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v12sm5812241wri.47.2020.09.03.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:31:53 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: media: atomisp: Don't abort on error in module exit path
Date:   Thu,  3 Sep 2020 19:31:34 +0100
Message-Id: <20200903183145.720727-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function lm3554_remove() checks for the return code for
lm3554_gpio_uninit() even though this is on the exit path and exits the
function, leaving the variable flash unfreed. Print a warning instead
and free flash unconditionally.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 .../staging/media/atomisp/i2c/atomisp-lm3554.c  | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
index cca10a4c2db0..621555b0cf6b 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
@@ -783,7 +783,7 @@ static int lm3554_gpio_init(struct i2c_client *client)
 	return 0;
 }
 
-static int lm3554_gpio_uninit(struct i2c_client *client)
+static void lm3554_gpio_uninit(struct i2c_client *client)
 {
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct lm3554 *flash = to_lm3554(sd);
@@ -792,13 +792,13 @@ static int lm3554_gpio_uninit(struct i2c_client *client)
 
 	ret = gpiod_direction_output(pdata->gpio_strobe, 0);
 	if (ret < 0)
-		return ret;
+		dev_err(&client->dev,
+			"gpio request/direction_output fail for gpio_strobe");
 
 	ret = gpiod_direction_output(pdata->gpio_reset, 0);
 	if (ret < 0)
-		return ret;
-
-	return 0;
+		dev_err(&client->dev,
+			"gpio request/direction_output fail for gpio_reset");
 }
 
 static void *lm3554_platform_data_func(struct i2c_client *client)
@@ -918,16 +918,11 @@ static int lm3554_remove(struct i2c_client *client)
 
 	del_timer_sync(&flash->flash_off_delay);
 
-	ret = lm3554_gpio_uninit(client);
-	if (ret < 0)
-		goto fail;
+	lm3554_gpio_uninit(client);
 
 	kfree(flash);
 
 	return 0;
-fail:
-	dev_err(&client->dev, "gpio request/direction_output fail");
-	return ret;
 }
 
 static const struct dev_pm_ops lm3554_pm_ops = {
-- 
2.28.0

