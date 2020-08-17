Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B3A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597663212;
	bh=1BxYmKlHGAYGgAGwfjEYuulG0rJG5NczRt9Xyo1ZNJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N8Om6/8tKuJCbltSDed2JB8LHE3Wu1eEQZrWF+3DmT07goRL+tAD2kQoYKkRKa/wd
	 DYFIY81j/RNb/sBfcVJ27J5Ws0Kj5uNpjkBYYDXVmYU0P4P6O6nyR63zmfDohdsTT1
	 hYkB0PxvPLHTyIv7WlJaKzJXvHvDWwNlvO6Q1dCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHQLTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgHQLT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:19:28 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F742072D;
        Mon, 17 Aug 2020 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597663168;
        bh=1BxYmKlHGAYGgAGwfjEYuulG0rJG5NczRt9Xyo1ZNJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orlAfBXKzkdMjfZHKw8cKc2q8t0149ohjtuqqBWyQZlTURSTXhO2uMXf408ANifDa
         Vr5XIM50eYgzDpgpvUiX0yq9JZjSwEy0xHVfZ2OEQYoPAG1mj4VEensYL0M91HNWXx
         kCykOPPbx4fhzDqaEHzrJd9OpzJ1EyPl/dre9bOo=
Date:   Mon, 17 Aug 2020 16:49:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 03/13] soundwire: intel: reset pm_runtime status during
 system resume
Message-ID: <20200817111924.GO2639@vkoul-mobl>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200721203723.18305-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721203723.18305-4-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 04:37, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The system resume does the entire bus re-initialization and brings it
> to full-power. If the device was pm_runtime suspended, there is no
> need to run the pm_runtime resume sequence after the system runtime.
> 
> Follow the documentation from runtime_pm.rst, and conditionally
> disable, set_active and re-enable the device on system resume.
> 
> Note that pm_runtime_suspended() is used instead of
> pm_runtime_status_suspended() so that we can deal with the case where
> pm_runtime is disabled.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index ed7163ae5f7a..284e5c9d240a 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1433,6 +1433,14 @@ static int intel_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> +	if (pm_runtime_suspended(dev)) {
> +		dev_dbg(dev,
> +			"%s: pm_runtime status: suspended\n",
> +			__func__);

first, can we have this in a single line, or better drop it
second why would this be called when device is suspended

> +
> +		return 0;
> +	}
> +
>  	ret = sdw_cdns_enable_interrupt(cdns, false);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot disable interrupts on suspend\n");
> @@ -1493,6 +1501,18 @@ static int intel_resume(struct device *dev)
>  		return 0;
>  	}
>  
> +	if (pm_runtime_suspended(dev)) {
> +		dev_dbg(dev,
> +			"%s: pm_runtime status was suspended, forcing active\n",
> +			__func__);

this one also could look better in a single line

> +
> +		/* follow required sequence from runtime_pm.rst */
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_active(dev);
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_enable(dev);
> +	}
> +
>  	ret = intel_init(sdw);
>  	if (ret) {
>  		dev_err(dev, "%s failed: %d", __func__, ret);
> -- 
> 2.17.1

-- 
~Vinod
