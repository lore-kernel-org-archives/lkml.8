Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB2C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51612051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbgCPPyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:54:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:43449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbgCPPyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:54:16 -0400
IronPort-SDR: XFU8staHDfseMNyCmKOsjQ6TDmEwHMW64iYAmDHFF6sKcKWvUoxchi9NyDxp2W1vEmFo7+geDN
 TmsYXHaKoReg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 08:54:16 -0700
IronPort-SDR: 9H7ibSLxOG2DT+oZsHA7wkTCY/juNIBOfL08d2HhpLx5fHL22J3Nu/YZTYNtY3qTsRh47ZBz1p
 yFK+Uta4yhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="233204234"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2020 08:54:13 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jDs4F-00A6Zn-WA; Mon, 16 Mar 2020 17:54:15 +0200
Date:   Mon, 16 Mar 2020 17:54:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] x86/quirks: Convert DMI matching to use a table
Message-ID: <20200316155415.GT1922688@smile.fi.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
 <20200122112306.64598-6-andriy.shevchenko@linux.intel.com>
 <874kuo9v6l.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kuo9v6l.fsf@ashishki-desk.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 05:27:30PM +0200, Alexander Shishkin wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > +static const struct dmi_system_id x86_machine_table[] __initconst = {
> > +	{
> > +		.ident = "x86 Apple Macintosh",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> > +		},
> > +		.driver_data = &x86_apple_machine,
> > +	},
> > +	{
> > +		.ident = "x86 Apple Macintosh",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
> > +		},
> > +		.driver_data = &x86_apple_machine,
> > +	},
> > +	{}
> > +};
> > +
> > +static void __init early_platform_detect_quirk(void)
> > +{
> > +	const struct dmi_system_id *id;
> > +
> > +	id = dmi_first_match(x86_machine_table);
> > +	if (!id)
> > +		return;
> > +
> > +	printk(KERN_DEBUG "Detected %s platform\n", id->ident);
> > +	*((bool *)id->driver_data) = true;
> 
> I'd suggest that x86_apple_machine and the ones that you add further
> down this patchset, be made functions instead. That way you could at
> first hide the global bool(s) and then replace this with something a
> little more type safe.

I'm not sure we will get any benefit of the proposed change. Also it will be
more intrusive since we have dozen of modules that are using it in the form of
exported boolean.

-- 
With Best Regards,
Andy Shevchenko


