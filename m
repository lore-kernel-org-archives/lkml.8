Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B653EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852E92074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231288;
	bh=acFLAnqkE86HeCOtNctPMq/uQTqTdSMzshdLBUt2XLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FlQsj1OLhHM6xohYY0fCVtaB61oVX0A52qfpd9IHZ5d1a8dM2A33yh/9VFB4nYOFd
	 p7qcgLuuuxRBcuoKy56yWND4N47Hy/vRlhcdlDUo59HfUszCGVr5xsyo9zl7zvqZ4E
	 IlKdEVkzOyVqyDTGVLhuNXT6sSg+aLrb+k2hrAS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgIDOyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbgIDOyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:54:37 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB4320770;
        Fri,  4 Sep 2020 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231276;
        bh=acFLAnqkE86HeCOtNctPMq/uQTqTdSMzshdLBUt2XLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8loe0i7Vb5Ga3aEbMBJ0L38GtsqZUHqeV/NiHs6RiB6w9Hx4HMS9f+VI74X7XOEw
         RQh6OYFXQ6IiRZ9yejJ5WbnVxrwuotKVHI7ECofFJvGn5Ri25GQHNmOEfoIeR99JwW
         6W5mVGsqul0iQYKLD/vW+yTRai9PW7tKE7dl0PYI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 13/13] arm64: dts: imx8mq-librem5: Add interrupt-names to ti,tps6598x
Date:   Fri,  4 Sep 2020 16:53:12 +0200
Message-Id: <20200904145312.10960-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti,tps6598x binding requires interrupt-names property.  The driver
does not really use it but the hardware could have more interrupt lines
connected.  This fixes dtbs_check warning:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: usb-pd@3f: 'interrupt-names' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index a78584086fa9..56295dd2fa8f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -605,6 +605,7 @@
 		pinctrl-0 = <&pinctrl_typec>, <&pinctrl_tcpc>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
 
 		connector {
 			ports {
-- 
2.17.1

