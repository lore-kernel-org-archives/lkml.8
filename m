Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51941C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD0620776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XAY7KFmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVsO7R0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgDXPgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:55 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:51735 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728658AbgDXPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 61F48334;
        Fri, 24 Apr 2020 11:36:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mIo2yTnIciTwR
        AfqGqPRdeUMoEIyJ/WFBxN68ut8oG8=; b=XAY7KFmQ9PTHYwXMyTnUapTYKD24g
        Mn8jD2A7zM2FUgstdDbWgxTUbdsc0MaTfjLL28skUbmn+ghoY9CUmOCfqIdgQOMZ
        cWcuu7sdV16n6KAK3qEP2dsnkV/3La8xkZiUS4kkqXAB9joVKqtv+siHkCJrOIDe
        e2USEfaz0X0x/OYcNdI3PFhO60umohg4/nIRvQytUdoB2svwIXx1YwCe2YAPSwg7
        MbVoWIWpWC8RsjFafN9sHKp/Kjads4lImncWQ/tOehrQiQmrU09QMlRYSwl5TLAD
        rIr8IusTRtEg/ppTulPcHDVCtD2jf1SqMDWHTImU7/5FtExW+xat4NDLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=mIo2yTnIciTwRAfqGqPRdeUMoEIyJ/WFBxN68ut8oG8=; b=ZVsO7R0B
        BZvoD2w8F8WMZ1HSehOtOrclHujG/eMySrgwFi75FD/rrRE0+DVvt3nPGa/gzyST
        ZciLYHA3TuTaKOHirgTL4GDuVa/Ljt//zPqv0uQl4UripPfTm3b1LJAaX81PV8No
        1EVD+UmkYXIugR48wNuwmBwQp268S2ETvuboamscQZrVbip10DIXe0aBk5ito7w/
        i7in/zrC/FZsRg9gOJTBDtcsjR42ut2ew6NdIcoYYhnrC5LWrrxthDgLVVDHOPj/
        uzQDeESNeVl76yAfKoNecbhciQz5uDODLalYS6nDF1LMzUpVSEOsDaYG70y5yBkq
        PW+yE+63KXrOOw==
X-ME-Sender: <xms:jAejXrPXjRki40XukrQGpqYkBxwCbfRMZWtOdTF6OGEOwB7nsL21wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jAejXqOeWAWXjKtcJ2WkYnNupPOLAY4qkuHbAlb0fetjOhhsWlp7Tg>
    <xmx:jAejXlTqMD-dvnKAFtjv5Bs3fT9Zp85QfufkPxe4y3sRVM38Hueq1w>
    <xmx:jAejXkBHysai9lOmJH8G_LW-AhHhH2rsA93tJMrkDLMjiP-1jYnduA>
    <xmx:jQejXoIDgJUvT34hWhwsWHKmIEK8IAAn4vmTCVAQd5Lor41MGUpKJtOFYHo>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8AADE3065CDA;
        Fri, 24 Apr 2020 11:36:44 -0400 (EDT)
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
Subject: [PATCH v2 59/91] dt-bindings: display: vc4: pv: Add BCM2711 pixel valves
Date:   Fri, 24 Apr 2020 17:34:40 +0200
Message-Id: <d32c991fa0441b631ca5de8a39107a0db5e13880.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
