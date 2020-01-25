Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E09A24690
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="K3SyMX5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgAYKqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:31 -0500
Received: from onstation.org ([52.200.56.107]:46808 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbgAYKq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:46:26 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id C7F323EA42;
        Sat, 25 Jan 2020 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1579949186;
        bh=20OLpT9AQImoBtwxHWnQUH6B+FTQGj1F0WZXTR5Jw4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3SyMX5cFR0sr1VBUvV0khHYzaXHHW/So/Kx2ccr2Yv2fYzu7jfEfFzybpz850Oov
         N5vmlOnIY3GOaFALeSK5M2fqmHFVBybX8GzsQhb5lsaQiq5c/jSRoAH0xGLFwEABuN
         3ktfx6GbKoZhHN46ngr80N0fqG38WVmUDdSV49Ko=
Date:   Sat, 25 Jan 2020 05:46:25 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: qcom_defconfig: Enable QRTR
Message-ID: <20200125104625.GB5646@onstation.org>
References: <20191104210943.101393-1-luca@z3ntu.xyz>
 <20191104210943.101393-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104210943.101393-2-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, Nov 04, 2019 at 10:09:41PM +0100, Luca Weiss wrote:
> This option is useful on msm8974, so enable it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index 94d5e1a8c61a..a71201fdc8c9 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -45,6 +45,8 @@ CONFIG_IP_ROUTE_VERBOSE=y
>  CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
>  # CONFIG_IPV6 is not set
> +CONFIG_QRTR=y
> +CONFIG_QRTR_SMD=y

Both of these should be modules. I verified on the Nexus 5 that booting
the modem works in this configuration.

Thanks for your work on the modem!

Brian

>  CONFIG_CFG80211=m
>  CONFIG_MAC80211=m
>  CONFIG_RFKILL=y
> -- 
> 2.23.0
> 
