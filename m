Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A91C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5629D20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBLLsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:48:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:10182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgBLLsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:48:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 03:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347500425"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 03:48:07 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 13:48:06 +0200
Date:   Wed, 12 Feb 2020 13:48:06 +0200
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
Subject: Re: [PATCH v5 18/18] MAINTAINERS: Update entry for Intel Broxton PMC
 driver
Message-ID: <20200212114806.GZ2667@lahna.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-19-mika.westerberg@linux.intel.com>
 <20200211160133.GI10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211160133.GI10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:01:33PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2020 at 04:26:03PM +0300, Mika Westerberg wrote:
> > The driver lives now under MFD so split the current entry into two parts
> > and add me as co-maintainer of the Intel Broxton PMC driver. While there
> > correct formatting of Zha Qipeng's email address.
> 
> ...
> 
> > -INTEL PMC/P-Unit IPC DRIVER
> > -M:	Zha Qipeng<qipeng.zha@intel.com>
> > +INTEL P-Unit IPC DRIVER
> > +M:	Zha Qipeng <qipeng.zha@intel.com>
> >  L:	platform-driver-x86@vger.kernel.org
> >  S:	Maintained
> > -F:	arch/x86/include/asm/intel_pmc_ipc.h
> >  F:	arch/x86/include/asm/intel_punit_ipc.h
> > -F:	drivers/platform/x86/intel_pmc_ipc.c
> >  F:	drivers/platform/x86/intel_punit_ipc.c
> >  
> >  INTEL PMIC GPIO DRIVERS
> 
> Does it stays at the same place after executing parse-maintainers.pl?

Good point, the entry needs to be moved in the correct place to keep it
sorted alphabetically since the name changes now from PMC -> P-Unit.
