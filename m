Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3ADC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E552071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elO4ES6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgDZMFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgDZMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DAEC09B050;
        Sun, 26 Apr 2020 05:04:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so17116941wma.4;
        Sun, 26 Apr 2020 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4BM4DNbysaClY0EV6xOgF2ovMVU3sJ0+ScvdfNi5NQ=;
        b=elO4ES6Zl1mm+m0hwviU6BmYb4hh+LOJNukPomLbcf7SS8SnTpLR7xGis+AHOwg1DT
         Wu0dzhT4g8+dSXBWjRPGm2FdYDu2KBxP5zevMclI8pAm+yWijzazLxVeXn/wcYIdc6j3
         nos2w6/74APgGBKOQVr1VdTqGkvGgsmQ6styreKbAIUzLomtg3hQleOfPSKegNlRXntS
         khjVPQAxuMSoSuvbDb/Xd7WO4dH2kdJws/h0BavW7efiAafndGqzthgfuWcAm+LqxvrR
         P/AOoIHdyY9OyMy3QcglfHD206KV0ir90VVAithplg7gGPDXO0yogXrHbho1JGDMZkJQ
         J+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4BM4DNbysaClY0EV6xOgF2ovMVU3sJ0+ScvdfNi5NQ=;
        b=X0Gm6wmSswHn1uYY0yi2zFh33iIPZnuYTAfS7wz6NRolql4odTWJ77UAsIo/Zk922i
         PEZsMulpBZY9C8LKZusVqc9RysmxOVbUeqrloKN2bCt0amB0Y5wQTDXQQGg0PhJ3Nj86
         LFjmEZxXPKX5LuwVb7xeXNeH2zO7WNbMW7cx0RbbRKmVtfCBqELLEDbtAjUrscZWKYNw
         UysnzMhj0SN3Jj0Q3O4MmTgdQmk6FIvChtALoS4AUvSzw7MxTCs5FXY+Z7gokmscuw/N
         6XvJ5DbFvrG0p83nKOmnAwZE7skq9HBVrgMrkm0MikQ+W8Vs17qnSHlz2BNMfWQ5+HFb
         ZcHg==
X-Gm-Message-State: AGi0PuY5/j2ae4UByo7G2hM1aMGefGpL5uuAd6b/fnSOjYPuAkB3xu5+
        WZb0qoju8wSPIPbJrxI8RlQ=
X-Google-Smtp-Source: APiQypJw86c/sNx95DXV8lKs4/fEZfGFlBuG6VgZQUEpXj3ZPhbvaLaZ89ziUvHrSB/ed3WVWYGD0A==
X-Received: by 2002:a1c:b684:: with SMTP id g126mr19832432wmf.163.1587902690012;
        Sun, 26 Apr 2020 05:04:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:49 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 3/7] arm64: dts: allwinner: a64: Add DAI node for HDMI
Date:   Sun, 26 Apr 2020 14:04:38 +0200
Message-Id: <20200426120442.11560-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8d10fe6d06b6..e56e1e3d4b73 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -863,6 +863,20 @@
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-i2s",
+				     "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "tx";
+			dmas = <&dma 27>;
+			status = "disabled";
+		};
+
 		dai: dai@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-codec-i2s";
-- 
2.20.1

