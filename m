Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702FD2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knZfke3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgGDLj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgGDLjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC570C08C5DE;
        Sat,  4 Jul 2020 04:39:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so35448614wrv.9;
        Sat, 04 Jul 2020 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=knZfke3sKYc0DXJM2t47oa2ovnx/dBeypmgCmiy3LPvRXi8c8/HnzAF1ftA44DIpVM
         u17jA8jPwwoWp/t8Ya47Jcbhd1CqcMj0+Mw+mt/E2zm25zjxG84IszIewvufsi+WlbuP
         nlHtCuAbGywK1wiTFYj3mfmErCdtgBOSfv1DqpGJrC+dJIN++ap5vun2+TcaV4voxohS
         hgd41PtZ2U4+cMgGmx9yo1mismQjgSIksxzaIeqXxIzj63hzYwX49+Uxc1Kb1gBh7KqG
         HYxa6jrxNS2qIRh4fQmekm32pi06pwsMtZeECEmDCkKrFlwVFtBb+OywLFbzEMrcNuVU
         yC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=nHxK7PFcRLS8XE4ZVPgm1ocg1yyV3U3teZYIhxlNnTiLUOukChg4DFzFrl+NYRj2d5
         +4Nd2MDPLW5j5HBTxl/JiwtdUbwdiACrCz4zhzpz+9Ea/u8+KZpkiiwGV3R/pFJ0WUG4
         Dtleq0sJDeTTvgkorDktQjuW/XdO4EghmDc1eSuVIOr6vTnTCv7jYMhcAlQh5oTAk6kU
         66HYNZrQekjaYvkEYar7tjsZgHHTf3ZDbRdGxd0YqxSeFDmoqPuEOnO966Bte0NQlPEy
         NJAHGuwnXGP66bj3Ksxh6HigIK7bsN39JHwCimkProFgaxD6qoFyBtQyd6iLs+on4xaX
         p8Jw==
X-Gm-Message-State: AOAM530HXskLthJ5k4BnDRbAxBOM8UX1eYeue3wAorfjWKJ51fDe1AhE
        SeeI+ZgxzbqbKv8kYBSZFqM=
X-Google-Smtp-Source: ABdhPJxuTS7kWmB4UbzVJyIM3G9fZFmSLmupexqyp35pR8yUKDd6X4+414YmhPgrPW1m9h4bEjT62A==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr39543136wrt.49.1593862756426;
        Sat, 04 Jul 2020 04:39:16 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:15 -0700 (PDT)
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
Subject: [PATCH 09/16] arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
Date:   Sat,  4 Jul 2020 13:38:55 +0200
Message-Id: <20200704113902.336911-10-peron.clem@gmail.com>
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

Now that HDMI sound node is available in the SoC dtsi.
Enable it for this board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..049c21718846 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -118,6 +118,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s1 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

