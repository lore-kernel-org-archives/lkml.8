Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BB6C2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 03:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C932077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 03:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n0crX8Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgDADW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 23:22:59 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:19739 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbgDADW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 23:22:59 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 0313MSET017333;
        Wed, 1 Apr 2020 12:22:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0313MSET017333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585711350;
        bh=6cmk4VhYcoiSK0648BJFDTb8WGo1i4aniwWtusevAaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=n0crX8GxExB2dPg/8QhQatWt02gUfaOo6/Q6XF2RR3LPaFrXrpow0/nhIbhk9UaSp
         a/+rhR9iy+jrfi4TIoRdURW1PVBAGPQ1E0Qbb7appR14bGzqqheIN3+Tx7tsYwceEx
         mQJxi6OQmpZb6Nar5VNm/dmqec/IsB23ZD5zBEZG7VFGh1uBd2BGZXjlY06PyQGSak
         7xgUgyNtqdbz+b1rgf6jKiqrYZsw273kOa1j7abnHphGqOx+Ff8e6bVIajur46u3j7
         LWs5x+R6+Vo36uvL3YHv/n2qz6z9yTXvH54CSJPzjKW07NcFPpKL7LMbISOrkFEyh6
         924kwGhB0OP7Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: uniphier-xdmac: switch to single reg region
Date:   Wed,  1 Apr 2020 12:21:50 +0900
Message-Id: <20200401032150.19767-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg in the example "<0x5fc10000 0x1000>, <0x5fc20000 0x800>"
is wrong. The register region of this controller is much smaller,
and there is no other hardware register interleaved. There is no
good reason to split it into two regions.

Just use a single, contiguous register region.

While I am here, I made the 'dma-channels' property mandatory because
otherwise there is no way to determine the number of the channels.

Please note the original binding was merged recently. Since there
is no user yet, this change has no actual impact.

Fixes: b9fb56b6ba8a ("dt-bindings: dmaengine: Add UniPhier external DMA controller bindings")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

We do not need to touch the driver either because the second
region is not used.


 .../devicetree/bindings/dma/socionext,uniphier-xdmac.yaml  | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
index 86cfb599256e..371f18773198 100644
--- a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
+++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
@@ -22,9 +22,7 @@ properties:
     const: socionext,uniphier-xdmac
 
   reg:
-    items:
-      - description: XDMAC base register region (offset and length)
-      - description: XDMAC extension register region (offset and length)
+    maxItems: 1
 
   interrupts:
     maxItems: 1
@@ -49,12 +47,13 @@ required:
   - reg
   - interrupts
   - "#dma-cells"
+  - dma-channels
 
 examples:
   - |
     xdmac: dma-controller@5fc10000 {
         compatible = "socionext,uniphier-xdmac";
-        reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
+        reg = <0x5fc10000 0x5300>;
         interrupts = <0 188 4>;
         #dma-cells = <2>;
         dma-channels = <16>;
-- 
2.17.1

