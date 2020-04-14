Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC1BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADD620656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440212AbgDNQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:47:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:34386 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbgDNQrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:47:01 -0400
IronPort-SDR: DG7mhedzGxxS/0g9HpWwVLDFBWeYmncoBoXZ5XdwCmWtIkHN9vZdhABxOmbZs8XO5HNhcpQwrW
 oZWDHBIVzIkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 09:46:59 -0700
IronPort-SDR: xSkRtuz/0mAMknRyz7BDeZHuZ49UisjFxpOarV2QgJQv0kTeb0oMNliNUhhLRjoWQdo5qezf/0
 wNnf5RREVEJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; 
   d="scan'208";a="245461385"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2020 09:46:57 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jOOiB-000ZUr-PC; Tue, 14 Apr 2020 19:46:59 +0300
Date:   Tue, 14 Apr 2020 19:46:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>, linus.walleij@linaro.org,
        patrice.chotard@st.com, info@metux.net, allison@lohutok.net,
        nehal-bakulchandra.shah@amd.com, tglx@linutronix.de,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: img-scb: remove duplicate dev_err()
Message-ID: <20200414164659.GY34613@smile.fi.intel.com>
References: <20200414142650.29359-1-zhengdejin5@gmail.com>
 <20200414143837.GV34613@smile.fi.intel.com>
 <20200414155047.GA10848@nuc8i5>
 <20200414162002.GX34613@smile.fi.intel.com>
 <20200414164259.GA3708@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414164259.GA3708@kunai>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 06:42:59PM +0200, Wolfram Sang wrote:
> 
> > > scripts/get_maintainer.pl --git --git-min-percent=67 v1-0001-i2c-img-scb-remove-duplicate-dev_err.patch
> > > linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS)
> > > linux-kernel@vger.kernel.org (open list)
> > 
> > Nice, you found a bug in MAINTAINERS database.
> 
> No, all fine. We don't have a maintainer for that driver.

I realized that there are many drivers like that in the tree...

> > I recommend to resend a new version with those mailings lists followed by
> > Wolfram included in the Cc list. Don't forget to add my tag in the commit
> > message and bump the version.
> 
> The patch is already in patchwork, so no need to resend from my side.

Good to know how you handle the (orphaned?) ones.

-- 
With Best Regards,
Andy Shevchenko


