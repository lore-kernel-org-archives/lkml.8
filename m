Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8122CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC6420578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rf/sB6ar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oM+16xZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgFOInR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:43:17 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33837 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728852AbgFOIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C6964580157;
        Mon, 15 Jun 2020 04:41:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=xWZqdsHt+6XnG
        lVmmHecqtGqe51QGLTcTPJqY9E6BXQ=; b=rf/sB6arnc1rND9DFy0oopvGGDlOx
        9R4Evuyf9zSzrEqCXE3gMPmarxr2ADeEy96zP9j6UF77BUF0xsuQCkJrM1t4gpMX
        JutrSVIyn/spmcqkV4lNZvWWMou3ZvTc/HqqJilkelAgtnMkFuiiZo+ZXIUinj7x
        wzv7BHWS4wFFrrNjSaeBq/LZvvtjzT62JoDgPQgEFT4pF7ghlELOwx+x/2IH6qpd
        Kgdvfycq8sSy9s6pWrhO/gD89ygdS/G7eGXsM467Np4Kpw6TLgTheUgsxxgg7VDS
        UJWV9pEJmQ0jP8xJCQYpF8cEhePnLOIfobnr7mxp5Q/gntKVf/DkX59RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xWZqdsHt+6XnGlVmmHecqtGqe51QGLTcTPJqY9E6BXQ=; b=oM+16xZp
        T0R3Uk1tSSYAhpivxYh0eamwxEVhI2QDzAQkxt82csqPBPS2FuePDoxP3ksQpvVT
        PJ34BidMOEJvTX/NW756o3VjrJsVh/UfhQOIK/SFuF3dF5szgzmdMxJuIFU4Nz9y
        ui3epPrNL0ToRgQKuqIDv7oSS+gwjVte/aiytIiu8lQ02OLbXXrxVJm9qchxLouC
        L1XFfpCncBpY+vMED9wRP+fEKHYnjrvjVbILRdpp34nZBhtx+hARHsz2O/iICOyL
        xt5eU3ZimB3q2MQD6zpUPM8XQnS0x3tO2ph0LdZr1qb/uLKh2eDTw3KD1CvPe32c
        YCSBU+UKBBiRrA==
X-ME-Sender: <xms:MzTnXgdCc6IdKnIEaqKKL_i6S-e1sli8WddaLPbnTMk-yfKUfR2m6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MzTnXiODz_AwCfZteVWHNfhM5LcpCIWYh2vRnBn1E5NPomqYcLZaSQ>
    <xmx:MzTnXhig0C0dMu5u5uC8U1_yYbCXq4JD9rqk4jZZTs7YUKyeVQPPAw>
    <xmx:MzTnXl8mrZyaenU93X5IGKDYnGUOWk_XfLjB40OKo7cPhR19I6ARUw>
    <xmx:MzTnXsF9Fp7jW6TKW7vQNi_nfGTLb_OTKoeeY7PfFHn_RLjyejVxkw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C5253280063;
        Mon, 15 Jun 2020 04:41:23 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 02/27] dt-bindings: clock: Add a binding for the RPi Firmware clocks
Date:   Mon, 15 Jun 2020 10:40:42 +0200
Message-Id: <f6105207e7ef5a5ea8d7a1774faf989d341a25f5.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware running on the RPi VideoCore can be used to discover and
change the various clocks running in the BCM2711. Since devices will
need to use them through the DT, let's add a pretty simple binding.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index cec540c052b6..b48ed875eb8e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -22,6 +22,25 @@ properties:
       Phandle to the firmware device's Mailbox.
       (See: ../mailbox/mailbox.txt for more information)
 
+  clocks:
+    type: object
+
+    properties:
+      compatible:
+        const: raspberrypi,firmware-clocks
+
+      "#clock-cells":
+        const: 1
+        description: >
+          The argument is the ID of the clocks contained by the
+          firmware messages.
+
+    required:
+      - compatible
+      - "#clock-cells"
+
+    additionalProperties: false
+
 required:
   - compatible
   - mboxes
@@ -31,5 +50,10 @@ examples:
     firmware {
         compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
         mboxes = <&mailbox>;
+
+        firmware_clocks: clocks {
+            compatible = "raspberrypi,firmware-clocks";
+            #clock-cells = <1>;
+        };
     };
 ...
-- 
git-series 0.9.1
