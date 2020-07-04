Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37025C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10690208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLybyCd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGDLjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgGDLjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1CC061794;
        Sat,  4 Jul 2020 04:39:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so7458952wrp.7;
        Sat, 04 Jul 2020 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l//kuzEonZP/MtSIPdl0oofvGh1vlE+vGu7lmwtYnss=;
        b=QLybyCd2a2kCXvm7nPchhmYIaButiS71TXF/yDP130cpemzym8xlOUV/3Qa+2FuPNj
         v+F0EidhgPddugmzL+i9L11c3P51SRSzQqLVB51jpMaX2JgnXrtvbJEITzIU9i0tb9x5
         uaCMVDOkM26Ve+gVdqPGeC9ywDnwoqMvv9jHvUvM4/u82K9g4zfnAfUzZ0H9RHAlIyCO
         /H+Y9vAE+RHfSttq+yAuIndsCLAWdoqpYLmxeGxaxeJ4qBOEl26y3BLA6bOpaFRiyBdr
         YYXECplBSawVpVylmhmNQbgp27K27qxrVyU+jejiwloGZAG/stMBlz2IN6FB7hFipEmC
         z7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l//kuzEonZP/MtSIPdl0oofvGh1vlE+vGu7lmwtYnss=;
        b=t/Gf0h3lZI3YtYkGHzFZp64pgg0zRsbO2qCWj2VkhIxfH+d99dhq1Li0KsgBZonf3j
         I2KY3nQh5xS/EopJy5lAxUzHTwAO/OSXtwM1c4uIBXjcWyb1gzdRosqnw7/OquxbL0Xl
         8qkvUC0sO6mf2OhTSIW9OJZ2AoGQ5UMucd/aSSGE5S9Tfrj/qfgKwX3UrKB2fmdQCzST
         EEduoPzVp+J0YNI72dvQJAzQZcBk1DTzN/oCSB2icC+vYD8LIQ1VALO2PUU8u2eHY4mi
         qD7t1v1NUD5yWh2M6LQ5ZNxu2K48bwFbHpDNbzYSlb4Z7xtHWXINBxNrIVNbNzyZ0Z6s
         ZM6g==
X-Gm-Message-State: AOAM5313D+WvXtDlPLeQmChbOeKxG3vxm7w3N7+COW3JcoOcWaiCQUa5
        ejThuwMoQm5mzqF+wzzmZ8M=
X-Google-Smtp-Source: ABdhPJzd1H9PD/V5StIT+Pl28p4LlonUtT9WBwwFKz+ltoQc2lgzwioCcRMWJv9/YlS9sd0/nJ3+oQ==
X-Received: by 2002:adf:e684:: with SMTP id r4mr40698341wrm.68.1593862757609;
        Sat, 04 Jul 2020 04:39:17 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:17 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 10/16] arm: dts: sunxi: h3/h5: Add DAI node for HDMI
Date:   Sat,  4 Jul 2020 13:38:56 +0200
Message-Id: <20200704113902.336911-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
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
index 22d533d18992..9be13378d4df 100644
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
+			dmas = <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
-- 
2.25.1

