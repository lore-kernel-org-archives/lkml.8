Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDB1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6062C208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589178753;
	bh=2NLujalkFrwrN4wsSJO1B+cIhyLExOYM1THy3Lqg6TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ij9Leh1SjWT7QQmVAVdIvmOLHtKwdrA2/vSktv7HbqW2QgVHr03kClGhHWzWYXDh4
	 LarT36fARLZv5qc1in/5/2J2UIP6m/o+vIzwTJp/HLfM5rh9ZmRkZWJnbb+48L3OAc
	 w6f14h/x07ZeZYUHLM7Vw35OfMwe1m1phkwTt4Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgEKGcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKGcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:32:32 -0400
Received: from localhost (unknown [122.167.117.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0955E207DD;
        Mon, 11 May 2020 06:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589178751;
        bh=2NLujalkFrwrN4wsSJO1B+cIhyLExOYM1THy3Lqg6TQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9kvfO/zExXGRVKlys3c28Ud+Gcpe6GQArrRMKHo+8aF3KgiZwYiTw3JHPwS91sdU
         /n4Prhvsm5Vu1boMsRGzV5YPloyF2FAz6GwTfZy3Yr2WMWVtPEiBsVx7JTVdNodGMb
         xy8lMkgIfXSZP0gZGSOhrjfeqeHH58gJJDZmWohQ=
Date:   Mon, 11 May 2020 12:02:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200511063227.GS1375924@vkoul-mobl>
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-04-20, 02:51, Bard Liao wrote:
> @@ -24,9 +24,14 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  	struct sdw_master_prop *prop = NULL;
>  	int ret;
>  
> -	if (!bus->dev) {
> -		pr_err("SoundWire bus has no device\n");
> -		return -ENODEV;

This check is removed and not moved into sdw_master_device_add() either,
can you add here or in patch 1 and keep checking the parent device please

> +int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
> +			  struct fwnode_handle *fwnode)
> +{
> +	struct sdw_master_device *md;
> +	int ret;
> +
> +	if (!bus)
> +		return -EINVAL;
> +
> +	/*
> +	 * Unlike traditional devices, there's no allocation here since the
> +	 * sdw_master_device is embedded in the bus structure.
> +	 */

Looking at this and empty sdw_master_device_release() above, makes me
wonder if it is a wise move? Should we rather allocate the
sdw_master_device() and then free that up in sdw_master_device_release()
or it is really overkill given that this is called when we remove the
sdw_bus instance as well...

> +	md = &bus->md;
> +	md->dev.bus = &sdw_bus_type;
> +	md->dev.type = &sdw_master_type;
> +	md->dev.parent = parent;
> +	md->dev.of_node = parent->of_node;
> +	md->dev.fwnode = fwnode;
> +	md->dev.dma_mask = parent->dma_mask;
> +
> +	dev_set_name(&md->dev, "sdw-master-%d", bus->link_id);

This give nice sdw-master-0. In DT this comes from reg property. I dont
seem to recall if the ACPI/Disco spec treats link_id as unique across
the system, can you check that please, if not we would need to update
this.

-- 
~Vinod
