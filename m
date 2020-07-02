Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9982065F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgGBOih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:38:37 -0400
Received: from foss.arm.com ([217.140.110.172]:58548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15A531B;
        Thu,  2 Jul 2020 07:38:35 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66DA13F68F;
        Thu,  2 Jul 2020 07:38:33 -0700 (PDT)
Subject: Re: [PATCH] usb: host: ohci-platform: Disable ohci for rk3288
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        mylene.josserand@collabora.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
References: <20200702090504.36670-1-jagan@amarulasolutions.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f0ae5915-9cb8-9550-f05c-6cebad191a14@arm.com>
Date:   Thu, 2 Jul 2020 15:38:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702090504.36670-1-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02 10:05, Jagan Teki wrote:
> rk3288 has usb host0 ohci controller but doesn't actually work
> on real hardware but it works with new revision chip rk3288w.
> 
> So, disable ohci for rk3288.
> 
> For rk3288w chips the compatible update code is handled by bootloader.
> 
> Cc: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note:
> - U-Boot patch for compatible update
> https://patchwork.ozlabs.org/project/uboot/patch/20200702084820.35942-1-jagan@amarulasolutions.com/
> 
>   drivers/usb/host/ohci-platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 7addfc2cbadc..24655ed6a7e0 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -96,7 +96,7 @@ static int ohci_platform_probe(struct platform_device *dev)
>   	struct ohci_hcd *ohci;
>   	int err, irq, clk = 0;
>   
> -	if (usb_disabled())
> +	if (usb_disabled() || of_machine_is_compatible("rockchip,rk3288"))

This seems unnecessary to me - if we've even started probing a driver 
for a broken piece of hardware to the point that we need magic checks to 
bail out again, then something is already fundamentally wrong.

Old boards only sold with the original SoC variant have no reason to 
enable the OHCI (since it never worked originally), thus will never 
execute this check.

New boards designed around the W variant to make use of the OHCI can 
freely enable it either way.

The only relative-edge-case where it might matter is older board designs 
still in production which have shipped with both SoC variants. Enabling 
OHCI can't be *necessary* given that it's still broken on a lot of 
deployed boards, so at best it must be an opportunistic nice-to-have. 
Since we're already having to rely on the bootloader to patch up the 
devicetree for other low-level differences in this case, it should be 
part of that responsibility for it to only enable the OHCI on the 
appropriate SoC variant too. Statically enabling it in the DTS for a 
board where it may well not work is just bad.

As soon as a DTB with a broken piece of hardware enabled gets passed to 
an OS, then the damage is already done. A driver patch in a future 
version of Linux that magically knows better and ignores it isn't going 
to help a user booting an older kernel image, or some other OS entirely.

Robin.

>   		return -ENODEV;
>   
>   	/*
> 
