Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB6C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B592020820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsDrppTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgEJQ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729230AbgEJQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE8C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so2040709wru.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/boFoUXaAgzs/9YRn/4qwyX/v1A/ZjToMiKSYzOwF0=;
        b=CsDrppTOIM1X8NLMAVH0m3CI9obn/4avW1sQrIKdscbA7S1vz0D5jaYiKPtt8AFN2c
         TPZ/3TRlrdUr+GRjCbCwJCWYOxOzw/IhiVFQp+KP/VPrKJXeOYNPQ+aZuC6zm3Sd65KR
         rhkc7cs3FBbPQAaAJ+Uq4k95gzdIX+zjTtGitOybYxTQE4qzEOcrr9p016MOfFfWVPFB
         C+vvtj6cGmwKoo8lxNEEcny94OGwyjQsjSAPjNm7HzL6rm69KqHLZtKOyUYEIBNBiB4i
         zja+XFUgqvVVDW12fow/JWywZgPXmBqDNL1bX/yR/61o9SwY8fcV03uALOl2ojejgG5C
         +E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/boFoUXaAgzs/9YRn/4qwyX/v1A/ZjToMiKSYzOwF0=;
        b=U/8asMpf0lcd/mbR0EkASR0exAQ15UqphN27RUXBHUqHeYBuQFPACcTo+w2EeYbH9b
         9e26Y2qWhxFTKMMp8fbyvZRFqXucsnHfmq6Xl7RbipIhIORfU9iWVkcZuMsZhInVQjhY
         YSADZhShZnczfWe53ucYm+I+ACOrN6v26W88gRli8VMvZJQiHRaHw+8Lp2Wbu+muszx8
         UrYZyqSdBJWJ5Le9QIwZ/poHLcpFQLpr0Q3zrD9Y6Znq1PrXiwnz2SvG6SugKXzwu+V3
         s8w7ulvt4YnSwcz3bitXDGOmJ74qPwqRvaKEqVCrGPQk0aiOwTpGVomZXcDLyjroebD1
         HUag==
X-Gm-Message-State: AGi0PuabLNy9cdNmcHNYFaE4//dJlmHV4fbOFoBnjisLgeI1zp1DaeSz
        PlZM0Au8+GAxGKWxwLGlgoo=
X-Google-Smtp-Source: APiQypKxxgw1gHTSXE0R2uidSfFJNoUSdztA5pN6FNFmbebfe2j6K8LCVB8QZ+7yVeNP4+OkgKQkcA==
X-Received: by 2002:adf:81e4:: with SMTP id 91mr14909020wra.143.1589129756971;
        Sun, 10 May 2020 09:55:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:56 -0700 (PDT)
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
Subject: [PATCH 14/15] [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Sun, 10 May 2020 18:55:37 +0200
Message-Id: <20200510165538.19720-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
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
index b26f735201c7..85f43a4b651f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -173,6 +173,7 @@
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
 			#cooling-cells = <2>;
 			status = "disabled";
 		};
@@ -1026,4 +1027,83 @@
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
2.20.1

