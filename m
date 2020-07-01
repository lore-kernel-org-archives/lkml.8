Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311FBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0388720760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593583021;
	bh=qyAj0nKPFYUi90Eumgd+ayXy3UaN1w3BRIx9nkrkAZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=keV62A7eDUFdLNmafTyQa1SdZszAgyaKNM1DlykkpXP18HYcYyXPrp1lTpSiHIt48
	 w4j2A2jXwcvz2VDaFlZD8zd93XMbnI5/SO0OvZF31HTtw95n4prsYA4BY5107Bp/9p
	 0xLLyC3jhR5BQ9g19i+YHX+ANjHJayGYyxC8gvns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgGAF47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 01:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgGAF46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:56:58 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5082F20747;
        Wed,  1 Jul 2020 05:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593583018;
        bh=qyAj0nKPFYUi90Eumgd+ayXy3UaN1w3BRIx9nkrkAZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKDS7ThlTXWAo/SqAgJWHqPz/ggV+FOXBVbgF/Qcksbg3SqE6/+0l7TIu6JQdRh4X
         3Xq1M0ZgBFsx6qTwtO0SMVsA5gFuPeoo1wPqRRzMiE4UykG+6q7BPXzEf+Azts0Tn9
         sx0NxH/PXxKJgzKSGgluF9W5VKwAXjM5+e5AwlOA=
Date:   Wed, 1 Jul 2020 11:26:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 8/9] soundwire: intel: add wake interrupt support
Message-ID: <20200701055654.GW2599@vkoul-mobl>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
 <20200623173546.21870-9-yung-chuan.liao@linux.intel.com>
 <20200630165126.GT2599@vkoul-mobl>
 <a69aa5d0-613a-6ef6-9263-378b1e99770a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69aa5d0-613a-6ef6-9263-378b1e99770a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-20, 12:18, Pierre-Louis Bossart wrote:
> > > +		return 0;
> > > +	}
> > > +
> > > +	shim = sdw->link_res->shim;
> > > +	wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
> > > +
> > > +	if (!(wake_sts & BIT(sdw->instance)))
> > > +		return 0;
> > > +
> > > +	/* disable WAKEEN interrupt ASAP to prevent interrupt flood */
> > > +	intel_shim_wake(sdw, false);
> > 
> > when & where is this enabled?
> 
> in follow-up patches where the clock-stop mode is enabled.

ok

> > > +	 * wake up master and slave so that slave can notify master
> > > +	 * the wakeen event and let codec driver check codec status
> > > +	 */
> > > +	list_for_each_entry(slave, &bus->slaves, node) {
> > > +		/*
> > > +		 * discard devices that are defined in ACPI tables but
> > > +		 * not physically present and devices that cannot
> > > +		 * generate wakes
> > > +		 */
> > > +		if (slave->dev_num_sticky && slave->prop.wake_capable)
> > > +			pm_request_resume(&slave->dev);
> > 
> > Hmmm, shouldn't slave do this? would it not make sense to notify the
> > slave thru callback and then slave decides to resume or not..?
> 
> In this mode, the bus is clock-stop mode, and events are detected with level
> detector tied to PCI events. The master and slave devices are all in
> pm_runtime suspended states. The codec cannot make any decisions on its own
> since the bus is stopped, it needs to first resume, which assumes that the
> master resumes first and the enumeration re-done before it can access any of
> its registers.
> 
> By looping through the list of devices that can generate events, you end-up
> first forcing the master to resume, and then each slave resumes and can
> check who generated the event and what happened while suspended. if the
> codec didn't generate the event it will go back to suspended mode after the
> usual timeout.
> 
> We can add a callback but that callback would only be used for Intel
> solutions, but internally it would only do a pm_request_resume() since the
> codec cannot make any decisions before first resuming. In other words, it
> would be an Intel-specific callback that is implemented using generic resume
> operations. It's probably better to keep this in Intel-specific code, no?

I do not like the idea that a device would be woken up, that kind of
defeats the whole idea behind the runtime pm. Waking up a device to
check the events is a generic sdw concept, I don't see that as Intel
specific one.

I would like to see a generic callback for the devices and let devices
do the resume part, that is standard operating principle when we deal
with suspended devices. If the device thinks they need to resume, they
will do the runtime resume, check the status and sleep if not
applicable. Since we have set the parents correctly, any resume
operation for slaves would wake master up as well...

I do not see a need for intel driver to resume slave devices here, or
did I miss something?

-- 
~Vinod
