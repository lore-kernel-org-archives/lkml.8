Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B396C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D489720707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHZPLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:11:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:9758 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgHZPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:11:26 -0400
IronPort-SDR: 8TcetRDtRqlaVLV3C5qbcHWcBlSJ9+4lJqhUnpVe3RTVw86gmX9deZDGLrKibxh24rjOqwUz3V
 1TE/2QOKhkSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153729699"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153729699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:25 -0700
IronPort-SDR: IGgxmkZop+YsRcGGramX/nJvANvQUeHyyD2q3q/ecm42zKIu7W2EkwkP3wmno/+0Q1JcO3f81m
 +5TVTJQlfGbQ==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="299505130"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51]) ([10.255.231.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:24 -0700
Subject: Re: [PATCH 4/4] ASoC: rt715: Fix return check for
 devm_regmap_init_sdw()
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
References: <20200826122811.3223663-1-vkoul@kernel.org>
 <20200826122811.3223663-4-vkoul@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e71ba625-ec1e-1adf-9e4c-b65a91562d9c@linux.intel.com>
Date:   Wed, 26 Aug 2020 10:09:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826122811.3223663-4-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 7:28 AM, Vinod Koul wrote:
> devm_regmap_init_sdw() returns a valid pointer on success or ERR_PTR on
> failure which should be checked with IS_ERR. Also use PTR_ERR for
> returning error codes.

Do you mind changing these two additional codecs that were missed in 
this series? Thanks!

rt700-sdw.c:	sdw_regmap = devm_regmap_init_sdw(slave, &rt700_sdw_regmap);
rt700-sdw.c-	if (!sdw_regmap)
rt700-sdw.c-		return -EINVAL;

--
rt711-sdw.c:	sdw_regmap = devm_regmap_init_sdw(slave, &rt711_sdw_regmap);
rt711-sdw.c-	if (!sdw_regmap)
rt711-sdw.c-		return -EINVAL;
--

> 
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Fixes: d1ede0641b05 ("ASoC: rt715: add RT715 codec driver")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   sound/soc/codecs/rt715-sdw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
> index d11b23d6b240..68a36739f1b0 100644
> --- a/sound/soc/codecs/rt715-sdw.c
> +++ b/sound/soc/codecs/rt715-sdw.c
> @@ -527,8 +527,8 @@ static int rt715_sdw_probe(struct sdw_slave *slave,
>   
>   	/* Regmap Initialization */
>   	sdw_regmap = devm_regmap_init_sdw(slave, &rt715_sdw_regmap);
> -	if (!sdw_regmap)
> -		return -EINVAL;
> +	if (IS_ERR(sdw_regmap))
> +		return PTR_ERR(sdw_regmap);
>   
>   	regmap = devm_regmap_init(&slave->dev, NULL, &slave->dev,
>   		&rt715_regmap);
> 
