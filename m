Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E10C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8912074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="Zvip8zar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgG2Uys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Uyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:54:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BF2C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:54:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so23688261qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hML/G2Vc4+8j8itR9nKQsmnhixEhsDERowGsOaYy7Gw=;
        b=Zvip8zarCHkiOAp40mMHVMaLvnPMf3ZQI2kSo9fjzG0D6nM7fysyjZo3oR16GmU5un
         RZJgAoIIftLEUrNHVTF5d0lcuWp9PmRHSF3BhGGu49F/B7bFuFDHer7uqebnWZZFa3Fx
         ImE6syx7IxfsoVqZFf3KE2Y2ZOVMFUPq/qg/Qr9gfRk4irvzzWLIKi2tVewrQsPEdZRU
         b7JOXqr/VFRFAD8UjkJ6aUCSZWimOZhK9HJsrNnkF9fgcDXyegTccsVKvnXdv9NOYyfQ
         ivnNne6r436/TAQ9T6N0GFYlXffps/RnZu6Py4vMLefN7S89NM15w3rCHeUH2y6nq22u
         n+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hML/G2Vc4+8j8itR9nKQsmnhixEhsDERowGsOaYy7Gw=;
        b=KdGAjjkfC9kXYBSrTGHnkXRJ7/Bn/ASRkBXM++O3HjEwPOjfjleUBb2qCdUjljHvIX
         4OXmt1COvJld81d3lCvqu44nJIZCS36Uns2UwwY+ZpMShpcLCi7BuUGxJzdR9r7Uf58l
         9NH0WsRHPsB0bFAvr7saGodmIKOCAo/OecKnbqZ0G/eVut+Bhv6XoHSMSdOfDmXqMxaj
         O6UJ/4KlVp8W1Jb5rCHfgApDQA6dPd/6auxAVQLaJtoYPCnLyH+734EsKUru13bfLKdU
         9ESz7CXMD1wQcSE13L7ozvEt7FVTHgNgDJdEOWzH7TKfT54bkMAnxcB/99sk7aodLcYr
         eFig==
X-Gm-Message-State: AOAM530nOIY2mvxkRWRmqiBssyo9WMIeW4+MkCxJPZHTpW5ShdxEAuOE
        078LysoyROwbg3QKCkzwhc/pywtNKCXRHNqa7KWHliM3
X-Google-Smtp-Source: ABdhPJziT1y1KwgPcmp+p6p/09SIbNmExj8/wOsyvDR2EqdYDYLBrsq7yFVHctr2qgO+0kbNSt238S1a8b5CibuBZ3s=
X-Received: by 2002:ae9:eb81:: with SMTP id b123mr35072208qkg.288.1596056086506;
 Wed, 29 Jul 2020 13:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com> <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
 <20200726071723.GB441916@kroah.com> <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
 <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com> <CAFmMkTExBY3V_Ghej7Bzjatg+vFtWq3UZmKzjAiEoR9EqnFN9Q@mail.gmail.com>
In-Reply-To: <CAFmMkTExBY3V_Ghej7Bzjatg+vFtWq3UZmKzjAiEoR9EqnFN9Q@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Wed, 29 Jul 2020 17:54:35 -0300
Message-ID: <CAFmMkTEO7VNKJeYz2uoHsS-yN_aY8UuiQ2GcCq9NyAD5481ZGA@mail.gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci attempts
 to turn the SPI flash chip writeable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:31 PM Daniel Gutson <daniel@eclypsium.com> wrote=
:
>
> On Mon, Jul 27, 2020 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Jul 27, 2020 at 5:05 PM Daniel Gutson <daniel@eclypsium.com> wr=
ote:
> > > On Sun, Jul 26, 2020 at 4:17 AM Greg Kroah-Hartman <gregkh@linuxfound=
ation.org> wrote:
> > >>
> > >> On Sat, Jul 25, 2020 at 02:20:03PM -0300, Daniel Gutson wrote:
> > >> > El s=C3=A1b., 25 jul. 2020 2:56 a. m., Greg Kroah-Hartman <
> > >> > gregkh@linuxfoundation.org> escribi=C3=B3:
> > >> >
> > >> >
> > >> > 1) I just did the same that intel-spi.c does.
> > >>
> > >> No need to copy bad examples :)
> > >
> > >
> > > Didn't know it was a bad example. What's is the current modern mechan=
ism that replaces initialization-time configuration?
> >
> > I'd say you'd generally want this to be a per-instance setting, which
> > could be a sysfs attribute of the physical device, or an ioctl for an
> > existing user space abstraction.
>
> But still, they are not equivalent. The initial configuration remains
> constant for the rest of the life of the driver, whereas the
> sysfs attribute is set after the initialization and can be re-set over
> time. I'm not asking module parameters "to come back" if
> they are now considered obsolete, I'm just trying to understand.
>
> >
> > In the changelog, you should also explain what this is used for. Do
> > you actually want to write to a device that is marked read-only, or
> > are you just trying to make the interface more consistent between the
> > two drivers?
>
> The device can either be locked or unlocked. If it is unlocked, it can
> be set writable depending on the module
> argument in intel-spi, or straight writable in intel-spi-pci. Which is
> dangerous.
> I wanted to make, as you say, the interface consistent.
> Exposing an interface to the user (via a sysfs attribute) to try to
> make the driver writable is definitively a bad idea.
> I'd rather do nothing (no module arg) rather than open that
> here-be-dragons door.

ping.
This is a real existing problem that I'm trying to address.
There's currently no way to prevent the kernel to try to turn
the SPI flash chip writable for the device IDs handled by
intel-spi-pci. And allowing userspace to switch it between
writable/non-writable is not an option.
What other mechanism can I use other than the module parameter,
so
 - not accessible through user space
 - ideally set once, ideally at initialization time

Thanks,

    Daniel.


>
> >
> >      Arnd
>
>
>
> --
> Daniel Gutson
> Argentina Site Director
> Enginieering Director
> Eclypsium
>
> Below The Surface: Get the latest threat research and insights on
> firmware and supply chain threats from the research team at Eclypsium.
> https://eclypsium.com/research/#threatreport



--=20
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
