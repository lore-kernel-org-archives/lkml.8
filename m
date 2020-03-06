Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A3C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B532073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCFNUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:20:21 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36728 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCFNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:20:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C268A8030792;
        Fri,  6 Mar 2020 13:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UHkjKO8DXrU4; Fri,  6 Mar 2020 16:20:18 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] dt-bindings: i2c: dw: Add Baikal-T1 SoC I2C controller
Date:   Fri, 6 Mar 2020 16:19:52 +0300
In-Reply-To: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306132018.C268A8030792@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Just add the "be,bt1-i2c" compatible string to the bindings. The rest of
the DW APB I2C properties can be freely used to describe the Baikal-T1
I2C controller dts-node.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 3f348f1ce172..eab2c9293665 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -34,6 +34,8 @@ properties:
         items:
           - const: mscc,ocelot-i2c
           - const: snps,designware-i2c
+      - description: Baikal-T1 SoCs I2C controller.
+        const: be,bt1-i2c
 
   reg:
     items:
-- 
2.25.1

