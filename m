Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05584C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5043206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037332;
	bh=w2pSz6sSKuZ1uwjqUAGFQHWs2ZIfFkdSdsug/JB3dAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZmccOQFESHLPdxMO5FiEghpAZkYmjPgGgzLVzV0d0l8vMwIrgvGPzkLhZtkeAKrgv
	 dRoDD+PGvozeZjWW+qb+D+6zK93AWnATMEo1npnffHH6PRx57RaJkyRvNzWJTOkHDj
	 FKVLkCt+Z913NkOeJ8uAtp8ZvcW1lGnFQkXb1WnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgFASsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbgFASHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:07:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA4720872;
        Mon,  1 Jun 2020 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034842;
        bh=w2pSz6sSKuZ1uwjqUAGFQHWs2ZIfFkdSdsug/JB3dAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBhD7gthnnlnItlLgIf6cynf3/ylRW9Qnnb9aE8vgUpRlusMIALwbXzaTDbjBWrL+
         ffMwk1sX75rf6096dJaaGPbdPg9Znmvr367oBCi2RjtjmmTMzxMvNtneje4uE5ytEN
         DD3LtRbTb8T5a2illc6wd96u5D6sis2B1BqLh5FQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/142] ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
Date:   Mon,  1 Jun 2020 19:53:15 +0200
Message-Id: <20200601174041.814110566@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 855bdca1781c79eb661f89c8944c4a719ce720e8 ]

A test with the command below gives these errors:

arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-0:
'#address-cells' is a required property
arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-1:
'#address-cells' is a required property
arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-0:
'#address-cells' is a required property
arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-1:
'#address-cells' is a required property

The $nodename pattern for spi nodes is
"^spi(@.*|-[0-9a-f])*$". To prevent warnings rename
'spi-0' and 'spi-1' pinctrl sub nodenames to
'spi0' and 'spi1' in 'rk322x.dtsi'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-controller.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200424123923.8192-1-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk322x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index c60784f3aa75..6bb78b19c555 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -1033,7 +1033,7 @@
 			};
 		};
 
-		spi-0 {
+		spi0 {
 			spi0_clk: spi0-clk {
 				rockchip,pins = <0 RK_PB1 2 &pcfg_pull_up>;
 			};
@@ -1051,7 +1051,7 @@
 			};
 		};
 
-		spi-1 {
+		spi1 {
 			spi1_clk: spi1-clk {
 				rockchip,pins = <0 RK_PC7 2 &pcfg_pull_up>;
 			};
-- 
2.25.1



