Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFD0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D78207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgEOO6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:58:54 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:26615 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgEOO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:58:51 -0400
X-Originating-IP: 90.65.91.255
Received: from localhost (lfbn-lyo-1-1912-bdcst.w90-65.abo.wanadoo.fr [90.65.91.255])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BAC78240089;
        Fri, 15 May 2020 14:58:49 +0000 (UTC)
Date:   Fri, 15 May 2020 16:58:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: Configure I2C SCL gpio as open drain
Message-ID: <20200515145849.GV34497@piout.net>
References: <20200515140001.287932-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515140001.287932-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 17:00:01+0300, Codrin Ciubotariu wrote:
> The SCL gpio pin used by I2C bus for recovery needs to be configured as
> open drain.
> 
> Fixes: 455fec938bbb ("ARM: dts: at91: sama5d2: add i2c gpio pinctrl")
> Fixes: a4bd8da893a3 ("ARM: dts: at91: sama5d3: add i2c gpio pinctrl")
> Fixes: 8fb82f050cf6 ("ARM: dts: at91: sama5d4: add i2c gpio pinctrl")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   | 6 +++---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 6 +++---
>  arch/arm/boot/dts/sama5d3.dtsi              | 6 +++---
>  arch/arm/boot/dts/sama5d4.dtsi              | 6 +++---
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 

Applied, thanks. There was a small conflict in the sama5d2 board dts,
please check.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
