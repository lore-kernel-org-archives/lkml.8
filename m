Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37C7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D2020FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFQV2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:28:04 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39991 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQV2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:28:04 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7FCD9FF804;
        Wed, 17 Jun 2020 21:27:58 +0000 (UTC)
Date:   Wed, 17 Jun 2020 23:27:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH 1/3] ARM: dts: at91: sama5d2_xplained: classd: pull-down
 the R1 and R3 lines
Message-ID: <20200617212758.GD3675@piout.net>
References: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2020 12:55:23+0300, Codrin Ciubotariu wrote:
> The R1 and R3 lines drive NMOS transistors that are OFF with a low level.
> On the SAMA5D2 Xplained board, if the pins corresponding to R1 and R3
> have pull-ups enabled, there is an extra 2 x 30uA power consumption.
> Use pull-downs for these 2 lines to remove the unnecessary power
> consumption.
> 
> Fixes: b133ca7a653c ("ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
