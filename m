Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0822C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5423208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgG3Ntn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:49:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:49930 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgG3Ntm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:49:42 -0400
IronPort-SDR: mnCH8k2/HXBTuoHFUYapiqES7pfdQMrGuY38tucCi6xCdTcAK/wgq9FFrIQ/YQvdWE8SmIBIkp
 OuM7kX+tZq+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="169718017"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="169718017"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 06:49:42 -0700
IronPort-SDR: YfxvqpoKyzsmflNuxxBu6oPO+XZR32091cdTsL9vvl0irDWf+tVtZQf7QpLfYe2mK03lFSlx+h
 Ha7SQi7AyuYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="490662970"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2020 06:49:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k18wD-004xUf-Rl; Thu, 30 Jul 2020 16:49:37 +0300
Date:   Thu, 30 Jul 2020 16:49:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Lu, Brent" <brent.lu@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Add period size constraint on strago
 board
Message-ID: <20200730134937.GK3703480@smile.fi.intel.com>
References: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
 <1596096815-32043-3-git-send-email-brent.lu@intel.com>
 <20200730084219.GF3703480@smile.fi.intel.com>
 <DM6PR11MB3642F476740FFDAB29C3B8DF97710@DM6PR11MB3642.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3642F476740FFDAB29C3B8DF97710@DM6PR11MB3642.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 01:23:57PM +0000, Lu, Brent wrote:
> > On Thu, Jul 30, 2020 at 04:13:35PM +0800, Brent Lu wrote:
> > > From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > >
> > > The CRAS server does not set the period size in hw_param so ALSA will
> > > calculate a value for period size which is based on the buffer size
> > > and other parameters. The value may not always be aligned with Atom's
> > > dsp design so a constraint is added to make sure the board always has
> > > a good value.
> > >
> > > Cyan uses chtmax98090 and others(banon, celes, edgar, kefka...) use
> > > rt5650.
> > 
> > Actually one more comment here.
> > Can you split per machine driver?
> > 
> 
> It adds constraints on BSW Chromebooks for same purpose. I don't see the
> benefit to split it.

I didn't get this.

Purpose of splitting this to two is to keep track on per driver basis what has
had happen there.

But it's minor and up to maintainers, of course.

-- 
With Best Regards,
Andy Shevchenko


