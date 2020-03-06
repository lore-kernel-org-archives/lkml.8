Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B53FC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D700A2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFMSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:18:03 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35020 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgCFMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:18:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 770608030786;
        Fri,  6 Mar 2020 12:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eLJFfEW1_82t; Fri,  6 Mar 2020 15:10:42 +0300 (MSK)
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
Subject: [PATCH 03/22] dt-bindings: Add MIPS CDMM controller as a trivial device
Date:   Fri, 6 Mar 2020 15:08:27 +0300
In-Reply-To: <20200306120847.32690-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306120847.32690-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306121043.770608030786@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

It's a Common Device Memory Map controller embedded into the MIPS IP
cores. The corresponding dts node is supposed to have a compatible
and regs properties. So add the device to the trivial-devices bindings
file.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index b6b6f3181fd8..370b8c6631fc 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -304,6 +304,8 @@ properties:
           - miramems,da280
             # MiraMEMS DA311 3-axis 12-bit digital accelerometer
           - miramems,da311
+            # MIPS Common Device Memory Map block (CDMM)
+          - mti,mips-cdmm
             # MIPS Cluster Power Controller (CPC)
           - mti,mips-cpc
             # Temperature sensor with integrated fan control
-- 
2.25.1

