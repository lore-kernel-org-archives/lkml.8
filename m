Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D394FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50DA2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597664859;
	bh=PWU1FA67zQAasUqd3BPumylawraXXdrgHP9MCo9WyJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bTFuH9eJsdScihs+mxnPydGseh4CQ1rGuv+TntKkJd7desI/tvqfQhpCCc/LLyfio
	 cU1SQYFUj68b5tymJdS+rvLSnfyMYGyWE50WfTHDiWmlkByFPe45bims5sWTmtqLcI
	 ao39GXxYBopIcDgBtGReA5i3CjAQu/Xt/FCTBOxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgHQLri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgHQLre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:47:34 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C07AE20674;
        Mon, 17 Aug 2020 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597664853;
        bh=PWU1FA67zQAasUqd3BPumylawraXXdrgHP9MCo9WyJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Bb0s9c1fXzrj0yzxKH6TCjhWGcINNywtn7fDxCldvxcXqhjpd+ietw8xoQr1LBU4
         +tId8AB1jrQEbVZDeJb458pPtVyNcCho0J3XN5oui0KxZzSSAUpgVTgwSfGcxehI18
         juHydM2Zsdmrr3Rko36cqSQH8+J5gro0pUpgtS08=
Date:   Mon, 17 Aug 2020 17:17:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 09/13] soundwire: intel: add CLK_STOP_BUS_RESET support
Message-ID: <20200817114729.GP2639@vkoul-mobl>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200721203723.18305-10-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721203723.18305-10-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 04:37, Bard Liao wrote:
> From: Rander Wang <rander.wang@intel.com>
> 
> Move existing pm_runtime suspend under the CLK_STOP_TEARDOWN case.
> 
> In this mode the Master IP will lose all context but in-band wakes are
> supported.
> 
> On pm_runtime resume a complete re-enumeration will be performed after
> a bus reset.
> 
> Signed-off-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 44 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 1954eb48b86c..744fc0a4816a 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1576,6 +1576,26 @@ static int intel_suspend_runtime(struct device *dev)
>  
>  		intel_shim_wake(sdw, false);
>  
> +	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
> +		ret = sdw_cdns_clock_stop(cdns, true);
> +		if (ret < 0) {
> +			dev_err(dev, "cannot enable clock stop on suspend\n");
> +			return ret;
> +		}
> +
> +		ret = sdw_cdns_enable_interrupt(cdns, false);
> +		if (ret < 0) {
> +			dev_err(dev, "cannot disable interrupts on suspend\n");
> +			return ret;
> +		}
> +
> +		ret = intel_link_power_down(sdw);
> +		if (ret) {
> +			dev_err(dev, "Link power down failed: %d", ret);
> +			return ret;
> +		}

no cleanup on all the error cases here?

> +
> +		intel_shim_wake(sdw, true);
>  	} else {
>  		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
>  			__func__, clock_stop_quirks);
> @@ -1694,6 +1714,30 @@ static int intel_resume_runtime(struct device *dev)
>  			dev_err(dev, "unable to exit bus reset sequence during resume\n");
>  			return ret;
>  		}
> +	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
> +		ret = intel_init(sdw);
> +		if (ret) {
> +			dev_err(dev, "%s failed: %d", __func__, ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * make sure all Slaves are tagged as UNATTACHED and
> +		 * provide reason for reinitialization
> +		 */
> +		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
> +
> +		ret = sdw_cdns_enable_interrupt(cdns, true);
> +		if (ret < 0) {
> +			dev_err(dev, "cannot enable interrupts during resume\n");
> +			return ret;
> +		}
> +
> +		ret = sdw_cdns_clock_restart(cdns, true);
> +		if (ret < 0) {
> +			dev_err(dev, "unable to restart clock during resume\n");
> +			return ret;
> +		}
>  	} else {
>  		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
>  			__func__, clock_stop_quirks);
> -- 
> 2.17.1

-- 
~Vinod
