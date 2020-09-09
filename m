Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7757C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B12020897
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="YWJGljpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgIIT5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIIT4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:56:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EB8C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:56:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so5340227ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+ciS2qx7n0ML41xAjv+I0OnFKOUx8aqQW6A20J9zqg=;
        b=YWJGljpf6NqYCyEmRgtbIZnfmxtQRL2RKLYngIzZ2jDJjdidTUCMeZRJMtFhQreFwq
         TP0r1FRpEv/FfCtu3K1RrvWtFR4jWuGk17OJWqe0hUZSwZ4HnUprBNslVduG4uSHy15M
         PJSd2Y+tCUTZovb00YO/d65nK4kHuk6Z+IDk4MkJOWn++H3aqT2iCAd5imuVFnJeopXO
         j7Sbm8Zp/C43qZ+BEcOha8jNMA5rtncsluXZzdlm6oUuxprHTmQjW0esNnGEw/+3shB7
         bUrllq4x3J1hUq6FkGvNrrxfCC218MHDGsvbuYbC88BfzIFK+Dh52hgetyfVgc6G2Qsk
         sA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+ciS2qx7n0ML41xAjv+I0OnFKOUx8aqQW6A20J9zqg=;
        b=NvMC069641g0IL9HtfmxpWQJCqALFraBxeLbb2Nv5TADbqHdT6O4dFPjdILzhcSXre
         WxnHqk/egKZh0UNk0+rtmS5q5Os2Unc7lDTCLuwfrYU5SMtZg1UVscNouZXWXttqqMXX
         LWRbb1fS/0FDi3urCIGcPxOvIqYbRRvwNYXvJKLsrUidEpzjcUpWeORrhVeRLpdZqp4+
         FBhb1RX2wp4iJI0Gz94qRN4KccVEpHc/AmNT0fePlue6LdnUmNiERX/B7QShsKbn7bXT
         dUNrFIaNZgeMntbg7mCacKIC5hn0XwxXz5o6hWGEYGlgVYsOWn7NyDVtLBS39VC9x3tK
         mVyg==
X-Gm-Message-State: AOAM531Gn8yxhfnk4wxd3l/97TuRN0xSPEGC7vaGsc2fme4yi06QunTF
        JZvC7A1ZpFBwNLlrRCsIEqmf0g==
X-Google-Smtp-Source: ABdhPJwZbg1ozv4MBW3qXWyJexh1RbCAIMd9u8UwGfFdGj0KXMnOru2pC/yh0FOO9gXyC16imsu3Ew==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr5705006ejf.134.1599681408354;
        Wed, 09 Sep 2020 12:56:48 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-133.xnet.hr. [88.207.97.133])
        by smtp.googlemail.com with ESMTPSA id n26sm3510870ejz.89.2020.09.09.12.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:56:47 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v2 1/4] arm: dts: qcom: ipq4019: add more labels
Date:   Wed,  9 Sep 2020 21:56:37 +0200
Message-Id: <20200909195640.3127341-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909195640.3127341-1-robert.marko@sartura.hr>
References: <20200909195640.3127341-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets add labels to more commonly used nodes for easier modification in board DTS files.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes since v1:
* Drop include that does not exist

 arch/arm/boot/dts/qcom-ipq4019.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 3d056aada8d1..7bf1da916f25 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -190,7 +190,7 @@ gcc: clock-controller@1800000 {
 			reg = <0x1800000 0x60000>;
 		};
 
-		rng@22000 {
+		prng: rng@22000 {
 			compatible = "qcom,prng";
 			reg = <0x22000 0x140>;
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
@@ -310,7 +310,7 @@ cryptobam: dma@8e04000 {
 			status = "disabled";
 		};
 
-		crypto@8e3a000 {
+		crypto: crypto@8e3a000 {
 			compatible = "qcom,crypto-v5.1";
 			reg = <0x08e3a000 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
@@ -396,7 +396,7 @@ blsp1_uart2: serial@78b0000 {
 			dma-names = "rx", "tx";
 		};
 
-		watchdog@b017000 {
+		watchdog: watchdog@b017000 {
 			compatible = "qcom,kpss-wdt", "qcom,kpss-wdt-ipq4019";
 			reg = <0xb017000 0x40>;
 			clocks = <&sleep_clk>;
-- 
2.26.2

