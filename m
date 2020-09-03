Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2BBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA4520684
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPn9PdHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgICUaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50FC061244;
        Thu,  3 Sep 2020 13:30:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so4612241wrt.3;
        Thu, 03 Sep 2020 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCiiLHdkyCif4lDSthP4Rue9BpevgzI0PU8h03qCRjY=;
        b=jPn9PdHbFfQYzxWap1ICE8K6I+puU4a41hfw1FW7yTjLz1RhIsitR1DWrUfJmsjeCB
         QuJOmJyDFQYCTkogqBoM4vrDLC/Z5EVI3XFVbh9zdKGJj77q909aTXooCxRXI7xYVuQP
         p/1egAtosQMJUMhUYeyBm4j5pbEtexUOiRgCbw1yLNA4GMSaR9MEwQi5gIl1O4P3cr9C
         CR146At7ZOwRhfRac+TMEc6WNIpHskIq3kk+tAK9MInIn63jVVs/EkMYpXiXfF/eZFOu
         ipNheUsBnVEN6N3RY7iXk1t0dVkKgpWJ/IWMMJP38c+cH+r61oiAKkfz5tqa04VR4jPZ
         ROmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCiiLHdkyCif4lDSthP4Rue9BpevgzI0PU8h03qCRjY=;
        b=nhkd007Kkhzp1hbu5HY9HsKrFp+cA11ly0Npz97LQK2iG4TWLfGtie+jLGKUzCoHix
         BJShOcxCAcVtMD9yw6cOb0otrVm86TIGqtKsnXW1fKN9ecabRz2cWGQMED0c3M8zhdXJ
         aSJSN2fG/6/uTTlKeOAWe5h0p9op8WeRW3Sx4ghr5ULMl8MUrPldO1uVMZ6jpMxGCyCu
         Q/MlhZRa/GwQplvYNEyhow6TFXbOiuXNJPiKQDfL6wYfbU1dAJ+Qi5CCxs6NZSYNVlW6
         0gCfu8GU5aqv9bDm1kjUGKnSMQqA0sx8DBx6ZRLRHyRDMmayIvmR5ndI9auDrLTdp5H+
         cm6w==
X-Gm-Message-State: AOAM533EgLLsH+F1dyjaU1+tCyX6OgAVX+e3S1ksa39molK55Vyy3hnP
        FFuIBYpd9DTRrYBTEgJ1Bhk=
X-Google-Smtp-Source: ABdhPJxWnW47sJQ9T2/8BdZhhOZMbOW7I2FSoB1MeYeY4KcXmQ1ajCllvvZtZlt7+JcUa4XQrMLvqw==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr4118026wrt.32.1599165043167;
        Thu, 03 Sep 2020 13:30:43 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:42 -0700 (PDT)
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
Subject: [PATCH v2 00/20] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Thu,  3 Sep 2020 22:30:14 +0200
Message-Id: <20200903203034.1057334-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Regarding the I2S LRCK polarity, Maxime Ripard test it and found that
the LRCK is fine: https://lkml.org/lkml/2020/7/29/581.
So the patch introduce this modification has been reverted.

I have tested this on Allwinner H6 but this should be tested on older
platform like sun4i family.

Regards,
Clement

Change since v1:
- rebase on next-20200828
- add revert LRCK polarity
- remove all simple-audio-card,frame-inversion in dts
- add Ondrej patches for Orange Pi board
- Add arm64 defconfig patch

Clément Péron (4):
  Revert "ASoC: sun4i-i2s: Fix the LRCK polarity"
  ASoC: sun4i-i2s: Fix sun8i volatile regs
  arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
  arm64: defconfig: Enable Allwinner i2s driver

Jernej Skrabec (3):
  ASoC: sun4i-i2s: Add support for H6 I2S
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  arm64: dts: allwinner: h6: Add HDMI audio node

Marcus Cooper (10):
  ASoC: sun4i-i2s: Adjust LRCLK width
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  arm: dts: sunxi: h3/h5: Add DAI node for HDMI
  arm: dts: sunxi: h3/h5: Add HDMI audio
  arm64: dts: allwinner: a64: Add DAI node for HDMI
  arm64: dts: allwinner: a64: Add HDMI audio
  arm: sun8i: h3: Add HDMI audio to Orange Pi 2
  arm: sun8i: h3: Add HDMI audio to Beelink X2
  arm64: dts: allwinner: a64: Add HDMI audio to Pine64

Ondrej Jirman (3):
  arm64: dts: allwinner: Enable HDMI audio on Orange Pi PC 2
  ARM: dts: sun8i-h3: Enable HDMI audio on Orange Pi PC/One
  arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   2 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts     |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts   |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts    |   8 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  32 ++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  33 ++
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  |   8 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   8 +
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  32 ++
 arch/arm64/configs/defconfig                  |   1 +
 sound/soc/sunxi/sun4i-i2s.c                   | 285 ++++++++++++++++--
 14 files changed, 431 insertions(+), 18 deletions(-)

-- 
2.25.1

