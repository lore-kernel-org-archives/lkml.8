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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D131C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122D520772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax7KLwYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGJJyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgGJJy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C6C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so5263327wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRxnrLEUrSrlK3zy1+2PoRYSjZZZ/aiOGCPYzvHmseE=;
        b=Ax7KLwYXMudeWTKZWMZoKaIdW+41vP/yk5pKH7JXbzOuY//U/J7sWJOgQoweFB5Ge9
         i4UMNN5Bx4cGkLa2CxA4RqLCNSvWnYhsCw2zSO29HftQPD5xgwhUHAO4F0PbX9OxoYMD
         CFefLJyFKjoAuLUpFy3t1adPxhdIMid6vBhO508c7MHFf9Oa8l//+W9N1o3b9VGSAYBD
         XVoHj3+ynKTaAxRf8jfbHf6d+xDig9Aqf1bHV8S6+NPG8yIuTl4qOsCeA8VUXhZlqsor
         Fb35cQkYy/XLpb6YSDbVcBzP7/5lizIBiBeBaVtJTmtTH16hmim7CWoTdF07NL1yORe5
         tdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRxnrLEUrSrlK3zy1+2PoRYSjZZZ/aiOGCPYzvHmseE=;
        b=HyjznK/ujE2UN0C0WYoFayjCepaQ6MJAWJECueX92HvEorLduurKpDaj3ydLBdY3gO
         Mj/kTJlccFIGLu9LHq3jj99tzvOaTSQ02mY5INh5y+z06GEE//rqxc+X2EM0xqo/DfUz
         avTMff4OI6fKxsP8jr+EwKBOchtBBoDruRgmSRtflIRqllOA/Dn5roqu+C9JYo93Z0IA
         JIBJsEgcOP97fGWJoTuWXl4XwU2EViNhSjQcj697DSTfWjxvmfIq2kVeDArTorA0jx0d
         yPnzD/NtBXXSwnlCGX5UaNmdECSN2amK6J6pLfBSWsn2vSBCjxUpYFOGTuUwEIYE7SHP
         A89A==
X-Gm-Message-State: AOAM533qJJXOSlxULfUO5OT03JYTZGFnwXjuGvqvfpKzi+HvHV9Ntdod
        qNC4+cz23Fm8Gsmr92De7e7LfYH+y3s=
X-Google-Smtp-Source: ABdhPJwTns1K8KXgCQ0MyV0FMjZlV8NiWamZDQPmHqlyMxrvB7J87elQSbKPOX8421NQ1QnrEw4/rA==
X-Received: by 2002:a1c:3504:: with SMTP id c4mr4326573wma.177.1594374867967;
        Fri, 10 Jul 2020 02:54:27 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:27 -0700 (PDT)
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
Subject: [PATCH v5 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Fri, 10 Jul 2020 11:54:08 +0200
Message-Id: <20200710095409.407087-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
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

