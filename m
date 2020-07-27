Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB2CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661982073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgG0PcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:32:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:15774 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbgG0PcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:32:01 -0400
IronPort-SDR: tomI0JPQYUp/QQPRHN+mO/EodWUNzb4kHjRt0j8JmhCEeqNwMbYxX9anVyIEMZhTycrttQDIa/
 L3pmrit+tSFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="148915978"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="148915978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 08:32:01 -0700
IronPort-SDR: N9v2zia3/Nh5wPi/k4sgQ299PY/D0/PAYHd5js99/HLd3x2F3G9xVpxpuOil8Eb7h2XndIHwf7
 YrBmjrbjwadw==
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="464099696"
Received: from pdewan-mobl1.amr.corp.intel.com (HELO [10.255.228.220]) ([10.255.228.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 08:32:00 -0700
Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alexander.Deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
Date:   Mon, 27 Jul 2020 10:31:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/20 9:58 AM, Ravulapati Vishnu vardhan rao wrote:
> changing SND_SOC_RT5682_I2C to SND_SOC_RT5682 because,
> This flag which was previously set as SND_SOC_RT5682
> used to build rt5682 codec driver but by changing into
> SND_SOC_RT5682_I2C is preventing to build rt5682 codec
> driver and machine driver fails to probe.So Reverting the changes.

The split between I2C and SoundWire means you have to choose the I2C or 
SDW mode. Selecting the common part looks very strange.

see Intel machine drviers:

Kconfig:	select SND_SOC_RT5682_I2C
Kconfig:	select SND_SOC_RT5682_I2C
Kconfig:	select SND_SOC_RT5682_I2C
Kconfig:	select SND_SOC_RT5682_SDW

> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index e37cf72f2bab..77ffdb41bee5 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -29,7 +29,7 @@ config SND_SOC_AMD_ACP3x
>   
>   config SND_SOC_AMD_RV_RT5682_MACH
>   	tristate "AMD RV support for RT5682"
> -	select SND_SOC_RT5682_I2C
> +	select SND_SOC_RT5682
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_CROS_EC_CODEC
>   	select I2C_CROS_EC_TUNNEL
> 
