Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D36C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D10206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036752;
	bh=ME+CV5unqIVO8MAWxN3rDYTcx2/ws9pvyndrNEY3HcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=okys2MRGbtoJgiPfeCzMnObYF+SIJxipsBgN6GJKby0QckOBEolbzGC8lpZ2GNSCF
	 qMH7atmR0iLKkgRJe3QDkSB6odcfgL+KgxLELFKIXxxvQ/3j6NcXZeopDQ5/rekEvu
	 MeX9Z8lm3/kXvSp97PchxqIZUGAuI6Qpas9Byfmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgFASjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbgFASOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:14:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364832065C;
        Mon,  1 Jun 2020 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035280;
        bh=ME+CV5unqIVO8MAWxN3rDYTcx2/ws9pvyndrNEY3HcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbj2AZRVEHMqdUoE9NUicjMhj7TS+9qhWCUU4neZ32R3yFusVxSwPf0o8wr5kCAF8
         Up7NVOcvyDZbwYsCOQ3KrbB8bw5med/vYFFFD7ivZ9bi8VEczPDHc+0lNUIoUerps4
         JyQn5gguT7es0T1Il2xZ5xdH6XaWdmVTTsZODCpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 048/177] arm64: dts: rockchip: swap interrupts interrupt-names rk3399 gpu node
Date:   Mon,  1 Jun 2020 19:53:06 +0200
Message-Id: <20200601174053.041631141@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit c604fd810bda667bdc20b2c041917baa7803e0fb ]

Dts files with Rockchip rk3399 'gpu' nodes were manually verified.
In order to automate this process arm,mali-midgard.txt
has been converted to yaml. In the new setup dtbs_check with
arm,mali-midgard.yaml expects interrupts and interrupt-names values
in the same order. Fix this for rk3399.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/gpu/
arm,mali-midgard.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200425143837.18706-1-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 5c4238a80144..c341172ec208 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1890,10 +1890,10 @@
 	gpu: gpu@ff9a0000 {
 		compatible = "rockchip,rk3399-mali", "arm,mali-t860";
 		reg = <0x0 0xff9a0000 0x0 0x10000>;
-		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "gpu", "job", "mmu";
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&cru ACLK_GPU>;
 		#cooling-cells = <2>;
 		power-domains = <&power RK3399_PD_GPU>;
-- 
2.25.1



