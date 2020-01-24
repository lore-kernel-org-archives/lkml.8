Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE48AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FAE208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klhHUcz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbgAXQaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389201AbgAXQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so2701122wrn.7;
        Fri, 24 Jan 2020 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QIn/ekjPN/8iXXGp7E1y+nPWPExusw+RM1dMcjlqWMY=;
        b=klhHUcz554C1wRT2sjn4IaqxVA4Patl8xOwKsmIyZKZJjc29Itt9BaTsyYMCZHIZIH
         egX0JlOPfx0qQIIQuYj2weYwn/Hl3ydE3GuWJ6Gx448DmZR2tj2DRrRQeSxrs21driLX
         n7hPjtACFDRGmlZTrl5PiTIzkpbE4NZ0xY4tWQ6n7hfuqnR/8us/5Mst/ifE85pb9aty
         iNK2bHIbfg+vd3Cu0B/zjLSLagz+Fsmv9w4q28iBGs+pEX1MnI8Wu0ro6C2xD92xlXMB
         aM/FJ00Io64zkp7TvJHNBpgjt97cOj6sijDt81O7HknYSrwRbH+DfejEcMKUUzioo6wd
         bZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QIn/ekjPN/8iXXGp7E1y+nPWPExusw+RM1dMcjlqWMY=;
        b=mHs5kcK2yqPktI27ctRxsp6lANv1cnJ97qV6WzTzZHDQp3Zcs9R9ZRl6XitbULvGq5
         2wcQK3rFOtXvCRruh/uflJggxtshCZ3Ll3K/gAA06K2T+YEzhpKt+32bs6cC7jegFHF0
         Qzwu4YX2zbOWbrh1jn3c9Z8tJ6JxGARdzDsxSsjn9eI4vTfwTf9yA2EFM09A8ne2eeWD
         VCX5BHuy0s0zVNAqBnaLXmkVi0q7YqZwxVAYauhbY2YFk80bIYuPs49eGBAt0THfbjIz
         tNBjgZHYZ4ng1On/1oyoK6mMUTzmreAWg//aoTbJYT+lI2dStFRYFZonmL4L2EEkUCpH
         wBDQ==
X-Gm-Message-State: APjAAAUX/m6jRPOjfjlSVarsrZtdO9cQQsuerCVfZdDNtIHCYjSDAmLe
        eYfG62DVVBmmpG0RQdGd8I0=
X-Google-Smtp-Source: APXvYqw7CIGAG3ZFB6XdbEJQoiV5N2eZpSn9bhSYo9ISaZGS3uiIABvz3px+HqgatIrQN/6z9wwJ6A==
X-Received: by 2002:adf:f606:: with SMTP id t6mr4960508wrp.85.1579883417532;
        Fri, 24 Jan 2020 08:30:17 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:17 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 06/10] ARM: dts: rockchip: add nandc node for rv1108
Date:   Fri, 24 Jan 2020 17:29:57 +0100
Message-Id: <20200124163001.28910-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Lin <jon.lin@rock-chips.com>

Add nandc node for rv1108.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 5876690ee..d7b9aadbd 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -456,6 +456,15 @@
 		#reset-cells = <1>;
 	};
 
+	nandc: nand-controller@30100000 {
+		compatible = "rockchip,rv1108-nand-controller";
+		reg = <0x30100000 0x1000>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+		clock-names = "hclk_nandc", "clk_nandc";
+		status = "disabled";
+	};
+
 	emmc: dwmmc@30110000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30110000 0x4000>;
-- 
2.11.0

