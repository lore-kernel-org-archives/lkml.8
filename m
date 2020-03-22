Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D877BC4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A994C20722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZAlZvIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCVPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:45:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40733 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCVPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:45:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so13528679wrw.7;
        Sun, 22 Mar 2020 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oW0vYewmMm0M3PXQVGqM0DMXOo8Xcl8P8bGj8WAcz1s=;
        b=UZAlZvIAW51LULMnDZHiLUIyOPiuB672JgdsY9xSfZmPxy9rSKsc2mRMp26i4Uv2Nm
         ByT7sJUTHNxolCeVb7eNDxWXO1BvR6+ZwFHcZxr9gHN8Vkac3Zd3B7DKjYykBp+GOABq
         T74BZntD5uAnvoQ3JlOfihftY9JeoXu0n8g6YdqPErGdkWIDmsNJGUTZ/a3m5CxP8t2f
         Wm2stFjip8ht8zH3nq0kba+vMB8i4avKJsePBOY2kIopk/amvbvEc0TAZ5aYMYUUOGy5
         4i9GaJXboD41m6m6h13rDonxBTFGTwN3i/luyjrBH1qfV3/xg4s6v2qj0j3nvvecqnqc
         H30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oW0vYewmMm0M3PXQVGqM0DMXOo8Xcl8P8bGj8WAcz1s=;
        b=CL3sedT7VEknCpNeMvkdx1/+DCGsFYOpByiT7OdWRWAWOi6kC//616DKbFQ8pXrmf0
         A+aY50IAB8TaMNV/cPIC9uQJ5kozk/rTdIyvrVKl/VGBxhwKBgwKKwY1fbfEyoYrD1bo
         D9Rva1qIV18oDzeq5fmT+gyniWhtCnkJLFlAk6v84TvWrGns7dsiKgyZpVkQz+GA1nD0
         wRdh8vUnb9FiDEhTkDt+/3lpTxEthMSVLXN64ClvRZuBZVo3mBxM5Ax2FIzc1NogcMKq
         u2rCzKn2V4AzFjLEzxgcAKP2/yYQ9uHighLRSKfTAOST5xu8GsQYEsDGdCDRcbYxEIuO
         VL0w==
X-Gm-Message-State: ANhLgQ2mH4miXCQa/BObQPXSB1kRry/XdGv4i7zBK42OHC2/U4pAMINY
        btNQwGzVuRGI+JV1gPXiP6Y=
X-Google-Smtp-Source: ADFU+vuLfqJLTVWgtE2gxmF3zyW7/5g33LYY933B6JEG7gw8iL8V704y0dGVTMbKy7oXYEW3aN89ag==
X-Received: by 2002:adf:e60b:: with SMTP id p11mr23245914wrm.140.1584891942005;
        Sun, 22 Mar 2020 08:45:42 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x17sm17685351wmi.28.2020.03.22.08.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 08:45:41 -0700 (PDT)
To:     jbx6244@gmail.com
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org
References: <20200322140046.5824-1-jbx6244@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix defines in pd_vio node for
 rk3399
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <48a91cc1-7751-4df0-a2cd-940eb829fa16@gmail.com>
Date:   Sun, 22 Mar 2020 16:45:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200322140046.5824-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The RK3399 TRM uses both

'pd_tcpc0, pd_tcpc1'

as

'pd_tcpd0, pd_tcpd1'.

What should we use here?

Thanks.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 8aac201f0..3dc8fe620 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1087,12 +1087,12 @@
>  					pm_qos = <&qos_isp1_m0>,
>  						 <&qos_isp1_m1>;
>  				};
> -				pd_tcpc0@RK3399_PD_TCPC0 {
> +				pd_tcpc0@RK3399_PD_TCPD0 {
>  					reg = <RK3399_PD_TCPD0>;
>  					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
>  						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
>  				};
> -				pd_tcpc1@RK3399_PD_TCPC1 {
> +				pd_tcpc1@RK3399_PD_TCPD1 {
>  					reg = <RK3399_PD_TCPD1>;
>  					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
>  						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
> -- 
> 2.11.0

