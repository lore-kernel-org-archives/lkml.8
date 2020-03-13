Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B42C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EC0206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHeV3oZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgCMLEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:04:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgCMLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:04:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id a5so9446778wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 04:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmK9rPbQ7ZkiTZPfd7jr8oEpxHT6uehvlGdRiVCfa9E=;
        b=bHeV3oZzGpOJp9X2/+ayJxINfN/+cGoX+D+XUhTs6Q4RfuCAcephVcJEMljWUqg0oY
         TfV385qnmaVVyq5bXflo/xOe/PW6CJyP7UWZx+Ile8m8rEY48+pmBcBK7vOK/frIvihh
         jJWxEC/zdw6oE6+NhGS7Y8H/sqWrUhsmqilh55QnUxolhvqTSVDJV67t24HGXxksGqmo
         2TVgjbWh3d5khSKPFOyWy8L3nXOtL/siZ07IAxXHCcZioSLCFldpaNLx30kHkN2IATKe
         /kZo0Av80UuI6B3c6Kja3n+wEg4K5XwWh/TC8zULaBHxtjGmpRFxf0aoN+y7As+iRpRe
         wUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmK9rPbQ7ZkiTZPfd7jr8oEpxHT6uehvlGdRiVCfa9E=;
        b=Zpybe0hO8+/iigO7v5kHJKxkw6hUDAJkidYliSBVEI5z+tIrtw71nNcYuVxJUDm4++
         1HYL44UJOeS/8ta0WuCzAWz1kKmT1WsvRSYr+LDJxQOBOiCzhKu3ufkUIDigcGG2otvM
         pmTwQFvNJpMbIC5+kNI+EDTk6WYv0TZiDWVioe3gnQlqY2KGerxKeLtoKdgjfef/Ae3Q
         FWMsyS1kEMRQvOVhZRobRZT2GwcEHchwYskzqI+8m62pj0xCwzQkhHcIVWCW64431GqF
         9zfqY9HFZU4YNS3uAo/BWwWw64CzwBa94SGmc+ScVaqHjTXgOY9VNDmHLJZkus/jsJ65
         MU0A==
X-Gm-Message-State: ANhLgQ3w90asVeUMhQCEnTQgvm4HWT4ayOM7w1xkkD5J8GkfVz0XDYch
        l3rcFxHuPuDXoaPosC7eon5IVA==
X-Google-Smtp-Source: ADFU+vsecmaXEqCn3VzdzRxpowdlFf1VRTVp8EqTIdciEiR4i/mJkERoqke1oLtWuG4/wpapMep3Bw==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr10778712wmj.12.1584097452112;
        Fri, 13 Mar 2020 04:04:12 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:c814:5be4:577e:3bd5])
        by smtp.gmail.com with ESMTPSA id r23sm23578052wrr.93.2020.03.13.04.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 04:04:11 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v2 3/3] media: ov8856: Implement sensor module revision identification
Date:   Fri, 13 Mar 2020 12:03:50 +0100
Message-Id: <20200313110350.10864-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313110350.10864-1-robert.foss@linaro.org>
References: <20200313110350.10864-1-robert.foss@linaro.org>
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
 drivers/media/i2c/ov8856.c | 54 +++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index db61eed223e8..39662d3d86dd 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -34,6 +34,18 @@
 #define OV8856_MODE_STANDBY		0x00
 #define OV8856_MODE_STREAMING		0x01
 
+/* define 1B module revision */
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
@@ -711,6 +723,25 @@ static int ov8856_test_pattern(struct ov8856 *ov8856, u32 pattern)
 				OV8856_REG_VALUE_08BIT, pattern);
 }
 
+static int ov8856_check_revision(struct ov8856 *ov8856)
+{
+	int ret;
+
+	ret = ov8856_write_reg(ov8856, OV8856_REG_MODE_SELECT,
+			       OV8856_REG_VALUE_08BIT, OV8856_MODE_STREAMING);
+	if (ret)
+		return ret;
+
+	ret = ov8856_write_reg(ov8856, OV8856_OTP_MODE_CTRL,
+			       OV8856_REG_VALUE_08BIT, OV8856_OTP_MODE_AUTO);
+	if (ret)
+		return ret;
+
+	return ov8856_write_reg(ov8856, OV8856_OTP_LOAD_CTRL,
+				OV8856_REG_VALUE_08BIT,
+				OV8856_OTP_LOAD_CTRL_ENABLE);
+}
+
 static int ov8856_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov8856 *ov8856 = container_of(ctrl->handler,
@@ -1144,6 +1175,23 @@ static int ov8856_identify_module(struct ov8856 *ov8856)
 		return -ENXIO;
 	}
 
+	/* check sensor hardware revision */
+	ret = ov8856_check_revision(ov8856);
+	if (ret) {
+		dev_err(&client->dev, "failed to check sensor revision");
+		return ret;
+	}
+
+	ret = ov8856_read_reg(ov8856, OV8856_MODULE_REVISION,
+			      OV8856_REG_VALUE_08BIT, &val);
+	if (ret)
+		return ret;
+
+	dev_info(&client->dev, "OV8856 revision %x (%s) at address 0x%02x\n",
+		val,
+		val == OV8856_1B_MODULE ? "1B" : "unknown revision",
+		client->addr);
+
 	return 0;
 }
 
@@ -1254,12 +1302,6 @@ static int ov8856_probe(struct i2c_client *client)
 		return PTR_ERR(ov8856->xvclk);
 	}
 
-	ret = clk_set_rate(ov8856->xvclk, OV8856_XVCLK_24);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to set xvclk rate (24MHz)\n");
-		return ret;
-	}
-
 	ov8856->reset_gpio = devm_gpiod_get(&client->dev, "reset",
 					       GPIOD_OUT_HIGH);
 	if (IS_ERR(ov8856->reset_gpio)) {
-- 
2.20.1

