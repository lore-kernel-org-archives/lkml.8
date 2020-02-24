Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C9C11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968C2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MyOYQRN1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vK82XeD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgBXJOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:14:01 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:52311 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbgBXJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:29 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 7C04460A;
        Mon, 24 Feb 2020 04:09:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=aLIZ5LnWvXHZ2
        KPr943ijW9nE1rxXfu6BQqu+bNMhqk=; b=MyOYQRN1ivxuli0O9VwvFX3toOraW
        BorRGB/DXvZG/kcuG0lrqyoFgtQS4cPVf77IoOsae5xGJXD/WdpPh4zM/EkZLCPv
        Bf65zttBer3S6zAGebATwP12MqB8/HQ+0utrgv4m4cU9x9u+WY2za0dc1+oAtS6Q
        X2LpQ1Su3+DOqluQGEtNX920o3txbK8i/OpqKRk9LN2PZC50BUgnjr/CSxgAOkWt
        fycnjtx9xRMEm+/jm8qn4DbQB2IiKoc+9SFx/Nd7LcTgYqcbK5DT63xB312OMG1f
        yi0fBCUDcokxmhOH7M/lCJGXH4eoK6GwNfsTdDKmkBRcjMp6QzwxP7ElQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=aLIZ5LnWvXHZ2KPr943ijW9nE1rxXfu6BQqu+bNMhqk=; b=vK82XeD2
        tN01lrRlqIYhjq844eDqHAoL/JvZ9liUkLgJBErytm7MKu32XAaS5hFQ+qoK65B2
        ujFpomVr9QMMTvWXOcCP9rTpjhuHfxQYR1tSQJhvpGkTt0Qg/iJmJ9DRkFc8U1et
        sJukVoOdUPiO8JlJdqvib3fPeeL1dDelfn+naAQucYU5xZF+0B03xNP0MwstOhhM
        Pxd6BQ+AyvwpazBNFmxvM7or8fwWtL58Zs+iV6BuCHhE764cz7wMdmXb77Np1Xj8
        fi6iDfYwwqDbvkXPi2Hlhxg9Jzsfkt7AfV0wP9pCH+HcoiJ7LCD4ZdanePiqusG6
        367VsekrTsomeA==
X-ME-Sender: <xms:x5JTXgmUWlcZ69BwNFEZgLYWwDYDt-IjpbVRc6JGALgFXMB_HfDO4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegovehorg
    hsthgrlhdqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvg
    estggvrhhnohdrthgvtghhqeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:x5JTXmYng-63hYNbwXJAGr9mlbVybD8XA_DQnsjOPJ4toCH-n6wbYA>
    <xmx:x5JTXgXIKD6vpGtE91-f3iwOH5TN_iy8ivH5_809foA_FYMD3m2Z-A>
    <xmx:x5JTXmD6nIeYMWNwLxdmwkuN-nWDfJu09Hoq70FoPVEdtjJJUUDVGA>
    <xmx:x5JTXlsqEma54XpKLlZYasWlHw2lKy6hn6y7IvZ2Zuo2rXrsoP5FtWdh2lM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8BE8328005A;
        Mon, 24 Feb 2020 04:09:26 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 26/89] dt-bindings: clock: Add BCM2711 DVP binding
Date:   Mon, 24 Feb 2020 10:06:28 +0100
Message-Id: <106e8a589a79eb70668b03d7160994c6a09a92c4.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 has a unit controlling the HDMI0 and HDMI1 clock and reset
signals. Let's add a binding for it.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml | 47 +++++++-
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
new file mode 100644
index 000000000000..08543ecbe35b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/brcm,bcm2711-dvp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2711 HDMI DVP Device Tree Bindings
+
+maintainers:
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  compatible:
+    const: brcm,brcm2711-dvp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - "#reset-cells"
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    dvp: clock@7ef00000 {
+        compatible = "brcm,brcm2711-dvp";
+        reg = <0x7ef00000 0x10>;
+        clocks = <&clk_108MHz>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
+
+...
-- 
git-series 0.9.1
