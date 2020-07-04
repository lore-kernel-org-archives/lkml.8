Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B10C20890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXEFrhsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGDLj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgGDLjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91BC061794;
        Sat,  4 Jul 2020 04:39:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so35372793wrj.13;
        Sat, 04 Jul 2020 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTGEWk45ndJLT2NY/8Es0iz5Nm0crZjCJORIXqLrPak=;
        b=CXEFrhscCk+j5TdunLyNHrZJrFTXYvNBQ5sAs4RwVo03mfiM+PtGWDpxafKr37ac0U
         w3EJeeD7fJHyI7NtFCa7hADR+v4sUNvZ8nVPHGJtiXAViVyRJ1oW7eTqlj1J8jyS6XCN
         mPfkZXS/SPAUWuo8crj9VojAf7Jq0apgMdlqZMAopvh2jH4reQIzeqgDR4FGEqrBp7SW
         bSokSJgr9mjXdsuhpWD+BWB0sb9sCtDcveDqNWTVbeXn+AGxd64K4jDMwQ6zRDdqJ85d
         1SKKSrScwedcGXGymdH5NehlKUFxb9PvGFfKOx8rdhkbHi8gneO9o/AC4I/6rsjWZYCO
         HMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTGEWk45ndJLT2NY/8Es0iz5Nm0crZjCJORIXqLrPak=;
        b=DhKU1NPnOL3LEmvrVPpixNpdx0Af3ZlxlRiYTXgCmNOv1FrUkwwiaaZBG45XAea/nA
         dAAsJ4winRZ9o+dbN0iAWOqRdhSpad3sTDIeihd8Duwb7/2mGxdlznj2R3RGsQDRzfPB
         NxqW9AtyiYfh7FgN63MGz+rrZVtPR9O5O3ToRFMzx6jiK7I83aIDx+LGhEFGDNdf/ZBI
         DQBYW3syBbuRxrBFk6FHAZvRcVEqiaEltMvSoZeOSL2a6cE9blQcQJP8bGXlblpeJWVO
         3fu1qXP+ktxM9PqNAb5+k6Tui24ZQ5tddm3VEt8TWB65JL3JG6aCye2n9BlKUy+yPNDm
         GWOw==
X-Gm-Message-State: AOAM530Pw4TvJItpsaUGn9lxMEmARBOKAcyj3ShgKX5LUd/Lux7FDyiX
        BASLWJDdiwfVhNtNd9toN58=
X-Google-Smtp-Source: ABdhPJzjNETgLRXE5zmLJIHF5Od05otTh5j/Sb/JD3W7Unyc0STwxcF2Y/1iz8u6zDLiGCgzVeKx3w==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr42411528wrm.92.1593862758810;
        Sat, 04 Jul 2020 04:39:18 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:18 -0700 (PDT)
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
Subject: [PATCH 11/16] arm: dts: sunxi: h3/h5: Add HDMI audio
Date:   Sat,  4 Jul 2020 13:38:57 +0200
Message-Id: <20200704113902.336911-12-peron.clem@gmail.com>
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

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 9be13378d4df..91d8c2690feb 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun8i-h3-hdmi";
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
@@ -806,6 +825,7 @@ csi: camera@1cb0000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

