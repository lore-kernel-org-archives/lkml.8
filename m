Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F89C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F7720658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSlYN7OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbgCaQ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:29:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39889 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgCaQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:29:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id g32so4518284pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wP5LCDf1qLgKK+VOjwy/fW1+iOb+VwqM7TAcp3BsV8=;
        b=YSlYN7OTswKyzWbeb+COMKOnvlKIkPMClodNu+D2n/6uKu5XWt6GHkoI5M1ofB5Gb+
         rRdOjtgl3DGJBdnP1/umt9xvGTr3WFLeINe/yjJJBKc+9E3IM29YYplh6m3b72qpovtK
         SfF/FNk5rtPH/jQEasgic5AtYgk1SBI7cPjzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wP5LCDf1qLgKK+VOjwy/fW1+iOb+VwqM7TAcp3BsV8=;
        b=YtT3JodQuWrfO3KJGA61WetU7MdCzH7wmUpaLUxEE8u9j4w6l0RPb/VIpu7A0oq/el
         XY44aixhg9K4yzB++h10kMHvtNypngmyFOkf88pO0aGiYUNb3WcS49zO4o4PXfz4TjR9
         SQqB0+0//LvQQC2NTCTgpMhYeXdKf/6A1E0nXTe+0GT/eRY8Tp9NzZA5pxvOwLx/gCow
         jP56tbZdttXpWccS9Ewjg/g3Mfz8Rp6uAH90ebRFkocama2gXW/O0uByQPxfI/moOU6w
         EWHm7gmV6c68UCgfOvbPDceznUP7F93lrgL+dzJarXvfrEfNMXMUOJvm823ZM+R6p20P
         btmw==
X-Gm-Message-State: AGi0PuZffro7TQto4qdlCW1x8ms0w5PIJDJsERcuao8onyMrQKqHaG+a
        jGjkX9sifMeU/SbRX39uZ1bQZA==
X-Google-Smtp-Source: APiQypIE8YZwOIL+SRdJzFHBcl+UVQk/2x3rJ3G6v/OprL+VIZ3bbRQSzJiLgYHEFwbBEdfp1hC1WQ==
X-Received: by 2002:a63:31c4:: with SMTP id x187mr11698385pgx.205.1585672177939;
        Tue, 31 Mar 2020 09:29:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i16sm2964502pfq.165.2020.03.31.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:29:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sc7180: Swap order of gpucc and sdhc_2
Date:   Tue, 31 Mar 2020 09:29:00 -0700
Message-Id: <20200331092832.1.Ic361058ca22d7439164ffea11421740462e14272@changeid>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices are supposed to be sorted by unit address.  These two got
swapped when they landed.  Fix.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 998f101ad623..4bdadfd9efb9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1294,6 +1294,20 @@ pinconf-sd-cd {
 			};
 		};
 
+		gpucc: clock-controller@5090000 {
+			compatible = "qcom,sc7180-gpucc";
+			reg = <0 0x05090000 0 0x9000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
@@ -1312,20 +1326,6 @@ sdhc_2: sdhci@8804000 {
 			status = "disabled";
 		};
 
-		gpucc: clock-controller@5090000 {
-			compatible = "qcom,sc7180-gpucc";
-			reg = <0 0x05090000 0 0x9000>;
-			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
-				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
-			clock-names = "bi_tcxo",
-				      "gcc_gpu_gpll0_clk_src",
-				      "gcc_gpu_gpll0_div_clk_src";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
-		};
-
 		qspi: spi@88dc000 {
 			compatible = "qcom,qspi-v1";
 			reg = <0 0x088dc000 0 0x600>;
-- 
2.26.0.rc2.310.g2932bb562d-goog

