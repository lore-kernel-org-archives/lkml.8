Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB2AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804BF20797
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231264;
	bh=GYXHc/jut7pyPvpbDTvNUMgHaA0UiB4OSxKbRiZPMsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FqOyfG8u4+1JuafF4/CiQXgdxyagjFDz2HIhqnsJCaWupHu2fjZNHroXohLYEYowt
	 l3pt6ZvP7rSz4DgIYCjCQ7tnZ2ZuJUY6Zd73gf7Jtf2AUZdszCzh4kZZtpQYtS1z4Q
	 akYCAlmSRMeYz7/jESu7ITn0b7VpFMut/8H5Z6OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgIDOyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbgIDOx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:53:58 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C42312074D;
        Fri,  4 Sep 2020 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231237;
        bh=GYXHc/jut7pyPvpbDTvNUMgHaA0UiB4OSxKbRiZPMsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2OqzhmPGzQ/3fVGEmEDa+858JjkTrG3uchgH4EXNUGRgb39BVd142y63QM7C29wX
         /APyTsfKAcmAF0kHAaWmt7rQKJ5B8T3nZ5MULOV2BjKGO6YdkD4a3Ow/8t0A8z+TnS
         943ZuS7A2hUE46zt1WshIBflnP+IMPXugvdkmCWg=
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
Subject: [PATCH 06/13] dt-bindings: mfd: rohm,bd71837-pmic: Add common properties
Date:   Fri,  4 Sep 2020 16:53:05 +0200
Message-Id: <20200904145312.10960-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (clock-names,
clock-output-names) to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
    pmic@4b: 'clock-names', 'clock-output-names', do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
index 65018a019e1d..ecce0d5e3a95 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
@@ -32,9 +32,15 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    maxItems: 1
+
   "#clock-cells":
     const: 0
 
+  clock-output-names:
+    maxItems: 1
+
 # The BD718x7 supports two different HW states as reset target states. States
 # are called as SNVS and READY. At READY state all the PMIC power outputs go
 # down and OTP is reload. At the SNVS state all other logic and external
-- 
2.17.1

