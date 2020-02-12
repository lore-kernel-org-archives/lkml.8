Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE28C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB7D20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBLLeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:34:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:46023 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBLLeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:34:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 03:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347498820"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 03:34:16 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 13:34:16 +0200
Date:   Wed, 12 Feb 2020 13:34:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
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
Subject: Re: [PATCH v5 01/18] platform/x86: intel_scu_ipc: Split out SCU IPC
 functionality from the SCU driver
Message-ID: <20200212113416.GU2667@lahna.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-2-mika.westerberg@linux.intel.com>
 <20200211153924.GD10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211153924.GD10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:39:24PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2020 at 04:25:46PM +0300, Mika Westerberg wrote:
> > The SCU IPC functionality is usable outside of Intel MID devices. For
> > example modern Intel CPUs include the same thing but now it is called
> > PMC (Power Management Controller) instead of SCU. To make the IPC
> > available for those split the driver into core part (intel_scu_ipc.c)
> > and the SCU PCI driver part (intel_scu_pcidrv.c) which then calls the
> > former before it goes and creates rest of the SCU devices. The SCU IPC
> > will also register a new class that gets assigned to the device that is
> > created under the parent PCI device.
> > 
> > We also split the Kconfig symbols so that INTEL_SCU_IPC enables the SCU
> > IPC library and INTEL_SCU_PCI the SCU driver and convert the users
> > accordingly. While there remove default y from the INTEL_SCU_PCI symbol
> > as it is already selected by X86_INTEL_MID.
> 
> ...
> 
> >  config INTEL_SCU_IPC
> 
> > +config INTEL_SCU
> 
> > +config INTEL_SCU_PCI
> 
> >  config INTEL_SCU_IPC_UTIL
> ...
> 
> >  obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
> >  obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
> >  obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
> > +obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
> 
> Please, keep the symbol ordering (whatever you choose) the same
> in Makefile and Kconfig.

OK, will do.
