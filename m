Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764492070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHJOer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:34:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:31394 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgHJOeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:34:46 -0400
IronPort-SDR: qyxowIxnEOkT4IRuXqkODzGVffnCD1QpWi2Ff8zp5tWac9kE1iTeo2F0L1aHdqlfE65aIq/zF0
 f1wOFQWrv1Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="215060129"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="215060129"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 07:34:45 -0700
IronPort-SDR: ykpKHPEA01HVmKLBbnbW7mdEUm3xME9VtWM7RLctOQr0UeMeOk5uXpB4mBa+4PbuJkRnbQaTqF
 ajsOmEu4637Q==
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="290367066"
Received: from schen8-mobl.amr.corp.intel.com (HELO [10.212.235.58]) ([10.212.235.58])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 07:34:44 -0700
Subject: Re: [PATCH] ASoC: intel: Fix memleak in sst_media_open
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200809085654.16483-1-dinghao.liu@zju.edu.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bf70ec51-6ee6-6d1e-1e5b-8e7191f08eba@linux.intel.com>
Date:   Mon, 10 Aug 2020 09:34:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809085654.16483-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/20 3:56 AM, Dinghao Liu wrote:
> When power_up_sst() fails, stream needs to be freed
> just like when try_module_get() fails. However, current
> code is returning directly and ends up leaking memory.
> 
> Fixes: 0121327c1a68b ("ASoC: Intel: mfld-pcm: add control for powering up/down dsp")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 49b9f18472bc..79fedf9e3da1 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -330,8 +330,10 @@ static int sst_media_open(struct snd_pcm_substream *substream,
>   	runtime->private_data = stream;
>   
>   	ret_val = power_up_sst(stream);
> -	if (ret_val < 0)
> +	if (ret_val < 0) {
> +		kfree(stream);
>   		return ret_val;
> +	}
>   
>   	/* Make sure, that the period size is always even */
>   	snd_pcm_hw_constraint_step(substream->runtime, 0,
> 

Alternate suggestion to fix this, it's not great when we mix gotos and 
returns.

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c 
b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 49b9f18472bc..b1cac7abdc0a 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -331,7 +331,7 @@ static int sst_media_open(struct snd_pcm_substream 
*substream,

         ret_val = power_up_sst(stream);
         if (ret_val < 0)
-               return ret_val;
+               goto out_power_up;

         /* Make sure, that the period size is always even */
         snd_pcm_hw_constraint_step(substream->runtime, 0,
@@ -340,8 +340,9 @@ static int sst_media_open(struct snd_pcm_substream 
*substream,
         return snd_pcm_hw_constraint_integer(runtime,
                          SNDRV_PCM_HW_PARAM_PERIODS);
  out_ops:
-       kfree(stream);
         mutex_unlock(&sst_lock);
+out_power_up:
+       kfree(stream);
         return ret_val;
  }
