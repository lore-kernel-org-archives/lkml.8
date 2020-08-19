Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C28C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20C8207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597828004;
	bh=+kIGh7xNBLq4Soui5QZSxxZW3BSSpRBV2ViZULaNly4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZfFCBJr87pKM7xGyaizDFcL2SIMViDB/2AVQ6XC7tH9DwKgh3GmhjK4EAfuAivz3/
	 3FBF49/ocYJvpEM0WFrezDKaxUHYf5JJTTN+W6Qx90pi9+kNh0JBOfoQAkrABqBi9i
	 UpjupxDW7o/9Sf0MEZ3MWNYUAmnDr5rn6Ob+VWc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgHSJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgHSJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:06:42 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402C02072D;
        Wed, 19 Aug 2020 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597828002;
        bh=+kIGh7xNBLq4Soui5QZSxxZW3BSSpRBV2ViZULaNly4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMW0n5iy8gqO/oeV3/AQHudp+ujLkQsnrje1maisElRLR1vFN2nGaPgkfP2/2S63f
         HsDwTO6PMmcB4QBY0dZXybGjOXPfdYarCusMqw/k9x+vlDkVjKDuXdk1fsy88Ax6pF
         UnKKYkXVmH2B72+FnyavT0pdHRvDq3gGDzI4SSYc=
Date:   Wed, 19 Aug 2020 14:36:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
Message-ID: <20200819090637.GE2639@vkoul-mobl>
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 06:23, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> In system suspend stress cases, the SOF CI reports timeouts. The root
> cause is that an alert is generated while the system suspends. The
> interrupt handling generates transactions on the bus that will never
> be handled because the interrupts are disabled in parallel.
> 
> As a result, the transaction never completes and times out on resume.
> This error doesn't seem too problematic since it happens in a work
> queue, and the system recovers without issues.
> 
> Nevertheless, this race condition should not happen. When doing a
> system suspend, or when disabling interrupts, we should make sure the
> current transaction can complete, and prevent new work from being
> queued.
> 
> BugLink: https://github.com/thesofproject/linux/issues/2344
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 24 +++++++++++++++++++++++-
>  drivers/soundwire/cadence_master.h |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 24eafe0aa1c3..1330ffc47596 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -791,7 +791,16 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
>  			     CDNS_MCP_INT_SLAVE_MASK, 0);
>  
>  		int_status &= ~CDNS_MCP_INT_SLAVE_MASK;
> -		schedule_work(&cdns->work);
> +
> +		/*
> +		 * Deal with possible race condition between interrupt
> +		 * handling and disabling interrupts on suspend.
> +		 *
> +		 * If the master is in the process of disabling
> +		 * interrupts, don't schedule a workqueue
> +		 */
> +		if (cdns->interrupt_enabled)
> +			schedule_work(&cdns->work);

would it not make sense to mask the interrupts first and then cancel the
work? that way you are guaranteed that after this call you dont have
interrupts and work scheduled?

>  	}
>  
>  	cdns_writel(cdns, CDNS_MCP_INTSTAT, int_status);
> @@ -924,6 +933,19 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
>  		slave_state = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
>  		cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave_state);
>  	}
> +	cdns->interrupt_enabled = state;
> +
> +	/*
> +	 * Complete any on-going status updates before updating masks,
> +	 * and cancel queued status updates.
> +	 *
> +	 * There could be a race with a new interrupt thrown before
> +	 * the 3 mask updates below are complete, so in the interrupt
> +	 * we use the 'interrupt_enabled' status to prevent new work
> +	 * from being queued.
> +	 */
> +	if (!state)
> +		cancel_work_sync(&cdns->work);
>  
>  	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
>  	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index fdec62b912d3..4d1aab5b5ec2 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -133,6 +133,7 @@ struct sdw_cdns {
>  
>  	bool link_up;
>  	unsigned int msg_count;
> +	bool interrupt_enabled;
>  
>  	struct work_struct work;
>  
> -- 
> 2.17.1

-- 
~Vinod
