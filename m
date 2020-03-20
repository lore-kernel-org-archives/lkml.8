Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE25C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1508120754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584711784;
	bh=7RGOPJR25CwJirzAerwKnDLjD3O8PXRhRx7qMiLnguk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SOYSniPsa6gMV29VJqe1ceq1REYAMD1OoYG5Cra+HEaPpk+iDjyHlabIQ0X/9DMyN
	 44Jb89+jIAyvR2CzgmmN5XJX4yZoO93gYBQOKMFFfMnf93YVmZUPnCV/QCX4gzv5Sx
	 mscGFY4/WsUwHizMWrSMSPDTHiJWw5evxkry7qK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCTNnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCTNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:43:01 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE3220739;
        Fri, 20 Mar 2020 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584711780;
        bh=7RGOPJR25CwJirzAerwKnDLjD3O8PXRhRx7qMiLnguk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IK13Wl2SiISx3G3YrNWIFPq1yrUzhqhUSirhjg5S49ODZ5Pf4p+riDnww6UOdd75Y
         jpGDNpLNPYlthJ0Y+RjRx+A1ks9jCrbf6CfqUEZ8L0pnCxEoeq0iiDOEcVbmkGvQMA
         cf1LRS3Ms5uw6M3FX/5B2y0BUEHCsJKFcy0xw2uc=
Date:   Fri, 20 Mar 2020 19:12:57 +0530
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
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 4/7] soundwire: intel: add definitions for shim_mask
Message-ID: <20200320134257.GD4885@vkoul-mobl>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311221026.18174-5-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 17:10, Pierre-Louis Bossart wrote:
> We want to make sure SHIM register fields such as SYNCPRD are only
> programmed once. Since we don't have a controller-level driver, we
> need master-level drivers to collaborate: the registers will only be
> programmed when the first link is powered-up.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.h           | 2 ++
>  include/linux/soundwire/sdw_intel.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
> index 568c84a80d79..cfc83120b8f9 100644
> --- a/drivers/soundwire/intel.h
> +++ b/drivers/soundwire/intel.h
> @@ -16,6 +16,7 @@
>   * @ops: Shim callback ops
>   * @dev: device implementing hw_params and free callbacks
>   * @shim_lock: mutex to handle access to shared SHIM registers
> + * @shim_mask: global pointer to check SHIM register initialization
>   */
>  struct sdw_intel_link_res {
>  	struct platform_device *pdev;
> @@ -27,6 +28,7 @@ struct sdw_intel_link_res {
>  	const struct sdw_intel_ops *ops;
>  	struct device *dev;
>  	struct mutex *shim_lock; /* protect shared registers */
> +	u32 *shim_mask;

You have a pointer, okay where is it initialized

>  };
>  
>  #endif /* __SDW_INTEL_LOCAL_H */
> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
> index 979b41b5dcb4..120ffddc03d2 100644
> --- a/include/linux/soundwire/sdw_intel.h
> +++ b/include/linux/soundwire/sdw_intel.h
> @@ -115,6 +115,7 @@ struct sdw_intel_slave_id {
>   * links
>   * @link_list: list to handle interrupts across all links
>   * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
> + * @shim_mask: flags to track initialization of SHIM shared registers
>   */
>  struct sdw_intel_ctx {
>  	int count;
> @@ -126,6 +127,7 @@ struct sdw_intel_ctx {
>  	struct sdw_intel_slave_id *ids;
>  	struct list_head link_list;
>  	struct mutex shim_lock; /* lock for access to shared SHIM registers */
> +	u32 shim_mask;

And a integer, question: why do you need pointer and integer, why not
use only one..?

-- 
~Vinod
