Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D57AC3B1AF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE762467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701340;
	bh=JvWkGWu+zJTSt92/+C6IwYRDtjcfu7RIC81rjcj5734=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=avyhCHejcy/4ygpApZFSYe+p2hbO8xY0i9j5t11lLvFoFvfZVYOixp3EeyG9ytacI
	 QnaAZwXt72Vf7MxkZ/icnheEyK1MOzoaNAsGT/9aDJrUVEiUEUbAU0rch8j+Xbd9v8
	 xAL6352+I30lUmf+HAcsyPGdv0B8fcCV+F6HJkoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbgBNR2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390846AbgBNQIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9D624699;
        Fri, 14 Feb 2020 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696483;
        bh=JvWkGWu+zJTSt92/+C6IwYRDtjcfu7RIC81rjcj5734=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugOKhRb0nHHGn5bOFsv7z+sgnj/4FLQwW6el7IlzxNnKpbCz+39EoZL1S5VNZ4dI7
         cNMYK3QAHY22Yx1dz2PjqVmikfTudb3Wt9oagD0BnqsnGyaNKh5gAG0dYEs3TLNxPA
         8vYN/JCEi8STkb++k6cD58nzC74iI6sxlrqq1WIg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 290/459] ARM: dts: rockchip: add reg property to brcmf sub node for rk3188-bqedison2qc
Date:   Fri, 14 Feb 2020 10:59:00 -0500
Message-Id: <20200214160149.11681-290-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit cf206bca178cd5b5a436494b2e0cea75295944f4 ]

An experimental test with the command below gives this error:
rk3188-bqedison2qc.dt.yaml: dwmmc@10218000: wifi@1:
'reg' is a required property

So fix this by adding a reg property to the brcmf sub node.
Also add #address-cells and #size-cells to prevent more warnings.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200110134420.11280-1-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index c8b62bbd6a4a4..ad1afd403052a 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -466,9 +466,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_bus4>;
 	vmmcq-supply = <&vccio_wl>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	brcmf: wifi@1 {
+		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio3>;
 		interrupts = <RK_PD2 GPIO_ACTIVE_HIGH>;
-- 
2.20.1

