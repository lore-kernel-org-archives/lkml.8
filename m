Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DB8206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgENPW5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:22:57 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56501 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:22:56 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 24BF41BF20E;
        Thu, 14 May 2020 15:22:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200324104918.29578-1-hhhawa@amazon.com>
References: <20200324104918.29578-1-hhhawa@amazon.com>
Cc:     devicetree@vger.kernel.org, benh@amazon.com,
        linux-kernel@vger.kernel.org, hanochu@amazon.com,
        dwmw@amazon.co.uk, jonnyc@amazon.com, ronenk@amazon.com,
        talel@amazon.com, linux-arm-kernel@lists.infradead.org
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     hhhawa@amazon.com, robh+dt@kernel.org, tsahee@annapurnalabs.com,
        arm@kernel.org
Subject: Re: [PATCH v5 0/6] Amazon's Annapurna Labs Alpine v3 device-tree
Message-ID: <158946977180.3480.12435085393834819053@kwain>
Date:   Thu, 14 May 2020 17:22:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding arm-soc]

Hi Hanna,

Sorry for the delay, the series was buried in my mails...

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Arnd, Olof, could you take this series directly as this will be the only
Alpine patches for this release (and for a long time)?

Thanks!
Antoine

Quoting Hanna Hawa (2020-03-24 11:49:12)
> This series organize the Amazon's Annapurna Labs Alpine device tree
> bindings, device tree folder and adds new device tree for Alpine v3.
> 
> Changes since v4:
> -----------------
> - Re-order nodes in increasing order.
> - Add disable to UART nodes.
> - Add missing UART nodes (1,2,3)
> - Add comments for GIC/UART
> - Add io-fabric bus, and move uart nodes into it.
> - Fix MSIx range according Alpine function spec
> 
> Changes since v3:
> -----------------
> - rebased and retested for tag Linux 5.6-rc2
> 
> Changes since v2:
> -----------------
> - Move up a level for DT node without mmio regs.
> - Drop device_type from serial@fd883000 node.
> - Minor change name of PCIe node to: pcie@fbd00000
> 
> Changes since v1:
> -----------------
> - Rename al,alpine DT binding to amazon,alpine
> - Rename al folder to be amazon
> - Update maintainers of amazon,alpine DT
> - Add missing alpine-v2 DT binding
> - Fix yaml schemas for alpine-v3-evp.dts:
>         - #size-cells:0:0: 0 is not one of [1, 2]
>         - arch-timer: interrupts: [[1, 13, 8, 1, 14, 8, 1, 11, 8, 1, 10,
>         8]] is too short
> - Change compatible string of alpine-v3-evp to amazon,al
> 
> Hanna Hawa (5):
>   dt-bindings: arm: amazon: rename al,alpine DT binding to amazon,al
>   arm64: dts: amazon: rename al folder to be amazon
>   dt-bindings: arm: amazon: update maintainers of amazon,al DT bindings
>   dt-bindings: arm: amazon: add missing alpine-v2 DT binding
>   dt-bindings: arm: amazon: add Amazon Annapurna Labs Alpine V3
> 
> Ronen Krupnik (1):
>   arm64: dts: amazon: add Amazon's Annapurna Labs Alpine v3 support
> 
>  .../devicetree/bindings/arm/al,alpine.yaml    |  21 -
>  .../devicetree/bindings/arm/amazon,al.yaml    |  33 ++
>  MAINTAINERS                                   |   2 +-
>  arch/arm64/boot/dts/Makefile                  |   2 +-
>  arch/arm64/boot/dts/{al => amazon}/Makefile   |   1 +
>  .../boot/dts/{al => amazon}/alpine-v2-evp.dts |   0
>  .../boot/dts/{al => amazon}/alpine-v2.dtsi    |   0
>  arch/arm64/boot/dts/amazon/alpine-v3-evp.dts  |  24 ++
>  arch/arm64/boot/dts/amazon/alpine-v3.dtsi     | 408 ++++++++++++++++++
>  9 files changed, 468 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/amazon,al.yaml
>  rename arch/arm64/boot/dts/{al => amazon}/Makefile (64%)
>  rename arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts (100%)
>  rename arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi (100%)
>  create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
>  create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> 
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
