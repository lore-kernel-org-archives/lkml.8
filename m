Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFFBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F612054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbgEMQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:25:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:47264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbgEMQZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:25:18 -0400
IronPort-SDR: rG+xkt7GWyR26ljDRgXcC9fEVlX059muwjQC36cHEJhGfOigkHQWxOSm2wvrxfNbEeV264+ciZ
 3wLBSgw7Pzbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 09:25:17 -0700
IronPort-SDR: kOFQPychjQRbqGq643hXqXa+zFK0sRN9uGhs37Qj+Z/Dl2Iqg2me8Rd4h0nTd/UOW5HMfUMGA6
 JkeYHsGcu5qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,388,1583222400"; 
   d="scan'208";a="371954293"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 May 2020 09:25:14 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 13 May 2020 19:25:13 +0300
Date:   Wed, 13 May 2020 19:25:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
Message-ID: <20200513162513.GI2571@lahna.fi.intel.com>
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
 <20200513070847.GM2571@lahna.fi.intel.com>
 <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
 <20200513091100.GY2571@lahna.fi.intel.com>
 <CAD2FfiGNErUhz=7DH6Z37X573hSkJkzbOEXbb++X+Ey5WLc9=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiGNErUhz=7DH6Z37X573hSkJkzbOEXbb++X+Ey5WLc9=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:13:28PM +0100, Richard Hughes wrote:
> On Wed, 13 May 2020 at 10:11, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > > I can fix up all those, but out of interest how did you "know" the
> > > right three digit identifier to use?
> > I work for Intel ;-)
> 
> Hah, okay, thanks :)
> 
> > > I'm really wondering if drivers/mfd/lpc_ich.c is the right place for
> > > this kind of "just expose one byte of PCI config space" functionality.
> > Ideally there is one driver per device.
> 
> My idea in https://github.com/hughsie/spi_lpc was to not actually
> register a pci_driver.

OK, I see the original code iterated over PCI devices finding anything
that matches the IDs in the table.

This may be problematic if there is driver bound to the device and
accessing the hardware simultaneusly. Although this is just read side
and I don't think these registers have any side effects when you read
them, so should not be an issue.

> 
> > If this is touching the 00:1f.5 PCI device (SPI-NOR controller) then the
> > right place is the intel-spi-pci.c as that's the driver for this
> > controller.
> 
> So Cannon Lake, Cannon Point and Ice Lake would go into
> drivers/mtd/spi-nor/controllers/intel-spi-pci.c and the systems like
> Sunrise Point using an ISA bridge would use drivers/mfd/lpc_ich.c?

Yes, something like that.

> > We can put this there so that it does not enable the SPI-NOR
> > functionality itself and the mark the SPI-NOR functionality only as
> > being dangerous or something like that.
> 
> I think getting the distros to enable SPI_INTEL_SPI_PCI might be a
> tough sell. Could we perhaps remove the DANGEROUS label as it's not
> writeable without a module option?

I would like to keep it (the label) there but I think we can label
SPI_INTEL_SPI with that instead and then make the -pci.c to work
standalone if CONFIG_SPI_INTEL_SPI is not enabled.

config SPI_INTEL_SPI
        tristate "Intel PCH/PCU SPI flash core driver (DANGEROUS)"
	depends on SPI_INTEL_SPI_PCI || SPI_INTEL_SPI_PLATFORM
	...

config SPI_INTEL_SPI_PCI
        tristate "Intel PCH/PCU SPI flash PCI driver"
	depends on PCI
	...

Then distros could enable only CONFIG_SPI_INTEL_SPI_PCI which would only
expose the security bits. Of course I'm open to any other ideas :)
