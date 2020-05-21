Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D154C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A68207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEULst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:48:49 -0400
Received: from foss.arm.com ([217.140.110.172]:45072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgEULst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:48:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A938E30E;
        Thu, 21 May 2020 04:48:48 -0700 (PDT)
Received: from [10.57.0.164] (unknown [10.57.0.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C46A3F52E;
        Thu, 21 May 2020 04:48:47 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: dts: rockchip: fix dmas dma-names for rk3308
 i2s node
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200520064816.3954-1-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <543270ad-dd11-2bd4-8959-e898834c19e5@arm.com>
Date:   Thu, 21 May 2020 12:48:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520064816.3954-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20 07:48, Johan Jonker wrote:
> One of the current rk3308 'i2s' nodes has a different dma layout
> with only 1 item. Table 9-2 DMAC1 Request Mapping Table shows that
> there 2 dma sources available, so fix the dmas and dma-names
> for the rk3308 'i2s' node.
> 
> 10 I2S/PCM_2CH_1 tx High level
> 11 I2S/PCM_2CH_1 rx High level

...however table 1-5 in the same manual (at least that I could find) 
says request 10 is reserved. Does that mean it was intended to be wired 
up for this, but ended up broken for some reason?

Do you have hardware to confirm whether this works reliably or not?

Robin.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index ac7f69407..79c1dd1fe 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -564,8 +564,8 @@
>   		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&cru SCLK_I2S1_2CH>, <&cru HCLK_I2S1_2CH>;
>   		clock-names = "i2s_clk", "i2s_hclk";
> -		dmas = <&dmac1 11>;
> -		dma-names = "rx";
> +		dmas = <&dmac1 10>, <&dmac1 11>;
> +		dma-names = "tx", "rx";
>   		resets = <&cru SRST_I2S1_2CH_M>, <&cru SRST_I2S1_2CH_H>;
>   		reset-names = "reset-m", "reset-h";
>   		status = "disabled";
> 
