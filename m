Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22861C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26152076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgDWKno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:43:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:64401 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgDWKnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:43:43 -0400
IronPort-SDR: kV1TdSzMaKk/mEtlb0Hixrf0MgYvkINhX44zP8nPwXL1cTF8y4BVA1pd0l7ORNrZrBBI8Fiwmo
 LTxB00o2q5gA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 03:43:43 -0700
IronPort-SDR: LFN631bqvXpK1Avb2NAO9GD0HWjBd6b8Fd9E7lTsRyNvFG6aGDLr9Ivioc9RfV3PXy9+Arw26f
 29Ai1z1Yhivg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="457459943"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2020 03:43:40 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jRZKZ-002cT3-1x; Thu, 23 Apr 2020 13:43:43 +0300
Date:   Thu, 23 Apr 2020 13:43:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 1/3] lib/vsprintf: Print time64_t in human readable
 format
Message-ID: <20200423104343.GP185537@smile.fi.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-2-andriy.shevchenko@linux.intel.com>
 <20200416023219.GA30641@jagdpanzerIV.localdomain>
 <20200421130846.GM185537@smile.fi.intel.com>
 <20200423015431.GB246741@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423015431.GB246741@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:54:31AM +0900, Sergey Senozhatsky wrote:
> On (20/04/21 16:08), Andy Shevchenko wrote:
> [..]
> > > Here you convert time64_t (signed, we also have unsigned version - timeu64_t)
> > > to tm first and then convert tm to rtc_time. Will rtc_time64_to_tm() do the
> > > trick?
> >
> > You missed v2 round. The RTC is configuration dependent and Alexandre in favour
> > of removing those from RTC completely by replacing with always enabled
> > time64_to_tm().
> 
> I see.
> I don't think I was Cc-ed on v1/v2.

It was in v1 [1], but yes, by some reason you were not in Cc, my apology.

[1]: https://lore.kernel.org/patchwork/patch/1029110/

-- 
With Best Regards,
Andy Shevchenko


