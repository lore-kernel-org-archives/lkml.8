Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E2CC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA48D2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgG3Pp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:45:58 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57322 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Ppz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:45:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id DB0A1803202F;
        Thu, 30 Jul 2020 15:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CFlFm4HzIXgH; Thu, 30 Jul 2020 18:45:52 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] dt-bindings: dma: dw: Add optional DMA-channels mask cell support
Date:   Thu, 30 Jul 2020 18:45:41 +0300
Message-ID: <20200730154545.3965-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each DW DMA controller channel can be synthesized with different
parameters like maximum burst-length, multi-block support, maximum data
width, etc. Most of these parameters determine the DW DMAC channels
performance in its own aspect. On the other hand these parameters can
be implicitly responsible for the channels performance degradation
(for instance multi-block support is a very useful feature, but having
it disabled during the DW DMAC synthesize will provide a more optimized
core). Since DMA slave devices may have critical dependency on the DMA
engine performance, let's provide a way for the slave devices to have
the DMA-channels allocated from a pool of the channels, which according
to the system engineer fulfill their performance requirements.

The pool is determined by a mask optionally specified in the fifth
DMA-cell of the DMA DT-property. If the fifth cell is omitted from the
phandle arguments or the mask is zero, then the allocation will be
performed from a set of all channels provided by the DMA controller.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../devicetree/bindings/dma/snps,dma-spear1340.yaml        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index 20870f5c14dd..ef1d6879c158 100644
--- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -18,12 +18,15 @@ properties:
     const: snps,dma-spear1340
 
   "#dma-cells":
-    const: 3
+    minimum: 3
+    maximum: 4
     description: |
       First cell is a phandle pointing to the DMA controller. Second one is
       the DMA request line number. Third cell is the memory master identifier
       for transfers on dynamically allocated channel. Fourth cell is the
-      peripheral master identifier for transfers on an allocated channel.
+      peripheral master identifier for transfers on an allocated channel. Fifth
+      cell is an optional mask of the DMA channels permitted to be allocated
+      for the corresponding client device.
 
   reg:
     maxItems: 1
-- 
2.27.0

