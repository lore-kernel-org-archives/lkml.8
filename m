Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A51C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8168220724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/RATo9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgCRT3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:29:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36224 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgCRT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:29:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id s5so31983602wrg.3;
        Wed, 18 Mar 2020 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=24spxwKs6/lu06D14Gb2r20D9msuLPFYXhBKgOUGLVY=;
        b=e/RATo9W4dh73ey1VeO1DFTpBsoaeBO/sb3+wu9I5BZ4DnG6xs/Fzvnqv2+wU6o+bK
         CB5yNr5Vt+FtbsHgYSE80t+Txf8NJPHdqDgPHfxh0bXiU+wgCkJrpmm/s87WIG0TWiK6
         zOamz7BEEoj4xtqAFGCOFl48gQXf49BoXuyZiaP71lJH8bfxd3FfjAbInUrV4LILb23p
         o/uv5iv2aS1FePjcgLw4sIER9Ek+zIVXvcGamxqobtmqU90tdvFFokcSBeG+3i2U1i47
         MKPY+6bvDkp9oAvYPOo4a5NmX2JMV4Tc/oIg0R77XkWocS63V3xq8RhVEjjnYSIUtX6s
         gB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=24spxwKs6/lu06D14Gb2r20D9msuLPFYXhBKgOUGLVY=;
        b=cTd+nQYOboVkImHxTv/z1rlRKrrDl1txaY27PxdLyFZj9k8LKwBm7zvgwpDQ8weO03
         2OOCuMpye2WDeqskwkItdjXAYN+ZIGT+MPdhm3VqKsixVWiM50U6bYAQtssPwFF4Uq8A
         XzI/ZG+trgMYYjVska39XjiUEZTMcR+djiDiT5wHoD5OSRDSxHokkBZT5otWm8ODkbQo
         eP75wDY7T5v5mBJ3DluRs2TQpA6ebm8/3iqWJfIhe9cX0AO87+Cjs70AKcPLQwsOTaV3
         QiwoYjgSwHDKcg2+49ZpRfZV7f9wgfNDCiJZYF0unVfoVn9Sk2dHz4jjaZK0DQJ30u3Z
         FmAA==
X-Gm-Message-State: ANhLgQ2greHB0cNh0ykJTX5gCXZWkB1MDVNQ0w5G19ocHP23iwwoVKov
        eYny+U/uzugCQdwEYeavMYg=
X-Google-Smtp-Source: ADFU+vuJAKgOP6N0WJCkC/0D+fPS5480Ytml+vLa/YcsAurBD7mGJpj/3MStcWaMC+osRkDc+h/ZnA==
X-Received: by 2002:adf:9b96:: with SMTP id d22mr7727492wrc.249.1584559749269;
        Wed, 18 Mar 2020 12:29:09 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s131sm5333728wmf.35.2020.03.18.12.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 12:29:08 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     kishon@ti.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] phy: phy-rockchip-inno-usb2: remove support for rockchip,rk3366-usb2phy
Date:   Wed, 18 Mar 2020 20:29:01 +0100
Message-Id: <20200318192901.5023-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200318192901.5023-1-jbx6244@gmail.com>
References: <20200318192901.5023-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'phy-rockchip-inno-usb2.txt' is updated to yaml, whereby
the compatible string 'rockchip,rk3366-usb2phy' was removed,
because it's not in use by a dts file, so remove support
in the code as well.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 680cc0c88..dcdb5589b 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1299,25 +1299,6 @@ static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
-static const struct rockchip_usb2phy_cfg rk3366_phy_cfgs[] = {
-	{
-		.reg = 0x700,
-		.num_ports	= 2,
-		.clkout_ctl	= { 0x0724, 15, 15, 1, 0 },
-		.port_cfgs	= {
-			[USB2PHY_PORT_HOST] = {
-				.phy_sus	= { 0x0728, 15, 0, 0, 0x1d1 },
-				.ls_det_en	= { 0x0680, 4, 4, 0, 1 },
-				.ls_det_st	= { 0x0690, 4, 4, 0, 1 },
-				.ls_det_clr	= { 0x06a0, 4, 4, 0, 1 },
-				.utmi_ls	= { 0x049c, 14, 13, 0, 1 },
-				.utmi_hstdet	= { 0x049c, 12, 12, 0, 1 }
-			}
-		},
-	},
-	{ /* sentinel */ }
-};
-
 static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 	{
 		.reg		= 0xe450,
@@ -1426,7 +1407,6 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,px30-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3228-usb2phy", .data = &rk3228_phy_cfgs },
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
-	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
 	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
 	{}
-- 
2.11.0

