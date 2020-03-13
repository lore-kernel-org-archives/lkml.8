Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1DCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF6D205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCMUcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:32:41 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38441 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCMUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:32:41 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DC712C0003;
        Fri, 13 Mar 2020 20:32:38 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Maciej Nowak <tmn505@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: marvell: espressobin: indicate dts version
In-Reply-To: <20200227164842.11116-1-tmn505@gmail.com>
References: <20200227164842.11116-1-tmn505@gmail.com>
Date:   Fri, 13 Mar 2020 21:32:38 +0100
Message-ID: <8736acyp09.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

> The commit introducing ESPRESSObin variants didn't specify dts version,
> and because of that they are treated by dtc as legacy ones. Fix that by
> properly specifying version in each dts.
>
> Fixes: 447b878935 ("arm64: dts: marvell: add ESPRESSObin variants")
> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts    | 2 ++
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 ++
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 ++
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi        | 2 --
>  4 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> index bd9ed9dc9c3e..ec72a11ed80f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> @@ -11,6 +11,8 @@
>   * Schematic available at http://espressobin.net/wp-content/uploads/2017/08/ESPRESSObin_V5_Schematics.pdf
>   */
>  
> +/dts-v1/;
> +
>  #include "armada-3720-espressobin.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 6e876a6d9532..03733fd92732 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -11,6 +11,8 @@
>   * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
>   */
>  
> +/dts-v1/;
> +
>  #include "armada-3720-espressobin.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index 0f8405d085fd..8570c5f47d7d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -11,6 +11,8 @@
>   * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
>   */
>  
> +/dts-v1/;
> +
>  #include "armada-3720-espressobin.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 53b8ac55a7f3..c8e2e993c69c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -7,8 +7,6 @@
>   *
>   */
>  
> -/dts-v1/;
> -
>  #include <dt-bindings/gpio/gpio.h>
>  #include "armada-372x.dtsi"
>  
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
