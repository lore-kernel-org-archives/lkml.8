Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1042DC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D949D206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKfgDHPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBVQZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:25:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41072 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgBVQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:25:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so2630931pgf.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZ0XPHrkGczK68VTqBdi2gga5qCDB/xbspdRfUcWe3Y=;
        b=JKfgDHPAPplpi8yLoQ8LrU7FuYC9H2z0fll1FQAjYKjGMPvnAfFGzgdvzd1dv7nKHB
         qqTnBKegtVbF51wnpByFo6AesU6BZu6o8rqRedDZLOan/KiLvEOqnU+P5BOBNYVaE0h0
         KJnwe/gQX5wvwIK53GfBCUJsE0DtaDLmAJ/ywAYNTAwMHfZXFTnUFtkfeZlT3+LCK/R8
         fRGsx8iFnxhuJU9Z/YbQV+PpT6hnsZVZ9BRjT/2WpCsCkORzG3l5taWKnxL5bkWBtrTm
         6poQqzAdbu3cpi9SZ+IXeRex5Enravo9BgL36LxQFLIr1sQpc/I+hsiwinLvmh4Jbm8t
         RONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZ0XPHrkGczK68VTqBdi2gga5qCDB/xbspdRfUcWe3Y=;
        b=cbFlm59fRYdS4muesSVwLy/UeD8gGgZT7NMX5J6R8zfJ0m9HD2sRZxeeSyOnO2qZ4W
         dkdW03MFLsJUXnb1a5LnrCNZdPYv+pa4sgNecYP3BMHRAoUAjA8zQyIcWdAcltKpKZVm
         ek0xcK0vzrj1ZIIGLT/mVK2b7zrHlckFaYuzL8wNG3+QtpFURfESycqwHERqZwTJj5je
         fj8yEtt1EbmFxAWsbSsedIzt+da1LlPw3FFC3TR4I7aoWeC4doPEy3j225V4eZ4fatuE
         kFat/mWn5NOu8rlOp3FA4Mz2fG62B6A2i7S7zbmwMSfLSv/CPcGjs8tCN7wTxvgXCe9T
         4O8g==
X-Gm-Message-State: APjAAAWOQbwTa/a080dibXOUtvU2ZegJ/rpnq/UiEYcD5ZdR4K7Bfgz9
        667WR0uWeRvp0wWXfR3TD4kD
X-Google-Smtp-Source: APXvYqwCNJokm7CWkuaJXTaW+Sp3pmLJBq34ZkBB8dcrtjSvqVAQjQaPEdtOdsgpQnUPlTarUqq3TA==
X-Received: by 2002:aa7:8bcd:: with SMTP id s13mr44039192pfd.234.1582388717854;
        Sat, 22 Feb 2020 08:25:17 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:801:b38c:89e8:305c:23c4:b77f])
        by smtp.gmail.com with ESMTPSA id q17sm6851296pfg.123.2020.02.22.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:25:17 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        adamboardman@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/4] arm64: dts: mediatek: Enable I2C support for 96Boards X20 Development board
Date:   Sat, 22 Feb 2020 21:54:43 +0530
Message-Id: <20200222162444.11590-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
References: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 7 I2C ports used on this board. Hence, enable all of them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/mediatek/mt6797-x20-dev.dts      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
index 13939d55b85b..eff9e8dbd076 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
@@ -28,6 +28,55 @@
 	};
 };
 
+/* HDMI */
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+/* HS - I2C2 */
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
+/* HS - I2C3 */
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins_a>;
+	status = "okay";
+};
+
+/* LS - I2C0 */
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins_a>;
+	status = "okay";
+};
+
+/* LS - I2C1 */
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins_a>;
+	status = "okay";
+};
+
+/* POWER_VPROC */
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins_a>;
+	status = "okay";
+};
+
+/* FAN53555 */
+&i2c7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_pins_a>;
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.17.1

