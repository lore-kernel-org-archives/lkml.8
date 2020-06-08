Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57742C433E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399C720872
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658510;
	bh=oEewM0dkDkgCwwft76H40HPXAdaBytAgQDChrE8c0FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lC+l2U8ZEq3FS7jwksnu10KIQd8u6FFKgscLp7BZFomG6IJdw/wynq7ZrY82aZb8p
	 VxG7ubgMtmeUQCXxO2XCSikM0pqeNDCf9z5d4lm/RIqo2UY8yVkxYl7XNrpIEFw0tO
	 lljWX97KYGasuQLQ3VwX5Pao02jdx3mHujjOf0/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgFHXVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbgFHXR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DDFC2086A;
        Mon,  8 Jun 2020 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658246;
        bh=oEewM0dkDkgCwwft76H40HPXAdaBytAgQDChrE8c0FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuwcPbBwSu3cPQOHb96YKnHgjXwKZejehVDLhN5EH0OvhDxc3mfuSknzWwrNwu1EI
         wO/gLldZhTk/RNH18uuLa9Q8KTcSgD1YKei2ufuRkPEqC07L57xGBzeehK+6Pz95l0
         T6T4/jnyZ3hjlkbScBiIS4RSu9hh1dWVwCNYVqwc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 256/606] ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
Date:   Mon,  8 Jun 2020 19:06:21 -0400
Message-Id: <20200608231211.3363633-256-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 729119952c68..a83f65486ad4 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -1033,7 +1033,7 @@ i2c3_xfer: i2c3-xfer {
 			};
 		};
 
-		spi-0 {
+		spi0 {
 			spi0_clk: spi0-clk {
 				rockchip,pins = <0 RK_PB1 2 &pcfg_pull_up>;
 			};
@@ -1051,7 +1051,7 @@ spi0_cs1: spi0-cs1 {
 			};
 		};
 
-		spi-1 {
+		spi1 {
 			spi1_clk: spi1-clk {
 				rockchip,pins = <0 RK_PC7 2 &pcfg_pull_up>;
 			};
-- 
2.25.1

