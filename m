Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A232080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgHROxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:53:40 -0400
Received: from foss.arm.com ([217.140.110.172]:42834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHROxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:53:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908A631B;
        Tue, 18 Aug 2020 07:53:33 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4F253F66B;
        Tue, 18 Aug 2020 07:53:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] usb: dwc3: of-simple: Add compatible for rk3328
To:     travelvia@airmail.cc, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Cameron Nemo <cnemo@tutanota.com>
References: <20200817031114.6107-1-travelvia@airmail.cc>
 <20200817031114.6107-2-travelvia@airmail.cc>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8dd853c0-c908-9d2f-fabf-c8f4c97b37e1@arm.com>
Date:   Tue, 18 Aug 2020 15:53:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817031114.6107-2-travelvia@airmail.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 04:11, travelvia@airmail.cc wrote:
> From: Cameron Nemo <cnemo@tutanota.com>
> 
> Add a compatible to be hooked into by the Rockchip rk3328 device tree.
> 
> The rk3399 compatible cannot be reused because the rk3328 SoCs may
> require a specialized driver in the future, and old device trees must
> remain compatible with newer kernels.
> 
> Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
> ---
>   drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index 7df115012935..68d6e4fa0c6a 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>   	 * Some controllers need to toggle the usb3-otg reset before trying to
>   	 * initialize the PHY, otherwise the PHY times out.
>   	 */
> -	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
> +	if (of_device_is_compatible(np, "rockchip,rk3328-dwc3") ||

Is this necessary? Even downstream there's no reset control in the DT, 
so I can't see that it achieves anything.

Robin.

> +	    of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
>   		simple->need_reset = true;
>   
>   	simple->resets = of_reset_control_array_get(np, false, true,
> @@ -171,6 +172,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
>   };
>   
>   static const struct of_device_id of_dwc3_simple_match[] = {
> +	{ .compatible = "rockchip,rk3328-dwc3" },
>   	{ .compatible = "rockchip,rk3399-dwc3" },
>   	{ .compatible = "xlnx,zynqmp-dwc3" },
>   	{ .compatible = "cavium,octeon-7130-usb-uctl" },
> 
