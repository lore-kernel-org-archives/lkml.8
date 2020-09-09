Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE0621D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIIKOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:14:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:30037 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgIIKOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:14:07 -0400
IronPort-SDR: 2nUnpAlrgAPWkeB0jDBWXA3HQIx8GDUK/pWDw3PdEGsMyTIvYOoCSn8rW3b0R8hMchnCDe+iYu
 wT8CegQfavhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="158336274"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="158336274"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 03:14:06 -0700
IronPort-SDR: 9MLrFPgsHmD4O0iz4AOWMMiE6QF6obCTq6Ip19VnTYxyNZl3Rndi09HcCruxytFUH128rw9S29
 Tl/VZoaf/zwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="333771047"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 03:14:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFx72-00FPka-Jr; Wed, 09 Sep 2020 13:14:00 +0300
Date:   Wed, 9 Sep 2020 13:14:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
Message-ID: <20200909101400.GK1891694@smile.fi.intel.com>
References: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
 <20200908121354.GA3848343@gmail.com>
 <20200908134350.GX1891694@smile.fi.intel.com>
 <20200909080020.GA2437694@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909080020.GA2437694@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 10:00:20AM +0200, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 08, 2020 at 02:13:54PM +0200, Ingo Molnar wrote:
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > uname => x86_64
> > make i386_defconfig
> > 
> > It was very convenient to not supply ARCH when build on multi-arch host.
> 
> Nice, TIL about the extended 'make *config' targets. :-)
> 
> Curiously, they aren't even mentioned in the 'configuration targets' 
> section of 'make help' and are not discoverable unless you know their 
> locations.
> 
> Anyway, your fix makes sense now to me too.

I see you applied original patch from Daniel.

> Do we need a similar for x86_64 defconfig, when built on 32-bit hosts? (not 
> that anyone does that in practice, but just for completeness.)

I never heard about such use, I consider it more academic rather than
practical.

> Also, it would be nice if there was a way to annotate the defconfig for 
> 'make savedefconfig' preserved these ARCH choices - it currently strips out 
> all non-enabled options that match their default configuration value.

Hmm... Yes, perhaps it would be nice to have such an exception.

-- 
With Best Regards,
Andy Shevchenko


