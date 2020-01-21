Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78801207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAUO5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:57:01 -0500
Received: from foss.arm.com ([217.140.110.172]:44364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgAUO5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:57:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0F0330E;
        Tue, 21 Jan 2020 06:57:00 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D725C3F52E;
        Tue, 21 Jan 2020 06:56:59 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: fix px30 lvds ports
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
References: <20200121134510.3893487-1-heiko@sntech.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1cd15d49-3c4f-6da2-4d4f-0414dd6d6adc@arm.com>
Date:   Tue, 21 Jan 2020 14:56:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200121134510.3893487-1-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2020 1:45 pm, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The lvds controller has two ports. port@0 for the connection
> to the display controller(s) and port@1 for the connection to
> the panel, so should have a ports node covering the port@x nodes.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>   arch/arm64/boot/dts/rockchip/px30.dtsi | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> index 9b1c92132007..37e014444214 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -421,19 +421,24 @@ lvds: lvds {
>   			rockchip,output = "lvds";
>   			status = "disabled";

FWIW, the main node's "#{address,size}-cells" properties above here 
should now be unnecessary too.

Robin.

>   
> -			port@0 {
> -				reg = <0>;
> +			ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> -				lvds_vopb_in: endpoint@0 {
> +				port@0 {
>   					reg = <0>;
> -					remote-endpoint = <&vopb_out_lvds>;
> -				};
> -
> -				lvds_vopl_in: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_lvds>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					lvds_vopb_in: endpoint@0 {
> +						reg = <0>;
> +						remote-endpoint = <&vopb_out_lvds>;
> +					};
> +
> +					lvds_vopl_in: endpoint@1 {
> +						reg = <1>;
> +						remote-endpoint = <&vopl_out_lvds>;
> +					};
>   				};
>   			};
>   		};
> 
