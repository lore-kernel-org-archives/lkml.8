Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678E8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40ABB20658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597830757;
	bh=KR3x17k71nv+WZsdM0NYFQMSokf99W1AI+fOHiCMtjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ycWjewtMeE3u5BSvIqR/PxkaMDmhe93s8D89/T9jFm3ZLq88qxfU0q3I7R92GByT0
	 mSOigg/KVo5o/VOGMBs+cQNSBo4JPuChYgwDEO3U9Ogg8h0jnJHHl2x1V1w2Nx5P3e
	 5Ui76wyOuNgPZ5xVNGBr8Zom1ZVdiMjk1zJDPjJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHSJwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgHSJwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:52:19 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC9A20786;
        Wed, 19 Aug 2020 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597830738;
        bh=KR3x17k71nv+WZsdM0NYFQMSokf99W1AI+fOHiCMtjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S84M9fMQvtlB1DDrpwWxH1+cioSkbILDVwb5dXPGpeqRhaPYSUmDO6iGSu4OU9ED/
         rffUNplTfvXn+MUKeWtyF5Nb5brnqAub4sGyV8TGiNHD8PhqNESPzOLEO8xRhRbxhR
         SyMQ/Qw16IGzvWbpop05lBhphxb/brSz8WdIOK04=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8KlT-00EqpZ-7U; Wed, 19 Aug 2020 11:52:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dts: hisilicon: hi3670.dtsi: add I2C settings
Date:   Wed, 19 Aug 2020 11:52:13 +0200
Message-Id: <577acc4d4de8f812d4f58de167a731bfc6d1d32e.1597830623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597830623.git.mchehab+huawei@kernel.org>
References: <cover.1597830623.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C buses are not declared at the device tree. As this will
be needed by further patches, add them, keeping all in
disabled state. Per-board settings can override it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 71 +++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index b1acb4fb1d1c..416f69c782d7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -723,5 +723,76 @@ dwmmc2: dwmmc2@fc183000 {
 			card-detect-delay = <200>;
 			status = "disabled";
 		};
+
+		/* I2C */
+		i2c0: i2c@ffd71000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd71000 0x0 0x1000>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&iomcu HI3670_CLK_GATE_I2C0>;
+			resets = <&iomcu_rst 0x20 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@ffd72000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd72000 0x0 0x1000>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&iomcu HI3670_CLK_GATE_I2C1>;
+			resets = <&iomcu_rst 0x20 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@ffd73000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd73000 0x0 0x1000>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&iomcu HI3670_CLK_GATE_I2C2>;
+			resets = <&iomcu_rst 0x20 5>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@fdf0c000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xfdf0c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_I2C3>;
+			resets = <&crg_rst 0x78 7>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_pmx_func &i2c3_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@fdf0d000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xfdf0d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_I2C4>;
+			resets = <&crg_rst 0x78 27>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.26.2

