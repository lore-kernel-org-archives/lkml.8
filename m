Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB49C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB8C2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgHXIWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:22:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:11442 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXIWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:22:35 -0400
IronPort-SDR: nZdivQrC3MoHja5/2pg3/DzdiKIS/eb+KvCJLlkkDrOgJ/ZFg6Zo0lP9SwK/Ttvxths9GCqTvY
 1RMevpldP+6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="135402587"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="135402587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 01:22:35 -0700
IronPort-SDR: 83dFkHN98CUz5kwF5Qoia5wrbwvXZE09znrTf3Z4V9iEH0BvIugh8QyCpgO7GKZD3ludAlnV4c
 g5UpC9WlxZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="402245358"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 01:22:29 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Aug 2020 11:22:27 +0300
Date:   Mon, 24 Aug 2020 11:22:27 +0300
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
Message-ID: <20200824082227.GU1375436@lahna.fi.intel.com>
References: <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com>
 <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
 <20200819091123.GE1375436@lahna.fi.intel.com>
 <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 06:06:03PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 19, 2020 at 11:11 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Aug 19, 2020 at 10:38:24AM +0200, Arnd Bergmann wrote:
> > > On Wed, Aug 19, 2020 at 8:57 AM Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >
> > > > Actually thinking about this bit more, to make PCI and the platform
> > > > parts consistent we can make the "writeable" control this for the PCI
> > > > part as well. So what if we add a callback to struct intel_spi_boardinfo
> > > > that the PCI driver populates and then the "core" driver uses to enable
> > > > writing when "writeable" is set to 1.
> > >
> > > If you are really worried about the write protection being bypassed by
> > > a different driver or code injection, the best way would seem to be to
> > > only enable writing in the mtd write callback and disable it immediately
> > > after the write is complete. I still don't see why this hardware would
> > > be more susceptible to this kind of attack than other drivers though,
> > > as it already has the safeguard against writing through the MTD layer
> > > without the module parameter.
> >
> > Hmm, is there already a mechanism at the MTD level to prevent writes? If
> > that's the case then sure we can use that instead.
> 
> The mtd core just checks both the permissions on the device node (which
> default to 0600 without any special udev rules) and the MTD_WRITEABLE
> on the underlying device that is controlled by the module parameter
> in case of intel-spi{,-platform,-pci}.c.

OK, thanks.

Since we cannot really get rid of the module parameter (AFAIK there are
users for it), I still think we should just make the "writeable" to
apply to the PCI part as well. That should at least make it consistent,
and it also solves Daniel's case.
