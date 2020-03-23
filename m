Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBEC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54E420870
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584965903;
	bh=hxcrz2tO+N8anTbgxKJo/lWuzhD01NFnXAyUAjiHza4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vx/n/GVoCXXK8VEOO32fh50uj3vNYBCjNCnDEYdMI95kJi2UtycZiGyUD/Z4VUeFg
	 DmXL+XAeYUmdoHa+2ofwleh0WOWVO8N/18gK2v7gY2Ap/1aWZcpk4tTZOZ0qsbjbZH
	 wFUNiHInFzP+s/DKz3f/e2qFxCzpkIEkDVrh2Axo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCWMSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbgCWMSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:18:22 -0400
Received: from localhost (unknown [122.178.205.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63E520788;
        Mon, 23 Mar 2020 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584965901;
        bh=hxcrz2tO+N8anTbgxKJo/lWuzhD01NFnXAyUAjiHza4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PI/1uCxozIzKRx7vhHJPe0CsTSpO3XsKw9Sgd+LFaJn3Ln0JiFczyNebpU4XmLahd
         9k2Jsj9Y9e6Vi6VVRWE8rmYkHk7u/wYVR2cGXT9q7MejalmAbv5lilBEiRO4MKJcu9
         rTiJ3RLUkcFlToDqkbg1zA0SKTiB/OAXgLwUGy1Q=
Date:   Mon, 23 Mar 2020 17:48:17 +0530
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
Subject: Re: [PATCH 3/7] soundwire: intel: add mutex to prevent concurrent
 access to SHIM registers
Message-ID: <20200323121817.GK72691@vkoul-mobl>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-4-pierre-louis.bossart@linux.intel.com>
 <20200320134112.GC4885@vkoul-mobl>
 <a989368c-5a57-a726-0816-2e389d733ae0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a989368c-5a57-a726-0816-2e389d733ae0@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-20, 09:07, Pierre-Louis Bossart wrote:
> 
> > > diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
> > > index 38b7c125fb10..568c84a80d79 100644
> > > --- a/drivers/soundwire/intel.h
> > > +++ b/drivers/soundwire/intel.h
> > > @@ -15,6 +15,7 @@
> > >    * @irq: Interrupt line
> > >    * @ops: Shim callback ops
> > >    * @dev: device implementing hw_params and free callbacks
> > > + * @shim_lock: mutex to handle access to shared SHIM registers
> > >    */
> > >   struct sdw_intel_link_res {
> > >   	struct platform_device *pdev;
> > > @@ -25,6 +26,7 @@ struct sdw_intel_link_res {
> > >   	int irq;
> > >   	const struct sdw_intel_ops *ops;
> > >   	struct device *dev;
> > > +	struct mutex *shim_lock; /* protect shared registers */
> > 
> > Where is this mutex initialized? Did you test this...
> 
> Dude, we've been testing the heck out of SoundWire.
> 
> If you want to see the actual initialization it's in the intel_init.c code:
> 
> https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L231

Which doesn't make much sense. A patch should do complete thing. I don't
see a reason why you cannot pull this single line into this patch.

It belongs here, not anywhere else.

-- 
~Vinod
