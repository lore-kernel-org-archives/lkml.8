Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8773FC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642BE20663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCIUic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:38:32 -0400
Received: from mail.v3.sk ([167.172.186.51]:46406 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbgCIUi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:38:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4E809DEDF6;
        Mon,  9 Mar 2020 20:38:46 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SKuz_4GrvM2l; Mon,  9 Mar 2020 20:38:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EE383E01B2;
        Mon,  9 Mar 2020 20:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TIDQc7w4R_ML; Mon,  9 Mar 2020 20:38:42 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 441CCDEDF6;
        Mon,  9 Mar 2020 20:38:42 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/4] dt-bindings: mfd: Add ENE KB3930 Embedded Controller binding
Date:   Mon,  9 Mar 2020 21:38:17 +0100
Message-Id: <20200309203818.31266-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309203818.31266-1-lkundrak@v3.sk>
References: <20200309203818.31266-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the ENE KB3930 Embedded Controller.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/mfd/ene-kb3930.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb3930.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml b/Docu=
mentation/devicetree/bindings/mfd/ene-kb3930.yaml
new file mode 100644
index 0000000000000..5c9009617aea2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ene-kb3930.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ENE KB3930 Embedded Controller bindings
+
+description: |
+  This binding describes the ENE KB3930 Embedded Controller attached to =
a
+  I2C bus.
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: ene,kb3930
+
+  reg:
+    maxItems: 1
+
+  power-gpios:
+    description: GPIO used for the power pin
+    maxItems: 2
+
+  system-power-controller: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    embedded-controller@58 {
+      compatible =3D "ene,kb3930";
+      reg =3D <0x58>;
+      system-power-controller;
+
+      off-gpios =3D <&gpio 126 GPIO_ACTIVE_HIGH>,
+                  <&gpio 127 GPIO_ACTIVE_HIGH>;
+    };
+
+...
--=20
2.25.1

