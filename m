Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B65C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7051D2187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578892688;
	bh=3JKBMvq4OBBdAcG1hCHnQX+4annnKW7d3wE9F87ZrQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GwADWLeGQexOGMAgvBs+HKJQJ2bSAkqTISux74rlItWkaVvmw0ow5fPRvykY0n035
	 U1IKqwifSFaakmUTks1iSDTSH/wMPjzSZvXa2HjaNYok19nWN8eKE4ZsQYqSfD8bdg
	 tUNQA/boBEYKxfBDR25Ty2C1MSz6P9b6jWEvWCYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgAMFSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgAMFSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:18:07 -0500
Received: from localhost (unknown [106.200.247.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A14E9214D8;
        Mon, 13 Jan 2020 05:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578892686;
        bh=3JKBMvq4OBBdAcG1hCHnQX+4annnKW7d3wE9F87ZrQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3jz0N5Aoe9CXGAepvpGpVO8BvntXLyGAFDvV2r7gStAYSdri3pOEjAVGuvqE90DX
         IU625KzcsjrajuGt3ZYEMNwOnVbQoMuroxzAJ0S22qj4gYUwgeuLYppsABVWD+IGYC
         NEXfnlIRxHM3j/ghpm4vg8BvyL1CtREVllqfgrtI=
Date:   Mon, 13 Jan 2020 10:48:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
Message-ID: <20200113051800.GP2818@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-10-pierre-louis.bossart@linux.intel.com>
 <20191227090826.GM3006@vkoul-mobl>
 <5be4d9df-0f46-d36f-471c-aae9e1f55cc0@linux.intel.com>
 <20200106054221.GN2818@vkoul-mobl>
 <32ae46a7-59ee-4815-270a-a519ff462345@linux.intel.com>
 <20200110064303.GX2818@vkoul-mobl>
 <39000dd7-3f77-bc33-0ad3-aa47ba2360f7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39000dd7-3f77-bc33-0ad3-aa47ba2360f7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-20, 10:08, Pierre-Louis Bossart wrote:
> 
> > > > The "big" difference is that probe is called by core (asoc) and not by
> > > > driver onto themselves.. IMO that needs to go away.
> > > 
> > > What I did is not different from what existed already with platform devices.
> > > They were manually created, weren't they?
> > 
> > Manual creation of device based on a requirement is different, did I ask
> > you why you are creating device :)
> > 
> > I am simple asking you not to call probe in the driver. If you need
> > that, move it to core! We do not want these kind of things in the
> > drivers...
> 
> What core are you talking about?

soundwire core ofcourse! IMO All that which goes into soundwire-bus-objs is
considered as soundwire core part and rest are drivers intel, qc, so on!
> 
> The SOF intel driver needs to create a device, which will then be bound with
> a SoundWire master driver.
> 
> What I am doing is no different from what your team did with
> platform_register_device, I am really lost on what you are asking.

Again repeating myself, you call an API to do that is absolutely fine,
but we don't do that in drivers or open code these things

> > > > > FWIW, the implementation here follows what was suggested for Greybus 'Host
> > > > > Devices' [1] [2], so it's not like I am creating any sort of dangerous
> > > > > precedent.
> > > > > 
> > > > > [1]
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/greybus/es2.c#L1275
> > > > > [2] https://elixir.bootlin.com/linux/latest/source/drivers/greybus/hd.c#L124
> > > > 
> > > > And if you look closely all this work is done by core not by drivers!
> > > > Drivers _should_ never do all this, it is the job of core to do that for
> > > > you.
> > > 
> > > Please look at the code again, you have a USB probe that will manually call
> > > the GreyBus device creation.
> > > 
> > > static int ap_probe(struct usb_interface *interface,
> > > 		    const struct usb_device_id *id)
> > > {
> > > 	hd = gb_hd_create(&es2_driver, &udev->dev, 	
> > > 
> > > 
> > > static struct usb_driver es2_ap_driver = {
> > > 	.name =		"es2_ap_driver",
> > > 	.probe =	ap_probe, <<< code above
> > > 	.disconnect =	ap_disconnect,
> > > 	.id_table =	id_table,
> > > 	.soft_unbind =	1,
> > > };
> > 
> > Look closely the driver es2 calls into greybus core hd.c and gets the
> > work done, subtle but a big differances in the approaches..
> 
> I am sorry, I have absolutely no idea what you are referring to.
> 
> The code I copy/pasted here makes no call to the greybus core, it's ap_probe
> -> gb_hd_create. No core involved. If I am mistaken, please show me what I
> got wrong.

1. es2_ap_driver is host controller driver

2. gb_hd_create() is an API provided by greybus core!

es2 driver doesn't open code creation like you are doing in intel driver,
it doesn't call probe on its own, greybus does that

This is very common pattern in linux kernel subsytems, drivers dont do
these things, the respective subsystem core does that... see about es2
driver and implementation of gb_hd_create(). See callers of
platform_register_device() and its implementation.

I don't know how else I can explain this to you, is something wrong in
how I conveyed this info or you... or something else, I dont know!!!

-- 
~Vinod
