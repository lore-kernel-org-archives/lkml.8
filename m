Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B14206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876778;
	bh=+5JA2poJMjR7STyvd8Wt5wYwpE8j6WD4wo/41oMHMv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cOun5kTJ5T5AWbjd2rUGhKamWlHxt7gkIk9S0vmvCULzW9Q4BpheDxBqqsC4YpoAb
	 lQ0g3/NVsXA8RsViRR+0HhGZy/sSpoWh1/FYecjCBbso8BQ9bYH0x4GZgawvGQf0aP
	 +Dh5IVPQ64eHjX6AWo+DwUuWobe4Y65GtXYsnjCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389418AbgAXOjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390723AbgAXOS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C8821569;
        Fri, 24 Jan 2020 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875509;
        bh=+5JA2poJMjR7STyvd8Wt5wYwpE8j6WD4wo/41oMHMv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BS2nQ4hNrQlgVR2ecFcVX8RH6dhsuF4vTc19szhufT1NGT+Bi82pd8QCznZQhqSYr
         cGLkhPM8yn+g1JRhSK+qxZaVZ8adaGNwnYPcI97NJvF8TVjN0/j0pICnbxpgOKl9Ri
         9erIoJXm8lLGTZuIwTWJ+nfAfnfQBQ3KqJgKop+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 010/107] ARM: dts: beagle-x15-common: Model 5V0 regulator
Date:   Fri, 24 Jan 2020 09:16:40 -0500
Message-Id: <20200124141817.28793-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
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
index 9a94c96b0350e..a813a0cf3ff39 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -29,6 +29,27 @@
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

