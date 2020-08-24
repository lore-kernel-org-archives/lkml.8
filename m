Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7D7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED0D206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgHXJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:16:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:20462 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729832AbgHXJPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:15:47 -0400
IronPort-SDR: rYN1T3dFnLRSwhyS870Xw/VDuojw4+1XTAQduL9hzRj+nZPJAb6EiGvKIJAdH2v63mAniPQ8CF
 je38qDQXA3Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220135688"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="220135688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 02:15:47 -0700
IronPort-SDR: Gy6kGGugzZLcfjZhdktYlsZL/u42rahULw/UFaWwpFFyVMGMZTAs7Y3XCgwQYCYe4N5IBMT2P+
 DBGlxuDDWzvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="402270489"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 02:15:43 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Aug 2020 12:15:42 +0300
Date:   Mon, 24 Aug 2020 12:15:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI
 flash chip writable
Message-ID: <20200824091542.GC1375436@lahna.fi.intel.com>
References: <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com>
 <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
 <20200819091123.GE1375436@lahna.fi.intel.com>
 <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
 <20200824082227.GU1375436@lahna.fi.intel.com>
 <CAK8P3a0==cZDHwZfqvCuvUg9jfjBOBG+AAomE9eqJ2xm-xNLvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0==cZDHwZfqvCuvUg9jfjBOBG+AAomE9eqJ2xm-xNLvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:08:33AM +0200, Arnd Bergmann wrote:
> On Mon, Aug 24, 2020 at 10:22 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Sat, Aug 22, 2020 at 06:06:03PM +0200, Arnd Bergmann wrote:
> > > On Wed, Aug 19, 2020 at 11:11 AM Mika Westerberg
> > >
> > > The mtd core just checks both the permissions on the device node (which
> > > default to 0600 without any special udev rules) and the MTD_WRITEABLE
> > > on the underlying device that is controlled by the module parameter
> > > in case of intel-spi{,-platform,-pci}.c.
> >
> > OK, thanks.
> >
> > Since we cannot really get rid of the module parameter (AFAIK there are
> > users for it), I still think we should just make the "writeable" to
> > apply to the PCI part as well. That should at least make it consistent,
> > and it also solves Daniel's case.
> 
> Can you explain Daniel's case then? I still don't understand what he
> actually wants.
> 
> As I keep repeating, the module parameter *does* apply to the pci
> driver front-end since it determines whether the driver will disallow
> writes to the mtd device without it. The only difference is that the pci
> driver will attempt to set the hardware bit without checking the
> module parameter first, while the platform driver does not. If the
> module parameter is not set however, the state of the hardware
> bit is never checked again.

I think Daniel wants the PCI driver not to set the hardware bit by
default (same as the platform driver).
