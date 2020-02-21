Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA3C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EAF206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbgBUItz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:49:55 -0500
Received: from mx.socionext.com ([202.248.49.38]:50873 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgBUHoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:44:30 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Feb 2020 16:44:28 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id BE6F5603AB;
        Fri, 21 Feb 2020 16:44:28 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 21 Feb 2020 16:44:28 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 4FCED403B2;
        Fri, 21 Feb 2020 16:44:28 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 1AC8E12047F;
        Fri, 21 Feb 2020 16:44:28 +0900 (JST)
Date:   Fri, 21 Feb 2020 16:44:28 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 0/2] dmaengine: Add UniPhier XDMAC driver
Cc:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <1582270646-29161-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1582270646-29161-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <20200221164427.32C3.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my mistake in this v4.

I'll resend it.

On Fri, 21 Feb 2020 16:37:24 +0900 <hayashi.kunihiko@socionext.com> wrote:

> Add support for UniPhier external DMA controller (XDMAC), that is
> implemented in Pro4, Pro5, PXs2, LD11, LD20 and PXs3 SoCs.
> 
> Changes since v3:
> - dt-bindings: Fix typo
> 
> Changes since v2:
> - dt-bindings: Fix SPDX and some properties
> - Fix iteration count calculation for memcpy
> - Replace zero-length array with flexible-array member in struct
>   uniphier_xdmac_device.
> 
> Changes since v1:
> - dt-bindings: Rewrite with DT schema.
> - Change return type of uniphier_xdmac_chan_init() to void,
>   and remove error return in probe.
> 
> Kunihiko Hayashi (2):
>   dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
>   dmaengine: uniphier-xdmac: Add UniPhier external DMA controller driver
> 
>  .../bindings/dma/socionext,uniphier-xdmac.yaml     |  63 +++
>  drivers/dma/Kconfig                                |  11 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/uniphier-xdmac.c                       | 611 +++++++++++++++++++++
>  4 files changed, 686 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
>  create mode 100644 drivers/dma/uniphier-xdmac.c
> 
> -- 
> 2.7.4

---
Best Regards,
Kunihiko Hayashi

