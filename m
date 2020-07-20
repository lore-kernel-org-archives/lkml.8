Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14C922B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGTJL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:11:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:26326 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTJL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:11:56 -0400
IronPort-SDR: Bo5FkFj4qe3OMu3g7T70umYJtpTEyNODvP304xJ/9G52MQRzQ0iUPlGR8ZlqDyJ/D+TySOxIj9
 LuBBE2pQu4Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="149032814"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="149032814"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 02:11:55 -0700
IronPort-SDR: pgu1xTEsiN9BK2ImwxhixSfL4hoV3HEGEtCY7woIl8RAd5vFr8ZEeHUC+XXMtfc9THbNrAL7sD
 i8GdFOg8f8Sg==
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="431547307"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.147.69]) ([10.249.147.69])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 02:11:52 -0700
Subject: Re: [PATCH][next] ASoC: Intel: Skylake: Avoid the use of one-element
 array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200717215500.GA13910@embeddedor>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <25892fe8-2ec4-9105-851b-8a0520756057@linux.intel.com>
Date:   Mon, 20 Jul 2020 11:11:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717215500.GA13910@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok and tests on our side also pass.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

On 7/17/2020 11:55 PM, Gustavo A. R. Silva wrote:
> One-element arrays are being deprecated[1]. Replace the one-element
> array with a simple value type 'u8 reserved'[2], once it seems this
> is just a placeholder for alignment.
> 
> [1] https://github.com/KSPP/linux/issues/79
> [2] https://github.com/KSPP/linux/issues/86
> 
> Tested-by: kernel test robot <lkp@intel.com>
> Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/skylake-20200717.md
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   sound/soc/intel/skylake/skl-topology.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
> index 9889f728752c..5e93ad85e06d 100644
> --- a/sound/soc/intel/skylake/skl-topology.h
> +++ b/sound/soc/intel/skylake/skl-topology.h
> @@ -97,7 +97,7 @@ struct skl_audio_data_format {
>   	u8 number_of_channels;
>   	u8 valid_bit_depth;
>   	u8 sample_type;
> -	u8 reserved[1];
> +	u8 reserved;
>   } __packed;
>   
>   struct skl_base_cfg {
> 
