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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983F9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F7520870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJk9vSxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGDK0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgGDKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1041C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so34241507wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV7x1Z5zj5Wjg3tK4n9i9paBzVB6Q8ndZsAB3QS+Wh0=;
        b=YJk9vSxe5NhDgZFDHmcheGZlJww4ux80NP9cQd2gkxXxRkH2UhzJimhJGqI4CM2X2f
         jRDNT+bVpr0toyfx5Lv7tLOCzQBoWaY/FsLAyQ0O6I0+OdWI7+YI+LiTf/22WEfpTGNQ
         cfu9pKktCp+C5Do2vDPasFu4SzNW7SiYwiKsVoaJ4aL82YmNyS0vBtKrCYfxskSg5Hkt
         /U4TJs2tkW+nX0N+YpgfNLauTOZbfBTUu6qyTAv/+WeAY4xml1WptBbLSqGJhQSTrLBV
         rwr09ULZ2C0GNSkTf6F10J1S4bJTd72Oykl+ByOp5INRS+rzUsZQ0aApujfcKqZz16N9
         GaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV7x1Z5zj5Wjg3tK4n9i9paBzVB6Q8ndZsAB3QS+Wh0=;
        b=lY9or0W2lLNYBDIUcJRbNJI4895Kf1Y8HyMs770XHYky+TEWWb7Rt7cWIFnN2NSg+y
         k3xi23MuSumx46jGA8taCtHpbosXFEg0aV7HFrTsohbGgMP1R7d3EkKZe98GI+2F0+er
         jXh3Dr3KeG3rabJ9KqkbWihA7YJ3qkDH3+6vd5uZu0r/YyUCYeN2yNHcDjIS3Xb8iqUA
         9c1Xxl/KLFQQdgACcZoET44uRSxGI/TEyBokbsxd6VSFKd71tj8X8kyurYsodB2nzFWF
         9ILJ10dext1lpeDeJOfcmdtHVAAJLI/IiHs8u4kYbOb7Dw+ygVjFQiMbb5EeKAd494a5
         +c2w==
X-Gm-Message-State: AOAM531l/9bxhlDrqi0uF40BEpPlPXraqPm3i9sm5Lik4MXttBxagvN2
        WXoU+wPto8hovApEUCce2tk=
X-Google-Smtp-Source: ABdhPJyEqBogAJqlBS2lzYmp9Ca55PYUAmfvL4gpcqCMlxNsqnWTHMWole1Oam7OJve7VD9Th2kHrQ==
X-Received: by 2002:a1c:9d96:: with SMTP id g144mr43273725wme.163.1593858356565;
        Sat, 04 Jul 2020 03:25:56 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:55 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Sat,  4 Jul 2020 12:25:34 +0200
Message-Id: <20200704102535.189647-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
References: <20200704102535.189647-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Operating Performance Points table for the GPU to
enable Dynamic Voltage & Frequency Scaling on the H6.

The voltage range is set with minival voltage set to the target
and the maximal voltage set to 1.2V. This allow DVFS framework to
work properly on board with fixed regulator.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 8f514a2169aa..a69f9e09a829 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -174,6 +174,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
 			#cooling-cells = <2>;
 			status = "disabled";
 		};
@@ -1036,4 +1037,83 @@ map0 {
 			};
 		};
 	};
+
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@336000000 {
+			opp-hz = /bits/ 64 <336000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <820000 820000 1200000>;
+		};
+
+		opp@384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <830000 830000 1200000>;
+		};
+
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <840000 840000 1200000>;
+		};
+
+		opp@420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <850000 850000 1200000>;
+		};
+
+		opp@432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <860000 860000 1200000>;
+		};
+
+		opp@456000000 {
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <870000 870000 1200000>;
+		};
+
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <890000 890000 1200000>;
+		};
+
+		opp@540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <910000 910000 1200000>;
+		};
+
+		opp@576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-microvolt = <930000 930000 1200000>;
+		};
+
+		opp@624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <950000 950000 1200000>;
+		};
+
+		opp@756000000 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-microvolt = <1040000 1040000 1200000>;
+		};
+	};
 };
-- 
2.25.1

