Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C635C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3932098B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589187611;
	bh=BDYB2489D6y/f/ZLmWPRkC7M2YYCV1n5uByAKeQ1lak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OaSefw3n+OEMDGyzPG9nypPbaQ2SjQ8zJbLXteAaY0EK7zo0fhrxuGvQgUIjuNOBf
	 e+YI3f5Tw/BK1xZ4d1pkNHYJNn3/qUz6FKVo5t9cSSxbQCF3jJMLdiR50HIfD2au7b
	 TkrrnLjVXHwSZrs3O7XPcIUNLVUBnvj3LQ9oQ0EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEKJAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgEKJAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:00:10 -0400
Received: from localhost (unknown [122.167.117.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE4F2075E;
        Mon, 11 May 2020 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589187609;
        bh=BDYB2489D6y/f/ZLmWPRkC7M2YYCV1n5uByAKeQ1lak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLBdAK19I74250GJZYTRbU0zbhZgyxAOQ42dCYU6JbS+EY5737tpc3LSyKYc5YPRJ
         wSAEVi0RqbQcr2o4XhzD9yy/RbG5SJ/Wz17QKiqal+TW3FYZ9c4QPPUmNr+Yp5Q+iu
         GGklh++PYduMuCsxriXuFrOXAcbsiBKRsY4+GpTY=
Date:   Mon, 11 May 2020 14:30:03 +0530
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
Message-ID: <20200511090003.GT1375924@vkoul-mobl>
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
 <20200511063227.GS1375924@vkoul-mobl>
 <DM6PR11MB40748EA6346831A67BD218C7FFA10@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40748EA6346831A67BD218C7FFA10@DM6PR11MB4074.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-20, 08:04, Liao, Bard wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Monday, May 11, 2020 2:32 PM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; tiwai@suse.de;
> > broonie@kernel.org; gregkh@linuxfoundation.org; jank@cadence.com;
> > srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> > ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> > louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>;
> > Blauciak, Slawomir <slawomir.blauciak@intel.com>; Lin, Mengdong
> > <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
> > 
> > On 30-04-20, 02:51, Bard Liao wrote:
> > > @@ -24,9 +24,14 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct
> > device *parent,
> > >  	struct sdw_master_prop *prop = NULL;
> > >  	int ret;
> > >
> > > -	if (!bus->dev) {
> > > -		pr_err("SoundWire bus has no device\n");
> > > -		return -ENODEV;
> > 
> > This check is removed and not moved into sdw_master_device_add() either, can
> > you add here or in patch 1 and keep checking the parent device please
> 
> We will set bus->dev = &md->dev in the end of sdw_master_device_add().

We need to test if this is valid or not :)

> That's why we remove the test. But now I am wandering does it make sense
> to set bus->dev = &md->dev? Maybe it makes more sense to set bus->dev =
> sdw control device. 
> A follow up question is that should slave device a child of bus device or
> master device? I would prefer bus device if it makes sense. 
> I will check bus->dev and parent and remove bus->dev = &md->dev in the
> next version.

the parent is bus->dev and sdw_master_device created would be child of
this and should be set as such. You can remove it from bus object and
keep in sdw_master_device object, that is fine by me.

The sdw_slave is child of sdw_master_device now and looks to be set
correct.

-- 
~Vinod
