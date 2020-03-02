Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A154217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCBMy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:54:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:52574 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbgCBMy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:54:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 04:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="286613230"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2020 04:54:25 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8kaZ-0068Np-Vd; Mon, 02 Mar 2020 14:54:27 +0200
Date:   Mon, 2 Mar 2020 14:54:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, dvhart@infradead.org,
        mika.westerberg@intel.com, peterz@infradead.org,
        charles.d.prestopine@intel.com, Chen Zhou <chenzhou10@huawei.com>,
        David Box <david.e.box@intel.com>
Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or
 code
Message-ID: <20200302125427.GV1224808@smile.fi.intel.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1583093898.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 12:44:21PM -0800, Gayatri Kammela wrote:
> Hi,
> 
> This patch series consists of bug fixes and code optimization for the
> series https://patchwork.kernel.org/patch/11365325/
> 

I had applied first four, the fifth requires additional work.
When send a new version, do it only for last one.

> Patch 1: Relocate both pmc_core_slps0_display() and pmc_core_lpm_display()
> Patch 2: Remove the duplicate if() condition to create debugfs entry
> Patch 3: Add back slp_s0_offset attribute back to tgl_reg_map
> Patch 4: Make pmc_core_substate_res_show() generic
> Patch 5: Make pmc_core_lpm_display() generic
> 
> Changes since v1:
> 1) Changed the order of the patches i.e., patch 2 in v1 is made first in
>    the order for v2.
> 2) Fixed the warnings reported by kbuild test robot.
> 
> Changes since v2:
> 1) Add "Make pmc_core_substate_res_show() generic" patch to v3.
> 2) Fixed the memory leak issue in pmc_core_lpm_display().
> 3) Moved patch 2 in v2 to the last in the series in v3.
> 
> Gayatri Kammela (5):
>   platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display()
>     and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
>   platform/x86: intel_pmc_core: fix: Remove the duplicate if() to create
>     debugfs entry for substate_live_status_registers
>   platform/x86: intel_pmc_core: fix: Add slp_s0_offset attribute back to
>     tgl_reg_map
>   platform/x86: intel_pmc_core: Make pmc_core_substate_res_show()
>     generic
>   platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generic
>     for platforms that support sub-states
> 
>  drivers/platform/x86/intel_pmc_core.c | 148 +++++++++++++++-----------
>  drivers/platform/x86/intel_pmc_core.h |   3 +-
>  2 files changed, 85 insertions(+), 66 deletions(-)
> 
> base-commit: 7adb1e8aeeb5d4d88012568b2049599c1a247cf2
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


