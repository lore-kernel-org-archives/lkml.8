Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEA5C2D0A7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE77A20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231239;
	bh=lpyJxehqQVhZJxW/dY5CSwmGXBpmMlm6lsFz5qVX6yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOn+J0nfnAvsS2NnuGWOx/CNIPr2I42BV781XhlDOfr0OxQxQCe19U8bJwDrsjNQr
	 oFHV4bQZcIppSQc/gw35vo3wsxvxBQQcWBBkQIpQdK3ko54r4awU3W82TBZ7yhFy0g
	 W4dRIEej33rmN3hQH+OfzGjaUxFd8i8HEB7LbsdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgIDOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730498AbgIDOxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:53:35 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7EC20772;
        Fri,  4 Sep 2020 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231214;
        bh=lpyJxehqQVhZJxW/dY5CSwmGXBpmMlm6lsFz5qVX6yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wK3d7MIkeOqvjPK91YR6e58IF+TNcP/AeMmFuRNFzRLRMMMKh4KskfdqOwjzRX5+/
         eVBbIXHVwJfRm52xd54SRoKevr9esDFL4y2KbbCWrQq9/HPa3ACLLTFAud5fdhaGan
         4HVvSSC0EG+QmCTIVQKKJ8HjSIPNOV/dyYKkaU/M=
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
Subject: [PATCH 02/13] dt-bindings: display: bridge: nwl-dsi: Add common properties
Date:   Fri,  4 Sep 2020 16:53:01 +0200
Message-Id: <20200904145312.10960-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (assigned-clocks and others) to
fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: mipi-dsi@30a00000:
    'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: '^panel@[0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
index 04099f5bea3f..b8ba6eb482a1 100644
--- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
@@ -30,6 +30,10 @@ properties:
   '#size-cells':
     const: 0
 
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+
   clocks:
     items:
       - description: DSI core clock
-- 
2.17.1

