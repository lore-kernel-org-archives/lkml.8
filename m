Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E40920849
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589982872;
	bh=CxK0gseNp+SBZ4zpW34ctL0VPz31/KFZU//G0BqDoic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYehkOGh+kfh63PHMtcpZe2E6WLlybnH7FLLyv70EzBs6mb+BAj5dp9/Kdk09Et1n
	 CgsMhCA3huIiLU0tpVkzz0r4Jeb8+b/IcF7n5BQmawuHH7XFEE1A6P/k/OKGhKUgZ/
	 Wts/adRoNncux7u3iqiJJ4/LSwSi6+Z3aZb0mr18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgETNyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETNyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:54:31 -0400
Received: from localhost (unknown [122.178.227.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E317F207F9;
        Wed, 20 May 2020 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589982870;
        bh=CxK0gseNp+SBZ4zpW34ctL0VPz31/KFZU//G0BqDoic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP5iWOo/9qDjvVjvbEylSRzNzc1P0LiHghbgdZY4dxGpzBJThK+EJ0f6GjpI/jIzt
         En0lE8LEBmTPGTp8Ufr1W6p3Hpu3kUdqZmNsxMlTom3yLxDB3rOECXh40wWr77fHf+
         AUhXCfu70UnH8kpKpvTXa6V+nu8yPMDlDlmqutzc=
Date:   Wed, 20 May 2020 19:24:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/2] soundwire: intel: transition to 3 steps
 initialization
Message-ID: <20200520135425.GX374218@vkoul-mobl.Dlink>
References: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
 <20200519191903.6557-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519191903.6557-2-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-20, 03:19, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Rather than a plain-vanilla init/exit, this patch provides 3 steps in
> the initialization (ACPI scan, probe, startup) which makes it easier to
> detect platform support for SoundWire, allocate required resources as
> early as possible, and conversely help make the startup() callback
> lighter-weight with only hardware register setup.

Okay but can you add details in changelog on what each step would do?

> @@ -1134,25 +1142,15 @@ static int intel_probe(struct platform_device *pdev)
>  
>  	intel_pdi_ch_update(sdw);
>  
> -	/* Acquire IRQ */
> -	ret = request_threaded_irq(sdw->link_res->irq,
> -				   sdw_cdns_irq, sdw_cdns_thread,
> -				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);

This is removed here but not added anywhere else, do we have no irq
after this patch?

> @@ -1205,5 +1201,5 @@ static struct platform_driver sdw_intel_drv = {
>  module_platform_driver(sdw_intel_drv);
>  
>  MODULE_LICENSE("Dual BSD/GPL");
> -MODULE_ALIAS("platform:int-sdw");
> +MODULE_ALIAS("sdw:intel-sdw");

it is still a platform device, so does sdw: tag make sense?
This is used by modprobe to load the driver!

> +/**
> + * sdw_intel_probe() - SoundWire Intel probe routine
> + * @res: resource data
> + *
> + * This creates SoundWire Master and Slave devices below the controller.

I dont think the comment is correct, this is done in intel_master_probe
which is platform device probe...

> + * All the information necessary is stored in the context, and the res
> + * argument pointer can be freed after this step.
> + */
> +struct sdw_intel_ctx
> +*sdw_intel_probe(struct sdw_intel_res *res)
> +{
> +	return sdw_intel_probe_controller(res);
> +}
> +EXPORT_SYMBOL(sdw_intel_probe);

I guess this would be called by SOF driver, question is when..?

> +/**
> + * sdw_intel_startup() - SoundWire Intel startup
> + * @ctx: SoundWire context allocated in the probe
> + *
> + */
> +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
> +{
> +	return sdw_intel_startup_controller(ctx);
> +}
> +EXPORT_SYMBOL(sdw_intel_startup);

when is this called, pls do document that

-- 
~Vinod
