Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50414C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320282078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgGIQx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:53:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:29814 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIQxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:53:25 -0400
IronPort-SDR: UnKa4NJ/f19y74904M33B3hEgwcqBfCMqgwyeJFRBRjpm04HBju/EU6zd6f8bkoUPCdrB6gfzs
 QY353bOHQ4bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149522304"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149522304"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:53:24 -0700
IronPort-SDR: Wfl4DjtewN9y8lcEqx4mIg3O24jMaRiJiaPADj4LdYQdAQsGMIduDLoSz9zrw7NJXWISQtLIrM
 CzRnXHnkAHbw==
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="284216674"
Received: from mdcoakle-mobl.amr.corp.intel.com (HELO [10.255.231.43]) ([10.255.231.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:53:24 -0700
Subject: Re: [PATCH] ASoC: Intel: boards: eve: Fix DMIC records zero
To:     vamshi.krishna.gopal@intel.com, lma@semihalf.com,
        harshapriya.n@intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     sathya.prakash.m.r@intel.com, brndt@google.com
References: <20200709152526.15764-1-vamshi.krishna.gopal@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <79866874-1ec3-50a1-1034-39bc116264fd@linux.intel.com>
Date:   Thu, 9 Jul 2020 11:53:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709152526.15764-1-vamshi.krishna.gopal@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/20 10:25 AM, vamshi.krishna.gopal@intel.com wrote:
> From: Brent Lu <brent.lu@intel.com>
> 
> Add a dapm route to provide ssp mclk/sclk early
> for DMIC  on SSP0(rt5514) and Headset on SSP1(rt5663)
> since sclk for both codecs are different the
> struct now defines SSP0 and SSP1 mclk , sclk separately
> This change ensures the DMIC PCM port
> will not return all-zero data
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
> ---
>   .../intel/boards/kbl_rt5663_rt5514_max98927.c | 150 ++++++++++++------
>   1 file changed, 102 insertions(+), 48 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index b34cf6cf1139..584e4f9cedc2 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -53,8 +53,10 @@ struct kbl_codec_private {
>   	struct snd_soc_jack kabylake_headset;
>   	struct list_head hdmi_pcm_list;
>   	struct snd_soc_jack kabylake_hdmi[2];
> -	struct clk *mclk;
> -	struct clk *sclk;
> +	struct clk *ssp0_mclk;
> +	struct clk *ssp0_sclk;
> +	struct clk *ssp1_mclk;
> +	struct clk *ssp1_sclk;

The definition of a per-SSP MCLK is just wrong. there are 2 MCLKs 
regardless of the number of SSPs, this should be MCLK0 and MCLK1.

It probably works in your case since you have 2 SSPs, but the Skylake 
driver exposes ssp2..5_mclk clocks that don't exist in hardware. Oh well.

If you don't mind I'd prefer it if you used mclk0 and mclk1 and drop the 
ssp_ prefix. You can still use the "ssp0_mclk" and "ssp1_mclk" strings 
when calling devm_clk_get(), but that way if the Skylake driver is fixed 
at some point we will not have to change the code in this driver, only 
the clock names.

[...]

> @@ -757,6 +800,29 @@ static struct snd_soc_card kabylake_audio_card = {
>   	.late_probe = kabylake_card_late_probe,
>   };
>   
> +static int kabylake_audio_clk_get(struct device *dev, const char *id,
> +	struct clk **clk)
> +{
> +	int ret = 0;
> +
> +	if (!clk)
> +		return -EINVAL;
> +
> +	*clk = devm_clk_get(dev, id);
> +	if (IS_ERR(*clk)) {
> +		ret = PTR_ERR(*clk);
> +		if (ret == -ENOENT) {
> +			dev_info(dev, "Failed to get %s, defer probe\n", id);
> +			return -EPROBE_DEFER;
> +		}
> +
> +		dev_err(dev, "Failed to get %s with err:%d\n", id, ret);
> +		return ret;

nit-pick: you can remove this return since you already have one two 
lines below.

> +	}
> +
> +	return ret;
> +}
> +

