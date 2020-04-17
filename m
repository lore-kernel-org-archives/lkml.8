Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E2C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117F120857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgDQPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:48:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:45404 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgDQPsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:48:23 -0400
IronPort-SDR: 1jEruK9lRC/6OfrUw2b4bEI79hBHGt8DfyNEQ6GRu/BUi7GJrAcpLiYDfkjE7ns647z05t52yu
 oMO+GNGe7/dw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 08:48:23 -0700
IronPort-SDR: ZBwe2yhen/Cg4VzUVmdatNxrnAr9gr2mfLpMqbuIjwHNm8+JZZMJryQnFAdgH7o+9ulVtWAxwR
 X5jV6k+GoP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="278417849"
Received: from dsbrown-mobl.amr.corp.intel.com (HELO [10.251.128.242]) ([10.251.128.242])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2020 08:48:21 -0700
Subject: Re: [PATCH] ASoC: Intel: atom: remove unused 'sst_mix_voip_controls'
To:     Jason Yan <yanaijie@huawei.com>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, tglx@linutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200417092344.14301-1-yanaijie@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8cd0ba8d-138d-d4da-d6fb-d2457ea2db13@linux.intel.com>
Date:   Fri, 17 Apr 2020 08:43:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417092344.14301-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/20 4:23 AM, Jason Yan wrote:
> Fix the following gcc warning:
> 
> sound/soc/intel/atom/sst-atom-controls.c:710:30: warning:
> ‘sst_mix_voip_controls’ defined but not used [-Wunused-const-variable=]
>   SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls);

I'd prefer it if we didn't change this but only added __maybe_unused in 
the macro.

This is 2013/2014 legacy stuff, some parts were not upstreamed and this 
was used by out-of-tree Android variations, and I don't know the 
consequences of taking this out.

Better just squelch the warning but not change anything, no?

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   sound/soc/intel/atom/sst-atom-controls.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
> index 69f3af4524ab..541f0059ba7a 100644
> --- a/sound/soc/intel/atom/sst-atom-controls.c
> +++ b/sound/soc/intel/atom/sst-atom-controls.c
> @@ -707,7 +707,6 @@ SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm2_controls);
>   SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_sprot_l0_controls);
>   SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l1_controls);
>   SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l2_controls);
> -SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls);
>   SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec0_controls);
>   SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec1_controls);
>   SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_modem_controls);
> 
