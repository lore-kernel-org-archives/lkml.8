Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66926206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHITfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:35:52 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:43008 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbgHITfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:35:51 -0400
X-IronPort-AV: E=Sophos;i="5.75,454,1589209200"; 
   d="scan'208";a="54030776"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Aug 2020 04:35:49 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9713140DD1CC;
        Mon, 10 Aug 2020 04:35:47 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Sort compatible string in increasing number of the SoC
Date:   Sun,  9 Aug 2020 20:35:27 +0100
Message-Id: <20200809193527.19659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the items in the compatible string list in increasing number of SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 6bfa090fd73a..9ada67b1f5f4 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -32,8 +32,8 @@ properties:
           - enum:
               - renesas,ipmmu-r8a774a1 # RZ/G2M
               - renesas,ipmmu-r8a774b1 # RZ/G2N
-              - renesas,ipmmu-r8a774e1 # RZ/G2H
               - renesas,ipmmu-r8a774c0 # RZ/G2E
+              - renesas,ipmmu-r8a774e1 # RZ/G2H
               - renesas,ipmmu-r8a7795  # R-Car H3
               - renesas,ipmmu-r8a7796  # R-Car M3-W
               - renesas,ipmmu-r8a77961 # R-Car M3-W+
-- 
2.17.1

