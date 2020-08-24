Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51436C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E09D207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgHXVBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:01:22 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:51508 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:01:21 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2020 17:01:19 EDT
Received: from [172.17.0.6] (37-247-245-190.fibertel.com.ar [190.245.247.37])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPSA id B81627B3207;
        Mon, 24 Aug 2020 17:54:03 -0300 (-03)
Subject: Re: [linux-sunxi] [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra:
 Fix dcdc1 regulator
To:     jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, icenowy@aosc.io, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200824193649.978197-1-jernej.skrabec@siol.net>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <a25ee214-5316-f6c8-53ce-676aa3c8a8ca@centosproject.org>
Date:   Mon, 24 Aug 2020 17:54:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824193649.978197-1-jernej.skrabec@siol.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: B81627B3207.A21CE
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-5.15, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90, NICE_REPLY_A -2.25)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/8/20 16:36, Jernej Skrabec wrote:
> DCDC1 regulator powers many different subsystems. While some of them can
> work at 3.0 V, some of them can not. For example, VCC-HDMI can only work
> between 3.24 V and 3.36 V. According to OS images provided by the board
> manufacturer this regulator should be set to 3.3 V.
>
> Set DCDC1 and DCDC1SW to 3.3 V in order to fix this.
>
> Fixes: da7ac948fa93 ("ARM: dts: sun8i: Add board dts file for Banana Pi M2
> 		      Ultra")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>   arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 42d62d1ba1dc..ea15073f0c79 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -223,16 +223,16 @@ &reg_aldo3 {
>   };
>   
>   &reg_dc1sw {
> -	regulator-min-microvolt = <3000000>;
> -	regulator-max-microvolt = <3000000>;
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
>   	regulator-name = "vcc-gmac-phy";
>   };
>   
>   &reg_dcdc1 {
>   	regulator-always-on;
> -	regulator-min-microvolt = <3000000>;
> -	regulator-max-microvolt = <3000000>;
> -	regulator-name = "vcc-3v0";
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-3v3";
>   };
>   
>   &reg_dcdc2 {


Should this be done also for the bananapi-m2-berry?, it is basically the 
same device
sun8i-v40-bananapi-m2-berry.dts


Pablo

