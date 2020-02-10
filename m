Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDADEC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A603C20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJVBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:01:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:58143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgBJVBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:01:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 13:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,426,1574150400"; 
   d="scan'208";a="265998822"
Received: from pdmullen-mobl.amr.corp.intel.com (HELO [10.251.9.121]) ([10.251.9.121])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2020 13:00:59 -0800
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix randbuild error
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, daniel.baluta@nxp.com,
        krzk@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200210061544.7600-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
Date:   Mon, 10 Feb 2020 15:00:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210061544.7600-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 12:15 AM, YueHaibing wrote:
> when do randconfig like this:
> CONFIG_SND_SOC_SOF_IMX8_SUPPORT=y
> CONFIG_SND_SOC_SOF_IMX8=y
> CONFIG_SND_SOC_SOF_OF=y
> CONFIG_IMX_DSP=m
> CONFIG_IMX_SCU=y
> 
> there is a link error:
> 
> sound/soc/sof/imx/imx8.o: In function 'imx8_send_msg':
> imx8.c:(.text+0x380): undefined reference to 'imx_dsp_ring_doorbell'
> 
> Select IMX_DSP in SND_SOC_SOF_IMX8_SUPPORT to fix this
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: f9ad75468453 ("ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF dependency")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the report.

Would you mind sharing the .config and instructions to reproduce this 
case? we have an unrelated issue with allyesconfig that was reviewed here:

https://github.com/thesofproject/linux/pull/1778

and I'd probably a good thing to fix everything in one shot.

Thanks!

> ---
>   sound/soc/sof/imx/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index bae4f7b..81274906 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -14,7 +14,7 @@ if SND_SOC_SOF_IMX_TOPLEVEL
>   config SND_SOC_SOF_IMX8_SUPPORT
>   	bool "SOF support for i.MX8"
>   	depends on IMX_SCU
> -	depends on IMX_DSP
> +	select IMX_DSP
>   	help
>   	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
>   	  Say Y if you have such a device.
> 
