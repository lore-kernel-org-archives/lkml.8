Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB07C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3ABC20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="k8lQDKuv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOSOEb9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgE0P5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:57:54 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49315 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390095AbgE0Ptb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C6153581FE2;
        Wed, 27 May 2020 11:49:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FMKLC09xuIf9F
        IYI+xqoFdFwX3vaShvGRIMTND5Z/+g=; b=k8lQDKuvjJyZSQm0zYsOKK/831vfI
        dwF1eR+LmaE1HsHlUvJQCpTYqRs5bv4zuqQF+QqsikMNrK44lkJeU5tAK2EuZ1iV
        ZJ2C/KC3olPmDpmkVU/4fL+8NhNjwbVHXEvo13urDJby5JD7+wQTg2t0rN4cXJuU
        UjIkOGnLMfWlsxEtrcvm65gbIKG642h1prlAs6MJwlNJlxFI0dsz6Lv2IkE5O7Kd
        k0UDuXS/GLC2sWdgvxfM9LZ3+uWq+7HXS//U3VIDRAosErI8uRAxG6i2Huat4O16
        XeS5x0emvICPiGZhnBitoksaGQi0y1nyZWubzPqMRW6Qe3RoIS3drhTeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FMKLC09xuIf9FIYI+xqoFdFwX3vaShvGRIMTND5Z/+g=; b=YOSOEb9R
        WsTOlJuCWYivbI7VpnVMB2Se0EQjIOllck6yN9f0J3mGCR9AAVuJLTyWBTZllI5I
        L4yWYz9nCaXFcd2Sv0k1i3eU4y03j5lSiEvdQBTX2q61SUqihhPNUev11mdmsDpp
        jZtFfkSkCcz8cyVIV4om9dQLZuOyDNyQ8aQ8z7ROYMFdoAT6WjWLyptBXx0i380u
        cpo6JT3FCj/iuoho4aMPPlRR2KcGgZMh194VEQLhhbpd2jUxCFSW+Z2povLbeLhg
        NpnikkBbsW1ZvInF6S/yPdCGWqMc+mY2uF7QwcYXfP79let6sEezM557vxWdDdk/
        C6gt9ar6YTZ4Mg==
X-ME-Sender: <xms:CYzOXo3k5ggk4CMwUXr4-QjPEHgDZ5wxvRkmItNAHgZM4Ddb2W7JHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CYzOXjEamHtenIDCn-_P7UuJat8hSAjGK8tXSvIIdLW87gJ844uE_g>
    <xmx:CYzOXg6F1-Elxg63MvQ6RAhOYNMMMAkV8NMV37ryabHpJ6Xiw4zosQ>
    <xmx:CYzOXh2nGdwYQm7Bqs5tVe3YdnhlwB01W2KDu6mcTCggWRHBFLv4ug>
    <xmx:CYzOXiDJCszV65p7WjgGUYa6NwaOP-FbahYUafV-Ig9MORX3d-JMww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 648093280060;
        Wed, 27 May 2020 11:49:29 -0400 (EDT)
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
Subject: [PATCH v3 008/105] dt-bindings: display: vc4: dsi: Add missing clock properties
Date:   Wed, 27 May 2020 17:47:38 +0200
Message-Id: <867813ae6b3e9cff0e9627e6ed09569dee5573bc.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the device tree and the driver expected a clock-names and a
clock-cells properties, it wasn't explicitly documented in the previous
binding. Make sure it is now.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml | 11 +++++++-
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
index 3887675f844e..3c643b227a70 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Eric Anholt <eric@anholt.net>
 
 properties:
+  "#clock-cells":
+    const: 1
+
   compatible:
     enum:
       - brcm,bcm2835-dsi0
@@ -24,6 +27,12 @@ properties:
       - description: The DSI ESC clock
       - description: The DSI pixel clock
 
+  clock-names:
+    items:
+      - const: phy
+      - const: escape
+      - const: pixel
+
   clock-output-names: true
     # FIXME: The meta-schemas don't seem to allow it for now
     # items:
@@ -35,9 +44,11 @@ properties:
     maxItems: 1
 
 required:
+  - "#clock-cells"
   - compatible
   - reg
   - clocks
+  - clock-names
   - clock-output-names
   - interrupts
 
-- 
git-series 0.9.1
