Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A8DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0A22B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583339322;
	bh=5ydkZ9GI1xp5CSnH6d1x60QXKXUBFoGsFKeAO+VEw6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gawKgOqQ+WPxxz2FJX2MFV63iWdWhLf0RxIrh6rT9qx9iF0GluONyiMQFPLPANsFa
	 0BhhlfMj9Z6NFziwUhSjYtuWAE7z7gwELVmQjG/UmZRw1k0L2jolwDy6jhE1jfMbtq
	 guCLpxf2A3MBVrtvy/kX+3weJto4gSggAdvBVw9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgCDQ2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:28:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgCDQ2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:28:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E6922522;
        Wed,  4 Mar 2020 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583339319;
        bh=5ydkZ9GI1xp5CSnH6d1x60QXKXUBFoGsFKeAO+VEw6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCatE1f8ucLJ2F2C285nv2wSRkWZxUXTxj8XLMzEWid4bqiN+ar8IYm4xkSnsjC77
         vz9iVOWr1hd6Qll+HjWet5SQoRUZ39jgplHCJRmIk7F4tQUD2F/CIct6AxVbVq6CQW
         yMWQwWd0cRLml5nCP+DJzlXu6UTzEVwCQ7fc/NeQ=
Date:   Wed, 4 Mar 2020 17:28:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        tiwai@suse.de, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
Message-ID: <20200304162837.GA1763256@kroah.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-2-pierre-louis.bossart@linux.intel.com>
 <20200303054136.GP4148@vkoul-mobl>
 <8a04eda6-cbcf-582f-c229-5d6e4557344b@linux.intel.com>
 <20200304095312.GT4148@vkoul-mobl>
 <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:17:07AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> > Were the above lines agreed or not? Do you see driver for master devices
> > or not? Greg was okay with as well as these patches but I am not okay
> > with the driver part for master, so I would like to see that removed.
> > 
> > Different reviewers can have different reasons.. I have given bunch of
> > reasons here, BUT I have not seen a single technical reason why this
> > cannot be done.
> 
> With all due respect, I consider Greg as THE reviewer for device/driver
> questions. Your earlier proposal to use platform devices was rejected by
> Greg, and we've lost an entire month in the process, so I am somewhat
> dubious on your proposal not to use a driver.
> 
> If you want a technical objection, let me restate what I already mentioned:
> 
> If you look at the hierarchy, we have
> 
> PCI device -> PCI driver
>   soundwire_master_device0
>      soundwire_slave(s) -> codec driver
>   ...
>   soundwire_master_deviceN
>      soundwire_slave(s) -> codec driver
> 
> You have not explained how I could possibly deal with power management
> without having a driver for the master_device(s). The pm_ops need to be
> inserted in a driver structure, which means we need a driver. And if we need
> a driver, then we might as well have a real driver with .probe .remove
> support, driver_register(), etc.

To weigh in here, yes, you need such a "device" here as it isn't the PCI
device that you can use, you need your own.  Just like most other busses
have this (USB has host controller drivers as one example, that create
the "root bus" device that all other USB devices hang off of.)  This
"controller device" should hang off of the hardware device be it a
platform/PCI/i2c/spi/serial/whatever type of controller.  That's why it
is needed.

> I really don't see what's broken or unnecessary with these patches.

The "wait until something else happens" does seem a bit hacky, odds are
that's not really needed if you are using the driver model correctly,
but soundwire is "odd" in places so maybe that is necessary, I'll defer
to you two on that mess :)

thanks,

greg k-h
