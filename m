Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7353DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA8020772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arCHEQlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgGJJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGJJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C5C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so5271711wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VG9wQ36+6wND2b+1ll55zwCVUgbhF9bJxt2xblFID8=;
        b=arCHEQlSPWMax2PHYcz1oSUlwEmdK/gJoipdUagX+JC4fIdh2+uF0ipKITX1uERJ7a
         McyCu8VSAkzZ2X1uIPcoPYrt57DcBTgqlbaDnNPj1+EzZGCWMo6kPGoxlvm6ekXMCbdK
         ZgycShxzBoHe4pSmN2YkIrKtYK8tgCZaaOlmVmjsBjG6dlStcaYLaOqVqrh36TACYRj7
         47pOHc8JeQNlLbRjrFIJL7ukWLVyoqlDy542+r+MRB9cTeXb4XCdZzr6xb/GSkPsvY62
         DZCA6xa1A+MqBlVYeB5j1lR+2q9QVXpaJnFxpa52glDuRuTPkWF4gIBGRGhNrXRCZ6hc
         RJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VG9wQ36+6wND2b+1ll55zwCVUgbhF9bJxt2xblFID8=;
        b=iIG+JKWZXgdjnp3940JDR23fGxBZzNHYje2D/rtk0Dzm9/L1frIqN+dSByqqMrOwSZ
         AMmH7/jEg9oXsqeCN5uXkyYqBzT7ZgR4QQRADR6Q3ZT27f9W5BvO3TBzNcJKl0G6VO6R
         VyBgCvz+Zm7RsME1LYsraaWN8WDHS9K40XbWdEKfryKJi67nq2F15bp72QFuAzcIV+sy
         +UxdRWm1e/03+s+hzQ60qdxtDfdprnNA/LN2RczUskoZ1Nd7mXA7rq4X2ZI9xdwP+kWD
         Zw/2q1V/BxaB2EIXk0VeMt+Y59EyrVl+nyly/PlcXWuqGPDW6jC/AKkbG9hral6dUVYX
         JAIg==
X-Gm-Message-State: AOAM532OkMxfOGI301ZPW3c7mPJq6/tEShGNV/FSFwQJy2baFT8kJT+P
        jt3BrORY5QWC/7wVcbamTaQ=
X-Google-Smtp-Source: ABdhPJyCS0Byis+30zzDr4BEH6T3l1hR4Yd0kDf359JHDMzQ2V1yzUqlbi3l5elMmoSteGmC6tQ0gA==
X-Received: by 2002:a1c:5646:: with SMTP id k67mr4515905wmb.61.1594374866911;
        Fri, 10 Jul 2020 02:54:26 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:26 -0700 (PDT)
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
Subject: [PATCH v5 12/14] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Fri, 10 Jul 2020 11:54:07 +0200
Message-Id: <20200710095409.407087-13-peron.clem@gmail.com>
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

Add a simple cooling map for the GPU.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 9ce78a7b117d..1c939c55aaea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -175,6 +175,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			#cooling-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1013,6 +1014,27 @@ gpu-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu_alert: gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.25.1

