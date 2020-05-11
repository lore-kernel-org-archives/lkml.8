Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB4C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409982075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589197276;
	bh=qVA+9DJ79+6bkSsk8R/e1V4bMq1lEKRjniVj/AiExgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uNScaDXh3nUppErIVZ3uXHMj+IqbzSWO/WgLXKo3F0xhk1MrLkYEz+AHSsE9q7zip
	 IvcGvscXwHoVsoE7x5ulgShSjDQ0HnAFldS3wXtxEUoe3G60HV9M00SMVg5/jve9Fz
	 GVgBnx1cw0pZPEobRPZ/swvCzMIy09Bkz0aL5Sn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgEKLlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgEKLlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:41:15 -0400
Received: from localhost (unknown [122.167.117.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B16420708;
        Mon, 11 May 2020 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589197274;
        bh=qVA+9DJ79+6bkSsk8R/e1V4bMq1lEKRjniVj/AiExgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x7dILyMr6XdHySREvLDzpe5C5AhgDfkT6/IMWHn2goMLLn6acGj+pM7k7VtP6x9wZ
         77xc7BrxSSdZVjRgeXF/VDqfoKD3OJm0qYs8Pk6e7juqTbh3aZLFziSplI0QZ/GYLc
         ihYC1C3Ls3rqC5Vnqc8S5a+qrhBv1/9gn6Dpo3q8=
Date:   Mon, 11 May 2020 17:11:08 +0530
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
Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200511114108.GU1375924@vkoul-mobl>
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
 <20200511063227.GS1375924@vkoul-mobl>
 <DM6PR11MB40748EA6346831A67BD218C7FFA10@DM6PR11MB4074.namprd11.prod.outlook.com>
 <20200511090003.GT1375924@vkoul-mobl>
 <DM6PR11MB407432225D0DA6E671DBAF67FFA10@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB407432225D0DA6E671DBAF67FFA10@DM6PR11MB4074.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-20, 11:34, Liao, Bard wrote:
> 
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Monday, May 11, 2020 5:00 PM
> > To: Liao, Bard <bard.liao@intel.com>
> > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>; alsa-devel@alsa-project.org;
> > linux-kernel@vger.kernel.org; tiwai@suse.de; broonie@kernel.org;
> > gregkh@linuxfoundation.org; jank@cadence.com;
> > srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> > ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> > louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>;
> > Blauciak, Slawomir <slawomir.blauciak@intel.com>; Lin, Mengdong
> > <mengdong.lin@intel.com>
> > Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
> > 
> > On 11-05-20, 08:04, Liao, Bard wrote:
> > > > -----Original Message-----
> > > > From: Vinod Koul <vkoul@kernel.org>
> > > > Sent: Monday, May 11, 2020 2:32 PM
> > > > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> > > > tiwai@suse.de; broonie@kernel.org; gregkh@linuxfoundation.org;
> > > > jank@cadence.com; srinivas.kandagatla@linaro.org;
> > > > rander.wang@linux.intel.com; ranjani.sridharan@linux.intel.com;
> > > > hui.wang@canonical.com; pierre- louis.bossart@linux.intel.com; Kale,
> > > > Sanyog R <sanyog.r.kale@intel.com>; Blauciak, Slawomir
> > > > <slawomir.blauciak@intel.com>; Lin, Mengdong
> > > > <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> > > > Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device
> > > > support
> > > >
> > > > On 30-04-20, 02:51, Bard Liao wrote:
> > > > > @@ -24,9 +24,14 @@ int sdw_bus_master_add(struct sdw_bus *bus,
> > > > > struct
> > > > device *parent,
> > > > >  	struct sdw_master_prop *prop = NULL;
> > > > >  	int ret;
> > > > >
> > > > > -	if (!bus->dev) {
> > > > > -		pr_err("SoundWire bus has no device\n");
> > > > > -		return -ENODEV;
> > > >
> > > > This check is removed and not moved into sdw_master_device_add()
> > > > either, can you add here or in patch 1 and keep checking the parent
> > > > device please
> > >
> > > We will set bus->dev = &md->dev in the end of sdw_master_device_add().
> > 
> > We need to test if this is valid or not :)
> > 
> > > That's why we remove the test. But now I am wandering does it make
> > > sense to set bus->dev = &md->dev? Maybe it makes more sense to set
> > > bus->dev = sdw control device.
> > > A follow up question is that should slave device a child of bus device
> > > or master device? I would prefer bus device if it makes sense.
> > > I will check bus->dev and parent and remove bus->dev = &md->dev in the
> > > next version.
> > 
> > the parent is bus->dev and sdw_master_device created would be child of this
> > and should be set as such. You can remove it from bus object and keep in
> > sdw_master_device object, that is fine by me.
> 
> Looks like we don't need the parent and fwnode parameter since we can
> get them from bus->dev 😊

Quite right

> > The sdw_slave is child of sdw_master_device now and looks to be set correct.
> 
> So, it will be
> bus device
>     -> master device
>          -> slave device
> right?

yes

> 
> I have a question here. We have pm supported on bus and slave devices,
> but not master device. Will pm work with this architecture?
> Can it be
> bus device
>     -> master device & slave device?

yes it would and you should check it out. The pm (runtime_pm) works well
with child devices and parents, so we need to ensure that parents are
set properly.

Thanks
-- 
~Vinod
