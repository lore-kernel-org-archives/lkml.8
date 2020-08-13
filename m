Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16117C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BF12078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHMOfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:35:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:44561 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgHMOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:35:46 -0400
IronPort-SDR: F9143Rouw6DKGlwVM54s29Ot/p2OFbAiFu/SyCUnmqBYXRAA5gNLjWBsCTeG4KFW7X9DLhJUF7
 +Ovj5+Ey7SPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="134279725"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="134279725"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 07:35:46 -0700
IronPort-SDR: sMiil9/2RLXm+J/PBnbkqew4A0wxJWaabcQ5kuwmyetPUk8ahLy6nNScw6BTLVFsiOXCl8bXIq
 4rEu3Nfby4cg==
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="333124546"
Received: from jsdraege-mobl1.amr.corp.intel.com (HELO [10.209.128.166]) ([10.209.128.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 07:35:45 -0700
Subject: Re: [PATCH] [v2] ASoC: intel: Fix memleak in sst_media_open
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200813084112.26205-1-dinghao.liu@zju.edu.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0add5326-d182-c456-0f8b-1d70bb67a2fc@linux.intel.com>
Date:   Thu, 13 Aug 2020 07:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813084112.26205-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/20 3:41 AM, Dinghao Liu wrote:
> When power_up_sst() fails, stream needs to be freed
> just like when try_module_get() fails. However, current
> code is returning directly and ends up leaking memory.
> 
> Fixes: 0121327c1a68b ("ASoC: Intel: mfld-pcm: add control for powering up/down dsp")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for spotting this!

> ---
> 
> Changelog:
> 
> v2: - Add a new label 'out_power_up' to unify code style.
> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 49b9f18472bc..b1cac7abdc0a 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -331,7 +331,7 @@ static int sst_media_open(struct snd_pcm_substream *substream,
>   
>   	ret_val = power_up_sst(stream);
>   	if (ret_val < 0)
> -		return ret_val;
> +		goto out_power_up;
>   
>   	/* Make sure, that the period size is always even */
>   	snd_pcm_hw_constraint_step(substream->runtime, 0,
> @@ -340,8 +340,9 @@ static int sst_media_open(struct snd_pcm_substream *substream,
>   	return snd_pcm_hw_constraint_integer(runtime,
>   			 SNDRV_PCM_HW_PARAM_PERIODS);
>   out_ops:
> -	kfree(stream);
>   	mutex_unlock(&sst_lock);
> +out_power_up:
> +	kfree(stream);
>   	return ret_val;
>   }
>   
> 
