Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5103C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8131C205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGd6b7Dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgETGs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgETGs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:48:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801BDC061A0E;
        Tue, 19 May 2020 23:48:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d7so2050060eja.7;
        Tue, 19 May 2020 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tTeswJdRafCs9rbWrwY8onvsdFrv8hfLm2G+qfpi0DI=;
        b=nGd6b7Dmq5fujZcS3MoQfhIQcFbakcZHSlnkHkKOonOhJzlAIQ2EqBFSR3kA9jz6KB
         bzDKVDex2C2sJ8Mtvle5+hYt82nW1O6fR6uHFL7igg005rcmVQWhZX9wOwhhw40GM2lC
         oCheyCEbG5K5EK4+9Y+Wdi7YRT9NsPNcTl22+Xg0bSIVuW/ySFzAdMkiCuj/Zmc1tZr9
         e0RPv0VCcWQfBw7h8bABZnyHYxvLGBCpLpubKm+/b9bNWNgKwtGlbfpXkVYCMjNuA60N
         JNsy/aWLkK+LlnkWPVNSVosBcT0pszz2Otg4kJIIEn2f501Ja2r2JuR7js38Z04Bx/Ra
         E6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tTeswJdRafCs9rbWrwY8onvsdFrv8hfLm2G+qfpi0DI=;
        b=H98A2cGcmDFd1X/vZ0obaaXuy1xBAzN3FI3kgXUZjAtcMwNBoE/LZnOv/2MyhVC+f0
         R5wu80jcEtaK9eIPOLf+37yebHFnbBlYKWtfJD1ETMarMYih38jXH+rZhOQU8QTdqLL3
         akPPmdfFqjVZV2nhoCCZd8nuby5NbGk1bOeM4nm6Z3aA0/a40OEKHvY9nenUrMsPyTAi
         vHi1t3doskKAwCXcl12sjAtgvfE8t6FDdtgTiZeSDHndjU743FTUlN3gYuZinJ4q+bGm
         s4Y6Zpw0gChRfSSBRD0KqxN/sgFORcWQ/ods6p4DdmuqQsH4YP2Fg75Y+HD8Ab48sTMv
         A9Fw==
X-Gm-Message-State: AOAM530kT3Nl8lDHZy+FXqbykX/ORGVhSg7fay5MD/L6dHP0/qohjtjg
        bTj/L6PJ2wCC59PgWq0BsvM=
X-Google-Smtp-Source: ABdhPJyoxv+ytT4N7FAeNxPJ21oQAAVQppQVdoT5uByDY/gnRHN6jAIqKTGnnwy5rtDNXvr3TpEVbA==
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr2412023ejb.305.1589957304221;
        Tue, 19 May 2020 23:48:24 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t23sm953961edr.71.2020.05.19.23.48.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 23:48:23 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] arm64: dts: rockchip: fix dmas dma-names for rk3308 i2s node
Date:   Wed, 20 May 2020 08:48:16 +0200
Message-Id: <20200520064816.3954-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the current rk3308 'i2s' nodes has a different dma layout
with only 1 item. Table 9-2 DMAC1 Request Mapping Table shows that
there 2 dma sources available, so fix the dmas and dma-names
for the rk3308 'i2s' node.

10 I2S/PCM_2CH_1 tx High level
11 I2S/PCM_2CH_1 rx High level

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index ac7f69407..79c1dd1fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -564,8 +564,8 @@
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_I2S1_2CH>, <&cru HCLK_I2S1_2CH>;
 		clock-names = "i2s_clk", "i2s_hclk";
-		dmas = <&dmac1 11>;
-		dma-names = "rx";
+		dmas = <&dmac1 10>, <&dmac1 11>;
+		dma-names = "tx", "rx";
 		resets = <&cru SRST_I2S1_2CH_M>, <&cru SRST_I2S1_2CH_H>;
 		reset-names = "reset-m", "reset-h";
 		status = "disabled";
-- 
2.11.0

