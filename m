Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C91206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgG2P4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:56:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:45859 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2P4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:56:11 -0400
IronPort-SDR: GCDXTmlTOwpWj8psFXHAuM/OGuAWjBzyivdANsND9GpGYHoYIlmY0zy83Q2eMS2nk97olNdlGX
 MZ2y8FXT195Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236307529"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="236307529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 08:56:10 -0700
IronPort-SDR: IDiwGItDXIzja3qJHXtAQwZsgkfdvjN51ZFJYyn4gETjqIXmWP3NNyN85itVh4GNZZCNBIn5O4
 HqvTijKzaFgQ==
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="322594221"
Received: from vmlivin-mobl1.amr.corp.intel.com (HELO [10.209.108.29]) ([10.209.108.29])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 08:56:08 -0700
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>, zhangn1985@outlook.com,
        Stephan Gerhold <stephan@gerhold.net>
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
 <20200729154639.1983854-1-jbrunet@baylibre.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
Date:   Wed, 29 Jul 2020 10:56:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729154639.1983854-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/20 10:46 AM, Jerome Brunet wrote:
> commit b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
> changed dpcm_playback and dpcm_capture semantic by throwing an error if
> these flags are not aligned with DAIs capabilities on the link.
> 
> The former semantic did not force the flags and DAI caps to be aligned.
> The flag previously allowed card drivers to disable a stream direction on
> a link (whether or not such feature is deemed useful).
> 
> With change ('ASoC: core: use less strict tests for dailink capabilities')
> an error is thrown if the flags and and the DAI caps are not aligned. Those
> parameters were not meant to aligned initially. No technical reason was
> given about why cards should now be considered "broken" in such condition
> is not met, or why it should be considered to be an improvement to enforce
> that.
> 
> Forcing the flags to be aligned with DAI caps just make the information
> the flag carry redundant with DAI caps, breaking a few cards along the way.
> 
> This change drops the added error conditions and restore the initial flag
> semantics.

or rather lack thereof.

I am ok to move dev_err to dev_warn and remove the return -EINVAL, but I 
maintain that we have to reach a point where configurations make sense 
before we can clean them up. If we implicitly push issues under the rug 
by not even being aware of them we'll never make progress.

> 
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> 
>   Hi Mark,
> 
>   Because b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
>   introduced more than one problem, the change
>   "ASoC: core: use less strict tests for dailink capabilities" [0] is still
>   necessary but the change of semantic remains a problem with it.
> 
>   This patch applies on top of it.
> 
>   sound/soc/soc-pcm.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 00ac1cbf6f88..2e205b738eae 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2749,13 +2749,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>   					break;
>   				}
>   			}
> -
> -			if (!playback) {
> -				dev_err(rtd->card->dev,
> -					"No CPU DAIs support playback for stream %s\n",
> -					rtd->dai_link->stream_name);
> -				return -EINVAL;
> -			}
>   		}
>   		if (rtd->dai_link->dpcm_capture) {
>   			stream = SNDRV_PCM_STREAM_CAPTURE;
> @@ -2766,13 +2759,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>   					break;
>   				}
>   			}
> -
> -			if (!capture) {
> -				dev_err(rtd->card->dev,
> -					"No CPU DAIs support capture for stream %s\n",
> -					rtd->dai_link->stream_name);
> -				return -EINVAL;
> -			}
>   		}
>   	} else {
>   		/* Adapt stream for codec2codec links */
> 
