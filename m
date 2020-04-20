Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E7C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2795620724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="pHC4uN65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDTMdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:33:32 -0400
Received: from plaes.org ([188.166.43.21]:34990 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTMdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:33:31 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id CCE9A40A95;
        Mon, 20 Apr 2020 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1587385978; bh=dD6UJxueO7iBXUJ0MYPcRp2vcNvPimi5NJR2GD1gM1U=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=pHC4uN65eK9FrZlif52Y7dJqnVpm/59WYaZQDMSv2CworsbmtUgWCLLJw63uW7CCa
         NRaKKkAAT30qxnEYe2S44AL0KbginlGKs6+yg/JSgw3RUUmSb6n30S7J9AHpYYP/JW
         XSfFlEORgxc42MBi9xx1ud5zA1c1FwBCIkh/PLXG62ZIN8UYfuF08m9yJ47cD/iVCm
         SjoYpBF/EY3FeRvMYE7AjvKCcG0vjoIFLfeXBlhuU30eo9IM5obdRQXXOmzBOfAL/j
         QEKlBuWLji8Vj3e6k7jWE0QNmAIhrvYllmH/RV9plJhx3kThbDA4ckR10tHEfDM4hf
         tZ+IfhX2kx/iQ==
Date:   Mon, 20 Apr 2020 12:32:57 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/4] ARM: sun7i: Convert A20 GMAC driver to CCU
Message-ID: <20200420123257.GA18522@plaes.org>
References: <20200417221730.555954-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417221730.555954-1-plaes@plaes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 01:17:26AM +0300, Priit Laes wrote:
> This serie converts Allwinner A20 (sun7i) GMAC driver to CCU
> while still retaining compatibility with existing devicetrees.
> 
> First two patches contain preliminary work which convert
> sun4i/sun7i clock drivers to platform devices and creates regmap
> to access gmac register from the sun7i gmac driver.
> 
> Third patch implements syscon-based regmap to allow driver manage
> its own clock source.
> 
> Fourth patch updates the devicetree and drops the unused clocks.
> 
> While testing the driver I noticed following bugs with the existing
> sun7i gmac driver:
> - driver relies on u-boot for initialization (fixed in this
>   implementation)

Scratch that.. this is actually due to unhandled rx and tx delays,
which I "accidentally" fixed by copying the value BIT(12) from the
u-boot..

> - `systemctl restart networking` fails to bring the link up again.
> 
> 
> Priit Laes (4):
>   clk: sunxi-ng: a10/a20: rewrite init code to a platform driver
>   clk: sunxi-ng: a20: export a regmap to access the GMAC register
>   net: stmmac: dwmac-sunxi: Implement syscon-based clock handling
>   ARM: dts: sun7i: Use syscon-based implementation for gmac
> 
>  arch/arm/boot/dts/sun7i-a20.dtsi              |  36 +----
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.c          | 108 ++++++++++++---
>  .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 124 ++++++++++++++++--
>  3 files changed, 206 insertions(+), 62 deletions(-)
> 
> -- 
> 2.25.2
> 
