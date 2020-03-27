Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C0C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3A62083E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585278281;
	bh=rpJytZ8i0tDwoRppmzgTSdMo9ejo2KY0026ChofTs+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ykZL5si3Mv7f+AFdapsTsb1z/gC6fJAvWUaIGhTfRIZcIhm1WtKR+Zu5JUgp+McS0
	 S5JMHMvxS5UiZV+ChVf5SO8mjFMw/VuM01cmZPJ+4Mve6iuAR9LxhFuLEX58cOvQMa
	 HgiUeERe/4Y/oyKj1PZKcIYRIV4gP9hWtZSzYGB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgC0DEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgC0DEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:04:31 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24EC22083E;
        Fri, 27 Mar 2020 03:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585278271;
        bh=rpJytZ8i0tDwoRppmzgTSdMo9ejo2KY0026ChofTs+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjTG3YO5hV4R1Ed554ydsqpZa5tYxdVW9IwOHqW/C5L8MDQrHNOY+CuofIY3f90sb
         5KMN9g9x4jB8aFhVV2CB+kr/FDUR/+udwQeAaLbIPk25ZNVbCZmucr0sgr7ZpOM/tn
         ku9StHmqZf7tftyM3HcGS1Sy8p3iq/Y/MqpaleYs=
Received: by wens.tw (Postfix, from userid 1000)
        id 3F2BF5FD8C; Fri, 27 Mar 2020 11:04:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: rockchip: rk3328: Replace RK805 PMIC node name with "pmic"
Date:   Fri, 27 Mar 2020 11:04:10 +0800
Message-Id: <20200327030414.5903-3-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327030414.5903-1-wens@kernel.org>
References: <20200327030414.5903-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

In some board device tree files, "rk805" was used for the RK805 PMIC's
node name. However the policy for device trees is that generic names
should be used.

Replace the "rk805" node name with the generic "pmic" name.

Fixes: 1e28037ec88e ("arm64: dts: rockchip: add rk805 node for rk3328-evb")
Fixes: 955bebde057e ("arm64: dts: rockchip: add rk3328-rock64 board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 49c4b96da3d4..6abc6f4a86cf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -92,7 +92,7 @@ &gmac2phy {
 &i2c1 {
 	status = "okay";
 
-	rk805: rk805@18 {
+	rk805: pmic@18 {
 		compatible = "rockchip,rk805";
 		reg = <0x18>;
 		interrupt-parent = <&gpio2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index bf3e546f5266..ebf3eb222e1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -170,7 +170,7 @@ &hdmiphy {
 &i2c1 {
 	status = "okay";
 
-	rk805: rk805@18 {
+	rk805: pmic@18 {
 		compatible = "rockchip,rk805";
 		reg = <0x18>;
 		interrupt-parent = <&gpio2>;
-- 
2.25.1

