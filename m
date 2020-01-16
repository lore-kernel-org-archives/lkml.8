Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC4C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FB22075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgAPNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:52:12 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44655 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:52:12 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D60D2C0019;
        Thu, 16 Jan 2020 13:52:08 +0000 (UTC)
Date:   Thu, 16 Jan 2020 14:52:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        a.zummo@towertech.it, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Sandeep Sheriker Mallikarjun 
        <sandeepsheriker.mallikarjun@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v4 5/5] ARM: dts: at91: sam9x60: add device tree for soc
 and board
Message-ID: <20200116135208.GG100374@piout.net>
References: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
 <1579085987-13976-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579085987-13976-6-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2020 12:59:47+0200, Claudiu Beznea wrote:
> From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> 
> Add device tree files for SAM9X60 SoC and SAM9X60-EK board.
> 
> Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  arch/arm/boot/dts/Makefile           |   2 +
>  arch/arm/boot/dts/at91-sam9x60ek.dts | 647 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/sam9x60.dtsi       | 691 +++++++++++++++++++++++++++++++++++
>  3 files changed, 1340 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sam9x60ek.dts
>  create mode 100644 arch/arm/boot/dts/sam9x60.dtsi
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
