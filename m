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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CAB208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtcohPOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGDK0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGDKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E2EC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so35257122wrj.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljYbPfikKidTyz4vCaRd3InFHHUQa8/wBp/13AuL7tw=;
        b=OtcohPOvXt2wkLQ8Gr+W1KKjsQooO/5qB9Qw8JWG4RNqLiqDxo/9dseNe3YnuskVz1
         s7+RSXF88YSx0S6+WZ8nxtvazmNCAcDUDipl+5YPKdkS0Sj+UxAu+3DwQ69w7IWJNq/e
         OEn29d41euiV7DUJLQ+IsPKmiIoZaugWLz0hax5yM9jQ2D5MD9QIbuyu6fhXI3OLFifN
         A3oxh7V5aXwUq4ERKGIgHYaqepYNQSO+ryAMrM3CqymMBsQVRYGPBQ6PElR5bge+l0c9
         +IDp464kLvagcPqwbTfP8MgY1W0ukcv19uHRk6Ya1lgRMXDV2XEaIfsvW39GtXFdUhOY
         021A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljYbPfikKidTyz4vCaRd3InFHHUQa8/wBp/13AuL7tw=;
        b=FJoQsU08fwXxbo/6XSGU5Kchckp45n4lwDAnM7WTNvECN6dWjprpTJHk1lZ9rhDDoB
         PiZ4oP3cLnjr6iasSlmss7vYBfU/i/zCuWC0dIYrQY9ybQ8QPE6hscrgbWp04alZJREi
         amKRXUio0ezkQiPlWwE1pE7dEZ/GAaaYscNLs8JJOPG/w6xitAjzzv3kaUgWmGk/9p9/
         s1f8hAjYv9pdXywY+NLHc2LWrM3FvZtqboBQMUfFurT98G8rEGV0ljB3p4bneu1CTQgd
         bQOx2nci7XgObQQM1sKDwhHomj+4xfnTWjhAOincqJY1sF08J56ZP3fKITCEAIzphkyI
         Jdgw==
X-Gm-Message-State: AOAM531JgjV5h55l1e1euSgISuNhPKxdylBYSTZIFeHp5hceJf/Q0MpF
        aFD6P95201dUOfLlpBqBBmc=
X-Google-Smtp-Source: ABdhPJyzbanNd720c5+6eFrmSAieB5pdrwV6bL2dAq30zpazgrsKSLmIJk9Tt8TYJ1H6eSrfY76sgw==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr40085606wrp.299.1593858355499;
        Sat, 04 Jul 2020 03:25:55 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:54 -0700 (PDT)
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
Subject: [PATCH v2 12/14] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Sat,  4 Jul 2020 12:25:33 +0200
Message-Id: <20200704102535.189647-13-peron.clem@gmail.com>
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

Add a simple cooling map for the GPU.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 78b1361dfbb9..8f514a2169aa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -174,6 +174,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			#cooling-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1012,6 +1013,27 @@ gpu-thermal {
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

