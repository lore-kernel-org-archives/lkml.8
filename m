Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41CAC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A6D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBUHha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:37:30 -0500
Received: from mx.socionext.com ([202.248.49.38]:50777 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBUHha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:37:30 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Feb 2020 16:37:28 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 20ED3603AB;
        Fri, 21 Feb 2020 16:37:29 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 21 Feb 2020 16:37:29 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 9E7961A01BB;
        Fri, 21 Feb 2020 16:37:28 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 0/2] dmaengine: Add UniPhier XDMAC driver
Date:   Fri, 21 Feb 2020 16:37:24 +0900
Message-Id: <1582270646-29161-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for UniPhier external DMA controller (XDMAC), that is
implemented in Pro4, Pro5, PXs2, LD11, LD20 and PXs3 SoCs.

Changes since v3:
- dt-bindings: Fix typo

Changes since v2:
- dt-bindings: Fix SPDX and some properties
- Fix iteration count calculation for memcpy
- Replace zero-length array with flexible-array member in struct
  uniphier_xdmac_device.

Changes since v1:
- dt-bindings: Rewrite with DT schema.
- Change return type of uniphier_xdmac_chan_init() to void,
  and remove error return in probe.

Kunihiko Hayashi (2):
  dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
  dmaengine: uniphier-xdmac: Add UniPhier external DMA controller driver

 .../bindings/dma/socionext,uniphier-xdmac.yaml     |  63 +++
 drivers/dma/Kconfig                                |  11 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/uniphier-xdmac.c                       | 611 +++++++++++++++++++++
 4 files changed, 686 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
 create mode 100644 drivers/dma/uniphier-xdmac.c

-- 
2.7.4

