Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4269C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00720637
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgCTW7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:59:14 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35475 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCTW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:59:14 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5F7B724000B;
        Fri, 20 Mar 2020 22:59:12 +0000 (UTC)
Date:   Fri, 20 Mar 2020 23:59:11 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cristian.birsan@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: sama5d27_wlsom1_ek: add USB device node
Message-ID: <20200320225911.GU5504@piout.net>
References: <20200318104236.21114-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318104236.21114-1-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2020 12:42:36+0200, Eugen Hristev wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> Add USB device node for WLSoM1 EK and enable it.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> [eugen.hristev@microchip.com: ported to 5.4]
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
