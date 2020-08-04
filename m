Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A042C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B4122B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tdFJADtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHDVSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:18:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37710 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgHDVR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:17:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 074LHrah092438;
        Tue, 4 Aug 2020 16:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596575873;
        bh=k8H3ySxg/5Hu3LKDVffSO2sqa0Uyy5zNLnUTjK7eCzg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tdFJADtgo4t55WG/kE46wuTPp6XRCjv1O+EIGabY+He27QoIYXh1F3DijOPUD2cSK
         6Z+CUH671m6tWc+skzVf8cW3CC+6JJilWX8JhMAnLWLKwHZt2MvQR9Y9XfPBZmHEa4
         vIXeCEfHHAVBGSACcIjJRrjkQN2UDy7DlZZlB6LU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 074LHrZQ040180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Aug 2020 16:17:53 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 4 Aug
 2020 16:17:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 4 Aug 2020 16:17:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 074LHpFe046405;
        Tue, 4 Aug 2020 16:17:52 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next 2/3] bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk
Date:   Wed, 5 Aug 2020 00:17:31 +0300
Message-ID: <20200804211732.2861-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804211732.2861-1-grygorii.strashko@ti.com>
References: <20200804211732.2861-1-grygorii.strashko@ti.com>
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

