Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09782C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E096F2098B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wbg/9a1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgH2SmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:42:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38862 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgH2SmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:42:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07TIg09J078958;
        Sat, 29 Aug 2020 13:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598726520;
        bh=5L07CDzVNrrZZZBEZh44eJfGeyDpv3gxKc0IwpXsybM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wbg/9a1G1YIQX5F/sBAwLW1iPLsIOCY5oQvodQ2nyfnWLOfSZ2GwINq0MBqAmDl/O
         tZcyaxL2kVAGrzScu6thrzfGF13u5T0Qv5D8bIKYGvLk/FOgj3WwIzqbJm9+Kgn8KU
         h2lI5gDNx0IBSHtG/09aDOvTw6MNsQ6ksNDgK2bc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07TIg0qf093728;
        Sat, 29 Aug 2020 13:42:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 29
 Aug 2020 13:42:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 29 Aug 2020 13:42:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07TIfx2N063177;
        Sat, 29 Aug 2020 13:41:59 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 2/3] bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk
Date:   Sat, 29 Aug 2020 21:41:38 +0300
Message-ID: <20200829184139.15547-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829184139.15547-1-grygorii.strashko@ti.com>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "ti,dma-ring-reset-quirk" DT property as proper w/a handling is
implemented now in Ringacc driver using SoC info.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
index ae33fc957141..c3c595e235a8 100644
--- a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
@@ -62,11 +62,6 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: TI-SCI device id of the ring accelerator
 
-  ti,dma-ring-reset-quirk:
-    $ref: /schemas/types.yaml#definitions/flag
-    description: |
-      enable ringacc/udma ring state interoperability issue software w/a
-
 required:
   - compatible
   - reg
@@ -94,7 +89,6 @@ examples:
             reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
             ti,num-rings = <818>;
             ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
-            ti,dma-ring-reset-quirk;
             ti,sci = <&dmsc>;
             ti,sci-dev-id = <187>;
             msi-parent = <&inta_main_udmass>;
-- 
2.17.1

