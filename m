Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01FAC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8271320787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4xGsdFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgDAHhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:37:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35524 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:37:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id d5so29355141wrn.2;
        Wed, 01 Apr 2020 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UL9L/CyBrVCzEQgwvr+OzrzI0iM1qlY+IPc8B3d54Uk=;
        b=F4xGsdFAsV/TIjXPGAqXfSqlyGmZ30mfw39njgikMjE0/4qVNARRKCUhFTNcvs5HTH
         T+5J2BSmhrESB3sIoug/Kk/Lli0CDqNb5OIY8Pd5dDr6u1eoZ77RASNtvfEdxMKsV9iy
         cdXc0U/K7p1q07UqMx1aYS7oC4w0sh+XExOKCFBNaA7LshlaKCgIk1RZAOYTFGae5ibD
         dPtgg7Y4itEheuRdbUSPwWfS+/dQJ8qVC/BkFPKEoGHPENaPDtSjfSIFwTlHRgUk9ZXL
         r28d/c/wmK8UhrOP42pbzm3SA8mOV7J2bR8O0O/DX52LrxT+uuNX7iEEg9OmP8Q3JU0h
         oyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UL9L/CyBrVCzEQgwvr+OzrzI0iM1qlY+IPc8B3d54Uk=;
        b=UN3msUZLKP87tocdUDHIt347tMkQqx2h19s/pVoM/1pfjjinYujvMSb9ucIkJ/0K13
         kvvnE5MtPBJDj506ygqXKSzLX3ZirwogJBHmNq4n9cF7U2maA5y6guGQ3cXVkDvntFQW
         VuQ8tRRNwRQHaVvU+Qw9+894ovQTFHt7iRP+39aRrPqpCNgfhsVh4Vlz+xzBytRwuaJM
         ZMd++qozcA6m+8Iwd4aQFx2tCSAvUkNWvJ1uvJUd++Cyg3APW1ra2ynw7m2WHFurqxvb
         6pgF89/pqRvM4hYnZN6c7nK/R3Pof4i7a06gVPC+gl3HV2MPQZKllf4lvpteLEFbcwle
         Cb1A==
X-Gm-Message-State: ANhLgQ0LjxPr54zlAO2DRYefFxLvDCn8PUhJVGF1kS03EhEeCIG/BrSn
        V1qnuunDoDLDRipCxCyq+UE=
X-Google-Smtp-Source: ADFU+vtwdLJ3roDKyKh7gH+Nq4Ettv7bI9BNPrDCjycpvqCdmWj6VAchRJw+IPzp8foaVLPgtOHruQ==
X-Received: by 2002:adf:decf:: with SMTP id i15mr25756408wrn.277.1585726654815;
        Wed, 01 Apr 2020 00:37:34 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g3sm1793431wrm.66.2020.04.01.00.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 00:37:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: rockchip: add #phy-cells to all usb2-phy nodes
Date:   Wed,  1 Apr 2020 09:37:24 +0200
Message-Id: <20200401073725.6063-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files for Rockchip with 'usb2-phy' subnodes
are manually verified. In order to automate this process
phy-rockchip-inno-usb2.txt has been converted to yaml.
'usb2-phy' nodes are now checked by:
'phy-rockchip-inno-usb2.yaml' and 'phy-provider.yaml'.
'#phy-cells' is now required for all usb2-phy nodes,
so add them.

make -k ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/
phy/phy-rockchip-inno-usb2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 ++
 arch/arm/boot/dts/rv1108.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 06172ebbf..9ad32651a 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -214,6 +214,7 @@
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy0";
 			#clock-cells = <0>;
+			#phy-cells = <0>;
 			status = "disabled";
 
 			u2phy0_otg: otg-port {
@@ -241,6 +242,7 @@
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy1";
 			#clock-cells = <0>;
+			#phy-cells = <0>;
 			status = "disabled";
 
 			u2phy1_otg: otg-port {
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index f9cfe2c80..b453f8d0f 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -269,9 +269,10 @@
 			reg = <0x100 0x0c>;
 			clocks = <&cru SCLK_USBPHY>;
 			clock-names = "phyclk";
-			#clock-cells = <0>;
 			clock-output-names = "usbphy";
 			rockchip,usbgrf = <&usbgrf>;
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 			status = "disabled";
 
 			u2phy_otg: otg-port {
-- 
2.11.0

