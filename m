Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B53C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F70620675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgBLLob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:44:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:59573 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBLLoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:44:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 03:44:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347499876"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 03:44:25 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 13:44:24 +0200
Date:   Wed, 12 Feb 2020 13:44:24 +0200
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
Subject: Re: [PATCH v5 07/18] platform/x86: intel_scu_ipc: Add managed
 function to register SCU IPC
Message-ID: <20200212114424.GX2667@lahna.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-8-mika.westerberg@linux.intel.com>
 <20200211155129.GG10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211155129.GG10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:51:29PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2020 at 04:25:52PM +0300, Mika Westerberg wrote:
> > Drivers such as intel_pmc_ipc.c can be unloaded as well so in order to
> > support those in this driver add a new function that can be called to
> > unregister the SCU IPC when it is not needed anymore.
> > 
> > We also add a managed version of the intel_scu_ipc_register() that takes
> > care of calling intel_scu_ipc_unregister() automatically when the driver
> > is unbound.
> 
> ...
> 
> > +	devres = devres_alloc(devm_intel_scu_ipc_unregister, sizeof(*devres),
> > +			      GFP_KERNEL);
> 
> Maybe devres -> dr and put on one line?
> But it's up to you, I'm fine with the current as well.

Sure, I'll change that.
