Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B750AC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886702080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="W76T6gjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKzivMKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBXJJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:45 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:33021 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBXJJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 42B9162B;
        Mon, 24 Feb 2020 04:09:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=CbU6f6ZrrpRWQ
        5qiZhenLgFrNL32RR24Q5O8MBsSZvU=; b=W76T6gjD+sG5x7IbekSRVdLvYieY4
        0tMN/Qq1LQA8/98MKWgeqgmo+9AIL7z8LUwDt5cQBrzcA6KymtAMYeuV2Ufk3+jV
        OO455hMj7nz1fbRpTPUDRlAm0IuWuKAQ0Wi8TqcSk4FtXqjehlrt/3/uOWDh1c0z
        Y0O+m8ULJaojxWUiNRK4gdMRLh7m9G/iP2fOg+DAaZ1Pofy9gYqPHMmY3ZzftXuu
        eXiXqnWmH3oOU27yO7tBpd3O2szkIh3301nwnZ5AbzUQDZ1HtZZwxFzT173WjjY3
        yv4t99V8s0Rp2YgaDoE7JUzUQBbNCf6KlhlSQiK88iugXBLd44MPsY3Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CbU6f6ZrrpRWQ5qiZhenLgFrNL32RR24Q5O8MBsSZvU=; b=RKzivMKy
        IQkX23piS/y2KwMA99ZW0TY+5SRbg4EinBkDfV+PiQXYEr0h9+zds8OQeHCmAIxP
        wQczdVgEGfBQ6Bqnts4qCLlJLYHmut8X80HdctAI6JskCQwXKvytevID6tzbNHbx
        cGxHJlcpQkZBGfH2UZXyw2CpbVCDDUmFNI9ydIYZguV5h6S/2BWeAYYpNvM4SRdL
        pOvR8W0hitW1A4DVREBSpD11cBwHuEGz64fBEcYh+C2hFXctcGerL7MhIhfOqIId
        hKH3IHeh+dr9mzyB01qS/e3dP6hxbdLuqz+2N9AxeUjsEeRwlYIOpeORcweakXCo
        WbnMb8CGWJEmOA==
X-ME-Sender: <xms:zJJTXgYA3KOAgVDKHdets8P1tOwZ0fTR-xPvmXsWcszeDVUNcjiO1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepvdegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zJJTXiXEHLsjUhY8NMC6KWUNJq2o0A3JEeyhIxxbIRKE4pBJxlDAmw>
    <xmx:zJJTXgAUhB0WVorQIzALKP5zIVVyIZZeDWaIHpTMfoMnseuXUxS1Jg>
    <xmx:zJJTXhy86s8Ketq3N1zcox58fE7uiG28WP2OeyE5KR5NzpMbyyc8FQ>
    <xmx:zJJTXntbuq4xgKgCV9oiEPx5LN3QcXLPEsVThr0AZdszfRIuGq6HD5giWH8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8691B3280066;
        Mon, 24 Feb 2020 04:09:32 -0500 (EST)
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
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 30/89] dt-bindings: display: vc4: dpi: Add missing clock-names property
Date:   Mon, 24 Feb 2020 10:06:32 +0100
Message-Id: <042c8f676d3d863b55092bb58c1f15db95370782.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the device tree and the driver expected a clock-names property, it
wasn't explicitly documented in the previous binding. Make sure it is now.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
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
