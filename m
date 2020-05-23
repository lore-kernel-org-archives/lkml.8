Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE62C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28DC207F9
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Vwf8oR+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgEWNMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbgEWNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:12:12 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF35C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:12:12 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p4so6011332qvr.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5+LkB1TL3R/xRtbnTpHtVc52mSgHT6mX07ymQdEhWE=;
        b=Vwf8oR+80FRu8UPj1VE1dhrJHkJlhsGbZ+BmwY6L1UJIBjNk7uSfXod2I+QlmDJjtH
         BNtFwcmQmq2hUUV/aBwSc5AzO148HI+MOP0EwoeJqpEOhoyYgJOIb6+aFL4+E7rXZMot
         mNv/yELgHPAIAU1cIFw9QxixlWzj2U5f4DTSNDfcwgrLh2v7obMGx+pXtg6pZR9H6kwz
         rF3cppHqtl2r9D9FumdxMQfyAnIqTnsv6fGEelckgd752cictGUZb6B8wOAJibBtbhAc
         M3o3vfhasmtxazjvqGxQRcC5dbzoUpimf3JwgZBYkoMeOgZOxRDMzPVczfsi6jdDO2ms
         AwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5+LkB1TL3R/xRtbnTpHtVc52mSgHT6mX07ymQdEhWE=;
        b=AyTAK+RR+ulEC0w+wU0RTdLB1DkZOAUrFwNkPenwSamv7FiopPWZCHY7ln4gB1lrN7
         q5gOLJe8GurjY4UVZK/wDm1dXtunyF7soFgr/y5CqO/UH/ohLEJYH0uAMknPX5KjTQds
         +Q0WEee29/mMCh4HJG2HPrCJj2M73Ynn1ZkrFkXjCteuVqjP+6nJSCn2Ver6btObRwp/
         hvSAyUR0/6E3XClgYzvAMCoKBk2rHLu1pc4m/RUOhnFMUKIH3cru02v8RBwWD/7nKWs7
         iekrmcmUEo+TJTGImb2w1u+5DlydZqcphQcAdrbLeH9ub+Kxq+c9Y+2UmyBteblKccAt
         0jMg==
X-Gm-Message-State: AOAM531ixpk07T1SJ98AO/SiQzL+kwaMHFMF3FsyW9ohJy/OPVQeFQs4
        QZCPmKsX6TaJWH+nMa00W3PEEQ==
X-Google-Smtp-Source: ABdhPJypNcrx5YdS8JdgKXKLMq/J/EbituhaWK1VReOyeS9PyW05locBmPix0rf/2iu/DzD4JiB92A==
X-Received: by 2002:a05:6214:122e:: with SMTP id p14mr8037854qvv.168.1590239531569;
        Sat, 23 May 2020 06:12:11 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d140sm9305607qkc.22.2020.05.23.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 06:12:11 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: sm8250: use dt-bindings defines for clocks
Date:   Sat, 23 May 2020 09:12:13 -0400
Message-Id: <20200523131213.18653-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dt-bindings defines for qupv3_id_1 node's clocks.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 9c210fbac65e..04c9c215ffcd 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -292,7 +292,8 @@ qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
 			clock-names = "m-ahb", "s-ahb";
-			clocks = <&gcc 133>, <&gcc 134>;
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -302,7 +303,7 @@ uart2: serial@a90000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0x0 0x00a90000 0x0 0x4000>;
 				clock-names = "se";
-				clocks = <&gcc 113>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-- 
2.26.1

