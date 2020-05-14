Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB99C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA7E206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgENNOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:14:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:21288 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENNOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:14:08 -0400
IronPort-SDR: Jz4mIg7E3uGqOIsmERcKSH+vIBzwimjYZPNq12yHsEsAshIn9h4txvhrmk70pfHOyPQFfMaQ6k
 fGEe1SxsXekA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 06:14:08 -0700
IronPort-SDR: EmIYT8jKZLaSFbl6v0aHerkzWU9i9q3hYSsjbj8gR9M70OCqmMP5HvJSdZELQYHB8VSc6ykjjp
 0KAyKwP5erkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="372266437"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 14 May 2020 06:14:05 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 14 May 2020 16:14:04 +0300
Date:   Thu, 14 May 2020 16:14:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
Message-ID: <20200514131404.GX2571@lahna.fi.intel.com>
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
 <20200513070847.GM2571@lahna.fi.intel.com>
 <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
 <20200513091100.GY2571@lahna.fi.intel.com>
 <CAD2FfiGNErUhz=7DH6Z37X573hSkJkzbOEXbb++X+Ey5WLc9=Q@mail.gmail.com>
 <20200513162513.GI2571@lahna.fi.intel.com>
 <c4602e6768377179ff3204ea0c2d5944e6d35844.camel@gmail.com>
 <20200514121536.GS2571@lahna.fi.intel.com>
 <CAD2FfiEEzL0D5uRWgt=Hb6ngD2KY_NrZYJFAYtJi4CmS08zpfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiEEzL0D5uRWgt=Hb6ngD2KY_NrZYJFAYtJi4CmS08zpfA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:53:23PM +0100, Richard Hughes wrote:
> On Thu, 14 May 2020 at 13:15, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > > +What:                /sys/kernel/security/firmware/bioswe
> > Should this still be "firmware_protections" or similar. Plain "firmware"
> > sounds again too generic. Maybe its just me..
> 
> It's not always going to be protections provided by the firmware; it
> might also be restrictions put on the firmware. My first choice was
> /sys/kernel/security/firmware_security/ but having the double
> 'security' just looked redundant.

OK.

> > > +     LPC_SPT,        /* Sunrise Point */
> > > +     LPC_KBL,        /* Kaby Lake */
> > > +     LPC_TGL,        /* Tiger Lake */
> >
> > These all have the SPI-NOR controller as separate PCI device (as ICL and
> > others).
> 
> For Sunrise Point I see:
> 
> 00:1f.0 ISA bridge [0601]: Intel Corporation CM236 Chipset LPC/eSPI
> Controller [8086:a150] (rev 31)
> 00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point LPC
> Controller/eSPI Controller [8086:9d4e] (rev 21)
> 
> For Kaby Lake I see:
> 
> 00:1f.0 ISA bridge [0601]: Intel Corporation HM175 Chipset LPC/eSPI
> Controller [8086:a152] (rev 31)",

Yes, both of these have LPC device (1f.0) but the SPI-NOR controller is
separate PCI device and most likely hidden.

> You're indeed correct about Tiger Lake, my apologies.
> 
> > > +     [LPC_SPT] = {
> > > +             .name = "Sunrise Point",
> > > +             .spi_type = INTEL_SPI_LPC,
> > > +     },
> >
> > So all of these have LCP/eSPI controller but the SPI-NOR controller is
> > not accessible through it - it is a separate PCI device.
> 
> I have a Sunrise Point system here -- the lspci is here:
> https://people.freedesktop.org/~hughsient/temp/lspci.txt
> 
> Is the SPI-NOR controller perhaps hidden? If I read the BCR @ 0xdc
> from the 00:1f.0 ISB bridge I get the expected BIOS_WE, BLE and
> SMM_BWP results.

OK, I checked datasheet of KBL and indeed the LPC still has the BIOS
Control (BC) register at 0xdc so that should work. Incidently the same
register is part of the SPI-NOR controller register set.

> > Like you said, Evolution seems to mangle these.
> 
> I'll use git for future patches, thanks.
> 
> > > +             pci_read_config_dword(dev, BCR, &bcr);
> > > +             info->writeable = !!(bcr & BCR_WPD);
> > > +             break;
> > > +
> > > +     case INTEL_SPI_LPC:
> >
> > So instead of this, you can add the security attributes to the existing
> > entries where we are sure there is SPI-NOR controller behind LPC. Here
> > it is not the case and further..
> 
> Sooo I'd use INTEL_SPI_LPT? On my system RCBA isn't set, and so "if
> (!res->start)" bails out with  return -ENODEV;"

I think the INTEL_SPI_LPC is slightly misleading because the SPI is not
accessible through LPC. Instead what if we read the BIOS control
register first in lpc_ich_init_spi() and then bail out since .spi_type
is not set?

Probably we can rename the function lpc_ich_init_spi() to
lpc_ich_init_security_and_spi() or something like that.
