Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A61C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8ED24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAVIbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:31:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:17473 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgAVIbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:31:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 00:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="244975321"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2020 00:31:39 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iuBQK-0001YZ-CA; Wed, 22 Jan 2020 10:31:40 +0200
Date:   Wed, 22 Jan 2020 10:31:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: remove expect_eq_u32_array
Message-ID: <20200122083140.GJ32742@smile.fi.intel.com>
References: <1579595625-250942-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200121132050.GT32742@smile.fi.intel.com>
 <20200122011018.GA14737@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122011018.GA14737@yury-thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 05:10:18PM -0800, Yury Norov wrote:
> On Tue, Jan 21, 2020 at 03:20:50PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 21, 2020 at 04:33:45PM +0800, Alex Shi wrote:
> > > expect_eq_u32_array isn't used from commit 3aa56885e516 ("bitmap:
> > > replace bitmap_{from,to}_u32array").
> > > And EXP2_IN_BITS are never used. so better to remove them.
> > 
> > I think better "fix" will be to add test cases.
> > See the commit message in the
> > 
> > commit 3aa56885e51683a19c8aa71739fd279b3f501cd7
> > Author: Yury Norov <ynorov@caviumnetworks.com>
> > Date:   Tue Feb 6 15:38:06 2018 -0800
> > 
> >     bitmap: replace bitmap_{from,to}_u32array

> On the other hand, it's almost 2 years gone since the commit you
> mentioned, and nobody used the check_eq_u32_array(). So I think
> it's long enough to consider the function useless.
> 
> This function is the last example of 2 lengths in input, so I'd
> prefer to remove it. However, removing check_eq_u32_array() should
> be synchronized with underlying __check_eq_u32_array().

Thanks for elaboration.
No objection from my side!

-- 
With Best Regards,
Andy Shevchenko


