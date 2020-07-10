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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B003C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DC420767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="carzkvlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGJJ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGJJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F1C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so5351605wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VG9wQ36+6wND2b+1ll55zwCVUgbhF9bJxt2xblFID8=;
        b=carzkvlL4fPgiY8/ikmG/X30/j14DZTnoy/ZCCRzPEovmjSSEjaSr0hHan1ZPp5ctO
         +Gf9XxFrLm6CMf32AlmmkOYRBK2KOQlUMNwqO6MQxwL3MEU3+WmznHgYSnqq3jCxiNx5
         h69+pu8JnjF+P/MaOiPDCMrDomeMx3FGwAege9a9KaSs0A8xh9TxWgGv2q8RrfYAyEiC
         a5JYNYsmWkxJkuPs2Y8YW5q4s4BF7OCzFr88UMxVXvx60wiQpfc0cWW0J0MFglDsH+nQ
         Hn1+k2D4l1a4ja044od/3j4EJ5iRrG9p2lsarnlD4ZtI9J/G2mvxM6XLT4ahZ9o/yr0h
         CaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VG9wQ36+6wND2b+1ll55zwCVUgbhF9bJxt2xblFID8=;
        b=CRSgEZCDNZMe6vQ4pdJtHTEnq18pLXIn0XJTgULyWd0vg91/Gf9xHsvyfhOELToosy
         S/g5xAjDHpZdbua1mi4xMOsKWbzJ2NPaKr5b9bFQPlKu7+hqU3k3dG7fJ8trwUPmM2mI
         mk64+zJL16Rpn7O/1/o/9O3BEuqTRIxMyVy8HF4YT/pxjxcH79GjtyFCgekOBcpec9E9
         DIiTSkNwPITtKXAr6jMzkGmmVbnymqUJuxWoNSLUYIYwtsSdh+ttbx6nXtDee/M0BRGH
         sZbR89goQV77x3y+DaXwIID7M+YvqhchKJ/duJPZwBpXFDcg4ITiKvUS+D+tKGlb72WL
         WZ1A==
X-Gm-Message-State: AOAM531nY3ud30dfBajuQ6maoTMOSY/CWkMkYdbai+ukqlXlD1W1tDNj
        kCdpCk2WwHE1xPcSPA4YwIY=
X-Google-Smtp-Source: ABdhPJzfsp51zsDGVN3GNH7Jbje1TAsP8U6D5DpK8iDepJ7CTVH039bhVIuUP/0C2wAuc0dbbbuGtw==
X-Received: by 2002:a7b:ca59:: with SMTP id m25mr4494841wml.151.1594373167015;
        Fri, 10 Jul 2020 02:26:07 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:26:06 -0700 (PDT)
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
Subject: [PATCH v4 12/14] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Fri, 10 Jul 2020 11:25:46 +0200
Message-Id: <20200710092548.316054-13-peron.clem@gmail.com>
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

