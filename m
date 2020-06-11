Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBD820747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgFKI5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:57:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:23521 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgFKI5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:57:11 -0400
IronPort-SDR: gkrByYmdD0llxZ7os43nv0FkpVmwnSKutCp89rC1VpQzmeMhYGIycqf2zoUwCcvCKAsaN7jIk8
 2lHDAO4iPBjg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 01:57:11 -0700
IronPort-SDR: juYuwjBBW9pUdIFqtvG3zMWTcmKtppmN3Rnc6YnMclLnW8KezPcotPYDMWX4LzKxJg9MZTpMDO
 PXagRMx5znpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="296522276"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2020 01:57:08 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jjJ1K-00CJpU-Gh; Thu, 11 Jun 2020 11:57:10 +0300
Date:   Thu, 11 Jun 2020 11:57:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v2 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
Message-ID: <20200611085710.GV2428291@smile.fi.intel.com>
References: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200611021246.3250-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200611081254.GR2428291@smile.fi.intel.com>
 <21b5db0e-c45a-2255-0389-04b204685d63@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b5db0e-c45a-2255-0389-04b204685d63@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 04:36:29PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> On 11/6/2020 4:12 pm, Andy Shevchenko wrote:
> > On Thu, Jun 11, 2020 at 10:12:46AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> > > From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

...

> > > +	ret = readl_poll_timeout(ctrl1, val, val & SRAM_INIT_DONE,
> > > +				 10, 10 * 1000);
> exceeds more than 80 characters, so checkpatch throws warnings, to avoid
> that move to next line.

> > On one line easier to read.

It's 82 characters. It's fine.

> > > +	if (ret) {
> > > +		dev_err(ta->phy.dev, "SRAM init failed, 0x%x\n", val);
> > > +		return ret;
> > > +	}

...

> > > +	int ret = 0;
> > 
> > Assignment is redundant.
> so you mean , should be declared as
> int ret;
> right?

Right.

...

> > > +		dev_info(ta->phy.dev, "connected%s\n",
> > > +			 flipped ? " flipped" : "");
> > 
> > One line.
> exceeds more than 80 characters, so checkpatch throw warnings, to avoid that
> moved to next line.

It's fine to have on one line.

And by the way, try new checkpatch.


-- 
With Best Regards,
Andy Shevchenko


