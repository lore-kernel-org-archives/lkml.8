Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A2FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B529C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="LwyVj0+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+sQWYkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbgE0Ptg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:49:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41401 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390099AbgE0Ptc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 519AE582003;
        Wed, 27 May 2020 11:49:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=l41voml82pNgG
        OR2Kp29KgbgqjpRY+t3Z1kDCxuBln8=; b=LwyVj0+V+DEaHSykM/vtJwaul2K23
        QDNU8Ty1iOhjlOwxdohJuJbJpJiRiRal4JDGuOHCy+pFzgx77yLj2ixp21ufLsGP
        B3uOtt2puIEP0u8NYd5DAdV8yrcUCiNysE7pkbftLgi5jSSgvA2LYztDgMaDPGPD
        x4jkhmPbV97DYnvZypq8cSAMYzsHsm0uyA+l7Y+nXuO7fzsyTccxPr+CIxugluzf
        Y7jaRyvLS7blQGyRqAZgju97h2dEn4BGLnZB1ncCUi4ad1wziJIRsBpPQFRKjaGU
        Y5zWHNiLV9HlcUVDwfNvWtNTjMdFLS6yA9u1pLWa91qXv9uCdRB2u/PvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=l41voml82pNgGOR2Kp29KgbgqjpRY+t3Z1kDCxuBln8=; b=l+sQWYkP
        QN/PjzUHwCSyMNiqasejVTcljvtl09YxV+msYyoEc72qm/JuTSj71dtQTs5TE/h0
        o+VFasE0INxrM39eUGxcELp3BWrC+0UJi8z7yXa0zxjXZEK4e2zCbQGdcdcUmHWe
        DOtT4wQGCG5FzWELp+It3z2iTsLbfQAtkCfGCDOVStSFKtobvmL8z2M9FRT21jYc
        l8DEYeOXbkCU2fsZ5fP5/57GLESKufFEU+ussoqrBZ3v/SsxKVfJ+ziAcXWZQlru
        gDPUNWZwr81f7d/i0ddHpb3PuPU/LG3XeqTdyeBqaJhsOEWlS6GqkHEqiubXDKLM
        MkaMi5/UT4Oa2A==
X-ME-Sender: <xms:C4zOXmVdW4IhUCfS7EfZ1WYyfxrl-Z8g26TGHVebdW-FJZdP7d75uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:C4zOXime4Y2KPW2Ahpz-wCnnlt7HKomlUMiw517uPXZvmlIXpw6UWg>
    <xmx:C4zOXqaFVXAc_3WD1Q4_Gi5kHA-D_MgokN-UnSin9yiGttzD1w40Ew>
    <xmx:C4zOXtV3aBhJjmFHhdaApBUCn_DZ22u8GbT2mDOpJo2D-8kgUoFH0g>
    <xmx:C4zOXtg3D02naQZX4ovv9wDz5f-W1nLksx6jk9Dktak5kYpjcHTHng>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E87AD30618B7;
        Wed, 27 May 2020 11:49:30 -0400 (EDT)
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
Subject: [PATCH v3 009/105] dt-bindings: display: vc4: hdmi: Add missing clock-names property
Date:   Wed, 27 May 2020 17:47:39 +0200
Message-Id: <10ef2821e10886b66af5f8ba3e212aa87e9fd360.1590594512.git-series.maxime@cerno.tech>
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
wasn't explicitly documented in the previous binding. The documented order
was wrong too, so make sure clock-names is there and in the proper order.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
index 834cc5f1c254..52b3cdac0bdf 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
@@ -23,8 +23,13 @@ properties:
 
   clocks:
     items:
-      - description: The HDMI state machine clock
       - description: The pixel clock
+      - description: The HDMI state machine clock
+
+  clock-names:
+    items:
+      - const: pixel
+      - const: hdmi
 
   ddc:
     allOf:
-- 
git-series 0.9.1
