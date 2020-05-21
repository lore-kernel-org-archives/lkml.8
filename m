Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09260C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A52207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590035820;
	bh=MA7haufr2rOvAnUOgYCt9oKAn9zrsqgUr5NKmHSkYiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vdysztUYIzpJPb/zsEwverl3zdEWvjO6G6DW7WXg5XoHuG24wHHcRKkkud5QGGeyK
	 swGe5UR2zcAPaxl2Zg967ri43d6DD5zqPctacwKd5cmNiVDq/r4EDumqltVUhMIg3T
	 RXINCuYSAUmFWqu2vPEihKRqaNcD7NrYIbQIcfJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgEUEg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgEUEg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:36:59 -0400
Received: from localhost (unknown [106.200.226.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F3E206D4;
        Thu, 21 May 2020 04:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590035819;
        bh=MA7haufr2rOvAnUOgYCt9oKAn9zrsqgUr5NKmHSkYiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxn0djuSvW5KFjPJ+JBsOrpo+bc5SYjBYZ+jiODEMYp2NZp8DstO4wfXYNrWAX53Z
         /RExFCtZpbMhO79mpPuIetbBzA6IJCo3slD+bvcowFTp3VdMxRrEQ1bUfFrlO90+Zj
         BhE342TjjZ1I1DYMtkH3H26ERD5mi4K0wj1Gx3mQ=
Date:   Thu, 21 May 2020 10:06:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Blauciak, Slawomir" <slawomir.blauciak@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 2/2] soundwire: intel: transition to 3 steps
 initialization
Message-ID: <20200521043655.GA374218@vkoul-mobl.Dlink>
References: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
 <20200519191903.6557-2-yung-chuan.liao@linux.intel.com>
 <20200520135425.GX374218@vkoul-mobl.Dlink>
 <DM6PR11MB4074165599273350FF7CA83EFFB70@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4074165599273350FF7CA83EFFB70@DM6PR11MB4074.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-20, 02:23, Liao, Bard wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Wednesday, May 20, 2020 9:54 PM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; tiwai@suse.de;
> > broonie@kernel.org; gregkh@linuxfoundation.org; jank@cadence.com;
> > srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> > ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> > louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>;
> > Blauciak, Slawomir <slawomir.blauciak@intel.com>; Lin, Mengdong
> > <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH 2/2] soundwire: intel: transition to 3 steps initialization
> > 
> > On 20-05-20, 03:19, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > >
> > > Rather than a plain-vanilla init/exit, this patch provides 3 steps in
> > > the initialization (ACPI scan, probe, startup) which makes it easier to
> > > detect platform support for SoundWire, allocate required resources as
> > > early as possible, and conversely help make the startup() callback
> > > lighter-weight with only hardware register setup.
> > 
> > Okay but can you add details in changelog on what each step would do?
> 
> Sure. Will do.
> 
> > 
> > > @@ -1134,25 +1142,15 @@ static int intel_probe(struct platform_device
> > *pdev)
> > >
> > >  	intel_pdi_ch_update(sdw);
> > >
> > > -	/* Acquire IRQ */
> > > -	ret = request_threaded_irq(sdw->link_res->irq,
> > > -				   sdw_cdns_irq, sdw_cdns_thread,
> > > -				   IRQF_SHARED, KBUILD_MODNAME, &sdw-
> > >cdns);
> > 
> > This is removed here but not added anywhere else, do we have no irq
> > after this patch?
> 
> We use a single irq for all Intel Audio DSP events and it will
> be requested in the SOF driver.

And how will the irq be propagated to sdw/cdns drivers here?

-- 
~Vinod
