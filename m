Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18132C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43C5206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593506410;
	bh=4rWqQhg+5mtxmFhsb50rEyT4z/1f9ATHJuUDJBaS3uo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pMqZi/dZxYc9E6uemsuNbFYuWae06GB9DlMkkwITE7n/9J0GvHg3pyQ6A+TsjQkDf
	 WDRyV4H/braGr1mhdU1romigi0nYgl3Am8Ot5N9IiIHkmz6gM8x00bXW0M1sGgxWmV
	 BYILhKv+J/RhZrlxo5kbVrTrEsFCqFVIrsHrGYUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgF3IkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:40:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38916 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgF3IkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:40:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id b25so17884947ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DjoSzu9rqnu2RmMjvpMxlvhGdgx+omtrZnaQOhXDhEw=;
        b=Mta7160BtbOYXtIQOeBcAKSuyVdqekwUdxRGhQVjzJ83SBFoAe6pOI/SD6v/8OKjFl
         CEUxRLkaETcYhfo+u1UDbSlaM9BhciWlnhdoqiEuVENZbUaV+K1sKioauaMQ8iy/gm/2
         5W6fMdku0B5k5unVQj36TVwmJAH0I56xQJXJ3nbEW/u1390ggbXMHa0X15UvXv7wuqg1
         sJqOysG4NGEwXN2WSeR1v7K0UfVHtXeZ1XT7YzJgXy9ZWap4GnHlD3mz1DFkEmina0h1
         gY6lo0LjnIFIA8UqGq96ofAr7mosxyCeTz4UFTJO33d/1vPNuC0ER/UySA76WRn7PoG4
         oaSg==
X-Gm-Message-State: AOAM530ZwY8ZcXUTkaff/C9qsbfHs8k5fstCy8LXhbPqhJHItUyXfbeT
        KdHpqNVTdR/ravZhXoEMGtW4LqzFefo=
X-Google-Smtp-Source: ABdhPJxpHAXN99fomr5eH8btMJZMUmI29cf1Qw6iekH1htEBKR4Cnx9Ifc6Ihk/KMYuyj3SQf0g3Nw==
X-Received: by 2002:a2e:6e01:: with SMTP id j1mr8773989ljc.442.1593506403007;
        Tue, 30 Jun 2020 01:40:03 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n7sm508517lji.97.2020.06.30.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 01:40:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jqBo7-0001pQ-QM; Tue, 30 Jun 2020 10:39:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] mfd: lm3533: expand control-bank accessors
Date:   Tue, 30 Jun 2020 10:39:48 +0200
Message-Id: <20200630083948.6987-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the control-bank accessors that were implemented using macros.
This allows the definitions of these exported functions to be found more
easily and specifically avoids a W=1 compiler warning due to the
redundant brightness sanity check:

drivers/mfd/lm3533-ctrlbank.c: In function 'lm3533_ctrlbank_set_brightness':
drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
   98 |  if (val > LM3533_##_NAME##_MAX)     \
      |          ^
drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro 'lm3533_ctrlbank_set'
  125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
      | ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mfd/lm3533-ctrlbank.c | 94 +++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlbank.c
index 34fba06ec705..2537dfade51c 100644
--- a/drivers/mfd/lm3533-ctrlbank.c
+++ b/drivers/mfd/lm3533-ctrlbank.c
@@ -17,7 +17,6 @@
 #define LM3533_MAX_CURRENT_MAX		29800
 #define LM3533_MAX_CURRENT_STEP		800
 
-#define LM3533_BRIGHTNESS_MAX		255
 #define LM3533_PWM_MAX			0x3f
 
 #define LM3533_REG_PWM_BASE		0x14
@@ -89,41 +88,33 @@ int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u16 imax)
 }
 EXPORT_SYMBOL_GPL(lm3533_ctrlbank_set_max_current);
 
-#define lm3533_ctrlbank_set(_name, _NAME)				\
-int lm3533_ctrlbank_set_##_name(struct lm3533_ctrlbank *cb, u8 val)	\
-{									\
-	u8 reg;								\
-	int ret;							\
-									\
-	if (val > LM3533_##_NAME##_MAX)					\
-		return -EINVAL;						\
-									\
-	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_##_NAME##_BASE);	\
-	ret = lm3533_write(cb->lm3533, reg, val);			\
-	if (ret)							\
-		dev_err(cb->dev, "failed to set " #_name "\n");		\
-									\
-	return ret;							\
-}									\
-EXPORT_SYMBOL_GPL(lm3533_ctrlbank_set_##_name);
-
-#define lm3533_ctrlbank_get(_name, _NAME)				\
-int lm3533_ctrlbank_get_##_name(struct lm3533_ctrlbank *cb, u8 *val)	\
-{									\
-	u8 reg;								\
-	int ret;							\
-									\
-	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_##_NAME##_BASE);	\
-	ret = lm3533_read(cb->lm3533, reg, val);			\
-	if (ret)							\
-		dev_err(cb->dev, "failed to get " #_name "\n");		\
-									\
-	return ret;							\
-}									\
-EXPORT_SYMBOL_GPL(lm3533_ctrlbank_get_##_name);
-
-lm3533_ctrlbank_set(brightness, BRIGHTNESS);
-lm3533_ctrlbank_get(brightness, BRIGHTNESS);
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val)
+{
+	u8 reg;
+	int ret;
+
+	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_BRIGHTNESS_BASE);
+	ret = lm3533_write(cb->lm3533, reg, val);
+	if (ret)
+		dev_err(cb->dev, "failed to set brightness\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(lm3533_ctrlbank_set_brightness);
+
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u8 *val)
+{
+	u8 reg;
+	int ret;
+
+	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_BRIGHTNESS_BASE);
+	ret = lm3533_read(cb->lm3533, reg, val);
+	if (ret)
+		dev_err(cb->dev, "failed to get brightness\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(lm3533_ctrlbank_get_brightness);
 
 /*
  * PWM-input control mask:
@@ -135,9 +126,36 @@ lm3533_ctrlbank_get(brightness, BRIGHTNESS);
  *   bit 1 - PWM-input enabled in Zone 0
  *   bit 0 - PWM-input enabled
  */
-lm3533_ctrlbank_set(pwm, PWM);
-lm3533_ctrlbank_get(pwm, PWM);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val)
+{
+	u8 reg;
+	int ret;
+
+	if (val > LM3533_PWM_MAX)
+		return -EINVAL;
+
+	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_PWM_BASE);
+	ret = lm3533_write(cb->lm3533, reg, val);
+	if (ret)
+		dev_err(cb->dev, "failed to set PWM mask\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(lm3533_ctrlbank_set_pwm);
+
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val)
+{
+	u8 reg;
+	int ret;
 
+	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_PWM_BASE);
+	ret = lm3533_read(cb->lm3533, reg, val);
+	if (ret)
+		dev_err(cb->dev, "failed to get PWM mask\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(lm3533_ctrlbank_get_pwm);
 
 MODULE_AUTHOR("Johan Hovold <jhovold@gmail.com>");
 MODULE_DESCRIPTION("LM3533 Control Bank interface");
-- 
2.26.2

