Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8537C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6052084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCFND6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:03:58 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36156 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFND6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:03:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D9FCD8030794;
        Fri,  6 Mar 2020 13:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CtNhC5NrpV3R; Fri,  6 Mar 2020 16:03:51 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: syscon: Add syscon endian properties support
Date:   Fri, 6 Mar 2020 16:03:38 +0300
In-Reply-To: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130356.D9FCD8030794@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

In accordance with the syscon-driver (drivers/mfd/syscon.c) the syscon
dts-nodes may accept endian properties of the boolean type: little-endian,
big-endian, native-endian. Lets make sure that syscon bindings json-schema
also supports them.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 39375e4313d2..9ee404991533 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -61,6 +61,11 @@ properties:
     description:
       Reference to a phandle of a hardware spinlock provider node.
 
+patternProperties:
+  "^(big|little|native)-endian$":
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Bytes order of the system controller memory space.
+
 required:
   - compatible
   - reg
@@ -81,4 +86,13 @@ examples:
         hwlocks = <&hwlock1 1>;
     };
 
+  - |
+    cpu_ctl: cpu@1F04D02C {
+      compatible = "syscon";
+      reg = <0x1F04D02C 0x004>;
+
+      little-endian;
+      reg-io-width = <4>;
+    };
+
 ...
-- 
2.25.1

