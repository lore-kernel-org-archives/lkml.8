Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00AEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6AE20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="wGdtcsoP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/yJoS4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbgE0P57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:57:59 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47407 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390087AbgE0Pt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 40720581FFB;
        Wed, 27 May 2020 11:49:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5EfepUmgVDPUO
        z3GVL3TqSbU3jIl6CJ4wxOzynhsQS0=; b=wGdtcsoPQSEMk57Pp2QJJwhiH3JXO
        ZgB0OTpO841RseW2zC8TuxTPXz6YYA2Fo7aPBgu2Ja/jYBMb+0IRLGkx1Cpt9Bin
        rR1CCvBP9zOld/O0tpiOtdJOXyi+JZpazGIMO1YEHdtrrSM9ltU/wQjn3y3lHXS9
        5TKFLA4mGSYYRFEfAhz6qI3wSGY4yWoR1cBrVSeMlTarf5r1G20F72QTBX03Epmo
        oZWzmrCrLfGMxtNWaw5OBLtDuNTUpK/Wm4lSDZy7fT8Hienz8s0Kl9urspGXC/z8
        fv7Xh4oP6aQ62hDEJH888eEkVfGn0N/TFaBQxXFApBLQTn38CIvRNImqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5EfepUmgVDPUOz3GVL3TqSbU3jIl6CJ4wxOzynhsQS0=; b=P/yJoS4r
        wZPI1T9jo+AULljM4ICpiwFadvxLo0HFPahyrtmqjj8YcqPWmTyzy4ysNIKhIFbI
        YMNpb69xzt4BYvW/UxwhCgJLpepf2WDqNsxUOGdtHyyV/e55CL5JRMQSKq+58Mip
        0R09Hl7DgFTV4B7VL0JcCkKPWDTAWL9NSRzW/m1kp3lMQq/f+jhTnZjlxsKnYlft
        gnY+DoXHj7XBu6JXX73S9yF0EDmayRBx+erqFA29HC4xeoUlYwR/IxffWpFBNVGC
        YDIbpby/u8LV/evsQChQPOsa/q3GPCGyLMXRyHN9xNdyJALzPf7M8g/xFJCZSA6c
        mX0Q13+eeiLjgQ==
X-ME-Sender: <xms:CIzOXin-Rec4SJPItuM6TITo1R5r0uQoGhJkg-Ca31OSnU-RLsHTeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CIzOXp0p6H6uuw2gatHvPkQAt3tIxXViKfHgz3TK884fSn5pxeIfsQ>
    <xmx:CIzOXgoeWRj97NThbIzJFm-pAmwTW9DGvOEg7J3aW2CI7Kg4unVPxA>
    <xmx:CIzOXmkyChH3bDKlcDjSeRR2Ju0kCPETdokBB0jN0UaBSPdk6-pHIA>
    <xmx:CIzOXmy_pLwVXdPD6CYWKaS96Ok6eANExebgMILMWquhzvRPH4Z3Ig>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D478430614FA;
        Wed, 27 May 2020 11:49:27 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 007/105] dt-bindings: display: vc4: dpi: Add missing clock-names property
Date:   Wed, 27 May 2020 17:47:37 +0200
Message-Id: <8c7a4a9d85f7d1b23346367acf8d321ddad7cffe.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the device tree and the driver expected a clock-names property, it
wasn't explicitly documented in the previous binding. Make sure it is now.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml
index 288494b70e82..58213c564e03 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml
@@ -21,6 +21,11 @@ properties:
       - description: The core clock the unit runs on
       - description: The pixel clock that feeds the pixelvalve
 
+  clock-names:
+    items:
+      - const: core
+      - const: pixel
+
   port:
     type: object
     description: >
@@ -31,6 +36,7 @@ required:
   - compatible
   - reg
   - clocks
+  - clock-names
   - port
 
 additionalProperties: false
-- 
git-series 0.9.1
