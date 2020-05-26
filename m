Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A63AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458EB2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgEZPe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:34:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:15153 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgEZPe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:34:58 -0400
IronPort-SDR: O98dEh0Zvs/+K6vTlRDfSSCjltkJmlzmKswzVnq0RyUT94PZJKDdBMJQj9HvLFBlOOMeBx4GkH
 OpNUAr/9PZNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 08:34:57 -0700
IronPort-SDR: TN5+3JgQvkZsl+te3qpnFMymhcJOiGLgqzwCX0HYuGRWB1PS0ilM83NsiGKythrEDG/n5LfGZi
 V63i28NHf6cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="291234586"
Received: from unknown (HELO [10.254.102.121]) ([10.254.102.121])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 08:34:56 -0700
Subject: Re: [PATCH] ASoC: Intel: sst: Fix runtime PM imbalance in
 sst_power_control
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200525070701.3888-1-dinghao.liu@zju.edu.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <922ac37c-0a5a-dff7-0cd7-d3487cf9ff00@linux.intel.com>
Date:   Tue, 26 May 2020 08:25:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525070701.3888-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/20 2:06 AM, Dinghao Liu wrote:
> When sst_load_fw() returns an error code, a pairing runtime
> PM usage counter decrement is needed to keep the counter
> balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   sound/soc/intel/atom/sst/sst_drv_interface.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
> index 762495385d5c..3897985b254f 100644
> --- a/sound/soc/intel/atom/sst/sst_drv_interface.c
> +++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
> @@ -150,6 +150,7 @@ static int sst_power_control(struct device *dev, bool state)
>   		if ((ctx->sst_state == SST_RESET) && (usage_count == 1)) {
>   			ret = sst_load_fw(ctx);
>   			if (ret) {
> +				pm_runtime_put_sync(dev);
>   				dev_err(dev, "FW download fail %d\n", ret);
>   				sst_set_fw_state_locked(ctx, SST_RESET);
>   				ret = sst_pm_runtime_put(ctx);

this change doesn't seem quite right, if you look the code below there 
is no PM imbalance, is there?

int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
{
	int ret;

	pm_runtime_mark_last_busy(sst_drv->dev);
	ret = pm_runtime_put_autosuspend(sst_drv->dev);
	if (ret < 0)
		return ret;
	return 0;
}

