Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC8C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F22078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLIfnCa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgDAHhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:37:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52752 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731849AbgDAHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:37:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id t8so2046107wmi.2;
        Wed, 01 Apr 2020 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Y6Wj9TjOPkwLscHBPA5Cfe2j0fMXJtpZJ9SAqxrysY=;
        b=gLIfnCa9RtFY4bg+BQkrVUO4Rvy87KxQjWbI4NQsRQAzQL0j7izLckcgIVc92kpaIC
         xqfFVmbpVbso5u+xZy9+UrR6XKHdhiFyWltAqmDbM2rzuZLhLJVuH2NiPb5Z1MWAH88r
         i9ocprWSufx8F2X7UhYwELcDpu5DwChiP80XwBruxSesGs8H9BwuFhDO4uTL/2sRJAsO
         2OgSzLfNkoKmgtbn5Np6X7TqKUDOmWuTNl6Ej4D9PfKmZE2wX0V3cmWoxAN4vsz0EmaK
         y8LoUpmUhQ4VOgyL7wxa0ALaHJABHW/scbpQl9TEhsNSVYHhxdd5qD9OTVmND9jgR1U7
         QAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Y6Wj9TjOPkwLscHBPA5Cfe2j0fMXJtpZJ9SAqxrysY=;
        b=RcG9ys32HAjz4x5aqwzzOjoWuvynlHBnWn91d733D/I6aYEnS29r5dprwmSyAC+yEZ
         sQheb8wRK6j3abnUIvsJfamnVbqZGZ3Z69Y979ejlym/Tt/PHZPyW2gzQ4cAnpnvED1Y
         finjJmYehV4djg2e1whNkWSqVZK9PAX9VT+D5y4FoBHoNtR/sDgq4OLxAVww/SY9fzRR
         uod0IsvpDZTx3vXaT3a1GHfVkwKKdFQyNIsDUYE/EjW+gkMT7WyF67t8sdrexHbigP9d
         H9niZvD/2DPkbMSy4tazlwWSQPQS6I0jhcokOTGVJ/sTpMxqVScBpXYQGShmcQscinml
         2LUg==
X-Gm-Message-State: AGi0PuZ4Rmna/TAhpHHhKwGkW9+uo9MwWLxF5kmgeh6HCzK0YCBZc5AM
        TDVgLBFmUXSCag0HX4Ao7pRY7h1J
X-Google-Smtp-Source: APiQypIo6BlXDVUAujJm5bjFl9PFx10seyVOAuO+YssZ1j2o9iXGGnPhJ3AFEfXIPfLYVm9Tx24sew==
X-Received: by 2002:a1c:dd8b:: with SMTP id u133mr2754794wmg.109.1585726655777;
        Wed, 01 Apr 2020 00:37:35 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g3sm1793431wrm.66.2020.04.01.00.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 00:37:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: rockchip: add #phy-cells to all usb2-phy nodes
Date:   Wed,  1 Apr 2020 09:37:25 +0200
Message-Id: <20200401073725.6063-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200401073725.6063-1-jbx6244@gmail.com>
References: <20200401073725.6063-1-jbx6244@gmail.com>
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

make -k ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/
phy/phy-rockchip-inno-usb2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 5 +++--
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 3 ++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index bd5f51d23..6f7171290 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -822,10 +822,11 @@
 			reg = <0x100 0x20>;
 			clocks = <&pmucru SCLK_USBPHY_REF>;
 			clock-names = "phyclk";
-			#clock-cells = <0>;
+			clock-output-names = "usb480m_phy";
 			assigned-clocks = <&cru USB480M>;
 			assigned-clock-parents = <&u2phy>;
-			clock-output-names = "usb480m_phy";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 			status = "disabled";
 
 			u2phy_host: host-port {
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 8976c869f..470783a48 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -830,9 +830,10 @@
 			clocks = <&xin24m>;
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy";
-			#clock-cells = <0>;
 			assigned-clocks = <&cru USB480M>;
 			assigned-clock-parents = <&u2phy>;
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 			status = "disabled";
 
 			u2phy_otg: otg-port {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3dc8fe620..a7ee5aa65 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1391,8 +1391,9 @@
 			reg = <0xe450 0x10>;
 			clocks = <&cru SCLK_USB2PHY0_REF>;
 			clock-names = "phyclk";
-			#clock-cells = <0>;
 			clock-output-names = "clk_usbphy0_480m";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 			status = "disabled";
 
 			u2phy0_host: host-port {
@@ -1418,8 +1419,9 @@
 			reg = <0xe460 0x10>;
 			clocks = <&cru SCLK_USB2PHY1_REF>;
 			clock-names = "phyclk";
-			#clock-cells = <0>;
 			clock-output-names = "clk_usbphy1_480m";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 			status = "disabled";
 
 			u2phy1_host: host-port {
-- 
2.11.0

