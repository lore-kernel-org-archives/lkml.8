Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2109C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A559921775
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o4b8Fvsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgCCQy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:54:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgCCQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=0h9eZXUbT/+wZn18IzVeTxSKw0VaeM+576oP9khRe6o=; b=o4b8FvszcUQVJsc7FTwT0eGsg2
        8IGAsPOmZEt3I7SeQ1YmMBj/ZGYGdXT9eTMWdDnusCnGWhT7wWB7fwX5ygtZL/FKfGUU70EidZkIZ
        7HQywX5V/rCqHkxjrPXBYVJ4jmZ7/XKBvA/SfBcJW7m68jJk9MqVg8rGu9VJqLKcYjTv7G2OWc/cQ
        ono48DKQUjNB59qUvXs3PDRsi1sCWSLPNy3Nr+Agttxw3T8gc5PV3R9vYg6Vi1WlqdapXMz2flidi
        HlTiTw6+5t6dO8uQIx5IwhrlLwVN1B84IkJeEihitV7XkAm5UMP8rwAWyNWFZNWZwuR+ntBNTb/S8
        r0NMFSOg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9AoX-0004ah-2t; Tue, 03 Mar 2020 16:54:37 +0000
Subject: Re: [PATCH] ASoC: amd: AMD RV RT5682 should depends on CROS_EC
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>
References: <20200303110514.3267126-1-enric.balletbo@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3e34a902-2a7c-c13c-d569-9d6479a65627@infradead.org>
Date:   Tue, 3 Mar 2020 08:54:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303110514.3267126-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 3:05 AM, Enric Balletbo i Serra wrote:
> If SND_SOC_AMD_RV_RT5682_MACH=y, below kconfig and build errors can be seen:
> 
>  WARNING: unmet direct dependencies detected for SND_SOC_CROS_EC_CODEC
>  WARNING: unmet direct dependencies detected for I2C_CROS_EC_TUNNEL
> 
>  ld: drivers/i2c/busses/i2c-cros-ec-tunnel.o: in function `ec_i2c_xfer':
>  i2c-cros-ec-tunnel.c:(.text+0x2fc): undefined reference to `cros_ec_cmd_xfer_status'
>  ld: sound/soc/codecs/cros_ec_codec.o: in function `wov_host_event':
>  cros_ec_codec.c:(.text+0x4fb): undefined reference to `cros_ec_get_host_event'
>  ld: sound/soc/codecs/cros_ec_codec.o: in function `send_ec_host_command':
>  cros_ec_codec.c:(.text+0x831): undefined reference to `cros_ec_cmd_xfer_status'
> 
> This is because it will select SND_SOC_CROS_EC_CODEC and I2c_CROS_EC_TUNNEL but
> both depends on CROS_EC.
> 
> Fixes: 6b8e4e7db3cd ("ASoC: amd: Add machine driver for Raven based platform")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> 
>  sound/soc/amd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index b29ef1373946..bce4cee5cb54 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -33,6 +33,6 @@ config SND_SOC_AMD_RV_RT5682_MACH
>  	select SND_SOC_MAX98357A
>  	select SND_SOC_CROS_EC_CODEC
>  	select I2C_CROS_EC_TUNNEL
> -	depends on SND_SOC_AMD_ACP3x && I2C
> +	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC
>  	help
>  	 This option enables machine driver for RT5682 and MAX9835.
> 


-- 
~Randy

