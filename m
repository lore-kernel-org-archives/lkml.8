Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A13208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633552AbgDPLdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:33:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:49755 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633425AbgDPLcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:32:55 -0400
IronPort-SDR: AQf1YNrfXGFCkTaTDHusUA6EYcszOs1nRzVxfCN++NR4blKKfVXkFwajp+jqFP3B9pW5KzVMIy
 5N8DcMoFjPhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 04:32:52 -0700
IronPort-SDR: JLjViU3I/7OhNUNFa14OtK4jxawo6cL4DIbAiuwxDw0aNbt8rAsEQeI/aVasFOrEUV6+diXta5
 ZTj7u56OWrjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="454295922"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2020 04:32:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jP2lG-00113k-Db; Thu, 16 Apr 2020 14:32:50 +0300
Date:   Thu, 16 Apr 2020 14:32:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        anders.roxell@linaro.org, arnd@arndb.de, brendanhiggins@google.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw, miquel.raynal@bootlin.com,
        piotrs@cadence.com, qi-ming.wu@intel.com, richard@nod.at,
        robh+dt@kernel.org, tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200416113250.GA185537@smile.fi.intel.com>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
 <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
 <20200416122619.2c481792@collabora.com>
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
 <20200416131725.51259573@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416131725.51259573@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 01:17:25PM +0200, Boris Brezillon wrote:
> On Thu, 16 Apr 2020 18:40:53 +0800
> "Ramuthevar, Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> 
> > >>> we'll be happy to have one more of the existing driver converted to  
> > >>> ->exec_op() ;-).  
> > >> I have completely adapted to ->exec_op() hook up to replace the legacy
> > >> call-back.  
> > > I suspect porting what you've done to the xway driver shouldn't be too
> > > complicated.  
> > Not ported from xway_nand.c driver , we have developed from the scratch 
> > to make it work on
> > Intel LGM SoC , it's new x86 ATOM based SoC, IP itself completely 
> > different and most of the registers won't match.
> > if we port then it would be ugly and also what are the problem may occur 
> > we do not know.
> 
> Sorry but IMO they look similar enough to try to merge them.

I agree. I tried to convince them internally... but here we are.

-- 
With Best Regards,
Andy Shevchenko


