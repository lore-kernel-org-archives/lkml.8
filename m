Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDFCC10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AC02063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgDBHtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:49:09 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58055 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgDBHtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:49:08 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A2FC5200014;
        Thu,  2 Apr 2020 07:49:05 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:49:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     nicolas.ferre@microchip.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tudor.Ambarus@microchip.com,
        Cristian.Birsan@microchip.com, Codrin.Ciubotariu@microchip.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM: dts: at91: sama5d2_ptc_ek: fix sdmmc0 node
 description
Message-ID: <20200402074905.GA3683@piout.net>
References: <20200401221504.41196-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401221504.41196-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2020 00:15:00+0200, Ludovic Desroches wrote:
> Remove non-removable and mmc-ddr-1_8v properties from the sdmmc0
> node which come probably from an unchecked copy/paste.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Fixes:42ed535595ec "ARM: dts: at91: introduce the sama5d2 ptc ek board"
> Cc: stable@vger.kernel.org # 4.19 and later
> ---
>  arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 2 --
>  1 file changed, 2 deletions(-)
> 

All applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
