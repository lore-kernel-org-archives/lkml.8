Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB41DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AED20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgGBPC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:02:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:43273 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbgGBPCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:02:53 -0400
IronPort-SDR: 4S2xJdLjwzVAd0XXrWFKhp95KePCP12VaxeWRUeXq1CgYLLqalEC0/RI31pDqJrBzzA5EpyVwf
 nlQvAHrn00/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134384116"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="134384116"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 08:02:43 -0700
IronPort-SDR: g9KHZtn+dpB+rln7D4IWEm3Us2IMiwL8/XfFecXINP8MXWWwUKauOb0QsNJMRNpXH3rPFpB9fO
 yvwINN8+Yj6A==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="304275487"
Received: from nchava-mobl1.amr.corp.intel.com (HELO [10.252.135.144]) ([10.252.135.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 08:02:42 -0700
Subject: Re: [PATCH][next] ASoC: Intel: bxt-da7219-max98357a: return -EINVAL
 on unrecognized speaker amplifier
To:     Colin King <colin.king@canonical.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200702114835.37889-1-colin.king@canonical.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d79c5d6b-5bb6-3552-d1a6-bbd40f6c3081@linux.intel.com>
Date:   Thu, 2 Jul 2020 09:40:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702114835.37889-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/20 6:48 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the ctx->spkamp is not recognized an error message is
> reported but the code continues to set up the device with uninitialized
> variables such as the number of widgets.  Fix this by returning -EINVAL
> for unrecognized speaker amplifier types.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: e1435a1feb18 ("ASoC: Intel: bxt-da7219-max98357a: support MAX98390 speaker amp")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Sounds good, thanks Colin.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index 4d39253e796b..0c0a717823c4 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -677,7 +677,7 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
>   		break;
>   	default:
>   		dev_err(card->dev, "Invalid speaker amplifier %d\n", ctx->spkamp);
> -		break;
> +		return -EINVAL;
>   	}
>   
>   	err = snd_soc_dapm_new_controls(&card->dapm, widgets, num_widgets);
> 
