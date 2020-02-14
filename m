Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EEEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ECA206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgBNOYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:24:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:42178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbgBNOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:24:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 06:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="223029129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2020 06:24:47 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j2btg-001MyR-Vd; Fri, 14 Feb 2020 16:24:48 +0200
Date:   Fri, 14 Feb 2020 16:24:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 0/9] x86: Easy way of detecting MS Surface 3
Message-ID: <20200214142448.GK10400@smile.fi.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 01:22:57PM +0200, Andy Shevchenko wrote:
> While working on RTC regression, I noticed that we are using the same DMI check
> over and over in the drivers for MS Surface 3 platform. This series dedicated
> for making it easier in the same way how it's done for Apple machines.


Any comments on this?

> Changelog v3:
> - fixed typo in patch 5 (Jonathan)
> - returned back to if {} else {} condition in ASoC driver (Mark)
> - added Mark's Ack tag
> 
> Changelog v2:
> - removed RTC patches for now (the fix will be independent to this series)
> - added couple more clean ups to arch/x86/kernel/quirks.c
> - redone DMI quirk to use driver_data instead of callback
> - simplified check in soc-acpi-intel-cht-match.c to be oneliner
> - added a new patch to cover rt5645 codec driver
> 
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> 
> Andy Shevchenko (9):
>   x86/platform: Rename x86/apple.h -> x86/machine.h
>   x86/quirks: Add missed include to satisfy static checker
>   x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
>   x86/quirks: Join string literals back
>   x86/quirks: Convert DMI matching to use a table
>   x86/quirks: Add a DMI quirk for Microsoft Surface 3
>   platform/x86: surface3_wmi: Switch DMI table match to a test of
>     variable
>   ASoC: rt5645: Switch DMI table match to a test of variable
>   ASoC: Intel: Switch DMI table match to a test of variable
> 
>  arch/x86/kernel/quirks.c                      | 91 +++++++++++++------
>  drivers/platform/x86/surface3-wmi.c           | 16 +---
>  include/linux/platform_data/x86/apple.h       | 14 +--
>  include/linux/platform_data/x86/machine.h     | 20 ++++
>  sound/soc/codecs/rt5645.c                     | 14 ++-
>  .../intel/common/soc-acpi-intel-cht-match.c   | 28 +-----
>  6 files changed, 93 insertions(+), 90 deletions(-)
>  create mode 100644 include/linux/platform_data/x86/machine.h
> 
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


