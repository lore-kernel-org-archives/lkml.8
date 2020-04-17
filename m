Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE89DC3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB62120644
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHGfQckc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgDQJXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgDQJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:23:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D30C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:23:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o81so2206495wmo.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2EV7Dr9G55HYkfQfAu+FWAIDztvRbZhmJstqdWtxkc=;
        b=mHGfQckcXTY3OTTrOiHgCXY+DEtOXW6whILiTwQMViLFk2xxhL0ohEkLxinS5qIwJv
         Sp2wM2kODOih4Jvw3l0spWfdAQH9aw4LjmCzHNuDa2iBdu1f5y3sXgF49f9AyTu53Lzi
         T0XTBiKAQwg3X6Cog6494wwQtTZObT0yKsRgsQ2wwZbEnxEMFPj+O4UT1GmIDtvwB2u0
         hQFUJtnTcXpnXs/DSt+EvisGhWQPfFKUjaKJ86JWV289ERfIIDtJ1xG0gobInZKBYkwx
         aWScF4SLYqYyJvDvk742vmlYD4JwPxnYeCGH8LDIT/H/nXTjxnTicWb1LMbiBVaNN2lH
         ELew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2EV7Dr9G55HYkfQfAu+FWAIDztvRbZhmJstqdWtxkc=;
        b=bfSEIWohB23YcqSDLAo5GjNA56v3IOs7nrNCuapsrMRaNEtsvhJN8sd3FRgIaGgwl1
         RHbi/CX8AJRTR2IuK52STPSu4X9+iC6S0vikO61UNbEzByJpA4MLrJHEiECoxQd/CCwC
         qrK9FVnXR6vQbiI4k7czBhATh8OjnQOvyLZ6FOWpoPBWVFGOK2Lpp2EWVPDgKBmfWxOU
         OehCl636S3p5nHVabmJptadMLd3APknvYuMsCTi47AV53yQIhr58LGoqFKhQmCdPJHUD
         U8XvwDjvRhjIbtqabwjx9x1tr+yFirn0CDnqOXaF0oXAEaKUOp6uXKutDnggY1asKohY
         8HVQ==
X-Gm-Message-State: AGi0Pubg1HKnjTfW8WtwZJAiGtm/C1veRqrX6E/S5X/Dlj3RpLeE1nrc
        6IY3ZlXqLU7ZkZK+2/E3aThYh30EyHk=
X-Google-Smtp-Source: APiQypIppZr/407qIeQiSZ9EWdSv165kLtjK+B5fx1fXkPd+6y30GQXlWG/yqKnV7BMkICzk//tfoA==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr2335863wmk.109.1587115411536;
        Fri, 17 Apr 2020 02:23:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id o18sm4713830wrp.23.2020.04.17.02.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:23:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: db820c: fix audio configuration
Date:   Fri, 17 Apr 2020 10:23:27 +0100
Message-Id: <20200417092327.7341-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After patch f864edff110d ("ASoC: qdsp6: q6routing: remove default routing")
and 9b60441692d9 ("ASoC: qdsp6: q6asm-dai: only enable dais from device tree")
asm dais and routing needs to be properly specified at device tree level.

This patch fixes this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 22 +++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi        |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 4692b7ad16b7..cf217b6b2b39 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -908,10 +908,30 @@
 	status = "okay";
 };
 
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+		direction = <2>;
+	};
+
+	dai@1 {
+		reg = <1>;
+		direction = <2>;
+	};
+
+	dai@2 {
+		reg = <2>;
+		direction = <1>;
+	};
+};
+
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "DB820c";
-	audio-routing =	"RX_BIAS", "MCLK";
+	audio-routing =	"RX_BIAS", "MCLK",
+		"MM_DL1",  "MultiMedia1 Playback",
+		"MM_DL2",  "MultiMedia2 Playback",
+		"MultiMedia3 Capture", "MM_UL3";
 
 	mm1-dai-link {
 		link-name = "MultiMedia1";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 14827adebd94..98634d5c4440 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2066,6 +2066,8 @@
 						reg = <APR_SVC_ASM>;
 						q6asmdai: dais {
 							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
 							#sound-dai-cells = <1>;
 							iommus = <&lpass_q6_smmu 1>;
 						};
-- 
2.21.0

