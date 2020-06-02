Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C7CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F281F2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBSID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:08:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:49770 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgFBSID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:08:03 -0400
IronPort-SDR: DNOlpNC29SzSvDEESO6Wqm2noLPZOGElqDr0JEaM0mveqYoPfwGFZtdq0DCOWrgnZR6xzxaaa9
 Asaritdb11Tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 11:08:02 -0700
IronPort-SDR: GFgu39VV8mRiSRuso9Tj9Wom8oigVbWKZaJlQ/L5nUG7eBJP0r6qnPvDLj8uo/qw6z7/CWPm1S
 KRaEVyd2IqwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="286742690"
Received: from aliang1-mobl1.gar.corp.intel.com (HELO [10.254.103.160]) ([10.254.103.160])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 11:08:00 -0700
Subject: Re: Subject: [PATCH v2] ASoC: soc-pcm: fix BE dai not hw_free and
 shutdown during mixer update
To:     =?UTF-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     kernel <kernel@vivo.com>,
        =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>,
        trivial@kernel.org
References: <ALMAWwB5CP9aAcKXCU5FzqqF.1.1590747164172.Hmail.zhucancan@vivo.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <338690ee-a081-054c-36e3-3f5fb3733442@linux.intel.com>
Date:   Tue, 2 Jun 2020 11:19:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ALMAWwB5CP9aAcKXCU5FzqqF.1.1590747164172.Hmail.zhucancan@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/20 5:12 AM, 朱灿灿 wrote:
> FE state is SND_SOC_DPCM_STATE_PREPARE now, BE1 is
> used by FE.
> 
> Later when new BE2 is added to FE by mixer update,
> it will call dpcm_run_update_startup() to update
> BE2's state, but unfortunately BE2 .prepare() meets
> error, it will disconnect all non started BE.
> 
> This make BE1 dai skip .hw_free() and .shutdown(),
> and the BE1 users will never decrease to zero.
> 
> Signed-off-by: zhucancan <zhucancan@vivo.com>
> ---
> re-format patch content v2
> ---
>   sound/soc/soc-pcm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 1f302de44052..df34422bd0dd 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2730,12 +2730,12 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
>   close:
>   	dpcm_be_dai_shutdown(fe, stream);
>   disconnect:
> -	/* disconnect any non started BEs */
> +	/* disconnect any closed BEs */
>   	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>   	for_each_dpcm_be(fe, stream, dpcm) {
>   		struct snd_soc_pcm_runtime *be = dpcm->be;
> -		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
> -				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
> +		if (be->dpcm[stream].state == SND_SOC_DPCM_STATE_CLOSE)
> +			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
>   	}
>   	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);

This change is quite hard to review, this error handling can be called 
from multiple places.

I *think* it's correct because in all cases where the 
disconnect/close/hw_free labels are reached, the non-shared BEs either 
remain or are put in the DPCM_STATE_CLOSE state before doing this test.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

It really wouldn't hurt though if others double-checked this change...



