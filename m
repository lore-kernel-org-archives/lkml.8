Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287EFC4BA3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098AA24687
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgB0KCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:02:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:33866 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgB0KCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:02:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 02:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="436980256"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2020 02:02:37 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j7G07-00596q-8o; Thu, 27 Feb 2020 12:02:39 +0200
Date:   Thu, 27 Feb 2020 12:02:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>
Subject: Re: [PATCH v5 2/2] clk: intel: Add CGU clock driver for a new SoC
Message-ID: <20200227100239.GD1224808@smile.fi.intel.com>
References: <cover.1582096982.git.rahul.tanwar@linux.intel.com>
 <6148b5b25d4a6833f0a72801d569ed97ac6ca55b.1582096982.git.rahul.tanwar@linux.intel.com>
 <e8259928-cb2a-a453-8f2a-1b57c8abdb8c@infradead.org>
 <4fb7a643-cbe1-da82-2629-2dbd0c0d143b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb7a643-cbe1-da82-2629-2dbd0c0d143b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:19:26PM +0800, Tanwar, Rahul wrote:
> On 19/2/2020 3:59 PM, Randy Dunlap wrote:
> > On 2/18/20 11:40 PM, Rahul Tanwar wrote:

> >> +config CLK_LGM_CGU
> >> +	depends on (OF && HAS_IOMEM) || COMPILE_TEST
> > This "depends on" looks problematic to me. I guess we shall see when
> > all the build bots get to it.
> 
> At the moment, i am not able to figure out possible problems in this..

COMPILE_TEST should be accompanied by non-generic dependency.
There is none.

So, I quite agree with Randy.

> >> +	select OF_EARLY_FLATTREE
> > If OF is not set and HAS_IOMEM is not set, but COMPILE_TEST is set,
> > I expect that this should not be attempting to select OF_EARLY_FLATTREE.
> >
> > Have you tried such a config combination?
> 
> Agree, that would be a problem. I will change it to
> 
> select OF_EARLY_FLATTREE if OF

Nope, I think this is wrong work around.
See above.

-- 
With Best Regards,
Andy Shevchenko


