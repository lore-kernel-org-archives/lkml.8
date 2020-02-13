Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0360C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766F9218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgBMRSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:18:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:8689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBMRSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:18:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 09:18:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="267204517"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2020 09:18:35 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j2I8K-001B0E-Ab; Thu, 13 Feb 2020 19:18:36 +0200
Date:   Thu, 13 Feb 2020 19:18:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Srivastava, Shobhit" <shobhit.srivastava@intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Rajat Jain <rajatja@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "rajatxjain@gmail.com" <rajatxjain@gmail.com>,
        "evgreen@google.com" <evgreen@google.com>,
        "Muthukrishnan, Porselvan" <porselvan.muthukrishnan@intel.com>
Subject: Re: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
Message-ID: <20200213171836.GD10400@smile.fi.intel.com>
References: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 04:57:24PM +0000, Srivastava, Shobhit wrote:
> > On 2/12/20 12:34 AM, Rajat Jain wrote:

...

> > I wonder is it enough to have this quick toggling only or is time or actually
> > number of clock cycles dependent? Now there is no delay between but I'm
> > thinking if it needs certain number cycles does this still work when using low
> > ssp_clk rates similar than in commit d0283eb2dbc1 ("spi:
> > pxa2xx: Add output control for multiple Intel LPSS chip selects").
> > 
> > I'm thinking can this be done only once after resume and may other LPSS
> > blocks need the same? I.e. should this be done in drivers/mfd/intel-lpss.c?

> This behavior is seen after S0ix resume, but it is not seen after S3 resume.

I already commented in the other thread about this.

Have you checked what's going on in intel_lpss_suspend() and
intel_lpss_resume() for your case?

Is intel_lpss_prepare() called during S0ix exit?

> I am thinking that it happens because we are not enabling the SSP after resume. 
> It is deferred until we need to send data. By enabling the SSP in resume, I don’t see the issue.
> For S3, I think BIOS re-enables the SSP in resume flow.

-- 
With Best Regards,
Andy Shevchenko


