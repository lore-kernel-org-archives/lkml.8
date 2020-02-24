Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA51C11D2B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706E72080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="CCMGcHBB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2YxvQ3Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgBXJNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:48 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:45883 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbgBXJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 83C2663B;
        Mon, 24 Feb 2020 04:09:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=tcEeIWCR5xDNY
        TxvAnWeBfw6yhxXXPV3oBBDWSfmiS8=; b=CCMGcHBBp44MBA4Quv4mYfmnmil9m
        fftMiZztC3Jt/0rPbr4gEC5tqlrP9oaifOZ7YPC4xiu31i/xfN6ODyotAFXgask0
        H7fROM6uV8dlrknPVnbI99MKLrDs9VXAAPnbUVkJ6a86ncAgpJ1LlaTufhpC5YWX
        sJxReG7xGyZtzMdN0zN0B/HX7tlPY5IlXnz7owOWYvdlzZsui4rUXY0rUFfmSnin
        xC8VnHOudg34kpX6Kk9TZip3av+oR/ccJnOFv7Vz4PSVp93KC1R7J4mTrqAboM7P
        GBuhWUjCs1OGzSAmW55eDBh7zICgmWLPUyV/uwOXAdadlILItC2dP4aXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=tcEeIWCR5xDNYTxvAnWeBfw6yhxXXPV3oBBDWSfmiS8=; b=2YxvQ3Ml
        GEtfI/BENXx98c+eQPaE7utv66AV+JVtYsS8+r+pS0xNy7vTKHS4HZv0a2QGGxa+
        FeQmPYroc/Npb5x/KyK543+42TcYeL6klwRpTB5aqVwv/g3Ppwgka90qy2BbntPA
        QylJarHsP4lGW/Q/cXOBA3e7gzhO0t7M7oH+KdI3g0XzCXFROYkMvBSQoIozQ41n
        E3eoL8F6/OTu3wAT3foqVhz1nNO7NtQylSabdpDGrE3mMfKEdHtZvIH7NQkAl8OL
        Op4REj3DeJI6+mUiJ3637l3qII1vUYdvSUCy1tjYWncAl/efSKbJlDWPp3R+LE23
        1w4Wg3fpOiaOQw==
X-ME-Sender: <xms:0ZJTXncbCuRYY-l6pP--EGR_wXgnDrmBYSUIwf18C9-WuvJLiZ2JjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepvdejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0ZJTXk0UZqgFCO0IQEXTxvyBVXvQC9xyTugM49VRjmpafe-Lon6m1A>
    <xmx:0ZJTXgvaePxHpnPyjFXas-54B8sOM4ozwkLhP8JSYJ2lEzsclj7nBA>
    <xmx:0ZJTXg-eQAbXWNV9J0FgYLT8ZvKLi6RwMBDL1CwVbtQCiwW7dm5LwQ>
    <xmx:0ZJTXvyAK7DOsFqoJ_avWbUfz3klNEyoVt7Zfg3T9eZO6Q0LpfD-Y9UF9fY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D77C33060FCB;
        Mon, 24 Feb 2020 04:09:36 -0500 (EST)
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
Subject: [PATCH 33/89] dt-bindings: display: vc4: Document BCM2711 VC5
Date:   Mon, 24 Feb 2020 10:06:35 +0100
Message-Id: <d8df122abf3875d9924a20996673bea49174dbb1.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 comes with a new VideoCore. Add a compatible for it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
index 0dcf0c397375..49a5e041aa49 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
@@ -17,6 +17,7 @@ description: >
 properties:
   compatible:
     enum:
+      - brcm,bcm2711-vc5
       - brcm,bcm2835-vc4
       - brcm,cygnus-vc4
 
-- 
git-series 0.9.1
