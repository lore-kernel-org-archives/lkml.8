Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C2C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A46E20754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584712313;
	bh=y7qXF+Hq92w8TU6GgEqFOUEr/nQFz4OOWmZ7gzxYsA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pY+/DPhUm2324sUM/OqkQNOLeC9OWT89C06xzs0/s3tx5AcUpSRxL7bxL+Sj/hb4B
	 aytMzfyBeTIiIYIp3inKuyPBBkE6BKKqEdWCTwP7Wp5vpEDKD47ZsiATTXeNY+a/qE
	 nAYAk2wNkFdZLzKX59i0d1Ba/nVe8i4c6ySg0+Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCTNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCTNvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:51:50 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B9120722;
        Fri, 20 Mar 2020 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584712309;
        bh=y7qXF+Hq92w8TU6GgEqFOUEr/nQFz4OOWmZ7gzxYsA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zFMvx0hvqwr72N/dXhAnTJiI/Zoq9SBqCEQoOJk/KLnBuoVrVkMndisdyQLJ5D6y0
         uvOzDDB0t/BhtmTE3qI8RZrkjTgaJIM+djbmG/o/HH6xwK6wIRcnm4EOpedPZ8fBhw
         7QxD9h34B1JwaLNnS1n/OIiWLyTA5U80pRBBk/fw=
Date:   Fri, 20 Mar 2020 19:21:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 5/7] soundwire: intel: follow documentation sequences for
 SHIM registers
Message-ID: <20200320135145.GE4885@vkoul-mobl>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-6-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311221026.18174-6-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 17:10, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@intel.com>
> 
> Somehow the existing code is not aligned with the steps described in
> the documentation, refactor code and make sure the register

Is the documentation available public space so that we can correct

> programming sequences are correct.
> 
> This includes making sure SHIM_SYNC is programmed only once, before
> the first link is powered on.
> 
> Note that the SYNCPRD value is tied only to the XTAL value and not the
> current bus frequency or the frame rate.
> 
> Signed-off-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 186 ++++++++++++++++++++++++++++----------
>  1 file changed, 139 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 3c271a8044b8..9c6514fe1284 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -46,7 +46,8 @@
>  #define SDW_SHIM_LCTL_SPA		BIT(0)
>  #define SDW_SHIM_LCTL_CPA		BIT(8)
>  
> -#define SDW_SHIM_SYNC_SYNCPRD_VAL	0x176F
> +#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
> +#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
>  #define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
>  #define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
>  #define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
> @@ -283,11 +284,48 @@ static int intel_link_power_up(struct sdw_intel *sdw)
>  {
>  	unsigned int link_id = sdw->instance;
>  	void __iomem *shim = sdw->link_res->shim;
> +	u32 *shim_mask = sdw->link_res->shim_mask;

this is a local pointer, so the one defined previously is not used.

> +	struct sdw_bus *bus = &sdw->cdns.bus;
> +	struct sdw_master_prop *prop = &bus->prop;
>  	int spa_mask, cpa_mask;
> -	int link_control, ret;
> +	int link_control;
> +	int ret = 0;
> +	u32 syncprd;
> +	u32 sync_reg;
>  
>  	mutex_lock(sdw->link_res->shim_lock);
>  
> +	/*
> +	 * The hardware relies on an internal counter,
> +	 * typically 4kHz, to generate the SoundWire SSP -
> +	 * which defines a 'safe' synchronization point
> +	 * between commands and audio transport and allows for
> +	 * multi link synchronization. The SYNCPRD value is
> +	 * only dependent on the oscillator clock provided to
> +	 * the IP, so adjust based on _DSD properties reported
> +	 * in DSDT tables. The values reported are based on
> +	 * either 24MHz (CNL/CML) or 38.4 MHz (ICL/TGL+).

Sorry this looks quite bad to read, we have 80 chars, so please use
like below:

	/*
         * The hardware relies on an internal counter, typically 4kHz,
         * to generate the SoundWire SSP - which defines a 'safe'
         * synchronization point between commands and audio transport
         * and allows for multi link synchronization. The SYNCPRD value
         * is only dependent on the oscillator clock provided to
         * the IP, so adjust based on _DSD properties reported in DSDT
         * tables. The values reported are based on either 24MHz
         * (CNL/CML) or 38.4 MHz (ICL/TGL+).
	 */

-- 
~Vinod
