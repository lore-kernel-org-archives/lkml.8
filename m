Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1BC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F832073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgEGOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:38:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:47930 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgEGO1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:27:45 -0400
IronPort-SDR: QtZUc6qnAL3/kzD2RSlef++m0jl/rPUbTtABADjPSmHVNs/Ez4SbdgoWyfCUqnbKvjh2VBIjAI
 C0VCGKNL0Umw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 07:27:44 -0700
IronPort-SDR: FlxiV9tkifVn7SQpdJR7/GHu1h0vfLl0fpMDGosXbdVPsI4k9OWpjGR5wCx5IQQCHBfeEcRq+R
 rvv4bnW83v2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="250105865"
Received: from kawilli2-mobl.amr.corp.intel.com (HELO [10.251.4.116]) ([10.251.4.116])
  by fmsmga007.fm.intel.com with ESMTP; 07 May 2020 07:27:34 -0700
Subject: Re: [PATCH v2 -next] ASoC: SOF: Intel: Fix unused variable warning
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, joe@perches.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
References: <20200507031911.38644-1-yuehaibing@huawei.com>
 <20200507072735.16588-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d3641489-e3c2-e525-567a-d0348c1eab4e@linux.intel.com>
Date:   Thu, 7 May 2020 09:27:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507072735.16588-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/20 2:27 AM, YueHaibing wrote:
> When CONFIG_SND_SOC_SOF_BAYTRAIL is not set, gcc warns:
> 
> sound/soc/sof/intel/byt.c:85:41: warning: ‘cht_debugfs’ defined but not used [-Wunused-const-variable=]
>   static const struct snd_sof_debugfs_map cht_debugfs[] = {
>                                           ^~~~~~~~~~~
> Move the variable inside #ifdef
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the patch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


