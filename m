Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0EC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DAB20754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYPMRioc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgCUVyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:54:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33875 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgCUVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:54:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so11890335wrl.1;
        Sat, 21 Mar 2020 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yAx8su1/7aGFuhAGg/EaVyMzVkBJWF+j6/kaWK9mJHw=;
        b=DYPMRiocriecW171ocGwPa9hcFeccH9jeYHN2XRG1NEeJm4jMNxU5HEbT66vOzJ+0b
         TBM+D+7C+/rGvMBuWvg7CL+g6f8u/nBpXpE87DuISS9Miig1W+Lkw91huA7ov4ubDRsf
         FOpgumAN96EbnJbeMfACCrmh+z4C75zUyN9AgYGxnTo2DeubxMSx4kNyqVz6E7AdrEny
         7fcCG5uRamQa0V/TnRUWzvNXwnVRKsZ8mfcAlfc4ACpKJ2z2GJpVTHk9UGlbvaotImyM
         YKaHOnPxLE2+ChXIQpvjLViwAimRpS0AQI/3bALuyQkarhgh26ntT3Ssj0/ZSaMQ0yEw
         /z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yAx8su1/7aGFuhAGg/EaVyMzVkBJWF+j6/kaWK9mJHw=;
        b=Kqy7F7futpI638bT47LUcT4BPKgupHmbxrD9CeKzhEas3q0nVq3SIpxL8lnbUK8unu
         Of1hQs3+GaAm0EMAUmayWqB/1qEnIU126ajNIDYChQW2U6ZkuBL5VfMMYHBCXwtLwWBE
         y2fmEJMArqHkLDdeBYu66AUvn0v2RSDt1wIhUgHVG0HBzATefyKYiqsW111g7gPRXLup
         iVfhbnr1JqthBBGASg/4jxHwRFc8DKw+uvjA7lEBabkpSHrg8Elso6+ChqhlwuEayM6K
         /ullcukiOQ6PvZyJmOPXp/iKIRDYFwnzWYAzspd1Qf6jEwHkXkLBREmiF4WmJ/TFwEHc
         YruA==
X-Gm-Message-State: ANhLgQ1yRqZ/laSKRg9zVUx77COXoueqAx+waJ3NlqMawugHasqZqdn/
        vUhhs22npj89YpafBLNLnmQ=
X-Google-Smtp-Source: ADFU+vv2IejMRNQduQ+Dww45mKhZKuLxpXnA3+KypuBSPMYHDsOLLuGwcTQoWBA5U+2hewuhWvgEPQ==
X-Received: by 2002:a05:6000:1184:: with SMTP id g4mr19735035wrx.396.1584827673044;
        Sat, 21 Mar 2020 14:54:33 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l83sm14113796wmf.43.2020.03.21.14.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 14:54:32 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robin.murphy@arm.com, aballier@gentoo.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: rockchip: fix rtl8211e nodename for rk3399-nanopi4
Date:   Sat, 21 Mar 2020 22:54:20 +0100
Message-Id: <20200321215423.12176-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200321215423.12176-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dt.yaml: phy@1:
'#phy-cells' is a required property
arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dt.yaml: phy@1:
'#phy-cells' is a required property
arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dt.yaml: phy@1:
'#phy-cells' is a required property

The rtl8211e node is used by a phy-handle.
The parent node is compatible with "snps,dwmac-mdio",
so change nodename to 'ethernet-phy', for which '#phy-cells'
is not a required property.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index c88018a0e..20529105c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -182,7 +182,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		rtl8211e: phy@1 {
+		rtl8211e: ethernet-phy@1 {
 			reg = <1>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
-- 
2.11.0

