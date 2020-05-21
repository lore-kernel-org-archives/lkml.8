Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459BE206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgEUPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:53:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:16692 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUPxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:53:03 -0400
IronPort-SDR: cNuu8YoJPC03MPywHk5NA3gFTOoLkTFFrkqjE2HTmNhmn2NlpD6UTu82kCU9U/LBQRCylo1yRY
 7RKGskc7vNTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 08:53:02 -0700
IronPort-SDR: eKT5YmAuvpOe2jI/yMyUnzaqoYjTO7TXYbeXY5qHz70naTws2owmUuAf0RNZEYcKWyjFZtJ1nj
 8tESj39lG9wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="466832319"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 21 May 2020 08:53:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jbnVI-0083z2-Mt; Thu, 21 May 2020 18:53:04 +0300
Date:   Thu, 21 May 2020 18:53:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <20200521155304.GA1921871@smile.fi.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20200120121645.GI32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120121645.GI32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:16:45PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > it has been done for ACPI RSDP.
> > 
> > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > particular the default I2C host speed is choosen based on DMI system
> > information and now gets it correct.
> 
> Guys, it was quite a long no hear from you.
> Today I found that Microsoft Surface 3 also affected by this.
> 
> Can we apply these patches for now until you will find better solution?
> 
> P.S. I may resend them rebased on recent vanilla.

Okay, since there is no reply I take it as confirmation that the problem exists
and needs to be addressed.  So, I'll send a new version of the series with
updated commit messages (to mention Surface 3 issue).

-- 
With Best Regards,
Andy Shevchenko


