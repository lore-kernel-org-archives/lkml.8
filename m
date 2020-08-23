Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C8C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA462078A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598191436;
	bh=EFE6jLBhE8IxwiWnVnZDQ7Ja0ooQMNmVgY6jo4NDWiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dgNavf81Bm19mmMbc7LbDqbcZDwRuwXBndcMJVDtheW0IrRMbV2Q+N6YHWKQWcj3K
	 lYX94lJkcK3UbCI9YBoKBXVlXX8bHU98hxGzoAYB8GjRDFE4dTGolQTRjuTFQoeovp
	 snUNwjUv4x5OA8Cs/xyWTbdtxLrp+jpJtsF/AO34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgHWODy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 10:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgHWODt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 10:03:49 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312FB206C0;
        Sun, 23 Aug 2020 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598191429;
        bh=EFE6jLBhE8IxwiWnVnZDQ7Ja0ooQMNmVgY6jo4NDWiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsSeugnElqiXFjOtTQ748aijFNETUw3KGWbIcsy7UZo9pqxwCmpmffSAYma5R/lDi
         BNw6CV+0c8GwnvLGLyEBw4SKlB9udN9H5NQj1nia8v75HIVQJGAm+tYz93n+rxVM5o
         IDE4kRvhz3j5CFIGOvPsG2m2GKD6+545ZEnWcGXQ=
Date:   Sun, 23 Aug 2020 19:33:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     kishon@ti.com, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 3/7] phy: tegra: xusb: Add USB2 pad power control
 support for Tegra210
Message-ID: <20200823140345.GP2639@vkoul-mobl>
References: <1595238948-20531-1-git-send-email-nkristam@nvidia.com>
 <1595238948-20531-4-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595238948-20531-4-git-send-email-nkristam@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 15:25, Nagarjuna Kristam wrote:
> Add USB2 pad power on and off API's for TEgra210 and provide its control
> via soc ops. It can be used by operations like charger detect to power on
> and off USB2 pad if needed.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V5:
>  - Made tegra210_usb2_pad_power_on() and tegra210_usb2_pad_power_down() static.
> ---
> V4:
>  - No changes
> ---
> V3:
>  - Added Acked-by updates to commit message.
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 190 ++++++++++++++++++++++++++------------
>  1 file changed, 133 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
> index 66bd461..2e5f71c 100644
> --- a/drivers/phy/tegra/xusb-tegra210.c
> +++ b/drivers/phy/tegra/xusb-tegra210.c
> @@ -994,6 +994,128 @@ static int tegra210_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
>  	return 0;
>  }
>  
> +static void tegra210_usb2_bias_pad_power_on(struct tegra_xusb_usb2_pad *pad)
> +{
> +	struct tegra_xusb_padctl *padctl = pad->base.padctl;
> +	u32 value;
> +
> +	if (pad->enable++ > 0)
> +		return;
> +
> +	dev_dbg(padctl->dev, "power on BIAS PAD & USB2 tracking\n");
> +
> +	if (clk_prepare_enable(pad->clk))
> +		dev_warn(padctl->dev, "failed to enable BIAS PAD & USB2 tracking\n");

do you want to proceed ahead even if clock is not enabled..?

> +
> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
> +	value &= ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK <<
> +		    XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT) |
> +		   (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_MASK <<
> +		    XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_SHIFT));
> +	value |= (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_VAL <<
> +		  XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT) |
> +		 (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_VAL <<
> +		  XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_SHIFT);

I recently found <linux/bitfield.h> I think this would look lot neater
if we use FIELD_PREP or u32_encode_bits() and you can drop shift defines

Since this is not new code but moved here, I will leave it upto you to
change this, either ways is fine by me.

-- 
~Vinod
