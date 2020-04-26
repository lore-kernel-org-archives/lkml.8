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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC7C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C582075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vftiurRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDZMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFCC09B04F;
        Sun, 26 Apr 2020 05:04:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so16387146wmc.0;
        Sun, 26 Apr 2020 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZMguin0qF+PG0k2dkN3ezS7N4XttGAbuy5WT8MZbio=;
        b=vftiurRMFrp9UJSlnfcY2kxkimb8O8bOGD0/SAMLHFdv5zcWKBboL9WM5sV1ea85BF
         GF0dm0POD9E5MjzmtN4W/zNpXU2pvfxXp7AOmyCLXTGgIjnyRMgA6pfvMvX1wDl1lBDD
         SQwf7sA31Oar7Tia4SxX7Njri/7ko/OsMGIxiAHKIjroHMMZvEPsFRZiy5ARMwgslden
         9usgYO0DNFLef3w3B1UKuAPCXyzSyA/wU71BXEMy9Ow5aEbosnfJqfpS4zZiHjdqcQ3o
         vjzrAWq46FDqwPKwk0CQsndCFt9Qy8gNeVV5FHlGq91NQXAoWJHGpFkqVGUAWaBl9vlM
         Z57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZMguin0qF+PG0k2dkN3ezS7N4XttGAbuy5WT8MZbio=;
        b=fuBIuPkY74PekXCjOchN9/NLYO37bv3bw6BdeDF5Fnl8fYgZxrhHcW359UCxJQbEVf
         9SKjw5lhLzAiKWw5Ws48eG3PtzaGwE+56oK75XwkQJA2BFayuh9miMHIw0+/ZuCbhghy
         l/g8rEF77fBKs1i0P3Lj66S83mbNiVjLlJIkB3k/HH/tBPdUF58S5JR/3uAypBmg9Opy
         veiNujEN0y/E84Du94s/ysx723+BmpCWahUSaG6AuaofytolKkprWHjj0GUCXO5ksR0a
         9nE1hFGYIkYKlcblHTgByjO137pAr663anXRtZYYjy4fyJz8VTMJZjDFTGsKRLqGxRsz
         V88w==
X-Gm-Message-State: AGi0PuaUkJt6Uy/bY134Cdqfx0Wy/nkS/WMYgzlAcHwRwpE291B3oD03
        +oI6bsmJXKnvZi7FDHrqiRQ=
X-Google-Smtp-Source: APiQypLThTyvf1ycYY1ugZwNSBUMPwNwiXiATnmOGXr+ZmCBZ+kYsICRhwugaNkeCjuyXI87+CsDnw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr20956181wmh.93.1587902688948;
        Sun, 26 Apr 2020 05:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:48 -0700 (PDT)
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
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/7] arm: dts: sunxi: h3/h5: Add HDMI audio
Date:   Sun, 26 Apr 2020 14:04:37 +0200
Message-Id: <20200426120442.11560-3-peron.clem@gmail.com>
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

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 9be13378d4df..3a4262294950 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,25 @@
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "allwinner,hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -672,6 +691,7 @@
 			dmas = <&dma 27>;
 			resets = <&ccu RST_BUS_I2S2>;
 			dma-names = "tx";
+			allwinner,playback-channels = <8>;
 			status = "disabled";
 		};
 
@@ -806,6 +826,7 @@
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.20.1

