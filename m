Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7362CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ED6204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC9Vpj5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbgEMONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgEMONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:13:42 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:13:42 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e10so10116960vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCRPmBf+bIjv/gHr5AWk1RbyQw6taBIM/9TqKHo+x6E=;
        b=LC9Vpj5aGvdbFDALXhMdOIffXIYZMOViIbG8buo3eE2kTLhqobBlVArL4MjS1BaDl2
         tb4rVQZIZXXorGlfKKmOKYPcouXTjKMPBTrkB9BYmfaGP0f0wIO08O/i7ZH5pE1zF0Q8
         lMxY2Beahh2WRSBmW5CxCP9GSHdc+ZxGU/j6MLzvFuNJ4zr/EGtYjkTwc+CvXGADZ+n1
         faoCkcpDbZ7o/f9xQFdDLLIg6ms+H6xHKIgLs0U8hr2n67qnMTDv4k4hk6pRUMysBgfZ
         1FfWy7me2GLJvholeW2hkll4VaZqD8JgjhZ2pz5Rs474s59hAAIwuihwx0RuSzAkN+Si
         xyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCRPmBf+bIjv/gHr5AWk1RbyQw6taBIM/9TqKHo+x6E=;
        b=IFItUO0u0mN/v7opKuqbM7PGbuuaUCZu7LDDPRnJpBtDhII38yjB+Qma8HHEgq17HM
         aWhD+eq/R/k5kKMoprKwGn0n2ViB7bZllT+rILhmMJT7EFqYRFgYlESBk8xLUSD4b/Kk
         0Im8kQkvjCXsAanPEws3Ybu5K7ZWBwj3riJPgB70teVEAbhBqr2nWyiPFqiPiZ4zoGmK
         A9/rF8nPlfyWC0v/0Wsopopp/EmTzHQPY2jU0xXD9EEdvU9ttJfO924z/yIMskFMzawa
         qyQ87I/X2AwkHn92Y2/nDaDaO6SSisIhxp5TBLv20GPUjAAGT1g0EiMvidymeb2WVEjq
         wc6Q==
X-Gm-Message-State: AGi0PubXUViQAAeNAEjAZzSM6ksFktOSHVXUhgtsFMebZMAArDvxoiCD
        AjwgROKK2bdNM7MzMMWD/H3NERFjNmpCuyg7Q/8=
X-Google-Smtp-Source: APiQypK9PkckYUve5Fg/x7q8ws6y5o++n4e5ZTL0yAeOlVub3u/qpyw0N169OJJ8fNITTRZ0bO00qR2kL/85wz6J/Qs=
X-Received: by 2002:a67:ffcf:: with SMTP id w15mr19434925vsq.213.1589379219878;
 Wed, 13 May 2020 07:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
 <20200513070847.GM2571@lahna.fi.intel.com> <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
 <20200513091100.GY2571@lahna.fi.intel.com>
In-Reply-To: <20200513091100.GY2571@lahna.fi.intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Wed, 13 May 2020 15:13:28 +0100
Message-ID: <CAD2FfiGNErUhz=7DH6Z37X573hSkJkzbOEXbb++X+Ey5WLc9=Q@mail.gmail.com>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 10:11, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> > I can fix up all those, but out of interest how did you "know" the
> > right three digit identifier to use?
> I work for Intel ;-)

Hah, okay, thanks :)

> > I'm really wondering if drivers/mfd/lpc_ich.c is the right place for
> > this kind of "just expose one byte of PCI config space" functionality.
> Ideally there is one driver per device.

My idea in https://github.com/hughsie/spi_lpc was to not actually
register a pci_driver.

> If this is touching the 00:1f.5 PCI device (SPI-NOR controller) then the
> right place is the intel-spi-pci.c as that's the driver for this
> controller.

So Cannon Lake, Cannon Point and Ice Lake would go into
drivers/mtd/spi-nor/controllers/intel-spi-pci.c and the systems like
Sunrise Point using an ISA bridge would use drivers/mfd/lpc_ich.c?

> We can put this there so that it does not enable the SPI-NOR
> functionality itself and the mark the SPI-NOR functionality only as
> being dangerous or something like that.

I think getting the distros to enable SPI_INTEL_SPI_PCI might be a
tough sell. Could we perhaps remove the DANGEROUS label as it's not
writeable without a module option?

> > > > +     char tmp[2];
> > > Wouldn't this need to account the '\0' as well?
> You sprint() there "%d\n", so that includes a number, '\n' and '\0' unless
> I'm missing something.

Doh, of course you're right. Will fix, thanks.

Richard
