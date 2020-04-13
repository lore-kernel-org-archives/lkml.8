Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FAEC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6E720692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgDMNVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:21:00 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44627 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDMNU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:20:59 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EBBD9200006;
        Mon, 13 Apr 2020 13:20:51 +0000 (UTC)
Date:   Mon, 13 Apr 2020 15:20:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     cristian.birsan@microchip.com
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: at91: Add initial support for SAMA5D2-ICP
Message-ID: <20200413132051.GF3628@piout.net>
References: <20200410164320.7658-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410164320.7658-1-cristian.birsan@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2020 19:43:18+0300, cristian.birsan@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch series adds initial support for SAMA5D2 Industrial
> Communication Platform.
> 
> Codrin Ciubotariu (1):
>   dt-bindings: ARM: Document SAMA5D2-ICP
> 
> Cristian Birsan (1):
>   ARM: dts: at91: sama5d2-icp: add SAMA5D2-ICP
> 
>  .../devicetree/bindings/arm/atmel-at91.yaml   |   7 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/at91-sama5d2_icp.dts        | 797 ++++++++++++++++++
>  3 files changed, 805 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d2_icp.dts
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
