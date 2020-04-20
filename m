Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823D9206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="xH/QmMTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgDTPfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgDTPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:35:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:35:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m67so10960725qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5AdbeASeN3LWLwAao7IPBW2Z8hbXGbMOqZhqhTsi0o=;
        b=xH/QmMTGrRk0vg4u23/IshU43Loy0kmEdOHU6LEJwx6eLcIS3nQx+g31KY/s6njFes
         eFpdGA7e7bgn8AdpC+HYklwRzIuGD6UXVNiT7wwaO//ei1ErR5rh3im2N2npx0XtCH5I
         7MjCLC6WKMEnm3WT0zxCUgdOoShSJb5RDyIr6UhlStTvwIFSmgZiz9QK5w6vmP2gTElx
         1KMCF7wdByLiQjdgU36XzxKeuqW39K5IHYgTUtlYhoJ/D3woMFjPHQJFTT80i3Pya+J6
         IqUmeLkj/OBSz+q5jbGXEunJfZIPSYFfvxTj/yhzE3WCA2F94rWYjbgLVNtuHOR6f/8C
         ieuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5AdbeASeN3LWLwAao7IPBW2Z8hbXGbMOqZhqhTsi0o=;
        b=tD9/ZgmSE82vfH7KiZ6c+V51Sned1kUq4gXDhpN0hNiWn7du/AQjAr1rmkxcbXFCBT
         YJHIOHmvdO2dd+YF0dQ1J4iqXpHoh16bYHj/q0OaL03vBDjx3KSP31JxFkOYYzIfy3Ss
         jqRIaCJf2LjGXo11CoaoPst/lQEc8DOhVR7+f/rpuOxQYZ2faQ1zOx1r3cnEaAa4RCLB
         GWz4jY24cuikK6zPhBLTQBTpMsafGIC1VV+gW4tEhes3aLMKYqdaTFPYGDVEEXiGu4e7
         sHmMQW+hhAEm51PZYd63K1woT1wtEK04ar8t3RZdfs0ndh1aWESke/5USfFB6ZO7s3/t
         8Yvg==
X-Gm-Message-State: AGi0PuaQlw9fbA/cEOYiL9Rnbf3ZgusnIQq3GUU94G/UVNPytAr8s/c8
        GFec+rQOU99Lu8H7Odqo6u0v8Q==
X-Google-Smtp-Source: APiQypKoJbJWLjg+0XysGGc0MJ3P0qgeXjQAIu8l5u0lW95JQmearXo4++Rg9AGrTzIHk3HGJC7uNg==
X-Received: by 2002:a37:9e94:: with SMTP id h142mr15638183qke.56.1587396953312;
        Mon, 20 Apr 2020 08:35:53 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id b11sm708373qti.50.2020.04.20.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:35:52 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: fix pm8150 gpio interrupts
Date:   Mon, 20 Apr 2020 11:35:43 -0400
Message-Id: <20200420153543.14512-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was mistakenly copied from the downstream dts, however the upstream
driver works differently.

I only tested this with the pm8150_gpios node (used with volume button),
but the 2 others should be the same.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi  | 14 ++------------
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 14 ++------------
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 14 ++------------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index b6e304748a57..c0b197458665 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -73,18 +73,8 @@ pm8150_gpios: gpio@c000 {
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <0x0 0xc0 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc1 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc2 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc3 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc4 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc5 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc6 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc7 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc8 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc9 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xca 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xcb 0x0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 322379d5c31f..40b5d75a4a1d 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -62,18 +62,8 @@ pm8150b_gpios: gpio@c000 {
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <0x2 0xc0 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc1 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc2 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc3 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc4 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc5 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc6 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc7 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc8 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc9 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xca 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xcb 0x0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index eb0e9a090e42..cf05e0685d10 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -56,18 +56,8 @@ pm8150l_gpios: gpio@c000 {
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <0x4 0xc0 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc1 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc2 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc3 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc4 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc5 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc6 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc7 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc8 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc9 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xca 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xcb 0x0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 
-- 
2.26.1

