Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475EEC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4420748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgGJOfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:35:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:48386 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgGJOfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:35:48 -0400
IronPort-SDR: PW4+0tFsmVEEFTCWe//jRB175Uahgbsqz5wIsSVeBp4oDjbB6FqhpfDvtRqbOiliMbjJ4UzpD1
 w2XZV8d02QvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="233069546"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="233069546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 07:35:30 -0700
IronPort-SDR: ECrrrkzvxc1YOLs1Tb1e4wtm6FjeWPUDFojMs/DsVc0DN6EH988x/HW76rC0HZqsRYezxxIYJh
 UOfNiwB0J9YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="316620225"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2020 07:35:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtu7d-0014Ir-O8; Fri, 10 Jul 2020 17:35:29 +0300
Date:   Fri, 10 Jul 2020 17:35:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200710143529.GR3703480@smile.fi.intel.com>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk>
 <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk>
 <20200710114622.GJ3703480@smile.fi.intel.com>
 <20200710120856.GD5653@sirena.org.uk>
 <20200710133233.GF5653@sirena.org.uk>
 <CAHp75VeWmWU6=ybDmQmv7ymwaHG+FxNBzZM9eBxp2Oie6MrZQw@mail.gmail.com>
 <CAHp75VcKSRem-eHi2FY89Y0yZcJrMVX_p_-OnF8+NuCrBSZfuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcKSRem-eHi2FY89Y0yZcJrMVX_p_-OnF8+NuCrBSZfuA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 05:15:27PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 10, 2020 at 5:13 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Jul 10, 2020 at 4:36 PM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 01:08:56PM +0100, Mark Brown wrote:
> > > > On Fri, Jul 10, 2020 at 02:46:22PM +0300, Andy Shevchenko wrote:
> > >
> > > > > You mean it's being synchronised with git.kernel.org, but not yet contains that
> > > > > patch? Okay, I will monitor the regmap tree (as of now I didn't see any update).
> > >
> > > > 5cc2013bfeee756a1ee6da9bfbe42e52b4695035
> > >
> > > Oh, I see your patch covered a different bit of code without covering
> > > the stuff in regmap-irq (which I'd just handled when your patch came in)
> > > for some reason so the changelog made it sound like the same code, and
> > > at the time you submitted it the patch was incomplete.
> >
> > Should I do anything to improve it?
> 
> Actually I think we can completely get rid of fwnode by switching to
> device properties.
> I'll send v2 soon.

Oops, I have looked into this and see that either way we would need an
additional conditional and fwnode approach looks better. So, if you agree with
v1, please apply.

-- 
With Best Regards,
Andy Shevchenko


