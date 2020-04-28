Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF1C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F0020730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD1VnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:43:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:58531 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgD1VnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:43:08 -0400
IronPort-SDR: g75KC5gZD0rKohz/767n+YDN6JKzkZ8Qa9jkaKAyAXMqf1/At6L4AfF4cIYlsw3e1i4Kb91rcI
 8HOiz7k7quAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 14:43:07 -0700
IronPort-SDR: zK/pOH0bB0NT5PPv86h4FZnum68iEaTsGInoqhARg7hctD54dmmM1+W6iUI50j6u6vBwxrQD+7
 Cq0xOkcDVr8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="249285767"
Received: from asehgal-mobl.amr.corp.intel.com (HELO [10.254.29.183]) ([10.254.29.183])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2020 14:43:04 -0700
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
To:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200428212752.2901778-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
Date:   Tue, 28 Apr 2020 16:43:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428212752.2901778-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/20 4:27 PM, Arnd Bergmann wrote:
> The imx8 config keeps causing issues:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SOF_IMX8M
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && IMX_DSP [=n]
>    Selected by [m]:
>    - SND_SOC_SOF_IMX_OF [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && SND_SOC_SOF_IMX8M_SUPPORT [=y]
> 
> This is complicated by two drivers having dependencies on both
> platform specific drivers and the SND_SOC_SOF_OF framework code,
> and using an somewhat obscure method to build them the same way
> as the SOC_SOF_OF symbol (built-in or modular).
> 
> My solution now ensures that the two drivers can only be enabled
> when the dependencies are met:
> 
> - When the platform specific drivers are built-in, everything is
>    fine, as SOC_SOF_OF is either =y or =m
> 
> - When both are loadable modules, it also works, both for Kconfig
>    and at runtime
> 
> - When the hardware drivers are loadable modules or disabled, and
>    SOC_SOF_OF=y, prevent the IMX_SOF_OF drivers from being turned on,
>    as this would be broken.
> 
> It seems that this is just an elaborate way to describe two tristate
> symbols that have straight dependencies, but maybe I'm missing some
> subtle point. It seems to always build for me now.

Thanks Arnd, do you mind sharing your config? We noticed last week that 
there's a depend/select confusion might be simpler to fix, see 
https://github.com/thesofproject/linux/pull/2047/commits

If I look at the first line I see a IMX_DSP=n which looks exactly like 
what we wanted to fix.

> 
> Fixes: fe57a92c8858 ("ASoC: SOF: Add missing dependency on IMX_SCU")
> Fixes: afb93d716533 ("ASoC: SOF: imx: Add i.MX8M HW support")
> Fixes: cb0312f61c3e ("ASoC: SOF: imx: fix undefined reference issue")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/sof/imx/Kconfig | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index f76660e91382..66684d7590f4 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -21,7 +21,8 @@ config SND_SOC_SOF_IMX_OF
>   
>   config SND_SOC_SOF_IMX8_SUPPORT
>   	bool "SOF support for i.MX8"
> -	depends on IMX_SCU
> +	depends on IMX_SCU=y || IMX_SCU=SND_SOC_SOF_IMX_OF
> +	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_IMX_OF
>   	help
>   	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
>   	  Say Y if you have such a device.
> @@ -29,14 +30,13 @@ config SND_SOC_SOF_IMX8_SUPPORT
>   
>   config SND_SOC_SOF_IMX8
>   	tristate
> -	depends on IMX_SCU
> -	select IMX_DSP
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level
>   
>   config SND_SOC_SOF_IMX8M_SUPPORT
>   	bool "SOF support for i.MX8M"
> +	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_OF
>   	help
>   	  This adds support for Sound Open Firmware for NXP i.MX8M platforms
>   	  Say Y if you have such a device.
> @@ -44,7 +44,6 @@ config SND_SOC_SOF_IMX8M_SUPPORT
>   
>   config SND_SOC_SOF_IMX8M
>   	tristate
> -	depends on IMX_DSP
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level
> 
