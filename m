Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D19C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5594420658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="pvpq2n60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yZxC22rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgBXJM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:12:27 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:38139 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbgBXJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:16 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id EB85063D;
        Mon, 24 Feb 2020 04:10:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=/HqohafekctYs
        ueNYIyWADwS7ESNsNdoU7kv2sDLpQo=; b=pvpq2n60UGf4X+eFGCIt/2VXcc/in
        uQzJPBTxVii1lVzHbVsyvpuP2t1h2UZYIb+MXv7dfNN8XNfstibVzypy7bj2Be0K
        0L1nbW88TdBUw2GFRqYCPozPAEVlbugMdvTDXIvshn2hEn4PR2owUgNhKyIiGN5r
        JGb3eNedCN/PdV1rfV4CS5o8lDEX6cdZOA38dGyepuX4pLCJcEMs/xX4kmauKYRN
        RvMaYSD7zbR4+mBH6ab9MCUhhyJy1j7iaMyBB/KhAxtfwoH55AX5ZUJUvQR+7b94
        bgO8m0YAVHsTS/U3tK+0tnVi+I+t5/RoQ2/xgpVUMX4k4CXQlptFtrAVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=/HqohafekctYsueNYIyWADwS7ESNsNdoU7kv2sDLpQo=; b=yZxC22rL
        EMci14Nm05ggtARzA9rU83oKRSc5Zl585o7m2dZAYZhyO3RfGAtxdt4zxoojni8w
        l1b7ZwqRRDXxqHAriHm6bfodBA9nuAEeV0aBZT8VWOa8Ip6yM1Hs4h0T164MUfWp
        d540vpSEzfWJlaqHYY7VWwvBB6L0agUQ7J7c7T2B/1zUz34s2nUGLkm7p/Kbz+Gl
        65OsW9zXQ4ajLoOWAiXFW4JH68/Jq1ZF6D31wZhIfXMGmcwVreSkHrbBVVKnZ2/s
        HPeNsFYZjSZGsGbIm9BPtdswJnNGubQcaibw3d0juswOQK8YEjYPzo6c5veWblTg
        3AApcviCxLp7og==
X-ME-Sender: <xms:9pJTXrwGr7g2eqIARQfwcccnahb1kZVaEcvlUna49LLAaMaHXpHQwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgephedvnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9pJTXmXHV1BOGwG5xrVVMWCVEoE42m_R-0N_5Q58ZKUGu0lcyzf-2w>
    <xmx:9pJTXv97vtXsaMU5pITI1ZTwpds3buEu_VQq0qth5b3iljbkry4Jsg>
    <xmx:9pJTXhtdmG-omkQfWmHZ_fnkgZ227PIky5DzV_SV4zfZwNFOyPHPBw>
    <xmx:9pJTXqggLtWmhBICgx3_WOosJU5CevJe16gHtMqf2DnOatNsjVirN2GSqys>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34CF83060BD1;
        Mon, 24 Feb 2020 04:10:14 -0500 (EST)
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
Subject: [PATCH 59/89] dt-bindings: display: vc4: pv: Add BCM2711 pixel valves
Date:   Mon, 24 Feb 2020 10:07:01 +0100
Message-Id: <4a3c6e3cad10eeff93fafbc512c35b0c69dd1c68.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 comes with other pixelvalves that have different requirements
and capabilities. Let's document their compatible.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
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
