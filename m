Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A22C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E231D20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404584AbgDOQoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:44:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:20935 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404634AbgDOQn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:43:58 -0400
IronPort-SDR: kYAeWkmNNhXeN8kAglaA8wce/XXfsDnIfj81G/mvMuyXQPinrDotYQQ9pKLImgCq3v9ZSZ2Pyd
 CH7lvUUNMT8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 09:43:55 -0700
IronPort-SDR: fuagpmujq77Rziv1zLS89tA66hrokcG+kqQcDL48t9oyYrlnE8kYF9kpV2ECtPeXNwsgFX/yNK
 WglxWEVbKDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="256912004"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2020 09:43:52 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jOl8l-000pTo-38; Wed, 15 Apr 2020 19:43:55 +0300
Date:   Wed, 15 Apr 2020 19:43:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 8/9] ASoC: rt5645: Switch DMI table match to a test of
 variable
Message-ID: <20200415164355.GW185537@smile.fi.intel.com>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
 <20200415145524.31745-9-andriy.shevchenko@linux.intel.com>
 <20200415162507.GG5265@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415162507.GG5265@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:25:07PM +0100, Mark Brown wrote:
> On Wed, Apr 15, 2020 at 05:55:23PM +0300, Andy Shevchenko wrote:
> > Since we have a common x86 quirk that provides an exported variable,
> > use it instead of local DMI table match.
> > 
> > Note, arch/x86/kernel/quirks.c::early_platform_detect_quirk() prints
> > the detected platform.
> 
> > @@ -3674,13 +3675,6 @@ static const struct dmi_system_id dmi_platform_data[] = {
> >  		},
> >  		.driver_data = (void *)&intel_braswell_platform_data,
> >  	},
> > -	{
> > -		.ident = "Microsoft Surface 3",
> > -		.matches = {
> > -			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
> > -		},
> > -		.driver_data = (void *)&intel_braswell_platform_data,
> > -	},
> >  	{
> 
> Are we going to convert all the other platforms to using a variable too?

It makes sense to ones that have spread quirks over the kernel, like Apple.

-- 
With Best Regards,
Andy Shevchenko


