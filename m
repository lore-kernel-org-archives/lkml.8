Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D773C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5EA21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBSVxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:53:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:61579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgBSVxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:53:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 13:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="228724420"
Received: from ssavage-mobl.amr.corp.intel.com (HELO [10.254.46.100]) ([10.254.46.100])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2020 13:53:43 -0800
Subject: Re: [PATCH] ASoC: dpcm: remove confusing trace in dpcm_get_be()
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20200219115048.934678-1-jbrunet@baylibre.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <88391284-8125-1be6-f7c9-4509b1d89367@linux.intel.com>
Date:   Wed, 19 Feb 2020 15:53:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219115048.934678-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/20 5:50 AM, Jerome Brunet wrote:
> Now that dpcm_get_be() is used in dpcm_end_walk_at_be(), it is not a error
> if this function does not find a BE for the provided widget. Remove the
> related dev_err() trace which is confusing since things might be working
> as expected.
> 
> When called from dpcm_add_paths(), it is an error if dpcm_get_be() fails to
> find a BE for the provided widget. The necessary error trace is already
> done in this case.
> 
> Fixes: 027a48387183 ("ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()")
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Good catch, this error log is indeed unnecessary, I see more than 30 
lines of 'can't get capture/playback BE' for all the non-BE widgets in 
our topologies (PCM, buffers, PGA, EQ, etc).

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/soc-pcm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 63f67eb7c077..aff27c8599ef 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1270,9 +1270,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
>   		}
>   	}
>   
> -	/* dai link name and stream name set correctly ? */
> -	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
> -		stream ? "capture" : "playback", widget->name);
> +	/* Widget provided is not a BE */
>   	return NULL;
>   }
>   
> 
