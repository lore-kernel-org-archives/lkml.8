Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F46EC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060902071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEaC4MBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgCaNeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:34:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbgCaNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:34:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id z7so535148wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wp21xVStqwrN1N12ROe6rhSLRy5whD/V05w5RA8tsUU=;
        b=pEaC4MBrF0d7B0b85LQcMeH5zZKdVyVNq5eZv5TiQpSDFkpooH40hCVmw0pLsDRHIT
         zCmNLYoiXZrdB7Gjd20bco+olUBrpt4JObPEorRc7sU1MVmoRFjMGd4oK4wmCneUn5EF
         XpmBH+artBLhjllPljF6s5ZhLCokfEcCaoQxg8gApfPIKfmBIfxOIG8b7XOXZEdV9d7T
         SUR69mrZ66AMDjRvbCHOF+lMJ7BZW+auUkdlO5V1pWSE3WjR6H/+mp46WSUA4HT5Pj2Y
         +8UuNnmDhB02kHaOSEyosTBd+fQxi5WCA0FI8y7K7ylpuC+rYz0qoqL+ejZ7IvjhK9Ab
         xWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wp21xVStqwrN1N12ROe6rhSLRy5whD/V05w5RA8tsUU=;
        b=bNxfRroKQqCBszzRd5J5se2dWSlgE+rajE0YjcsYyV4O8OM6VgUEKs7Pjsd2y94hCh
         wwfrS+z9mlVT8QLEOPCkp9LwLMpbdoxCN0ySB6Gf39nZEZDOodlFOSYurBV2BdmgfcUx
         hguIGjgF9Z5pGvM5qm4wFKbO8ScMv9niu2Y5mOPpZ+F5qY9mYNqvwXty+zUgWw1CrAuB
         OinDljcOvLqU2pxYJDI4BLWFjN4pJZtGxK5spJvXB0PJVw07pJgQC3+aXjiHiCN5JrtP
         fGlhFTYyPNjPKW4FtXYcML0y2iX3mfGlvqJi7yyBtnIfsk5YP1sQhJwgYnFup940i8sq
         +GvA==
X-Gm-Message-State: ANhLgQ3BOeWgtqsfDsjOrI6gLxQQUHO/ialSK28FgiLW62e2+8N4t7F7
        uXhlARIKB4z+qBYAVY7kqz+/jw==
X-Google-Smtp-Source: ADFU+vt6gmU3ICepXWInCQgT7paaToRl88C0JQzwtYhmAlm1bldIjQplA/Nx855WwsF8gsnYyaQSiw==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr3441990wmh.72.1585661639903;
        Tue, 31 Mar 2020 06:33:59 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id 61sm28623081wrn.82.2020.03.31.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:33:59 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v3 3/3] media: ov8856: Implement sensor module revision identification
Date:   Tue, 31 Mar 2020 15:33:46 +0200
Message-Id: <20200331133346.372517-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200331133346.372517-1-robert.foss@linaro.org>
References: <20200331133346.372517-1-robert.foss@linaro.org>
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

- Changes since v2:
  * Add module revision 2A
  * Sakari: Remove ov8856_check_revision()
  * Sakari: Stop EEPROM streaming mode


 drivers/media/i2c/ov8856.c | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 260aaf332631..c7551cee2bb0 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -32,6 +32,18 @@
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
@@ -1152,6 +1164,45 @@ static int ov8856_identify_module(struct ov8856 *ov8856)
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

