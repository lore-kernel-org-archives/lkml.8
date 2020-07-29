Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DA4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A002076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgG2LTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:19:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:15810 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2LTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:19:32 -0400
IronPort-SDR: uBO9NlicRWMgH9pdShLvHfXWNGi3cM+0uoF2Ps3TG5MBCTkpwE3ary7aAsDWS0R8Oi6HM+IN2p
 z3sMfcLt+QcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="139410650"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="139410650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 04:19:32 -0700
IronPort-SDR: p88OI+P5yPX3nTPCMXDzuzWyzJRVyFyhyuhhTQHhfAbFp3LGMMp4OpFuHF7QZg/wDP0y0d3Fyp
 gu/tKhW/ZNgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="312991400"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2020 04:19:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0k7L-004gAn-KP; Wed, 29 Jul 2020 14:19:27 +0300
Date:   Wed, 29 Jul 2020 14:19:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: intel: atom: Add period size constraint
Message-ID: <20200729111927.GV3703480@smile.fi.intel.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596020585-11517-2-git-send-email-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596020585-11517-2-git-send-email-brent.lu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 07:03:04PM +0800, Brent Lu wrote:
> Use constraint to enforce the period sizes which are validated in
> Android BSP.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/intel/atom/sst-mfld-platform-pcm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 49b9f18..f614651 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -300,6 +300,16 @@ static void power_down_sst(struct sst_runtime_stream *stream)
>  	stream->ops->power(sst->dev, false);
>  }
>  
> +static const unsigned int media_period_size[] = {
> +	/* sizes validated on Android platform */

> +	240, 320, 960, 3072

Leave comma at the end.

> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_media_period_size = {
> +	.count = ARRAY_SIZE(media_period_size),
> +	.list  = media_period_size,
> +};
> +
>  static int sst_media_open(struct snd_pcm_substream *substream,
>  		struct snd_soc_dai *dai)
>  {
> @@ -333,6 +343,11 @@ static int sst_media_open(struct snd_pcm_substream *substream,
>  	if (ret_val < 0)
>  		return ret_val;
>  
> +	/* Avoid using period size which is not validated */
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +			SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> +			&constraints_media_period_size);
> +
>  	/* Make sure, that the period size is always even */
>  	snd_pcm_hw_constraint_step(substream->runtime, 0,
>  			   SNDRV_PCM_HW_PARAM_PERIODS, 2);
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko


