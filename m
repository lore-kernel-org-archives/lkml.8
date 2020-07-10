Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E5920725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSawlulE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgGJJ0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgGJJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437CC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so5166184wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRxnrLEUrSrlK3zy1+2PoRYSjZZZ/aiOGCPYzvHmseE=;
        b=bSawlulEpd9Gvd+NXknKucPeR5epPWbrc8DgBm+CGFcpLMSZfETEbjd/QKCnqHOFto
         TCF7azngY7Kue6kkHfCNjQnihQgPSOUMOZrZA9/qLRvveZl2APcz6wY/pKuZDQU3d9HT
         v/oG/L4KTdExJ0uytXLDs3fxMv2gDEgoe5zYkPG7ibAHbG3txEl6f9askhqUG2Wf+RbB
         LTWT/SGqoJH9aRVL0/GBVRJzYjQOkVSARxe+xtw6yR7OiuOEMGjd9Xw4fM4SBp5nbheT
         FdbFnq66hrMZpT5+zwCHQEj7/zY0ozXOUkK/mAJL/lcwdx8cEZU0HYm50Bl5WrEDLhV6
         gnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRxnrLEUrSrlK3zy1+2PoRYSjZZZ/aiOGCPYzvHmseE=;
        b=of1XPNV1C4l055HMjElzK4rEJJ2Q8/BAdTYCfsZSx5ENStGZOMsUAO0xSOfvc5JwTY
         uZ7Mo6FE0lwjn0uSISTjtyfseSXH356A3CvhOCxLaHLWRann9XKHJxTCaGrjSC8IwURR
         Wz5LDmnEOI2mhCdjdH/fyFLXTeWQvcKxUeTde5d3Mc5ZKSh1HEY+5lWADLPZpl0xWQLo
         dqzvnccYK5QM4vsBXU83NLeevmghhukE5E/A6b4FtYTNLa1J7sSMWY/hTNwQIM8/7EP0
         ru6yzKb4sVkIDg1TFUv1RWoCkk1oB0FMsUgDxzvnfrE/TNnietkiLCdlhjH7vlCjcfh+
         sLtA==
X-Gm-Message-State: AOAM5323itBIpzpnOxIsCDQAdJshONSlvcGMvTbWdTGaubjpxL3kqOP3
        GNCuGFxHp9XHRcE9IthNxfQ=
X-Google-Smtp-Source: ABdhPJzK2+qhw5quxWJfN44dQFlBu1dD9VH3B/Tx16GZDKFQPlmPAM1LR4v85GhCEQ96wokmZWS/oA==
X-Received: by 2002:a1c:2805:: with SMTP id o5mr4337815wmo.25.1594373168118;
        Fri, 10 Jul 2020 02:26:08 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:26:07 -0700 (PDT)
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
Subject: [PATCH v4 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Fri, 10 Jul 2020 11:25:47 +0200
Message-Id: <20200710092548.316054-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
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
index 1c939c55aaea..16c3ad8abd9d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -175,6 +175,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
 			#cooling-cells = <2>;
 			status = "disabled";
 		};
@@ -1037,4 +1038,83 @@ map0 {
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

