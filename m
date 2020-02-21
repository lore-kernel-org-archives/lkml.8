Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F587C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E7222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271729;
	bh=rXdWtPMHa6hJZMY0j6WQRhp1vZvRxw1l4dsVIRkRzkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sIxyZ9HGMX+A07syYx55DVX7SmvK7jaHeAaZLt1BvoYj4C20j8F9JRGdUoTVAR0DX
	 yut2tTLDni11ilP6chBP9dYTYBBqEzE3YeJItt5tAz9y6WCJSjMQCwZj8aUwiohPL7
	 2OCGdMBSn8zrQE63wXoVrKqqp9jhRylsITP4TcAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgBUHz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730194AbgBUHzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:55:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82A020801;
        Fri, 21 Feb 2020 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271723;
        bh=rXdWtPMHa6hJZMY0j6WQRhp1vZvRxw1l4dsVIRkRzkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdGqr6LYlAdtv7O5P+58Q3e9OObE75hYl4KcANtRMVe7IctTTM5X7lvYrp49/puaD
         OkNBHk/mLB6Zy8GYEPQgv/xzirGhfKNzn8n2kFlthYjwIs0jUZDzNpPR11aMjGVs+z
         LGOd/QmNzChZDYJ8oN9MaZY0n5QJJocHaqiiPFbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 237/399] arm64: dts: rockchip: fix dwmmc clock name for rk3308
Date:   Fri, 21 Feb 2020 08:39:22 +0100
Message-Id: <20200221072425.679507074@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 2be6a280144e521248a4bdefb691a0a97e604294 ]

An experimental test with the command below gives this error:
rk3308-evb.dt.yaml: dwmmc@ff480000: clock-names:2:
'ciu-drive' was expected

'ciu-drv' is not a valid dwmmc clock name,
so fix this by changing it to 'ciu-drive'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200110161200.22755-1-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 8bdc66c62975b..fa0d55f1a5871 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -591,7 +591,7 @@
 		bus-width = <4>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -606,7 +606,7 @@
 		bus-width = <8>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		status = "disabled";
@@ -619,7 +619,7 @@
 		bus-width = <4>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
-- 
2.20.1



