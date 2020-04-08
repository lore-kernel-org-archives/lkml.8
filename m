Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2355C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8334220780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoSrQxuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgDHLIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:08:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36083 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgDHLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:08:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so7373544wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jeVjBN/6H/gI6gMyuL/+Tdutryht/EUxewf1jqrLbh8=;
        b=CoSrQxuOgUErP6j4vE5Hnof3IlCEsZecLbmey7kO4uUjcv82/taslS3HKv0A+42o5L
         OfbEuUrdi0sjmzf9L9MH44bGbnbnhN2vWSuWO9+xJYWDm2mS2PpB9tDa4GSJWUxr1xxA
         Q8B6NmnYq8CJAjZTwoUszgiOYZ0nNUxeRS6/TuV7+U9ZbMFMgvjwdd3i489E21poNS/e
         qfg63B8lm51EjOhKSrh+40rsC7XGQrzqGvAHzE7ZZZ3sS6llZOha4jGpQBPQ8Y0ZquY+
         YNXfDO3eRm56/YZHWf9E94HQkGmp4nJza9reFnnWVLLTGS50ED2VdfYH+rExUOCIdMJM
         /UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jeVjBN/6H/gI6gMyuL/+Tdutryht/EUxewf1jqrLbh8=;
        b=phom7yAy1mnqOLbOXq3INhwlC5huh/H5x0xkGADkMIdg0PUhV82F7rbS9UT6V+EPWk
         rLlPUPrr44Ssf4hwSlI30AZaHLVRAW0247/bOm6IcxsOS4xU698VyxZRu6ysBdvgaOEr
         A8ueBf5Zu9CtibzV9qGoh7am/Tn6Z0FEDpIIBZO0HWT0XEg7Kv0i74BepRori97qMoFt
         oYQYX0Ou/pvNz0a5HO+/10ENDjLsvCwFKTxjn9A0yvKZYJ2VBhzDIKDhuTov6cgoYbv8
         PP/VcY4ekhaujfGP0IRT+cKaFIuQhQNarV8O9xqO2rQj3FB+SfWxtr7IpIl1wP/ECWum
         vhmQ==
X-Gm-Message-State: AGi0PuaEjMkFR8nRvp1lJae8j/gAEvzfZAlIcuH2AzdTBe9RkzvUy8Ks
        HWt8qKVH+hDXwaqqvBRm9Q1g7g==
X-Google-Smtp-Source: APiQypLzDqcFeNJoAa/AvreW1err4IF4jkgQFP1M6cVKPw6A9RRXkIJZFlBSKVJUggBN9Dvq+Tnp2g==
X-Received: by 2002:a5d:4306:: with SMTP id h6mr7558068wrq.234.1586344107109;
        Wed, 08 Apr 2020 04:08:27 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id i8sm37596253wrb.41.2020.04.08.04.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 04:08:26 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4 3/3] media: ov8856: Implement sensor module revision identification
Date:   Wed,  8 Apr 2020 13:08:16 +0200
Message-Id: <20200408110816.2712841-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408110816.2712841-1-robert.foss@linaro.org>
References: <20200408110816.2712841-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Query the sensor for its module revision, and compare it
to known revisions.
Currently only the '1B' revision has been added.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

- Changes since v3:
  * Actually add module revision 2A

- Changes since v2:
  * Add module revision 2A
  * Sakari: Remove ov8856_check_revision()
  * Sakari: Stop EEPROM streaming mode

 drivers/media/i2c/ov8856.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 473d3245344a..de0b484b85d0 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -32,6 +32,19 @@
 #define OV8856_MODE_STANDBY		0x00
 #define OV8856_MODE_STREAMING		0x01
 
+/* module revisions */
+#define OV8856_2A_MODULE		0x01
+#define OV8856_1B_MODULE		0x02
+
+/* the OTP read-out buffer is at 0x7000 and 0xf is the offset
+ * of the byte in the OTP that means the module revision
+ */
+#define OV8856_MODULE_REVISION		0x700f
+#define OV8856_OTP_MODE_CTRL		0x3d84
+#define OV8856_OTP_LOAD_CTRL		0x3d81
+#define OV8856_OTP_MODE_AUTO		0x00
+#define OV8856_OTP_LOAD_CTRL_ENABLE	BIT(0)
+
 /* vertical-timings from sensor */
 #define OV8856_REG_VTS			0x380e
 #define OV8856_VTS_MAX			0x7fff
@@ -1152,6 +1165,46 @@ static int ov8856_identify_module(struct ov8856 *ov8856)
 		return -ENXIO;
 	}
 
+	ret = ov8856_write_reg(ov8856, OV8856_REG_MODE_SELECT,
+			       OV8856_REG_VALUE_08BIT, OV8856_MODE_STREAMING);
+	if (ret)
+		return ret;
+
+	ret = ov8856_write_reg(ov8856, OV8856_OTP_MODE_CTRL,
+			       OV8856_REG_VALUE_08BIT, OV8856_OTP_MODE_AUTO);
+	if (ret) {
+		dev_err(&client->dev, "failed to set otp mode");
+		return ret;
+	}
+
+	ret = ov8856_write_reg(ov8856, OV8856_OTP_LOAD_CTRL,
+			       OV8856_REG_VALUE_08BIT,
+			       OV8856_OTP_LOAD_CTRL_ENABLE);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable load control");
+		return ret;
+	}
+
+	ret = ov8856_read_reg(ov8856, OV8856_MODULE_REVISION,
+			      OV8856_REG_VALUE_08BIT, &val);
+	if (ret) {
+		dev_err(&client->dev, "failed to read module revision");
+		return ret;
+	}
+
+	dev_info(&client->dev, "OV8856 revision %x (%s) at address 0x%02x\n",
+		val,
+		val == OV8856_2A_MODULE ? "2A" :
+		val == OV8856_1B_MODULE ? "1B" : "unknown revision",
+		client->addr);
+
+	ret = ov8856_write_reg(ov8856, OV8856_REG_MODE_SELECT,
+			       OV8856_REG_VALUE_08BIT, OV8856_MODE_STANDBY);
+	if (ret) {
+		dev_err(&client->dev, "failed to exit streaming mode");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

