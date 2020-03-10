Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDD3C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3333920675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCTm8JnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCJNpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:45:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33674 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgCJNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:45:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id r7so813306wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcpWwT5ZMggrjSQT2EvWM0uaER77QpGrPnMzAFtSYRI=;
        b=lCTm8JnF+0Ve7mENUYFS6Emi8ap4J4QZZykbHjBIWTHz+m+82slBKI0PmKKA+9XUIK
         j8jCvomsTAzeavD5T6AB54hCOiuKq90ZGP7Vy9CAyCK2/IcF9kngT3oHHf7ll32hjEs1
         rJ+IlD35LzyezuHBOVjg2z3Uc+tiW6J9cldQrOuTTtoCeUVe5RzhZNPBdqxWqwi4mheO
         lPlV+RlQKBcMWjS4Lu4NX3pWscelto4OWTcVxS59AdRn5c/W5TpV+GI/q6Q7wUvBJ5NG
         f0xyhgiu6/xp63Kg87zDYqWELKMb98Haa9908+lc40m24Q8NNTcXCdB7hs2n/DaMP2/k
         CgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcpWwT5ZMggrjSQT2EvWM0uaER77QpGrPnMzAFtSYRI=;
        b=RBiMiwh9F5H/MJSVhw/kGg8Kltnw6mlZAVML3FCGlWUf0J2G3zfEbqldWt4gRGVMdt
         zzUvLpoDGRVCa1X6Abebm3Oj7ywdNoRpE2dC56D0teq18oR9jbVe++Q0PDknlVtV1Iwk
         2a8ANLRZncpootdhrLdE0Vh6Ce9H1a4zZfQn90hWPk0WpGMEm05nwbTRiE/J2S4i5uoa
         hvPUtrDo+WrfVw8Nq9aXPkm6uzYyjzYnoo4rqz3sgGESttQiYG40mS1mv02OGJeq5lqX
         GI05Yg3z84ZLIiL++knA8bbAr4VdRkEeEjVk1ujEMlgIL7/27hKAMqy7BaTL+QqXN/kK
         wzOw==
X-Gm-Message-State: ANhLgQ0WitFTsW3O+0+ylW4UiQNu4AN9RzljBGL5tTX3Y4jPqCqUoz8q
        aScsz5u+o3pPmWBzwsnrRtBj+276UKo=
X-Google-Smtp-Source: ADFU+vshiP3TqHjYmA0LSk+r7RlKdK9hh2/o0ICzZ0FsVoXwdOWjpsAB8Q2bUd6JL7B0HnPn0624YA==
X-Received: by 2002:a05:600c:414a:: with SMTP id h10mr549952wmm.53.1583847901055;
        Tue, 10 Mar 2020 06:45:01 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:e50c:c780:9a1:8b61])
        by smtp.gmail.com with ESMTPSA id b5sm24298435wrj.1.2020.03.10.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:45:00 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     me@robertfoss.se
Cc:     linux-kernel@vger.kernel.org, Robert Foss <robert.foss@linaro.org>
Subject: [PATCH] media: ov8856: Implement sensor module revision identification
Date:   Tue, 10 Mar 2020 14:44:57 +0100
Message-Id: <20200310134457.30131-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
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
 drivers/media/i2c/ov8856.c | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 1769acdfaa44..48e8f4b997d6 100644
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
@@ -713,6 +725,25 @@ static int ov8856_test_pattern(struct ov8856 *ov8856, u32 pattern)
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
@@ -1145,6 +1176,23 @@ static int ov8856_identify_module(struct ov8856 *ov8856)
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
 
-- 
2.20.1

