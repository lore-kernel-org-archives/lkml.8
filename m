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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E3AC54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ADF20820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkGNQyc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEJQ4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729254AbgEJQz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A10FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so7924065wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msywohSuGh6swONibcP6F+70WAKAL/uMsF9k7te5F+k=;
        b=hkGNQyc/x4KmNhR09Y2373rMJ+tldHIgVAtQ5VwfCBsP8haDn+N554iEOj/zvNyHXG
         2apeoK0tQG+mCZe97atPSgr5GjCqVes/Vgfs61/9MXW6B0/NaycoQm9quf+iHnLJpxfn
         EdOP0OBpcI+8rSXiKPOUWE1n30U81mOmraEgodeYJpyKJu38h+3/GKIkcd+Szc6UV9qd
         NQf0r9ZCLRFpAZHtAhEpxwT/l5YlSSP94UTc2Z/IWWgFz2c4CA1+Z3ZT+t/8dGPIe+ac
         33uMRKEFmjB204J9WZxdHkaJp9PZ0z38gHVu99IcR/xD1X804ASAGwRe1OlbaHnF1ljh
         H3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msywohSuGh6swONibcP6F+70WAKAL/uMsF9k7te5F+k=;
        b=MbAkjmshB3h3V4nYp34w9gEMKd/9/9urT45xNte3fH5xsOv1nNgDvLTJLnhmFzUH/d
         lBreshZBMwCA8ksJ0bgrWJUu6vgumOghV/xJTHRGGEe62W6Dwh1mF93RBi4/HTjyqNz1
         X7ldJB1r+QJmlQMmfkazikUdm7wLK2G1wVqrWcs4K3JalEe4/2oWAima+E9WuwPMIJ30
         w+J2a3LgHVDMM4BF2q6Az41xfXr82ZcO+GEiAxiZB5pzcGzdO4PK3ujUxJF3aI8z4uVb
         AmGiRlfchFoz31axuXpWUI5PuxrbHWWWyRiNNmTZ9VrIFfrEY50S7OtUYXmGyBZThazA
         rQpw==
X-Gm-Message-State: AGi0PubM4YzgZPx6NkeDizfwccq0yw6n2zHFrbXSa2+d7jHkkwB5LNvd
        nCiAWV5H+J2pkaNXkp2TDkQ=
X-Google-Smtp-Source: APiQypJQLiGZ3inhyarOnjxz5H8I+2somPxs9/69ewsW1D9UgAjT/OiP3usqGH5auhmMYmhn3EFEJA==
X-Received: by 2002:a5d:69c3:: with SMTP id s3mr13817785wrw.305.1589129756050;
        Sun, 10 May 2020 09:55:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:55 -0700 (PDT)
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
Subject: [PATCH 13/15] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Sun, 10 May 2020 18:55:36 +0200
Message-Id: <20200510165538.19720-14-peron.clem@gmail.com>
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

Add a simple cooling map for the GPU.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 2e31632c6ca8..b26f735201c7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -173,6 +173,7 @@
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			#cooling-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1002,6 +1003,27 @@
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
2.20.1

