Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB3C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D6220726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 15:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBIPe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:34:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:17402 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbgBIPe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 10:34:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 07:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,421,1574150400"; 
   d="scan'208";a="226964306"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.86.168]) ([10.251.86.168])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2020 07:34:52 -0800
Subject: Re: [PATCH] ASoC: Intel: mrfld: return error codes when an error
 occurs
To:     Colin King <colin.king@canonical.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200208220720.36657-1-colin.king@canonical.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <5622cdca-c17b-c0d8-8dbc-4616449877d2@intel.com>
Date:   Sun, 9 Feb 2020 16:34:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200208220720.36657-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-08 23:07, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently function sst_platform_get_resources always returns zero and
> error return codes set by the function are never returned. Fix this
> by returning the error return code in variable ret rather than the
> hard coded zero.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: f533a035e4da ("ASoC: Intel: mrfld - create separate module for pci part")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/soc/intel/atom/sst/sst_pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
> index d952719bc098..5862fe968083 100644
> --- a/sound/soc/intel/atom/sst/sst_pci.c
> +++ b/sound/soc/intel/atom/sst/sst_pci.c
> @@ -99,7 +99,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>   	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
>   do_release_regions:
>   	pci_release_regions(pci);
> -	return 0;
> +	return ret;
>   }
>   
>   /*
> 

Thank you for the fix.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
