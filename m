Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A07C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0189F20853
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgESM1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:27:32 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:62245 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgESM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:27:32 -0400
X-Originating-IP: 90.65.91.255
Received: from localhost (lfbn-lyo-1-1912-bdcst.w90-65.abo.wanadoo.fr [90.65.91.255])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C0A5540014;
        Tue, 19 May 2020 12:27:23 +0000 (UTC)
Date:   Tue, 19 May 2020 14:27:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: sama5d2_xplained: Add aliases for the
 dedicated I2C IPs
Message-ID: <20200519122723.GE5193@piout.net>
References: <20200518114802.253660-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518114802.253660-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2020 11:49:21+0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sama5d2 SoC has two dedicated I2C IPs that are enabled on
> sama5d2_xplained. Add alias for the i2c devices to not rely on
> probe order for the i2c device numbering.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
