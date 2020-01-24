Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D5F20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876045;
	bh=4BulwQtBrg3DU3XdrFtI9JrA+USSSeddWgbxypc0wxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pcvEWM5X1f2qQZH+B3zmbxhYZ7S0qAerPb8baqV2d7HROmFvS3VuD23jhauJ0bLZU
	 0/sRmT88d1ZRik/Nt+aJF0dqzjw0nLVDwB/vatznNjDuGMplRppxb0a7SMKNZqqnLI
	 l4N+B5fgHSm1kUIJhCc1brAcuH5xiq20NvV6MDCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbgAXO1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387457AbgAXOVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3C921556;
        Fri, 24 Jan 2020 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875684;
        bh=4BulwQtBrg3DU3XdrFtI9JrA+USSSeddWgbxypc0wxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5Q/0LgRMUDjUH0Hv0Mj6VHg9Uj1rx9C45AqsaVmSxyrxr4SUQxL1CFCDe5lpq0Dg
         9MmzMf3g24iF63+E2sHfA63igdVN4VLDirGI/qCrhqEZya/C1q6OV0jhjU2ilXCfmQ
         30FbjgdYuJB8AYybTqxzoUm8xBQCzAyrYl493l/4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 04/32] ARM: dts: beagle-x15-common: Model 5V0 regulator
Date:   Fri, 24 Jan 2020 09:20:51 -0500
Message-Id: <20200124142119.30484-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit e17e7c498d4f734df93c300441e100818ed58168 ]

On am57xx-beagle-x15, 5V0 is connected to P16, P17, P18 and P19
connectors. On am57xx-evm, 5V0 regulator is used to get 3V6 regulator
which is connected to the COMQ port. Model 5V0 regulator here in order
for it to be used in am57xx-evm to model 3V6 regulator.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/am57xx-beagle-x15-common.dtsi    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 49aeecd312b4b..d578a9f7e1a0e 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -32,6 +32,27 @@
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
+	main_12v0: fixedregulator-main_12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "main_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	evm_5v0: fixedregulator-evm_5v0 {
+		/* Output of TPS54531D */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&main_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vdd_3v3: fixedregulator-vdd_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3";
-- 
2.20.1

