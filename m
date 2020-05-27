Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E822088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WIujI7Wh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wn93fV+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbgE0Pvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:43213 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730605AbgE0Puv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E600B5820B3;
        Wed, 27 May 2020 11:50:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mIo2yTnIciTwR
        AfqGqPRdeUMoEIyJ/WFBxN68ut8oG8=; b=WIujI7WharlAGicvX2WyOiv3jX+w/
        sT18coLSjEtk5L6aOGZY5lEKGgnwldzH3cLD8lbkMcVhqvgRz3ICcqIxnBGeRMrw
        sCG3316RnFnMeU3i7e5daLdaLKRYg7+FjeHtF0AEpaV0IQ7C+1MFLC+CbSpOWUq8
        Vn3+NbxUHP5RNbgafLj5MOlPPLpXGsan+WRemQ9AKtNZ2fkjRbsrk4Q9CHqW1crt
        s6Fmu23OKv0wtN4mphn96mVswCajMnF677jS+WpYpaTucREJhPkTggCh8/UYY8FJ
        1UyDuHxaMWLdKntiSlyOJfz2o7MBprRWdDO6lqtxZMkVGXND67UCYIgTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=mIo2yTnIciTwRAfqGqPRdeUMoEIyJ/WFBxN68ut8oG8=; b=Wn93fV+R
        q1M2XVFtqYnkqegBnI2+hcYd65lr3f+m4BIGlxHmdf6Hgre9IShj5JSu7XGCoXz8
        yE1eZdm5wV5arOOa4w2NiU3YeUN8gw1fXX0yU9Xr9IsJBNuQpRC7Lu/HNUDfddqG
        0USSPnOFBnuYyRh5hEXkMrmMlWQUGDXpxlYp5yza7lRjsl25J+ZZ5Rqqqyiczz5A
        6Y+vrG7MRNzE+ptXg9W/IzFwduiWxOZeFqevg0I2owrehgdm2zYHq5DfTMITEczi
        4H8DDAVfixWaqZKs/4sqtQ3QLwSfPAA3lKzrTRRx7b0vRpBPbHEebDd9YmMP+y7/
        KAovOHXo2fb26w==
X-ME-Sender: <xms:WYzOXuaXTafeeH1qBIUAYGWr3X21ebDrB9dOHZ8wFMBc7C6HItNLbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WYzOXhZtgLYNhhexBOTBA6ekPuv5j5tLZn190Cf_lBBfLsUgv6Q65A>
    <xmx:WYzOXo-OWLJuw1Pf0HRrPKQfBDUL3huWfJqU7z1Qe1pA2PzsrA7jDw>
    <xmx:WYzOXgqZgDKyETahtm56zYeJtFcIIQQ75t6Ma4356fq1LYgp97pVng>
    <xmx:WYzOXk0QdgkupH8rqEGRjj03brjLl77Z9AxUQD2EfQ-GxsT29GxhBA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8671B3280069;
        Wed, 27 May 2020 11:50:49 -0400 (EDT)
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
Subject: [PATCH v3 058/105] dt-bindings: display: vc4: pv: Add BCM2711 pixel valves
Date:   Wed, 27 May 2020 17:48:28 +0200
Message-Id: <38e915fcfcbc6896344423eb651f60cc04273caa.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 comes with other pixelvalves that have different requirements
and capabilities. Let's document their compatible.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
index e60791db1fa1..4e1ba03f6477 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
@@ -15,6 +15,11 @@ properties:
       - brcm,bcm2835-pixelvalve0
       - brcm,bcm2835-pixelvalve1
       - brcm,bcm2835-pixelvalve2
+      - brcm,bcm2711-pixelvalve0
+      - brcm,bcm2711-pixelvalve1
+      - brcm,bcm2711-pixelvalve2
+      - brcm,bcm2711-pixelvalve3
+      - brcm,bcm2711-pixelvalve4
 
   reg:
     maxItems: 1
-- 
git-series 0.9.1
