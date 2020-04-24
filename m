Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2275AC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0017321473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mk/zFL1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHRiLxRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDXPgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:15 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60097 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbgDXPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9048678A;
        Fri, 24 Apr 2020 11:36:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=m33/GpK4Sa24j
        4S+fnmVvjFqz0KFoPPGqLfZr0rxfJ8=; b=mk/zFL1yTHH5kTKyt6HJCgSKCNKro
        NpdRpxpmwQd74E0Y1MVQ/296vDbUTlNflssuEh3ihEyK3pd2rmZ1eImFAUKqO9xx
        TORpLKMKiRHKwS+esi68lN3PQP9+9uwqss0F0WNJcne26kKQpOxaa5zg1+Q+R1mr
        XH81HOL0Qcl6teSmQSZPhas/x/Dk3PkiXIRWpEnovI1GXjkkzYU0Qz5Ag+QGfOcU
        FjPzo5AHF+0mr0Gn9+z+Mgtilsckt49E8Vm42dnRl32Q8zxaTNh6Ir1FmW0Xel00
        e1kO2t753SBvSlaMV9KNDBBzZjiFawSvFCJAhbkkC3PrnQcmZFEr4d/WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=m33/GpK4Sa24j4S+fnmVvjFqz0KFoPPGqLfZr0rxfJ8=; b=BHRiLxRL
        Up2Ju1gmxhn0dH+LnePTBirJZah1DG3U3nJmMKtbgdDOUmM4p4yJ5tHu0nqgz99z
        go/HDs1aUuSj/9xbpenJAsFnTNe+h4gqW6Lz+hpBuWXnDHxZUtOmkqxmCT8Zwx+I
        6kcnr/F4HrRISzBar3vc9XsWdUunhHNYSW2S+uWqeVnH3aotq3QVyUBcrm9S3gOp
        A9fPGK5ABTpkOQ3hibcbm/Hz+eS2HL+dIGAq3KQZwUwA8q/phvA8SCpbbWJ5PnjZ
        vRFrptovTckyyeM5ac9eHrfO7RLXRgMDWGEI0G69SbtYh3RYMhqYgEw5obggngoR
        ggxy1V7L9L25qQ==
X-ME-Sender: <xms:agejXkPuX7vVQXjhtp2Z9tFQxsxH-uJ0ie-O9UnwdRplyVq5O_R9lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvleenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:agejXhanFMcucCZ2VAo0JLGccnUAiM09AbQ_aLqj3jxv3ODAhvij0w>
    <xmx:agejXkEfYDxf0qWlO8z244m2ErDkf3H0zvMrfapR6PSS1YbhKCA6PQ>
    <xmx:agejXr-ona9IUt2RJpik3Ldrko1mdX1JrmEIx-TY8MuR_8x7g-ENQA>
    <xmx:agejXgnitBwPv4XITGhQYnPwjCV-D3ylx8duJCs2kdmEya4oyXUtCaWegP4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8919328006A;
        Fri, 24 Apr 2020 11:36:09 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 34/91] dt-bindings: display: Add support for the BCM2711 HVS
Date:   Fri, 24 Apr 2020 17:34:15 +0200
Message-Id: <009f6bb76ff74d1835f9f9c86a2b04947608edb5.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HVS found in the BCM2711 is slightly different from the previous
generations, let's add a compatible for it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml | 18 ++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
index 02410f8d6d49..bb1fa805b14e 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: brcm,bcm2835-hvs
+    enum:
+      - const: brcm,bcm2711-hvs
+      - const: brcm,bcm2835-hvs
 
   reg:
     maxItems: 1
@@ -19,6 +21,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description: Core Clock
+
 required:
   - compatible
   - reg
@@ -26,6 +32,16 @@ required:
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: brcm,bcm2711-hvs"
+
+then:
+  required:
+    - clocks
+
 examples:
   - |
     hvs@7e400000 {
-- 
git-series 0.9.1
