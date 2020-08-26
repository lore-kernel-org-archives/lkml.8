Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52379C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C33C2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598421466;
	bh=VIUzUu/h2wdFkcTjJvViiZyHJeKsITsy61I885Oe8qQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=umsTie/5YrFuAt6N4JJqq95NkzlbiuHnSc0sz/SkzdoKB28ojOYDCzgya9AVJw9eJ
	 UZp2joDmqULlnr8/5+HDh9PCsBb0spywfeJGTPu04etzJJ4sC3wb8pcAw6UbfWoTBZ
	 hu+85Hc4wKVThMzWPHbBKUoQlsFgXP6PgPiCioCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHZF5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgHZF5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:57:44 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E342B206FA;
        Wed, 26 Aug 2020 05:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598421464;
        bh=VIUzUu/h2wdFkcTjJvViiZyHJeKsITsy61I885Oe8qQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Zik0cEXf4IOd/9yoCR/qz/EWtsqQkZRCrQmFbTJm1tFt8saY4cZh4rB8BBqTPb5YM
         Mkvk6bheqdV44uKQsT9EdDU1uRjG84aUNUwMcHaBLC8S7aoMZrmX5ob/HTJKi9q3IK
         areZpymcNtdpul0a1xA4GbLC+eBarOo9mUHi3dnw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAoRJ-001PY0-SQ; Wed, 26 Aug 2020 07:57:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dtbs: hikey970: add wifi support
Date:   Wed, 26 Aug 2020 07:57:40 +0200
Message-Id: <b22e5799fe16a6902f95a8bd3f0f41f5a260c1ad.1598421453.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwmmc2 is used on Hikey 970 for WiFi support. The
hi3670.dtsi adds it, but with status="disabled".

For WiFi to work,it needs to be enabled. While here, add
the missing properties:

	#address-cells = <0x1>;
	#size-cells = <0x0>;

and add
	ti,non-removable

To DT properties, as the WiFi support is on a non-removable slot.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index f218acceec0b..a2b0d2a1d09d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -402,6 +402,7 @@ &sd_clk_cfg_func
 
 &dwmmc2 { /* WIFI */
 	bus-width = <0x4>;
+	ti,non-removable;
 	non-removable;
 	broken-cd;
 	cap-power-off-card;
@@ -409,8 +410,12 @@ &dwmmc2 { /* WIFI */
 	pinctrl-0 = <&sdio_pmx_func
 		     &sdio_clk_cfg_func
 		     &sdio_cfg_func>;
+	status = "ok";
+
 	/* WL_EN */
 	vmmc-supply = <&wlan_en>;
+	#address-cells = <0x1>;
+	#size-cells = <0x0>;
 	status = "ok";
 
 	wlcore: wlcore@2 {
-- 
2.26.2

