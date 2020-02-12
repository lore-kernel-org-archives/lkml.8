Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA7C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A552073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgBLLzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:55:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:60416 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgBLLzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:55:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 03:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="227804226"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2020 03:55:40 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1qcH-000vnl-Fl; Wed, 12 Feb 2020 13:55:41 +0200
Date:   Wed, 12 Feb 2020 13:55:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Subject: Re: [PATCH v5 03/18] platform/x86: intel_scu_ipc: Introduce new SCU
 IPC API
Message-ID: <20200212115541.GT10400@smile.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-4-mika.westerberg@linux.intel.com>
 <20200211154841.GF10400@smile.fi.intel.com>
 <20200212114341.GW2667@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212114341.GW2667@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 01:43:41PM +0200, Mika Westerberg wrote:
> On Tue, Feb 11, 2020 at 05:48:41PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2020 at 04:25:48PM +0300, Mika Westerberg wrote:
> > > The current SCU IPC API has been operating on a single instance and
> > > there has been no way to pin the providing module in place when the SCU
> > > IPC is in use.
> > > 
> > > This implements a new API that takes the SCU IPC instance as first
> > > parameter (NULL means the single instance is being used). The SCU IPC
> > > instance can be retrieved by calling new function
> > > intel_scu_ipc_dev_get() that take care of pinning the providing module
> > > in place as long as intel_scu_ipc_dev_put() is not called.
> > > 
> > > The old API and constants that are still being used are left there to
> > > support existing users that cannot be converted easily but they are put
> > > to a separate header that is subject to be removed eventually.
> > > Subsequent patches will convert most of the users over to the new API.
> > 
> > I'm thinking now if it would be better to do this in two steps, i.e. split out
> > legacy header first and then introduce new API?
> 
> No problem doing that but I'm not sure what's the benefit over what is
> done now?

That's what I'm trying to figure out. Would it be? Maybe you can play with it
locally and decide which one is better?

-- 
With Best Regards,
Andy Shevchenko


