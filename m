Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D4FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD0E206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpLF/RoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgEaR2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEaR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:28:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AF6C061A0E;
        Sun, 31 May 2020 10:28:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c71so8555999wmd.5;
        Sun, 31 May 2020 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOBT0oRZV1eBos2C+n7L/o8LpzJdP3OFJYUQsdgdARI=;
        b=QpLF/RoCo4iDJcEqSVqfPHs88H3aUe2oAy/4pnwgxLkmyJyS/hxJMsi4yiik9DVyZn
         mn1n4igYcI7gWoK0m2qyRkyiMUTR4WRiNvaKv6RGULH1R+5C0zryhnALM279U2JZEirb
         Q8y5N6w3Ht27xcIa0FKBhTpg9jjVL6lxMW2D2oDQvrte0P1cd1PNpcBTqSIXQxMj9jaW
         ckHjmYfIFKosMZFDfzIpqEwjOiO8OeI+6MywvnFvEjeZMWZTNCCHDcPmbIGJZQVw/LJs
         DlqNdkjeXnHZv6DBq5H3RQHBlVPUqm98HW+mxXBhCebz5/9J6j4cJ4Iyx+juqTAVTW15
         +OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOBT0oRZV1eBos2C+n7L/o8LpzJdP3OFJYUQsdgdARI=;
        b=VAZv6BOmjBqQgTHvDqsE13f7rIqJrn8jj6fJxobs6F/LaO52xgNqc3LoiiipLE5qQO
         G0qERa9ZyaMZNG/xf6Y/xkcVMAcGsjSuCI+oK76Lm9vYHMlf4EyEGjlftMzbpI8yCi+L
         T46rAkMHq5GKbHGttr9TGh2LlfmItBPa/Amg6IyFBC28gWlrhUVgyDrB1Jc6cRz6/u4O
         QAGZaaUsewYAShiEKimVSvxncN7oCCBRhcyF2vPxzRGCk/bdreclQ2yKkDGLOwgXdsT2
         1/2dR5xPXuiGBFx0PPsJkpINNvaK9As3foxinWa3qchHJm+LAbdHmJ6qdOmzIylq10iE
         J9og==
X-Gm-Message-State: AOAM533+hp5GN9j2NPlhvIlmtsAdMC2TS/tum1Hmq6P1ONcRQ6z6BtIt
        AZHLKa5OV81aB44mzPuLZA+FbmPN
X-Google-Smtp-Source: ABdhPJxsAVB+CfCF+bTsJ2wVSgZ9enQL5C1AVIgBLv4gn90IHePMAPd8zYNwSGN15gsff1zx0uKR+g==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr18309758wmj.34.1590946110162;
        Sun, 31 May 2020 10:28:30 -0700 (PDT)
Received: from localhost.localdomain (abad130.neoplus.adsl.tpnet.pl. [83.6.167.130])
        by smtp.googlemail.com with ESMTPSA id b81sm8922326wmc.5.2020.05.31.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 10:28:29 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] arm64: dts: qcom: Update msm8992 pin configuration
Date:   Sun, 31 May 2020 19:28:02 +0200
Message-Id: <20200531172804.256335-13-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531172804.256335-1-konradybcio@gmail.com>
References: <20200531172804.256335-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for i2c2 and i2c6 interfaces, wrap up
SDC pins into pmx_sdc groups (following msm8916).

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi | 149 ++++++++++++++++-----
 1 file changed, 118 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
