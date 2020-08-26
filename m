Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6716C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F823214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHZOQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:16:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:33036 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgHZOQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:16:20 -0400
IronPort-SDR: 2dbJygXuIEYwJ0bnaKAHcI7uth4OMfh+9cjrZtJWmBSZWh5Rq103kUfNNoYLCT/f3TRZB7N6NS
 rPdpsJlsco/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136357418"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="136357418"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 07:16:18 -0700
IronPort-SDR: FYBTzDiLsChTNrLw3hHvz28OzSVrkrJq8fZ3fmZemIFpgcRzm/vFTFdGL6rAmjxRYEznSjwypt
 5XkO1iz008lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="329240239"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 07:16:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAwDn-00BaFl-C7; Wed, 26 Aug 2020 17:16:15 +0300
Date:   Wed, 26 Aug 2020 17:16:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with
 __must_check
Message-ID: <20200826141615.GN1891694@smile.fi.intel.com>
References: <CGME20200826104505eucas1p2e6ac15abfb6104fdbc4229fc148cbe02@eucas1p2.samsung.com>
 <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
 <1e3708e5-24f2-18e0-40c0-284853171338@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e3708e5-24f2-18e0-40c0-284853171338@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:23:40PM +0200, Andrzej Hajda wrote:
> On 26.08.2020 12:44, Andy Shevchenko wrote:
> > We have got already new users of this API which interpret it differently
> > and miss the opportunity to optimize their code.
> >
> > In order to avoid similar cases in the future, annotate dev_err_probe()
> > with __must_check.
> 
> 
> There are many cases where __must_check can be annoying, for example:
> 
> ret = ...;
> 
> if (ret < 0) {
> 
>      dev_err_probe(...);
> 
>      goto cleanup;

Can be
	ret = dev_err_probe(...);

> }
> 
> 
> Or (less frequently):
> 
> ptr = ...;
> 
> if (IS_ERR(ptr)) {
> 
>      dev_err_probe(...);
> 
>      return ptr;

...which basically should be something like

	return dev_err_probe_ptr(...);

> }
> 
> 
> Of course in both cases one can add workarounds, but I am not sure what 
> is better.

Me neither, but definitely API in current state allows to make code suboptimal.
So, up to Greg and Rafael to decide.

-- 
With Best Regards,
Andy Shevchenko


