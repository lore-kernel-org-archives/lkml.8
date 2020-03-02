Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4162187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgCBMxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:53:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:44317 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbgCBMxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:53:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 04:53:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="257943869"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2020 04:53:41 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8kZr-0068NG-6Y; Mon, 02 Mar 2020 14:53:43 +0200
Date:   Mon, 2 Mar 2020 14:53:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, dvhart@infradead.org,
        mika.westerberg@intel.com, peterz@infradead.org,
        charles.d.prestopine@intel.com, Chen Zhou <chenzhou10@huawei.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: Re: [PATCH v3 5/5] platform/x86: intel_pmc_core: fix: Make
 pmc_core_lpm_display() generic for platforms that support sub-states
Message-ID: <20200302125343.GU1224808@smile.fi.intel.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <5e28f488a6cc8b7c1e08b536868844b586a1eaf1.1583093898.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e28f488a6cc8b7c1e08b536868844b586a1eaf1.1583093898.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 12:44:26PM -0800, Gayatri Kammela wrote:
> Currently pmc_core_lpm_display() uses array of struct pointers i.e.,
> tgl_lpm_maps for Tiger Lake directly to iterate through and to get the
> number of status/live status registers which is hardcoded and cannot
> be re-used for future platforms that support sub-states. To maintain
> readability, make pmc_core_lpm_display() generic, so that it can re-used
> for future platforms.

My comments below.

...

> +static int pmc_core_lpm_get_arr_size(const struct pmc_bit_map **maps)
> +{
> +	int idx, arr_size = 0;

And why do you need arr_size variable at all?

> +
> +	for (idx = 0; maps[idx]; idx++)
> +		arr_size++;
> +
> +	return arr_size;
> +}

...

> -	int index, idx, len = 32, bit_mask;
> +	int index, idx, bit_mask, len = 32;

What's the point of shuffling this?

> +	int arr_size = pmc_core_lpm_get_arr_size(maps);

This would be better in a split manner, i.e.

	int arr_size;

	...

	arr_size = ...;

...

> +	lpm_regs = kmalloc_array(arr_size, sizeof(*lpm_regs), GFP_KERNEL);
> +	if(!lpm_regs)

> +		goto err;

There is no point to have the label. Simple return will work.

> -	for (index = 0; tgl_lpm_maps[index]; index++) {
> +	for (index = 0; maps[index]; index++) {

Why not to reuse arr_size here?

>  		lpm_regs[index] = pmc_core_reg_read(pmcdev, offset);
>  		offset += 4;
>  	}

-- 
With Best Regards,
Andy Shevchenko


