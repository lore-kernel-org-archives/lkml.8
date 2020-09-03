Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85563C2D0A6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6114C2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q65xxxeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgICUkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgICUbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD81C06125F;
        Thu,  3 Sep 2020 13:30:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so4139242wmm.2;
        Thu, 03 Sep 2020 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
        b=q65xxxebQ5o0CGBL7V0pXVWRuuEQJXqkTJ4fvQTtbbZtdVPp1+1K1jDEF74acvpUba
         AQ5Hx9JAdLnM4rGo9B0DlcNSdUdUk4BaleSAIK190wD+JRW2XEpzGjoSr4VeKBJ/8GLw
         3vDbrFNbL/AVczZaL/iB4NeNmxme+z5ET5q+bakPEvtFAROuvh5NrdwbxTX/0sI8wRSm
         KRxOWPsMz4qfLu8dnCp5oN9MZqqt2/AsJWiS4SKXWfyzqYSDkIbj+h2rcYNJHAzFvSn1
         KurPOpAP+ArNQAlvPJlol6XH6TK7Omo608AD8RXHRcgUC2BzZ1YMJliWNK5BKECnHJuR
         UdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
        b=jCCUr+KHgnTV73EMTPO7wOO8TuXY3a8VpAb0Pp51CmcsnCqPS0LSwydPW1OE8N1dCh
         07zFoPNKDw+jLg0Rlr17MrbobQxc726CVjWENqDT5KdYxu1iIFw2SLPcWRGEJAr/MjCr
         P773Unrsb0deQUmLmzeBNFAPIg8mtMporfaom31gwWqqvGvojVE+IgKYAagAJVGzcSzz
         tEQ5UXMK7CPYy9QOJKNdiGmZDqLoyXMrNKGihQrxHro8RKlJfEZuuxIDRIhqf9j8JGCr
         MMOW4hBmVm5//78w9Z+1YfeNQ+66GjAk8hHu5cmDoj9AvOdVXQvesQ0G0KQ5GmmY5H4x
         AK5Q==
X-Gm-Message-State: AOAM531GciKPQIw3ZNdIv58Ob3fGKr56YkyJVgmfaUvUUnqd0c5a2qLb
        TQIw5YIfrygsJ+BkJR0373U=
X-Google-Smtp-Source: ABdhPJxkFH2OLYuxAHxFrqCP+1QlNdTrnstdo4sIsV5Hxm1M+fvSoQbG7ckceLE1d4Lijogw88crTw==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr4115503wmm.2.1599165055122;
        Thu, 03 Sep 2020 13:30:55 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:54 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 10/20] arm: dts: sunxi: h3/h5: Add DAI node for HDMI
Date:   Thu,  3 Sep 2020 22:30:24 +0200
Message-Id: <20200903203034.1057334-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add the new DAI block for I2S2 which is used for HDMI audio.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..3dca6d89cab9 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -662,6 +662,19 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 27>, <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
-- 
2.25.1

