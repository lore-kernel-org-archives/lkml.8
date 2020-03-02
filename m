Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F235FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE61C217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCBPmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:23080 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbgCBPmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 07:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="351565302"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2020 07:42:04 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8nCn-006IRf-It; Mon, 02 Mar 2020 17:42:05 +0200
Date:   Mon, 2 Mar 2020 17:42:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/19] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200302154205.GF1224808@smile.fi.intel.com>
References: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
 <20200302142621.GB3494@dell>
 <20200302143803.GI2667@lahna.fi.intel.com>
 <20200302151924.GC3494@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302151924.GC3494@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 03:19:24PM +0000, Lee Jones wrote:
> On Mon, 02 Mar 2020, Mika Westerberg wrote:
> > On Mon, Mar 02, 2020 at 02:26:21PM +0000, Lee Jones wrote:
> > > On Mon, 02 Mar 2020, Mika Westerberg wrote:

> > > > Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> > > > IPC communications with minor differences. This duplication does not make
> > > > much sense so this series reworks the two drivers so that there is only a
> > > > single implementation of the SCU IPC. In addition to that the API will be
> > > > updated to take SCU instance pointer as an argument, and most of the
> > > > callers will be converted to this new API. The old API is left there but
> > > > the plan is to get rid the callers and then the old API as well (this is
> > > > something we are working with Andy Shevchenko).
> > > > 
> > > > The intel_pmc_ipc.c is then moved under MFD which suits better for this
> > > > kind of a driver that pretty much sets up the SCU IPC and then creates a
> > > > bunch of platform devices for the things sitting behind the PMC. The driver
> > > > is renamed to intel_pmc_bxt.c which should follow the existing conventions
> > > > under drivers/mfd (and it is only meant for Intel Broxton derivatives).
> > > > 
> > > > This is on top of platform-driver-x86.git/for-next branch because there is
> > > > already some cleanup work queued that re-organizes Kconfig and Makefile
> > > > entries.
> > > > 
> > > > I have tested this on Intel Joule (Broxton-M) board.
> > > > 
> > > > Changes from v6:
> > > > 
> > > >   * Added Reviewed-by tag from Andy
> > > >   * Expanded PMC, IPC and IA acronyms
> > > >   * Drop TCO_DEVICE_NAME, PUNIT_DEVICE_NAME and TELEMETRY_DEVICE_NAME
> > > >   * Move struct intel_pmc_dev into include/linux/mfd/intel_pmc_bxt.h
> > > >   * Add PMC_DEVICE_MAX to the enum and use it
> > > >   * Add kernel-docs for simplecmd_store() and northpeak_store()
> > > >   * Use if (ret) return ret; over the ternary operator
> > > >   * Drop "This is index X" from comments
> > > >   * Use acpi_has_watchdog() to determine whether iTCO_wdt is added or not.
> > > >   * Rename intel_scu_ipc_pdata -> intel_scu_ipc_data to make it less
> > > >     confusing wrt. platform data for platform drivers.
> > > 
> > > Any reason why you've dropped all my tags?
> > 
> > You mean these?
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > I wasn't really sure what to do with them. They are not in the normal
> > tag format I've seen so I thought you use them yourself somehow to
> > manage your mailboxes. I can add them back if needed.
> 
> Yes, please add them, so I can track them.
> 
> It normally means that I plan to take the set through MFD and
> subsequently send an immutable pull-request out to the other
> Maintainers once all the other Acks have been provided.
> 
> MFD handles these kinds of cross-subsystem patch-sets often.

This series has dependencies to PDx86 (as mentioned in cover letter).

What do you prefer then, me to:
a) prepare ib from what I have, then you take it followed by me taking your ib, or
b) take everything and prepare ib for you?

-- 
With Best Regards,
Andy Shevchenko


