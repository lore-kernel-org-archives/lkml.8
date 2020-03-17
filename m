Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7886FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537E2205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgCQIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:43:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:23764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgCQIn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:43:27 -0400
IronPort-SDR: vN7byG2GEXD7msGWL1dU5RXrBSqRRiLNgRucM0EY9DJ4+VwmDonn2pfauZAwnbg3C7oOy4gYIu
 phkFLI1CYlRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 01:43:26 -0700
IronPort-SDR: +docOiDqVc1l3NEISqhzMl5AJ6YYAkBWQjirftyHCvIHVoRaBFmc0eqdgdnBiYxtpGPqTX5uI4
 ElQjYnYSjE3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="355297772"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2020 01:43:22 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 17 Mar 2020 10:43:21 +0200
Date:   Tue, 17 Mar 2020 10:43:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/19] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200317084321.GC2601@lahna.fi.intel.com>
References: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Mar 03, 2020 at 04:36:30PM +0300, Mika Westerberg wrote:
> Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> IPC communications with minor differences. This duplication does not make
> much sense so this series reworks the two drivers so that there is only a
> single implementation of the SCU IPC. In addition to that the API will be
> updated to take SCU instance pointer as an argument, and most of the
> callers will be converted to this new API. The old API is left there but
> the plan is to get rid the callers and then the old API as well (this is
> something we are working with Andy Shevchenko).
> 
> The intel_pmc_ipc.c is then moved under MFD which suits better for this
> kind of a driver that pretty much sets up the SCU IPC and then creates a
> bunch of platform devices for the things sitting behind the PMC. The driver
> is renamed to intel_pmc_bxt.c which should follow the existing conventions
> under drivers/mfd (and it is only meant for Intel Broxton derivatives).
> 
> This series is on top of platform-driver-x86.git/for-next because there are
> a couple of commits in that branch that re-organize the Kconfig and
> Makefile of drivers/platform/x86. So these do not apply cleanly without
> those commits. For this reason I would prefer this to go through pdx86 tree
> if there are no objections.

If there are no objections it would be nice to get this series merged for v5.7.

Thanks!
