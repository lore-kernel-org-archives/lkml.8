Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B1DC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C632072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCFMSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:18:10 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35034 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgCFMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:18:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8DD43803087C;
        Fri,  6 Mar 2020 12:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SFkyHKoccYws; Fri,  6 Mar 2020 15:09:39 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/22] dt-bindings: Permit platform devices in the trivial-devices bindings
Date:   Fri, 6 Mar 2020 15:08:25 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306120940.8DD43803087C@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Indeed there are a log of trivial devices amongst platform controllers,
IP-blocks, etc. If they satisfy the trivial devices bindings requirements
like consisting of a compatible field, an address and possibly an interrupt
line why not having them in the generic trivial-devices bindings file?
We only need to accordingly alter the bindings title and description nodes.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 978de7d37c66..ce0149b4b6ed 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -4,15 +4,15 @@
 $id: http://devicetree.org/schemas/trivial-devices.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Trivial I2C and SPI devices that have simple device tree bindings
+title: Trivial I2C, SPI and platform devices having simple device tree bindings
 
 maintainers:
   - Rob Herring <robh@kernel.org>
 
 description: |
-  This is a list of trivial I2C and SPI devices that have simple device tree
-  bindings, consisting only of a compatible field, an address and possibly an
-  interrupt line.
+  This is a list of trivial I2C, SPI and platform devices that have simple
+  device tree bindings, consisting only of a compatible field, an address and
+  possibly an interrupt line.
 
   If a device needs more specific bindings, such as properties to
   describe some aspect of it, there needs to be a specific binding
-- 
2.25.1

