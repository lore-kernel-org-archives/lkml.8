Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40F5C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 07:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00FC2468B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579331583;
	bh=8kYNVmCF+TfrVkxC52xPjvOoyGTuOnOi1x6LfPS1HMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1bQJlcCmCOUD/QDwRBuoetmUWTkrZLL5znGrj3k2WosD3OgNnhxxNO++hRJlKz0He
	 J0ZDtYi95NeXRFDSQ59vfF+FodXi8aLlVP0NGOyL9H+a7ITIhGiFatrKRVcNE3nZSY
	 aIlVQCrelEJlJSGJ9Cf//AT+929y5GkofLzccxu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgARHNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 02:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgARHNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 02:13:02 -0500
Received: from localhost (unknown [171.61.88.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC61F24687;
        Sat, 18 Jan 2020 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579331581;
        bh=8kYNVmCF+TfrVkxC52xPjvOoyGTuOnOi1x6LfPS1HMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxcKFA5dIk8hiFgSgSIkxdEqrhb4Xp8HVp2zECd7nhlwSBhIVih4XBzbCSzbcMCfS
         SSPwDKZ+7rMv+n3/QGbrQo0/sm7WB7a/8cMVgKRioeleQyh+FZ+K0Zt+MKE3/ymRPX
         pF726Ici8UpopGXeOuXhnMej6lXe4RPzYIz68X6U=
Date:   Sat, 18 Jan 2020 12:42:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
Message-ID: <20200118071257.GY2818@vkoul-mobl>
References: <20200114060959.GA2818@vkoul-mobl>
 <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 10:01, Pierre-Louis Bossart wrote:
> 
> > I am quoting the code in patch, which i pointed in my first reply!
> > 
> > On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> > 
> > > diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> > > index 4b769409f6f8..42f7ae034bea 100644
> > > --- a/drivers/soundwire/intel_init.c
> > 
> > This is intel specific file...
> > 
> > > +++ b/drivers/soundwire/intel_init.c
> > 
> > snip ...
> > 
> > > +static struct sdw_intel_ctx
> > > +*sdw_intel_probe_controller(struct sdw_intel_res *res)
> > 
> > this is intel driver, intel function!
> > 
> > > -
> > > -		link->pdev = pdev;
> > > -		link++;
> > > +		/* let the SoundWire master driver to its probe */
> > > +		md->driver->probe(md, link);
> >                              ^^^^^^
> > which does this... calls a probe()!
> > 
> > And my first reply was:
> > 
> > > > +             /* let the SoundWire master driver to its probe */
> > > > +             md->driver->probe(md, link);
> > > 
> > > So you are invoking driver probe here.. That is typically role of driver
> > > core to do that.. If we need that, make driver core do that for you!
> > 
> > I rest my case!
> 
> I think you are too focused on the probe case and not realizing the
> extensions suggested by this patchset. A "driver" is not limited to 'probe'
> and 'remove' cases.
> 
> As mentioned since mid-September, there is a need for an initialization of
> software/kernel structures (which I called probe but should have been called
> init really), and a second step where the hardware is actually configured -

I find it amusing that a person whom i admired for strict use of terms
can get this differently!

A rename away from probe will certainly be very helpful as
you would also agree that terms 'probe' and 'remove' have a very
special meaning in kernel, so let us avoid these

-- 
~Vinod