index c543c718c22d..17c9e048e414 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
@@ -32,59 +32,146 @@ pinconf {
 	/* Order of pins */
 	/* SDC1: CLK -> 0, CMD -> 1, DATA -> 2, RCLK -> 3 */
 	/* SDC2: CLK -> 4, CMD -> 5, DATA -> 6 */
-	sdc1_clk_on: clk-on {
-		pinconf {
-			pins = "sdc1_clk";
-			bias-disable = <0>; /* No pull */
-			drive-strength = <16>; /* 16mA */
+
+	pmx_sdc1_clk {
+		sdc1_clk_on: clk-on {
+			pinmux {
+				pins = "sdc1_clk";
+			};
+			pinconf {
+				pins = "sdc1_clk";
+				bias-disable; /* No pull */
+				drive-strength = <6>; 
+			};
+		};
+
+		sdc1_clk_off: clk-off {
+			pinmux {
+				pins = "sdc1_clk";
+			};
+			pinconf {
+				pins = "sdc1_clk";
+				bias-disable; /* No pull */
+				drive-strength = <2>; 
+			};
 		};
 	};
 
-	sdc1_clk_off: clk-off {
-		pinconf {
-			pins = "sdc1_clk";
-			bias-disable = <0>; /* No pull */
-			drive-strength = <2>; /* 2mA */
+	pmx_sdc1_cmd {
+		sdc1_cmd_on: cmd-on {
+			pinmux {
+				pins = "sdc1_cmd";
+			};
+			pinconf {
+				pins = "sdc1_cmd";
+				bias-pull-up;
+				drive-strength = <6>;
+			};
+		};
+
+		sdc1_cmd_off: cmd-off {
+			pinmux {
+				pins = "sdc1_cmd";
+			};
+			pinconf {
+				pins = "sdc1_cmd";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
 		};
 	};
 
-	sdc1_cmd_on: cmd-on {
-		pinconf {
-			pins = "sdc1_cmd";
-			bias-pull-up;
-			drive-strength = <8>;
+	pmx_sdc1_data {
+		sdc1_data_on: data-on {
+			pinmux {
+				pins = "sdc1_data";
+			};
+			pinconf {
+				pins = "sdc1_data";
+				bias-pull-up;
+				drive-strength = <6>;
+			};
+		};
+
+		sdc1_data_off: data-off {
+			pinmux {
+				pins = "sdc1_data";
+			};
+			pinconf {
+				pins = "sdc1_data";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
 		};
 	};
 
-	sdc1_cmd_off: cmd-off {
-		pinconf {
-			pins = "sdc1_cmd";
-			bias-pull-up = <0x3>; /* same as 3.10 ?? */
-			drive-strength = <2>; /* 2mA */
+	pmx_sdc1_rclk {
+		sdc1_rclk_on: rclk-on {
+			pinmux {
+				pins = "sdc1_rclk";
+			};
+			pinconf {
+				pins = "sdc1_rclk";
+				bias-pull-down; /* pull down */
+			};
+		};
+
+		sdc1_rclk_off: rclk-off {
+			pinmux {
+				pins = "sdc1_rclk";
+			};
+			pinconf {
+				pins = "sdc1_rclk";
+				bias-pull-down; /* pull down */
+			};
 		};
 	};
 
-	sdc1_data_on: data-on {
+	i2c2_default: i2c2_default {
+		pinmux {
+			function = "blsp_i2c2";
+			pins = "gpio6", "gpio7";
+		};
 		pinconf {
-			pins = "sdc1_data";
-			bias-pull-up;
-			drive-strength = <8>; /* 8mA */
+			pins = "gpio6", "gpio7";
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 
-	sdc1_data_off: data-off {
+	i2c2_sleep: i2c2_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio6", "gpio7";
+		};
 		pinconf {
-			pins = "sdc1_data";
-			bias-pull-up;
+			pins = "gpio6", "gpio7";
 			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 
-	sdc1_rclk_on: rclk-on {
-		bias-pull-down; /* pull down */
+	i2c6_default: i2c6_default {
+		pinmux {
+			function = "blsp_i2c6";
+			pins = "gpio28", "gpio27";
+		};
+		pinconf {
+			pins = "gpio28", "gpio27";
+			drive-strength = <2>;
+			bias-disable;
+		};
 	};
 
-	sdc1_rclk_off: rclk-off {
-		bias-pull-down; /* pull down */
+	i2c6_sleep: i2c6_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio28", "gpio27";
+		};
+		pinconf {
+			pins = "gpio28", "gpio27";
+			drive-strength = <2>;
+			bias-disable;
+		};
 	};
 };
-- 
2.26.2

