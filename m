Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8355C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A9B246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgB1KG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:06:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:51206 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgB1KG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:06:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 02:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="scan'208";a="232491608"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2020 02:06:26 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j7cXM-005OMX-AT; Fri, 28 Feb 2020 12:06:28 +0200
Date:   Fri, 28 Feb 2020 12:06:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, dvhart@infradead.org,
        mika.westerberg@intel.com, peterz@infradead.org,
        charles.d.prestopine@intel.com, Chen Zhou <chenzhou10@huawei.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: Re: [PATCH v2 2/4] platform/x86: intel_pmc_core: fix: Make
 pmc_core_lpm_display() generic for platforms that support sub-states
Message-ID: <20200228100628.GJ1224808@smile.fi.intel.com>
References: <cover.1582845395.git.gayatri.kammela@intel.com>
 <49e90f024d89746d5955331e023231149210917c.1582845395.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e90f024d89746d5955331e023231149210917c.1582845395.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:29:14PM -0800, Gayatri Kammela wrote:
> Currently pmc_core_lpm_display() uses array of struct pointers i.e.,
> tgl_lpm_maps for Tiger Lake directly to iterate through and to get the
> number of status/live status registers which is hardcoded and cannot
> be re-used for future platforms that support sub-states. To maintain
> readability, make pmc_core_lpm_display() generic, so that it can re-used
> for future platforms.

This patch need more work, see below.
That said, I would prefer to see it last in the series for next version.

...

> +	lpm_regs = kmalloc_array(arr_size, sizeof(*lpm_regs), GFP_KERNEL);

No error check?
Besides that it is obvious memory leak.

> +	for (index = 0; maps[index]; index++) {
>  		lpm_regs[index] = pmc_core_reg_read(pmcdev, offset);
>  		offset += 4;
>  	}

-- 
With Best Regards,
Andy Shevchenko


