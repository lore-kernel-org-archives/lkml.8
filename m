Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD34CC43463
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12ED208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGMVgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:36:04 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:62097 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727810AbgGMVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:36:01 -0400
X-IronPort-AV: E=Sophos;i="5.75,348,1589209200"; 
   d="scan'208";a="52016013"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2020 06:35:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9650940F7FE5;
        Tue, 14 Jul 2020 06:35:55 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 8/9] dt-bindings: net: renesas,ravb: Add support for r8a774e1 SoC
Date:   Mon, 13 Jul 2020 22:35:19 +0100
Message-Id: <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Document RZ/G2H (R8A774E1) SoC bindings.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 032b76f14f4f..9119f1caf391 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -21,6 +21,7 @@ Required properties:
       - "renesas,etheravb-r8a774a1" for the R8A774A1 SoC.
       - "renesas,etheravb-r8a774b1" for the R8A774B1 SoC.
       - "renesas,etheravb-r8a774c0" for the R8A774C0 SoC.
+      - "renesas,etheravb-r8a774e1" for the R8A774E1 SoC.
       - "renesas,etheravb-r8a7795" for the R8A7795 SoC.
       - "renesas,etheravb-r8a7796" for the R8A77960 SoC.
       - "renesas,etheravb-r8a77961" for the R8A77961 SoC.
-- 
2.17.1

