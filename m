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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D24C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B1120890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrewqFuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGDLje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgGDLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE84C061794;
        Sat,  4 Jul 2020 04:39:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so36655806wmf.5;
        Sat, 04 Jul 2020 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1wxiSXb6FjGblsvKrZYztMSCVGGVQHB+0DmuQ/lyxA=;
        b=JrewqFucv5cYOk7OE3oVnmZEW3IbJjLlbiFhIN8TjMDZzUl7L+jK5AKEFgEXWzxTt2
         2pQXxy3Pz1M75SMWDCj/v0RMb9zesYAdX6YFCYIbnYmGaG9U9A/BVMclHljHSKcbD+qe
         YAwDMlcI+nxg14LvyfWNzqkomR1qajrWKg4u814ufNNLKFQAY6e3hDdo729Kvyx+Pcil
         IDKRHP5AQmDyohNs9j0Xia144mKJyU+H5ggVM8MSPXcNsrLv/Pbsxr2TwbtFJf+3XCQy
         89ld2FVKMq24fnhWHiB3dC+gxVF4kpm1vsG8xovGK4fAWvcuKmXsP643kNsh9VlDOEoe
         Kgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1wxiSXb6FjGblsvKrZYztMSCVGGVQHB+0DmuQ/lyxA=;
        b=uJUUZS2UncPnf/n6cEKz42vZb0VlwUreQAjPD2jfs4GwDMLqp4usb7FTYZWtWWDA0u
         Kvi+/bDxp6mJ4PnG9q++aa1twiu9QRkdNVr5Rayc64a95XZ0Wdzh0uarVccTdMsTO+To
         uOMconvmF2/R1L5uCGL5bWz3kd/yGrk4kdHY5/0/HBl/aoj4RxJTdxyEiOiO67t+9h1R
         XJ6fsbaXzZfTIo8kWzoCINdRaB2VDD0/0I3xSdTgBogXajLdfmrxUH3vuIwrVUw/Lleu
         q/a68MNt4cDWqgthE8a8b9EFUvzS6wmhVEfGSEgJwFYV5ypSCBDkoa29T/2eiyFDwsei
         1+7Q==
X-Gm-Message-State: AOAM531Y9bR7ZiosUvSdDOnjv0SR7uybmpMVaykUePe+nsglbCxkylIY
        OMKEoSgz1hdkF2YakJEJxekn6bSA8Dai3g==
X-Google-Smtp-Source: ABdhPJwzV34Wu9Tm/bGGoIIBjIyhv/6HbZCqgcw/NraTBYcNKoYfUjnjYieuWUKNkx3O6QBQVusUfg==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr39307080wmi.148.1593862764834;
        Sat, 04 Jul 2020 04:39:24 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:24 -0700 (PDT)
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
Subject: [PATCH 16/16] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date:   Sat,  4 Jul 2020 13:39:02 +0200
Message-Id: <20200704113902.336911-17-peron.clem@gmail.com>
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

Enable HDMI audio on Pine64.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 2165f238af13..c5939ba52f19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -99,6 +99,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -107,6 +111,10 @@ &i2c1_pins {
 	bias-pull-up;
 };
 
+&i2s2 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

