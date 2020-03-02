Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B691C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE06721775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgCBOiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:38:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:42161 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgCBOiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:38:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 06:38:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="351553732"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2020 06:38:03 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Mar 2020 16:38:03 +0200
Date:   Mon, 2 Mar 2020 16:38:03 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200302143803.GI2667@lahna.fi.intel.com>
References: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
 <20200302142621.GB3494@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302142621.GB3494@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 02:26:21PM +0000, Lee Jones wrote:
> On Mon, 02 Mar 2020, Mika Westerberg wrote:
> 
> > Hi all,
> > 
> > Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> > IPC communications with minor differences. This duplication does not make
> > much sense so this series reworks the two drivers so that there is only a
> > single implementation of the SCU IPC. In addition to that the API will be
> > updated to take SCU instance pointer as an argument, and most of the
> > callers will be converted to this new API. The old API is left there but
> > the plan is to get rid the callers and then the old API as well (this is
> > something we are working with Andy Shevchenko).
> > 
> > The intel_pmc_ipc.c is then moved under MFD which suits better for this
> > kind of a driver that pretty much sets up the SCU IPC and then creates a
> > bunch of platform devices for the things sitting behind the PMC. The driver
> > is renamed to intel_pmc_bxt.c which should follow the existing conventions
> > under drivers/mfd (and it is only meant for Intel Broxton derivatives).
> > 
> > This is on top of platform-driver-x86.git/for-next branch because there is
> > already some cleanup work queued that re-organizes Kconfig and Makefile
> > entries.
> > 
> > I have tested this on Intel Joule (Broxton-M) board.
> > 
> > Changes from v6:
> > 
> >   * Added Reviewed-by tag from Andy
> >   * Expanded PMC, IPC and IA acronyms
> >   * Drop TCO_DEVICE_NAME, PUNIT_DEVICE_NAME and TELEMETRY_DEVICE_NAME
> >   * Move struct intel_pmc_dev into include/linux/mfd/intel_pmc_bxt.h
> >   * Add PMC_DEVICE_MAX to the enum and use it
> >   * Add kernel-docs for simplecmd_store() and northpeak_store()
> >   * Use if (ret) return ret; over the ternary operator
> >   * Drop "This is index X" from comments
> >   * Use acpi_has_watchdog() to determine whether iTCO_wdt is added or not.
> >   * Rename intel_scu_ipc_pdata -> intel_scu_ipc_data to make it less
> >     confusing wrt. platform data for platform drivers.
> 
> Any reason why you've dropped all my tags?

You mean these?

For my own reference:                                                                                                                                                                       
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

I wasn't really sure what to do with them. They are not in the normal
tag format I've seen so I thought you use them yourself somehow to
manage your mailboxes. I can add them back if needed.
