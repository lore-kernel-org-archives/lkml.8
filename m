Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636482051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgCPPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:52:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:50432 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731984AbgCPPwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:52:35 -0400
IronPort-SDR: PsTGVIaWJVwV6lm6RXikZHUw2r0AK2JWP9pkSZCNMbNGif/eS4A3sLniCrYHPzxHhV5AX0PHX3
 ITzeR+8m7/pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 08:52:34 -0700
IronPort-SDR: 9zyAWkN3nB4wjhOmEf4Pmw/yZT/SB1Nniyz6/VX2h1j7UqExbvfs+TP/uKG+b02wCSWlFjD6bV
 MlEAeKpPPj5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="237986234"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2020 08:52:31 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jDs2b-00A6Y7-2Y; Mon, 16 Mar 2020 17:52:33 +0200
Date:   Mon, 16 Mar 2020 17:52:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 0/9] x86: Easy way of detecting MS Surface 3
Message-ID: <20200316155233.GS1922688@smile.fi.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
 <871rps9uxd.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rps9uxd.fsf@ashishki-desk.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 05:33:02PM +0200, Alexander Shishkin wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > While working on RTC regression, I noticed that we are using the same DMI check
> > over and over in the drivers for MS Surface 3 platform. This series dedicated
> > for making it easier in the same way how it's done for Apple machines.
> 
> [...]
> 
> >   x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
> >   x86/quirks: Join string literals back
> 
> These two don't seem to be related to the Surface 3 cause of the rest of
> the patchset, or am I missing something?

No, they are not. I think it's suitable to have them in the bunch nevertheless.

-- 
With Best Regards,
Andy Shevchenko


