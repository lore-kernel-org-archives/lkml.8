Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFE620787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgGPSVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:21:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:19378 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgGPSVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:21:22 -0400
IronPort-SDR: Zm/f1OQhboXoaHeqvT53dndd3NFwQtIARK00ut5FnVzGKUSzrtkW2bOizXM55sfNhtnOcLv+CE
 NSo4gw4TwB5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="150855389"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="150855389"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 11:21:21 -0700
IronPort-SDR: kNc46GhuYzuSAHRY/GsieDvarl/xNSWAnR+5QBxDKYczNj+8D7+X/J1loySBBahP/JPkvFCbZY
 8ftirJUHrc9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="391170669"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2020 11:21:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jw8VU-002Cr4-Gb; Thu, 16 Jul 2020 21:21:20 +0300
Date:   Thu, 16 Jul 2020 21:21:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        sakari.ailus@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Subject: Re: kernel oops in 'typec_ucsi' due to commit 'drivers property:
 When no children in primary, try secondary'
Message-ID: <20200716182120.GS3703480@smile.fi.intel.com>
References: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
 <20200716154721.GO3703480@smile.fi.intel.com>
 <43148a2ebe546fde67028d99fd7365acce1311b2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43148a2ebe546fde67028d99fd7365acce1311b2.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:00:00PM +0300, Maxim Levitsky wrote:
> On Thu, 2020-07-16 at 18:47 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 16, 2020 at 11:17:03AM +0300, Maxim Levitsky wrote:
> > > Hi!
> > > 
> > > Few days ago I bisected a regression on 5.8 kernel:
> > > 
> > > I have nvidia rtx 2070s and its USB type C port driver (which is open source)
> > > started to crash on load:
> > 
> > ...
> > 
> > > Reverting the commit helped fix this oops.
> > > 
> > > My .config attached.
> > > If any more info is needed I'll be happy to provide it,
> > > and of course test patches.
> > 
> > Can you test below?
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 1e6d75e65938..d58aa98fe964 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -721,7 +721,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
> >  		return next;
> >  
> >  	/* When no more children in primary, continue with secondary */
> > -	if (!IS_ERR_OR_NULL(fwnode->secondary))
> > +	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
> >  		next = fwnode_get_next_child_node(fwnode->secondary, child);
> >  
> >  	return next;
> 
> It works (no more oops)

Thanks for testing. I'm about to send formal patch, can you give your Tested-by tag there then?

-- 
With Best Regards,
Andy Shevchenko


