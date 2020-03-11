Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA0C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF8F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583907148;
	bh=vamP7d+KnGr3p/Y17yl3FP+noKI2Kol6BSNnY5Hhrdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ibOPF6qGhxX+SnvX8RT62Mdj+a9U+WPuS7sGyKa5FNfooWZWUI8KPZl0XRYr0OnuR
	 8baxkUlWwfMolsqRB0s0R1rehY0NRmBRakVnBy1cAY0HBEnQqP6EPfq3YDbVEXPwpR
	 P3aBYGZOmenTwM7UCeTgKlCDqFCIxJFnAg4jYWeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgCKGM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKGMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:12:25 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9CA208C4;
        Wed, 11 Mar 2020 06:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583907145;
        bh=vamP7d+KnGr3p/Y17yl3FP+noKI2Kol6BSNnY5Hhrdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSsAwIOZyHa/yhRXc4BWgxfY/x1VkRyVWZyUUjUoiDxRASFO77bfNYrekZ7ggUxzZ
         +8h2ItRnouwujq5NTCwhtxtfjjCto/ERQInWTzSF3vukyP5VbnXLSOAp3XlC8d1hyV
         FiWOcVGLr2te0d1TpV0LLJ1XwxqvMLcVj4fMUuAU=
Date:   Wed, 11 Mar 2020 14:12:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
Message-ID: <20200311061220.GB29269@dragon>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-8-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582585690-463-8-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 05:08:02PM -0600, Li Yang wrote:
> Enables the generic QorIQ cpufreq driver to support frequency scaling
> for various QorIQ SoCs.  Enabled as built-in as it is a core feature.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e97ef8b944b8..996dc749ea5c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -90,6 +90,7 @@ CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
>  CONFIG_ARM_QCOM_CPUFREQ_HW=y
>  CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
> +CONFIG_QORIQ_CPUFREQ=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
>  CONFIG_INTEL_STRATIX10_SERVICE=y
> @@ -722,7 +723,6 @@ CONFIG_COMMON_CLK_RK808=y
>  CONFIG_COMMON_CLK_SCPI=y
>  CONFIG_COMMON_CLK_CS2000_CP=y
>  CONFIG_COMMON_CLK_S2MPS11=y
> -CONFIG_CLK_QORIQ=y

Why is this getting removed?

Shawn

>  CONFIG_COMMON_CLK_PWM=y
>  CONFIG_CLK_RASPBERRYPI=m
>  CONFIG_CLK_IMX8MM=y
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
