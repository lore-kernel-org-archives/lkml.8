Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A51C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB93222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgB0J4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:56:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:38583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgB0J4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:56:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 01:56:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="385101599"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2020 01:56:41 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j7FuN-00592S-8n; Thu, 27 Feb 2020 11:56:43 +0200
Date:   Thu, 27 Feb 2020 11:56:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, dvhart@infradead.org,
        mika.westerberg@intel.com, peterz@infradead.org,
        charles.d.prestopine@intel.com, Chen Zhou <chenzhou10@huawei.com>,
        David Box <david.e.box@intel.com>
Subject: Re: [PATCH v1 0/4] platform/x86: intel_pmc_core: Add bug fixes or
 code
Message-ID: <20200227095643.GB1224808@smile.fi.intel.com>
References: <cover.1582770011.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582770011.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 06:43:26PM -0800, Gayatri Kammela wrote:
> Hi,
> 
> This patch series consists of bug fixes and code optimization for the
> series https://patchwork.kernel.org/patch/11365325/
> 
> Patch 1: Make pmc_core_lpm_display() generic
> Patch 2: Relocate both pmc_core_slps0_display() and pmc_core_lpm_display()
> Patch 3: Remove the duplicate if() condition to create debugfs entry
> Patch 4: Add back slp_s0_offset attribute back to tgl_reg_map

Let's do other way around, i.e. patch 2 as a first in the series, so I may fix
the current (visible) issue.

Then fix the kbuild bot complains and send the rest.

> 
> Gayatri Kammela (4):
>   platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generic
>     for platforms that support sub-states
>   platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display()
>     and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
>   platform/x86: intel_pmc_core: fix: Remove the duplicate if() to create
>     debugfs entry for substate_live_status_registers
>   platform/x86: intel_pmc_core: fix: Add slp_s0_offset attribute back to
>     tgl_reg_map
> 
>  drivers/platform/x86/intel_pmc_core.c | 131 +++++++++++++-------------
>  1 file changed, 66 insertions(+), 65 deletions(-)
> 
> Cc: Chen Zhou <chenzhou10@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Box <david.e.box@intel.com>
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


