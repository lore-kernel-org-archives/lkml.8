Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED6BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011B620770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231233;
	bh=bvXZcz7ttVocHXEVxEt5vYwPMCOoOFG4MAo12LWzn3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ctzT+6CV982hrD3qP5Au2bgYOLN+E2ZihAnDd+K/jnwvoeTzoowuc2UwMDbcJzWbn
	 y2iudlM9JVjcbIOxzQ8w6wHLI3/WN+EprC+ITdGC4xt7DvdMvi90tm+gu6Y9tsZjba
	 7dRi0W4CkLuA3dqmFhthW7tf6HYvwizIc+N8FjVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgIDOxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbgIDOx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:53:29 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 192A620722;
        Fri,  4 Sep 2020 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231208;
        bh=bvXZcz7ttVocHXEVxEt5vYwPMCOoOFG4MAo12LWzn3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxY9sZT4eR3/CDZbyP/ApLs6rtNEXa0MdbPLKO4rgS7onWVP3+/Nl9GLwVCJ/OFbg
         ylTvLxlAir9ilUwaFgZAhbYQF1K9J9WiNr4WD9NxuJTQlbaoW0PMF/CBCjqOUBmdmb
         IVgVlnXvuo9ZYq/UNiK2xCf8H+ectwAqN63xY/Sk=
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
Subject: [PATCH 01/13] dt-bindings: power: fsl,imx-gpcv2: Document interrupt controller properties
Date:   Fri,  4 Sep 2020 16:53:00 +0200
Message-Id: <20200904145312.10960-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX General Power Controller v2 is also an interrupt controller so
document additional properties to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpc@303a0000:
    '#interrupt-cells', 'interrupt-controller' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index bde09a0b2da3..a96e6dbf1858 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -33,6 +33,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-controller: true
+  '#interrupt-cells':
+    const: 3
+
   pgc:
     type: object
     description: list of power domains provided by this controller.
-- 
2.17.1

