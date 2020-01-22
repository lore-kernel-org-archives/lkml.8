Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC63C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB25D2467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAVOdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:33:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:46302 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVOdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:33:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 06:33:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="283964989"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jan 2020 06:33:15 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 22 Jan 2020 16:33:14 +0200
Date:   Wed, 22 Jan 2020 16:33:14 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/38] platform/x86: intel_scu_ipc: Drop
 intel_scu_ipc_raw_command()
Message-ID: <20200122143314.GS2665@lahna.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-12-mika.westerberg@linux.intel.com>
 <20200122133619.GB4963@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122133619.GB4963@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 02:36:19PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 21, 2020 at 07:00:47PM +0300, Mika Westerberg wrote:
> > There is no user for this function so we can drop it from the driver.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/include/asm/intel_scu_ipc.h |  2 -
> >  drivers/platform/x86/intel_scu_ipc.c | 63 ----------------------------
> >  2 files changed, 65 deletions(-)
> 
> These first 11 patches are fine, why didn't you just submit them as
> cleanups/fixes and then build on them with the rest?  Having to wade
> through 38-patch series is a pain...

OK, I'll submit the first cleanup patches separately so they can be
applied first and then rework rest of the series on top.
