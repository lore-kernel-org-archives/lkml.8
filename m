Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A36C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E3F20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584101174;
	bh=q+0D/K3yLFpRrEgdR8NjgvruhvTmw4R8SOGsrQpR0ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0m14Swbh6tsjwnLH/WwHAgxRtUUzydzbiX2DbnTbyGeRo2ZuyXK9+xDSTOozqKZx
	 8henMipSmBFWQDV/rW3JrscmzBghXLqSFWHZe5O/TxvpUCkprDIqaEBrI0HcD3piJ/
	 mHUtwnjDaKLUWHfgKmC/8kAcGB+DKp6uF3FFuaBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCMMGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgCMMGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:06:12 -0400
Received: from localhost (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C6F206FA;
        Fri, 13 Mar 2020 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584101171;
        bh=q+0D/K3yLFpRrEgdR8NjgvruhvTmw4R8SOGsrQpR0ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBHmGu3FIQGse3B1aLKIp3EXkV54dS0959MiD2uYZA5EqCZ/kL6frkYwsMoAjV8Ax
         wKf4cZpQG0/6QWcPEfXBy2irf4a3osCzdNE7xTj8zAjtRz1Q96zGy+3v8l3qYFDCLT
         pMWrrhFRTCQIjTZo0V4vr7/LIy69opgfqnnbDslQ=
Date:   Fri, 13 Mar 2020 17:36:07 +0530
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
Subject: Re: [PATCH 03/16] soundwire: cadence: add interface to check clock
 status
Message-ID: <20200313120607.GE4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311184128.4212-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 13:41, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@intel.com>
> 
> If master is in clock stop state, driver can't modify registers
> in master except the registers for clock stop setting.
> 
> Signed-off-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 19 +++++++++++++++++++
>  drivers/soundwire/cadence_master.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 941809ea00a8..71cba2585151 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -1207,6 +1207,25 @@ static const struct sdw_master_port_ops cdns_port_ops = {
>  	.dpn_port_enable_ch = cdns_port_enable,
>  };
>  
> +/**
> + * sdw_cdns_is_clock_stop: Check clock status
> + *
> + * @cdns: Cadence instance
> + */
> +bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns)
> +{
> +	u32 status;
> +
> +	status = cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP;
> +	if (status) {
> +		dev_dbg(cdns->dev, "Clock is stopped\n");
> +		return true;
> +	}

This can be further optimized to:

        return !!(cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP);

-- 
~Vinod
