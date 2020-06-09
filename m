Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A96F207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgFIJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:16:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:65193 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgFIJQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:16:48 -0400
IronPort-SDR: ReFmBkqDpzgMDluIiWAMUWcAAN9i12uFTzk1Zlw+5Oy7ZWevKW1dX3QZADjtSarVqOIPhIoWNj
 TU/tJvVO7IXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:16:47 -0700
IronPort-SDR: DHCLJdYjcY8ckOKfzURIh3dxYBRhuAhHF4Uv53Aj7tCcARUyI4WitszBXQtMWFx6GXm92lJvGO
 14Mc9AVmNAQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="258947635"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2020 02:16:46 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiaNF-00BrC1-E9; Tue, 09 Jun 2020 12:16:49 +0300
Date:   Tue, 9 Jun 2020 12:16:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200609091649.GX2428291@smile.fi.intel.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
 <20200604122805.d2ndjmkmti6wl3nz@master>
 <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
 <20200605230610.bizp2j23ivyma5rn@master>
 <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
 <20200608223112.ftncszh7hfnmqj3m@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608223112.ftncszh7hfnmqj3m@master>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 10:31:12PM +0000, Wei Yang wrote:
> On Fri, Jun 05, 2020 at 05:16:29PM -0700, Andrew Morton wrote:

...

> The test on 64bit machine pass. Since I don't have a 32bit machine by hand, 

Out of curiosity what that machine is?

> Geert, would you mind have a try on 32bit machine? 

-- 
With Best Regards,
Andy Shevchenko


