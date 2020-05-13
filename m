Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A770FCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8607720740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgEMJLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:11:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:55922 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbgEMJLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:11:04 -0400
IronPort-SDR: WS/6MFxI8STOIEn9F6h2u1v2kHJHZ6Ye8+8pO5zMgVFobF0zNVIvmk5CZkj2RolC39lJQDj+h2
 xbqfmhs3Jqcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 02:11:03 -0700
IronPort-SDR: Ua5hi5rFo4umR1oI75OeCOex7tlQp6bLWph0By+6gpnYrmOkpuMVvr20EsjT0esp0q9ujP4DZI
 0uCFFRLar5kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="371844362"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 May 2020 02:11:01 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 13 May 2020 12:11:00 +0300
Date:   Wed, 13 May 2020 12:11:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
Message-ID: <20200513091100.GY2571@lahna.fi.intel.com>
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
 <20200513070847.GM2571@lahna.fi.intel.com>
 <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 09:48:55AM +0100, Richard Hughes wrote:
> On Wed, 13 May 2020 at 08:08, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > I think this one should contain KernelVersion as well, see
> > Documentation/ABI/README.
> 
> Thanks, I'll fix that up.
> 
> > I think you can always include this header without #ifs
> 
> Thanks.
> 
> > >  static struct resource wdt_ich_res[] = {
> > > @@ -221,6 +236,16 @@ enum lpc_chipsets {
> > >       LPC_APL,        /* Apollo Lake SoC */
> > >       LPC_GLK,        /* Gemini Lake SoC */
> > >       LPC_COUGARMOUNTAIN,/* Cougar Mountain SoC*/
> > > +     LPC_SPT,        /* Sunrise Point */
> > > +     LPC_KLK,        /* Kaby Lake */
> > KBL for Kaby Lake
> 
> I can fix up all those, but out of interest how did you "know" the
> right three digit identifier to use?

I work for Intel ;-)

> > This is not PCH, Cactus Ridge is Thunderbolt host controller AFAIK.
> 
> This was suggested from someone testing the original spi_lpc.c code on
> a macbook, I can remove it for now and work out if it's incorrect
> later.

It is definitely incorrect. They are completely different things.

> > For example these PCI IDs are for the SPI-NOR controller (not LPC
> > controller) so this causes this driver to try to bind to a completely
> > different device which it cannot handle.
> 
> I'm really wondering if drivers/mfd/lpc_ich.c is the right place for
> this kind of "just expose one byte of PCI config space" functionality.
> Certainly drivers/platform/x86/intel_spi_lpc.c is much simpler, and
> would also allow me to do some of the chipsec tests in the future --
> for instance if BIOSWE is unset but BLE is set, try setting BIOSWE and
> check that SMM clears it back.

Ideally there is one driver per device. Otherwise we end up issues when
the device appears and there are several to choose from, which one to
pick.

If this is touching the 00:1f.5 PCI device (SPI-NOR controller) then the
right place is the intel-spi-pci.c as that's the driver for this
controller. We can put this there so that it does not enable the SPI-NOR
functionality itself and the mark the SPI-NOR functionality only as
being dangerous or something like that.

> 
> > > +     char tmp[2];
> >
> > Wouldn't this need to account the '\0' as well?
> 
> It's one char ('1' or '0') plus '`\0` -- no?

You sprint() there "%d\n", so that includes a number, '\n' and '\0' unless
I'm missing something.

> > I think "spi" is bit too general name here. I would expect "spi" to
> > actually refer to something connected to spi bus and possibly coming
> > from drivers/spi/*.
> > Perhaps "bios_protections" or something like that.
> 
> Sure, that's a good idea. I know BIOS is a badword now, so how about
> just "firmware"? so /sys/kernel/security/firmware/bioswe

Yup, sounds good :)

> > > +     securityfs_remove(priv->spi_dir);
> > > +     return -1;
> > I don't know securityfs well enought but I think -1 is not correct here
> > and if you want that then maybe -EPERM instead.
> 
> I will look, I don't think the actual value is terribly important. The
> only time I can trigger this is forgetting to remove the securityfs
> file in module unload, and then trying to re-insert the module --
> which failed with -EEXIST from memory.
> 
> > I wonder if you can simply call
> >         securityfs_remove(priv->spi_dir);
> > and that removes the children automatically? I'm do not know securityfs
> > so it may not be the case.
> 
> No, that doesn't work.

OK
