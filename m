Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B8BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A40A2077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgGUCoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:44:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgGUCoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:44:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6FE68FAD4C1F2E7FF75C;
        Tue, 21 Jul 2020 10:44:01 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 10:43:59 +0800
Subject: Re: [PATCH] ARM: dts: hisilicon: Align L2 cache-controller nodename
 with dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200626080637.4191-1-krzk@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F16566F.1010807@hisilicon.com>
Date:   Tue, 21 Jul 2020 10:43:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200626080637.4191-1-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2020/6/26 16:06, Krzysztof Kozlowski wrote:
> Fix dtschema validator warnings like:
>     l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks!
Applied to the hisilicon arm32 dt tree.

Best Regards,
Wei

> ---
>  arch/arm/boot/dts/hi3620.dtsi     | 2 +-
>  arch/arm/boot/dts/hisi-x5hd2.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
> index 9c207a690df5..f0af1bf2b4d8 100644
> --- a/arch/arm/boot/dts/hi3620.dtsi
> +++ b/arch/arm/boot/dts/hi3620.dtsi
> @@ -71,7 +71,7 @@
>  		interrupt-parent = <&gic>;
>  		ranges = <0 0xfc000000 0x2000000>;
>  
> -		L2: l2-cache {
> +		L2: cache-controller {
>  			compatible = "arm,pl310-cache";
>  			reg = <0x100000 0x100000>;
>  			interrupts = <0 15 4>;
> diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> index 696e6982a688..3ee7967c202d 100644
> --- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
> +++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> @@ -381,7 +381,7 @@
>  			interrupts = <1 13 0xf01>;
>  		};
>  
> -		l2: l2-cache {
> +		l2: cache-controller {
>  			compatible = "arm,pl310-cache";
>  			reg = <0x00a10000 0x100000>;
>  			interrupts = <0 15 4>;
> 
