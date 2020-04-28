Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC5BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBBA206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD1LSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgD1LSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:18:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B3FC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:18:49 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jTOGC-0000SP-8u; Tue, 28 Apr 2020 13:18:44 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jTOGB-0007Mt-K0; Tue, 28 Apr 2020 13:18:43 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, ceggers@arri.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: nvmem: skip nodes with compatibles other than "nvmem-cell"
Date:   Tue, 28 Apr 2020 13:18:26 +0200
Message-Id: <20200428111829.2215-2-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428111829.2215-1-a.fatoum@pengutronix.de>
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nodes matching the nvmem binding, all child objects matching
"^.*@[0-9a-f]+$" are assumed to be nvmem cells, without taking a
compatible into account.

This precludes:

  - future extension of e.g. eeprom nodes by any child nodes other
    than nvmem cells
  - extending the NVMEM binding to nodes that already have other
    child nodes, e.g., MTD and its partitions

To allow co-existence of nvmem-cells with other nodes, loosen the
binding to consult an optional compatible property for the cells:

  - if a compatible exists, it must be "nvmem-cell"
  - if none exists, it's assumed to be a nvmem cell, like before

As additionalProperties: false was specified for nvmem-cell bindings,
a compatible property was so far invalid. This means no already
compliant device tree should be reinterpreted differently after
this binding adjustment and in that regard, the change is completely
backwards-compatible.

This resolves an existing clash between this nvmem-cell binding and
the barebox bootloader binding that extends the fixed-partitions MTD
binding to EEPROMs.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 65980224d550..c39f5dd7e1aa 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -44,9 +44,21 @@ properties:
 
 patternProperties:
   "^.*@[0-9a-f]+$":
-    type: object
+    if:
+      properties:
+        compatible:
+          items:
+            const: nvmem-cell
+    then:
+      $ref: "#/definitions/nvmem-cell"
 
+definitions:
+  nvmem-cell:
     properties:
+      compatible:
+          items:
+            const: nvmem-cell
+
       reg:
         maxItems: 1
         description:
-- 
2.26.2

