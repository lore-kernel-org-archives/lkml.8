Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC83721D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mQJ/P6I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIIToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:44:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47294 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgIIToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:44:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 089Jhv8Q021391;
        Wed, 9 Sep 2020 14:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599680637;
        bh=k8H3ySxg/5Hu3LKDVffSO2sqa0Uyy5zNLnUTjK7eCzg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mQJ/P6I02UnvprJU7jHtW8AnyCxfT0q+cwZmHuBdEHaclA4w/Oel0RD75z/6DWYVs
         H2EzHP6Rfp8XFo81BF19ZCWRbJZ4Z512+CSyQ2GDT1oxTYG/rb3KP4pxnZVUd/qtHo
         2HoIj7s8gMJcsyxWoobewQcT0nZk+wUsYGgl3qYw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 089Jhvtv068869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Sep 2020 14:43:57 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Sep
 2020 14:43:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Sep 2020 14:43:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089JhtA5019776;
        Wed, 9 Sep 2020 14:43:56 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RESEND PATCH next v2 2/2] bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk
Date:   Wed, 9 Sep 2020 22:43:38 +0300
Message-ID: <20200909194338.21840-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909194338.21840-1-grygorii.strashko@ti.com>
References: <20200909194338.21840-1-grygorii.strashko@ti.com>
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

