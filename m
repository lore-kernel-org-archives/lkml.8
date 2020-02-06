Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D97C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660AD20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBFITD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:19:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43390 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:19:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so4658061oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ILeCcfkYYjTxS6oflRLxWrVymyuGundyUAIWkRyyXgE=;
        b=ssYI7NMPgaPPo3inbPPF1QcA/iqJirR/DSVMuHWO7VJeNpHCsJHirwHgBx9Y5CEeJi
         T80LJCT9PCPPzZCG/gEN3UrEigx3OL4TlfgA2yBTYSBSdIhD8AizUV/JnmKoYGZPaalO
         vNTthUfRtAUi6faUNRDGpSm8CvH03NXykgWkimsNaK2nWNWBAYXnK7nnjO82UIfFlUw+
         Ndk30/yODVMCmph+ZP5ZlajkPDYU49yjL7+DYjoe8h2thVtR1/J4ITBtq+DSUUaJluLg
         SGHzq/s1Zg+MBuRQUvdgJYME7aZq69nebC3sgls96QSTe7QlwwnFKkTh0mECARjCejKm
         HdRA==
X-Gm-Message-State: APjAAAXS8HS1u48AJEAVvM5Poh2o4O9IiLQCwT+LEjxLhfrJuOK2kHjR
        AKXTrrGIu7A80ACHnEgcRc/whDef5VUOMxjANNc=
X-Google-Smtp-Source: APXvYqzD5+HlMwpdnKhhYsSUh7s8+K86BYM3tnZF4atz2qANzxRGvmiaLDGI59RrIn4aYfNVH10hyIp5eiV2Ps1BzKo=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr27747368otf.107.1580977140903;
 Thu, 06 Feb 2020 00:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net> <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
 <20200204070927.GA966981@kroah.com> <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
 <20200204203116.GN8731@bombadil.infradead.org> <20200205033416.GT1778@kadam>
 <a3032823-03a9-f018-73e4-eb0d71e0bb53@roeck-us.net> <CAMuHMdXKtJEvwRViRpy4nHbxv68P_rCFWbpikw=BMM5XnBvD2A@mail.gmail.com>
 <dd09609d-d504-9a9e-453e-6b0ef66e6211@roeck-us.net>
In-Reply-To: <dd09609d-d504-9a9e-453e-6b0ef66e6211@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Feb 2020 09:18:48 +0100
Message-ID: <CAMuHMdVfH90GDJMOTBQeLE5vx==YEMdE-Q+Hp1+E1ZKpQ=nhqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fw@strlen.de" <fw@strlen.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        "bobdc9664@seznam.cz" <bobdc9664@seznam.cz>,
        "sandro@volery.com" <sandro@volery.com>,
        "ivalery111@gmail.com" <ivalery111@gmail.com>,
        "ynezz@true.cz" <ynezz@true.cz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Wed, Feb 5, 2020 at 2:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 2/5/20 1:03 AM, Geert Uytterhoeven wrote:
> > On Wed, Feb 5, 2020 at 4:57 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >> On 2/4/20 7:34 PM, Dan Carpenter wrote:
> >>> On Tue, Feb 04, 2020 at 12:31:16PM -0800, Matthew Wilcox wrote:
> >>>> On Tue, Feb 04, 2020 at 08:06:14PM +0000, Chris Packham wrote:
> >>>>> On Tue, 2020-02-04 at 07:09 +0000, gregkh@linuxfoundation.org wrote:
> >>>>>> On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
> >>>>> On Tue, 2020-02-04 at 10:21 +0300, Dan Carpenter wrote:
> >>>>>> My advice is to delete all the COMPILE_TEST code.  That stuff was a
> >>>>>> constant source of confusion and headaches.
> >>>>>
> >>>>> I was also going to suggest this. Since the COMPILE_TEST has been a
> >>>>> source of trouble I was going to propose dropping the || COMPILE_TEST
> >>>>> from the Kconfig for the octeon drivers.
> >>>>
> >>>> Not having it also causes problems.  I didn't originally add it for
> >>>> shits and giggles.
> >>>
> >>> I wonder if the kbuild bot does enough cross compile build testing these
> >>> days to detect compile problems.  It might have improved to the point
> >>> where COMPILE_TEST isn't required.
> >
> > It depends...
> >
> >> Not really. Looking at the build failures in the mainline kernel right now:
> >>
> >> Failed builds:
> >>          alpha:allmodconfig
> >>          arm:allmodconfig
> >>          i386:allyesconfig
> >>          i386:allmodconfig
> >>          m68k:allmodconfig
> >>          microblaze:mmu_defconfig
> >>          mips:allmodconfig
> >>          parisc:allmodconfig
> >>          powerpc:allmodconfig
> >>          s390:allmodconfig
> >>          sparc64:allmodconfig
> >
> > I did receive a report from noreply@ellerman.id.au for the m68k build
> > failure. But that was sent to me only, not to the offender, and I do my
> > own builds anyway.
> >
> > More interesting, that report happened after the offending commit landed
> > upstream, while it had been in next for 4 weeks.
>
> m68k in -next builds fine for me, and did for a while. I have not seen a build
> failure there. There must be a context commit causing this failure, or what
> is (or was) in -next differs from what is in mainline.

Indeed. The offending symbol depended on another symbol, which never
made it to next before it hit mainline, thus hiding the issue.

> >> Many of those don't even _have_ specific configurations causing the build failures.
> >
> > Exactly. These are the "easy" ones, as the all*config builds enable as
> > much infrastructure as possible.  It's much harder if some common
> > dependency is not fulfilled in some specific config.
>
> Yes, that is correct. But that doesn't mean that it would be a good idea
> to retire COMPILE_TEST.

I agree.

Retiring COMPILE_TEST could have a positive side-effect, though: it
would reduce the compile time for all*config, which might give the
overloaded build bots spare cycles to cover other configs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
