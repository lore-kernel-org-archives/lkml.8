Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0946320CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgCSNHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:07:45 -0400
Received: from foss.arm.com ([217.140.110.172]:34986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgCSNHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:07:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DF1A30E;
        Thu, 19 Mar 2020 06:07:42 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAA7B3F534;
        Thu, 19 Mar 2020 06:07:37 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] phy: phy-rockchip-inno-usb2: remove support for
 rockchip, rk3366-usb2phy
To:     Johan Jonker <jbx6244@gmail.com>, kishon@ti.com
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200318192901.5023-1-jbx6244@gmail.com>
 <20200318192901.5023-2-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <233769c3-a44a-0ebd-7a2c-6fab17fb56f2@arm.com>
Date:   Thu, 19 Mar 2020 13:07:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318192901.5023-2-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2020-03-18 7:29 pm, Johan Jonker wrote:
> 'phy-rockchip-inno-usb2.txt' is updated to yaml, whereby
> the compatible string 'rockchip,rk3366-usb2phy' was removed,
> because it's not in use by a dts file, so remove support
> in the code as well.

Here's a DT using it:

https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot/dts/rockchip/rk3366.dtsi#L820

Please note that although DT bindings happen to be primarily maintained 
in the upstream kernel tree at the moment, it is mostly as a consequence 
of Linux being the source of most active development. Bindings should 
not be considered to be "owned" by upstream Linux since there are many 
other consumers, both downstream, and in completely different projects 
like the BSDs. As far as I'm aware there is still a long-term plan to 
eventually flip the switch and move maintenance to a standalone repo:

https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git

Things like PCI Device IDs and ACPI HIDs aren't even documented as 
formally as DT bindings, so by the reasoning here we could arguably 
delete the majority of drivers from the kernel...

Robin.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 --------------------
>   1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 680cc0c88..dcdb5589b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1299,25 +1299,6 @@ static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
>   	{ /* sentinel */ }
>   };
>   
> -static const struct rockchip_usb2phy_cfg rk3366_phy_cfgs[] = {
> -	{
> -		.reg = 0x700,
> -		.num_ports	= 2,
> -		.clkout_ctl	= { 0x0724, 15, 15, 1, 0 },
> -		.port_cfgs	= {
> -			[USB2PHY_PORT_HOST] = {
> -				.phy_sus	= { 0x0728, 15, 0, 0, 0x1d1 },
> -				.ls_det_en	= { 0x0680, 4, 4, 0, 1 },
> -				.ls_det_st	= { 0x0690, 4, 4, 0, 1 },
> -				.ls_det_clr	= { 0x06a0, 4, 4, 0, 1 },
> -				.utmi_ls	= { 0x049c, 14, 13, 0, 1 },
> -				.utmi_hstdet	= { 0x049c, 12, 12, 0, 1 }
> -			}
> -		},
> -	},
> -	{ /* sentinel */ }
> -};
> -
>   static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
>   	{
>   		.reg		= 0xe450,
> @@ -1426,7 +1407,6 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
>   	{ .compatible = "rockchip,px30-usb2phy", .data = &rk3328_phy_cfgs },
>   	{ .compatible = "rockchip,rk3228-usb2phy", .data = &rk3228_phy_cfgs },
>   	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
> -	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
>   	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
>   	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
>   	{}
> 
