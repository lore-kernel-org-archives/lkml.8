Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB3CC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519A82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="txhJsuoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU2uHWGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgDXPgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:06 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50781 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728340AbgDXPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 3DFFE1338;
        Fri, 24 Apr 2020 11:36:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5EfepUmgVDPUO
        z3GVL3TqSbU3jIl6CJ4wxOzynhsQS0=; b=txhJsuoBnl+bVOQuzi8GERvG9jny1
        icHSH5yYHUNe0aHhZrfUwh3HDEusyYk9UTVXAWe/Fo69Fea3dQczMne1t+uJQpyl
        e5i+AoI/xSeBWLUHmpFoiOZx3yovfreQBPOX6o1Ns1JekaVZuHfE6QyCqGkDL/3d
        D7DluPyBU/6Nvwj65GJUiVa/17BfU+HN7yPmEbKgK3qvwLyArpMz6E7L5r6rYJeI
        YzR3eFpqxIdJq1pT283Zcn0rft/rNeUhPFKQ3c300gGIec65sb68WlDQ9XDoUvJZ
        nZ6PLhpP8CcReBntLfa1MlaDwhMrLioGhjrS9vlgAX91wn1JeQvYlLrrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5EfepUmgVDPUOz3GVL3TqSbU3jIl6CJ4wxOzynhsQS0=; b=FU2uHWGj
        2QyRJgVUbZCQqCft0ETFQdxL9P0+lWbTdRtvpHrw9LchDiuz+clw/bP1sWBxnzW0
        AQW7aWK2TQIPzFYfRhV4qUrMR8IQ3cfFqImgQDBlkYoI/83Bk+GnXA0U1ZZCknSZ
        6Sf5TYqnOfzj/tnaWZaAFQNR5eIx+DIOgMZsPrhGhFqI0fb52Ak5OFWC14HaIBXw
        t8aL+FH8FW6C36/Fe0rPFnVqNtAmQBWzY4ZUFVWx5FiqDVgo70diLQeU4du7mZZs
        EtEDd5Zc9i/65s4kGPV04wjBxcvXpxPFpRda42lQZLWFUkgcD5kgoq7COyscnzw+
        9AtpSbxbFv4mQA==
X-ME-Sender: <xms:YQejXqC8WTmxeQnL_VF53PL1f2WLTS1YpfkqvBc2BGuyEJbgxxSjSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvvdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:YQejXpKxWyPhAs-mJK7T8ku-OMZ11X2Dm47mz1NEKKmI3Vg5JycFgg>
    <xmx:YQejXltevHlWVaFZaGI8dbodUyQjhuWJkxUs_-nRgQmMlc_i2Gem-w>
    <xmx:YQejXi79ukv8eJ-MdwR3KQGX_L7bhDddhR6mP35GfPeL0txUUarqrQ>
    <xmx:YQejXv74mxP4GPht6FuGqhBJ4qKT4anSkNIiwg9SlnL8ub99D3ElfgtCADQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75CFA328005A;
        Fri, 24 Apr 2020 11:36:01 -0400 (EDT)
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
Subject: [PATCH v2 28/91] dt-bindings: display: vc4: dpi: Add missing clock-names property
Date:   Fri, 24 Apr 2020 17:34:09 +0200
Message-Id: <068b7528b56d53a5c8a527d66e2306c947477940.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
