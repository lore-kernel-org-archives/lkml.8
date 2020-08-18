Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05213C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BF3207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="iFWIrMUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHRQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHRQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:06:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F6C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:06:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n129so18723490qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb6+E88tPfrh7pXAb8/QpJmE56xGtpeHAmtdqNrSre8=;
        b=iFWIrMUj1y8bl5vDvdxItFMkHBHiLl3hFAn4vTP5yUsEd5zLRXmh+2g+omU4U+PsKd
         ee99TzJ1jI8wfz8gbK+n8amNNPa4BM4m25x5SEMFB8s6k+KAEEqLm2kpfBuz6v0Z1igh
         JUNdY0Ls0lIakRjtBkbWpyNk3UhMy6iosG8ZRdlpLla/8eHCOGJ5MlmVgCFXKXicM79B
         nZ37CP3fQjmGvzVhCh0J4kMhtWq03CzOGKXhL0rqxIZh7r23FxTc4E4scARgIXDjIEBG
         0vZKTD60YSzvm4udK3cS4jsEKDaLMItlBQOXx5NupganU2WohItyk+nDZSoJ3ex9hqPg
         L0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb6+E88tPfrh7pXAb8/QpJmE56xGtpeHAmtdqNrSre8=;
        b=qDsOQ+9gwFkRmCnPdgGDuxApZWXKJ1bQH7vaTXWE2Z6XxnXEbZqKFNEKGRWx0BD1Wm
         wyPc1q6tJU/CaAMNcmQil/DnV0eNEA/qIx5+AhiRMM3kyE6Doiq6oJfCJcGn44etsHQC
         oDJMuwaCJ9Fq+8LGC0kBMa3Q5+l4N3Lr0BaCzuP8hEcvAtnTixG9JFgG9mNlXHe/3vVx
         RmFrRvU2smNxNWoZG0So13bXhIMKO6yyVkV14Z9PiUWOR0zeu/TJhTmmvU64UbAnG3GM
         ZPHcvHp73OtQ8VIbxh8euqXC33aTnKl2D6CBnN3AkEwzq621M9QmeFFL2CPENLRk+xm0
         5WFA==
X-Gm-Message-State: AOAM532+i+8wF3nNeznIG1AWnUqOGwalCvTB/LZwRrUF1X9GVGVUV57E
        hD0CX/EvDTQTMIti41LDUhs5LA==
X-Google-Smtp-Source: ABdhPJxRl+Vb8fTDjmbgOzk/DiCo6S63qpktDOPwsZIZMqiBL4j0ZZXaQ/Yn6ZwA2oXdSmuZOAKRew==
X-Received: by 2002:a37:6644:: with SMTP id a65mr17827907qkc.4.1597766778037;
        Tue, 18 Aug 2020 09:06:18 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 128sm21198034qkk.101.2020.08.18.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:06:17 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Jack Pham <jackp@codeaurora.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] arm64: dts: qcom: sm8150: fix up primary USB nodes
Date:   Tue, 18 Aug 2020 12:04:43 -0400
Message-Id: <20200818160445.14008-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible for hsphy has out of place indentation, and the assigned
clock rate for GCC_USB30_PRIM_MASTER_CLK is incorrect, the clock doesn't
support a rate of 150000000. Use a rate of 200000000 to match downstream.

Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index b86a7ead3006..ab8680c6672e 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -767,7 +767,7 @@ glink-edge {
 
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sm8150-usb-hs-phy",
-							"qcom,usb-snps-hs-7nm-phy";
+				     "qcom,usb-snps-hs-7nm-phy";
 			reg = <0 0x088e2000 0 0x400>;
 			status = "disabled";
 			#phy-cells = <0>;
@@ -833,7 +833,7 @@ usb_1: usb@a6f8800 {
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
-			assigned-clock-rates = <19200000>, <150000000>;
+			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.26.1

