Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D701C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBE720684
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvhWJaDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgICUjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgICUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A39C06123E;
        Thu,  3 Sep 2020 13:31:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so4139585wmm.2;
        Thu, 03 Sep 2020 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=NvhWJaDbv/CVT9H6S29IsQSZxL5ZweScApFazMPHWLRFiJH07CfnQWVipSJp0FmtUE
         c03kRCzyLeMaYSSW7xh88tK0WE0f0Ainzb0Zf0NGSPH+P5sAHS5NIkXRZuDG5gNusfzT
         y1lxM3ngFNEYJ5J2CZMvQ4w+QpC4tZjAMrO9iIWDrYVt+0QBU1Bx4H5VYJApJyoTkecd
         1aEuWZL15F6x0irX5hYs5FxvJ2nGY5gkntUET07x0KdepGdP/wAkehcEi40dhNsv95pk
         ++yJde9mhM34UMD9S+wydpdyqcyPDyIde9D71FBDkDq74l6ljB4K0DDjeJTGVo5G5dhV
         8sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=B+skvCtmzUPJpUT+eWrez3vSXjvvjD7hP8Od2Z3BBtO03Zk3PH/X2aHUOoM3+K8H+K
         3oYzNhr9dG5tvGpD9h5t6b6/8okiP/JuCv2HwZlmnESMTNqohTsajbBEDD0yghiUrhz9
         nzDPGbNewH+k9M/yxtiCsz9oToiGI4zo3zIykFpi4uI5lssve1G3wEwheLYtKkuqF3b+
         xDUI7vKlipN/B2S9vvoBm/M2p1OHwxgfwvNWcdmgwP0inmqhbcKemqOahsTVzNeuYkAM
         81Sz3TG9mpOBXXhq4UN5mewRSVk1rwop1cI/ISCaJw9pWl+YKAwBfMLeLYLoR4LfQR9H
         VZMg==
X-Gm-Message-State: AOAM532/oExG40/bhZOMQt1u2G2uOOeZC0fzRnaY/JBZuWvxPJYFov8T
        pnZJSPD1dKYPOAHKS3gE6so=
X-Google-Smtp-Source: ABdhPJzrI2TFNBVGeQt56vIBniKFdjFqYjQTb+7a/xKeOi2G2IH0IgIrLV+8r2IOyg1V2Aoaghdcug==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr4080239wmk.47.1599165064542;
        Thu, 03 Sep 2020 13:31:04 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:31:03 -0700 (PDT)
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
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 18/20] ARM: dts: sun8i-h3: Enable HDMI audio on Orange Pi PC/One
Date:   Thu,  3 Sep 2020 22:30:32 +0200
Message-Id: <20200903203034.1057334-19-peron.clem@gmail.com>
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

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 8 ++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 4759ba3f2986..a5b45655fcf6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -146,6 +146,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 5aff8ecc66cb..ebb12a6f3a9f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -146,6 +146,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

