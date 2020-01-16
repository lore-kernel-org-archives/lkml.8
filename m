Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B159C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9942176D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgAPItr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:49:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54644 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAPItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:49:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F332F2938AD
Subject: Re: [PATCH v3 2/3] arm64: dts: mt8173: add uart aliases
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <20200116051209.37970-1-hsinyi@chromium.org>
 <20200116051209.37970-3-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b53e1bab-2f0e-07f0-4540-810e34b81e48@collabora.com>
Date:   Thu, 16 Jan 2020 09:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200116051209.37970-3-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On 16/1/20 6:12, Hsin-Yi Wang wrote:
> Add serial as uart aliases in mt8173.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 8b4e806d5119..790cd64aa447 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -50,6 +50,10 @@ aliases {
>  		mdp_wdma0 = &mdp_wdma0;
>  		mdp_wrot0 = &mdp_wrot0;
>  		mdp_wrot1 = &mdp_wrot1;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
>  	};
>  
>  	cluster0_opp: opp_table0 {
> 
