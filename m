Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D6C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB8521D7D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="HP6pGegu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgIITt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIITs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:48:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF6C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:48:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z22so5289789ejl.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFWBRuBomEOc1AsNpFqzFzJjX31ZCaqoNrXK9E6+NME=;
        b=HP6pGegucsqmbIJq/xueNs0NuBZPrk+2Tra6TT84n7TA+XDh1ih9EX+SRzQoNRF2XA
         Z9Qc/HGIM7UeLoJX9XK6vfc8T9y//LEzd0tuS5hqyC8wxlNpHG32YrgdP2VZTO5taeFA
         Uv+Agb3SyFlYLHfCZx52iDlKj8ytStVoWdZuccJ8U56P1H96FHNS9EwU/qNjh0oHoWx5
         D3zHN3VDUrYZoX+cG4DF0TmCJMWhHqPoIJczhtGYKb7/Awsb2jC098vrblGY3950bjOh
         Hc8tiYpflGYYPBY0XbYn3DAUidNCIAhkwzu2veO4VLqOn3w84/MvL+VX2leyC7+e4tsq
         KhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFWBRuBomEOc1AsNpFqzFzJjX31ZCaqoNrXK9E6+NME=;
        b=ikdxiiTFLprY1idHFu1rAWBAghQxqrLJ1x0+RTYKx9uogLRucsk6ssjNQ/D3xsSfb+
         HixGsmb2/YUzhFLr+4CKrM9AmCj2I5nIZ0PdDPUtK1gihdjX8/BgvG6bd/EO0Dp5dAWL
         8getMjfay2PgioG/KMPXJFUVCt8tTE9LTYDJC+bRFsHrhwkG/C11T2vwdSyjenOmGzhT
         044Bsh0fyl8zpXVlxr8MT3RY2u0ZATFOIOmaSxpvgRbrciKIZO77OAfPjQlux1KP4R4F
         1YaWUcWkxArxDbX9Jn2oddbr8ZNypfBq5eVH/S4xpVW1kkKgwqVx8i8lil1jluMxD8h0
         A/5Q==
X-Gm-Message-State: AOAM530DTeSlghieKc6jUJF4tfnDYxGBB0K9OOdXRRi+uzIVXDeuKIuF
        0YRYiBAjdjZvi8Uyxt5UTgWysQ==
X-Google-Smtp-Source: ABdhPJzn+JUOAZaTspjmvOqJtqXONNR0nFAxuBqtugakcZE1QR4tzAMM4FULbqe4fSudVKSUXf1Frg==
X-Received: by 2002:a17:906:a256:: with SMTP id bi22mr5196194ejb.375.1599680903929;
        Wed, 09 Sep 2020 12:48:23 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-133.xnet.hr. [88.207.97.133])
        by smtp.googlemail.com with ESMTPSA id hk14sm3461452ejb.88.2020.09.09.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:48:23 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH 1/4] arm: dts: qcom: ipq4019: add more labels
Date:   Wed,  9 Sep 2020 21:48:13 +0200
Message-Id: <20200909194816.3125213-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909194816.3125213-1-robert.marko@sartura.hr>
References: <20200909194816.3125213-1-robert.marko@sartura.hr>
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

