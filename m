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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8170208E4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0vd95Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGDLju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgGDLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E454C061794;
        Sat,  4 Jul 2020 04:39:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so27368234wrs.0;
        Sat, 04 Jul 2020 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVjW7FiC+qSaQ3KBioDqK1mV2GwG3KhiYxWo2WY1YG8=;
        b=W0vd95QbcYPxywbQ8+RJ8ztu8DvaIkr0ZKZitkNzpk1C9WB8xdrZhvB/JHiMxOaX6w
         tG55l5DSxI/MHd92V/oAFfN31k91tu7G3CuqVPR9EAYe+/LWLF69wUhr1wHIXKjXZWFF
         ps6F4O98jUYhoh6t/XTfLPOjfb0g8dOlfcXi+Ls7rzXpN0Y+/Y+IPlMPO0sVJKtESqnO
         jo++bS18e4d3QnhkVNi2d+n4FJtQJWSr2yZC/0H533V7Or0YyVRns5b+gpgqn9IJEji1
         hw9NsWkziOWm4S3+KrFAQpj6iZ2g97dgkRjWrm5L+4dS0Ej6rygfY2qkHyAae9/nXkpj
         RI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVjW7FiC+qSaQ3KBioDqK1mV2GwG3KhiYxWo2WY1YG8=;
        b=S+0GFo1hgsyS6JUtQwVXxJrk9WmCQ04VcSkhcZws1dRur3EfnvEcRl88cf8j//sUTn
         2zY0MyTsPmPmP4OBkbsnUR3+Z3P7aEQuXHGSEqJRyhph6QkeIcsvdOn4045RHY/pd18G
         +F2Wr6ZD2hItX5yqThBeJzg8/4jfDLOpBWuCbKuK0n0S6E81N5R4L3pWvscV+ZFOis3K
         5ZOyP5m3wH+NHJGQpx98DrVT60gSvcKhgh1yT6wcrF5Prby2mXr5K0lkAVP3oig26fRQ
         Hlsk0U1zH//3Lhq54dahuKWkoA9SASUpsGaM0xjoa3J1Fqwp5qgf5Z21f4ToRnxoRBgy
         ByuQ==
X-Gm-Message-State: AOAM531xagjiQRNdvKL6WP8xM2S19FbhlB3P4zVs0ie2vyoT5pgueUIH
        4Xq1S6pr6P8BeI1ZjOJEtkY=
X-Google-Smtp-Source: ABdhPJwerxoQFv4zEnNu+Da57+LRJoLW49iAkIp8U0yBpTUxgLCXgzWvx3YJVjiOUOqQbUJjIMeB6A==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr40337474wrs.365.1593862760024;
        Sat, 04 Jul 2020 04:39:20 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:19 -0700 (PDT)
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
Subject: [PATCH 12/16] arm64: dts: allwinner: a64: Add DAI node for HDMI
Date:   Sat,  4 Jul 2020 13:38:58 +0200
Message-Id: <20200704113902.336911-13-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8dfbcd144072..c662f6a170ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -845,6 +845,20 @@ i2s1: i2s@1c22400 {
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
2.25.1

