Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A272072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgFHKNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:13:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:49784 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbgFHKNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:13:01 -0400
IronPort-SDR: TAP0+SEHRsmdR27IwAKsuQyPO4qyszf29n/4+NJqCsrJSuDLW1zxtzKDjijpjIf3M88pypVKNA
 DRiFFQZt4uQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 03:13:01 -0700
IronPort-SDR: 3cHZ8utAMldvx3xI8E46FJ16DrBnoog2uChT3b69grEFZg+OzjdfQri4RDWuRnEGjPXCZ0ymig
 l0Ulm33mCs9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="313838474"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2020 03:12:59 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiEm6-00BeMR-87; Mon, 08 Jun 2020 13:13:02 +0300
Date:   Mon, 8 Jun 2020 13:13:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] lib: Fix bitmap_cut() for overlaps, add test
Message-ID: <20200608101302.GF2428291@smile.fi.intel.com>
References: <cover.1591606281.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1591606281.git.sbrivio@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:13:27AM +0200, Stefano Brivio wrote:
> Patch 1/2 addresses the issue Yury reported with partially overlapping
> src and dst in bitmap_cut(), and 2/2 adds a test that covers basic
> functionality as well as this case.
> 
> 

FWIW, after addressing comments per test case,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Stefano Brivio (2):
>   lib: Fix bitmap_cut() for partial overlapping case
>   lib: Add test for bitmap_cut()
> 
>  lib/bitmap.c      |  4 ++--
>  lib/test_bitmap.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


