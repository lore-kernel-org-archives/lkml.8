Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284A6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26372086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgHGMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgHGMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:11:06 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3373C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 05:11:05 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id CcAz230074C55Sk01cAzZ2; Fri, 07 Aug 2020 14:11:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k41D9-0000Z2-93; Fri, 07 Aug 2020 14:10:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k41D9-0003hp-7L; Fri, 07 Aug 2020 14:10:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: lpspi: Add missing boolean type for fsl,spi-only-use-cs1-sel
Date:   Fri,  7 Aug 2020 14:10:57 +0200
Message-Id: <20200807121057.14204-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running "make dt_binding_check" (even if restricted to an unrelated
binding document using DT_SCHEMA_FILES=...):

    Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml: ignoring, error in schema: properties: fsl,spi-only-use-cs1-sel
    warning: no schema found in file: Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml

Fix this by adding a proper type definition for the vendor-specific
fsl,spi-only-use-cs1-sel property.

Fixes: 7ac9bbf6ab3085c2 ("dt-bindings: lpspi: New property in document DT bindings for LPSPI")
Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 22882e769e260f76..312d8fee9dbb8199 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -39,6 +39,7 @@ properties:
       spi common code does not support use of CS signals discontinuously.
       i.MX8DXL-EVK board only uses CS1 without using CS0. Therefore, add
       this property to re-config the chipselect value in the LPSPI driver.
+    type: boolean
 
 required:
   - compatible
-- 
2.17.1

