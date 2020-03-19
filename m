Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B3FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3420E2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgCSRpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:45:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:59183 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgCSRpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:45:05 -0400
IronPort-SDR: Amx9KGKhWu3dJ0GgiHCU4EYyJ9W5kLCiwOfxwC28HVuw5kagrbJrNxYY9LTzb4pQQfjc/Fe7U5
 LWkZH9ZMUMPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 10:45:04 -0700
IronPort-SDR: nyg3Ka5QrvO3iYtSgsFbqxfqHGG7+n8+Zf6c65Hz/36CO+GdLR3Ez0v3k5pfe+8G9I643vtJNa
 10W4HYXOFQkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="245232828"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.128.140]) ([10.249.128.140])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 10:45:01 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mark Brown <broonie@kernel.org>, kuninori.morimoto.gx@renesas.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
References: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <a7bf2aee-78e7-f905-bcc3-cd21bf16a976@intel.com>
Message-ID: <2346211f-4639-75c3-513a-b765a0ba88d2@intel.com>
Date:   Thu, 19 Mar 2020 18:45:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a7bf2aee-78e7-f905-bcc3-cd21bf16a976@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-19 18:33, Cezary Rojewski wrote:
> 
> Thank you for being so cooperative during this 2day debug session.
> 
> The patch I mentioned earlier unintentionally (?) changed 'platform' 
> component param for ssp0_port from 'dummy' to 'platform' for non-SOF 
> solution:
> 
> diff --git a/sound/soc/intel/boards/broadwell.c 
> b/sound/soc/intel/boards/broadwell.c
> index b9c12e24c70b..db7e1e87156d 100644
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -164,14 +164,6 @@ SND_SOC_DAILINK_DEF(platform,
>   SND_SOC_DAILINK_DEF(codec,
>          DAILINK_COMP_ARRAY(COMP_CODEC("i2c-INT343A:00", "rt286-aif1")));
> 
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
> -SND_SOC_DAILINK_DEF(ssp0_port,
> -           DAILINK_COMP_ARRAY(COMP_CPU("ssp0-port")));
> -#else
> -SND_SOC_DAILINK_DEF(ssp0_port,
> -           DAILINK_COMP_ARRAY(COMP_DUMMY()));
> -#endif
> -
>   /* broadwell digital audio interface glue - connects codec <--> CPU */
>   static struct snd_soc_dai_link broadwell_rt286_dais[] = {
>          /* Front End DAI links */
> @@ -226,7 +218,7 @@ static struct snd_soc_dai_link 
> broadwell_rt286_dais[] = {
>                  .ops = &broadwell_rt286_ops,
>                  .dpcm_playback = 1,
>                  .dpcm_capture = 1,
> -               SND_SOC_DAILINK_REG(ssp0_port, codec, platform),
> +               SND_SOC_DAILINK_REG(dummy, codec, dummy),
>          },
> 

Of course I messed up the mail - above is a revert of said change.
