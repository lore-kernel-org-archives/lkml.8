Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867C2C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C75A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584319829;
	bh=MZc7oF3471k1hccW1atocrA0d/NQncNY/pnti0s5LzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z6f4JkEMTENw2fW/EoTqof6SdtVb9FVKoJO3yYvYbKKGCuB0z2LV3pyQk3eLLT1wN
	 DcGwmhLomIDt4Mctx0mXHxX3Pvv9esLQhxPG5ZwEN26YT7i8Oo1I6mnugJVlcyzjFX
	 nxy/Nn+GzJ7nQ7LNERHZf+pHuXOxyCSoB3DR9pgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgCPAu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgCPAu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 20:50:28 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1615205C9;
        Mon, 16 Mar 2020 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584319827;
        bh=MZc7oF3471k1hccW1atocrA0d/NQncNY/pnti0s5LzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmSkGTJqfSsEHrjGpbw7TCdn8y7Iv0YcJFmoX+d0AfoLbYxGQcuePcDkskovUoUTo
         RKgvFpbRrCnzDfxwWayahd4qLANc8a1bTEGr0ADs2qwax31sKHAAmtyBGmApMF6jN7
         h3SYM03EEE5ZZ5Lhn1O7Cru4zPo4UhXIjyM5jC/s=
Date:   Mon, 16 Mar 2020 08:50:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Heimpold <mhei@heimpold.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx23: introduce mmc0_sck_cfg
Message-ID: <20200316005019.GC17221@dragon>
References: <20200308222144.24863-1-mhei@heimpold.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308222144.24863-1-mhei@heimpold.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:21:44PM +0100, Michael Heimpold wrote:
> The Olimex Olinuxino board has a user led connected to SSP1_DETECT.
> But since this pin is listed in mmc0_pins_fixup, it is already claimed
> by MMC driver and this results in this error during boot:
> 
> [    1.390000] imx23-pinctrl 80018000.pinctrl: pin SSP1_DETECT already
>   requested by 80010000.spi; cannot claim for leds
> [    1.400000] imx23-pinctrl 80018000.pinctrl: pin-65 (leds) status -22
> [    1.410000] imx23-pinctrl 80018000.pinctrl: could not request pin 65
>    (SSP1_DETECT) from group led_gpio2_1.0  on device 80018000.pinctrl
> [    1.420000] leds-gpio leds: Error applying setting, reverse things back
> [    1.430000] leds-gpio: probe of leds failed with error -22
> 
> This fix it, introduce mmc0_sck_cfg and switch the Olinuxino board to it.
> 
> Signed-off-by: Michael Heimpold <mhei@heimpold.de>

Applied, thanks.
