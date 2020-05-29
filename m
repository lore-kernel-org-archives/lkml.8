Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4813EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2244E2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgE2KuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:50:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:17708 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2KuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:50:10 -0400
IronPort-SDR: MQpYkXHuBmBRQJVrSORf384O4Bxl8vWiUwbvdJIuDTRN8KBt37wBAjeXJUhYMkcGwlnKLQknUP
 DzJgrjRbTvxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 03:50:10 -0700
IronPort-SDR: qDeHSxX5EIEVu1yQr2VAMYDeZwnVPe+R7mFXgpk4JTDsMaZP5U99KOOzSNUdGazpWDC/a19Ag4
 WZ7sYVmuhScg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="256471708"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 29 May 2020 03:50:06 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jecaX-009bHf-4Z; Fri, 29 May 2020 13:50:09 +0300
Date:   Fri, 29 May 2020 13:50:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] dmaengine: dw: Initialize min_burst capability
Message-ID: <20200529105009.GH1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-10-Sergey.Semin@baikalelectronics.ru>
 <20200529102515.GD1634618@smile.fi.intel.com>
 <20200529102902.GG1634618@smile.fi.intel.com>
 <20200529104119.qrqoptp5iz5hs56r@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529104119.qrqoptp5iz5hs56r@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:41:19PM +0300, Serge Semin wrote:
> On Fri, May 29, 2020 at 01:29:02PM +0300, Andy Shevchenko wrote:
> > On Fri, May 29, 2020 at 01:25:15PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 29, 2020 at 01:23:59AM +0300, Serge Semin wrote:

...

> > > >  	/* DMA capabilities */
> > > > +	dw->dma.min_burst = 1;
> > > 
> > > Perhaps then relaxed maximum, like
> > > 
> > > 	dw->dma.max_burst = 256;
> > > 
> > > (channels will update this)
> > > 
> > > ?
> 
> > And forgot to mention that perhaps we need a definitions for both.
> 
> By "definitions for both" do you mean a macro with corresponding parameter
> definition like it's done for the max burst length in the next patch?
> Something like this:
> --- include/linux/platform_data/dma-dw.h
> +++ include/linux/platform_data/dma-dw.h
> +#define DW_DMA_MIN_BURST	1
> +#define DW_DMA_MAX_BURST	256
> 
> ?

Yes!

-- 
With Best Regards,
Andy Shevchenko


