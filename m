Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E49CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0874420729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="POX89PUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgG0Pbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgG0Pbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:31:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30207C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:31:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so15582235qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tc6U4B4ifrBotOh/fXS5TVXJl0j6RPCfuacCtXdF/Bs=;
        b=POX89PUxNVTvKUH1A4IvhZs88Vh004sHJ6vDsdtT1qEnZTeAPN9d4ux66c8fnpxrLe
         GFGANIM94UQHjSOL5C71fJf7QzOZId/30YS5Ou0PhM0TJLI9TSgzRlPogD77U0QuBXwT
         0uwHQgRBAlbeQQ9+6j8K9dA5uoqGwT3TzdEuiPHM3pGN/IkvAI3aZWgz9jQoB6Do/BK4
         rGSeGwbUzBeaisWIlSSv99+V+BhnkHa5t3otM4Y93xF/iLBsSLdplEJm6KdgNARJONoG
         3csM6GxAGc3rQZK+s2fndFK/n4xtDktyPnOscTVI2U1B+DyQ7aEZIKxxzelNQuUUXZ5E
         ga3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tc6U4B4ifrBotOh/fXS5TVXJl0j6RPCfuacCtXdF/Bs=;
        b=aJm3HP5j6cMlzld3v5utLuQAc2bj1U0mOWlNXigPlO+LGnWGVpzUgZu6zKzFYwgkOa
         K1BTnQBKOlrbB4EDK3hvfBvUcIvtfOg7T2dhfbtrZb+un/JEMRlxR0izuQcdgOOsnZMu
         CPNngM/Xu8qZ5yqPCvEg00AtO0UZbrqMoPOkzpK5tkvFcyL+cAg7zmWdOHP9OIxPLeKo
         WzrGbblt62HMWwo43fJPjWFx0r6Y+qOL1V5jasxV5UA/MmoZf5ENFW5zNgNlnLEzYnAq
         +c5IRNmbyEXyrz5lH3r1tso44h30SrxJjk+OJTaXruz3D6YBE9r0FRQ4B4BtzO05CZlo
         k+sw==
X-Gm-Message-State: AOAM533fwXnQ3nVKxW5pYO41SKSeZvyFCz+29ce7DVhGPEA5s1Ave9Da
        aLeB3IFsJ3uqeVotS86qETWiNeWge2lro/Q6h9BoaA==
X-Google-Smtp-Source: ABdhPJxyNMAKvg1LEG48ofJJNYU+f8IxgUp0EcqzWaM5nc5Eojucgiz/T7/9vC6vuPXocWDtZtqeYPIuc6dsnTOw1Ws=
X-Received: by 2002:a37:278d:: with SMTP id n135mr22801202qkn.486.1595863898240;
 Mon, 27 Jul 2020 08:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com> <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
 <20200726071723.GB441916@kroah.com> <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
 <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
In-Reply-To: <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Mon, 27 Jul 2020 12:31:27 -0300
Message-ID: <CAFmMkTExBY3V_Ghej7Bzjatg+vFtWq3UZmKzjAiEoR9EqnFN9Q@mail.gmail.com>
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

On Mon, Jul 27, 2020 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 27, 2020 at 5:05 PM Daniel Gutson <daniel@eclypsium.com> wrot=
e:
> > On Sun, Jul 26, 2020 at 4:17 AM Greg Kroah-Hartman <gregkh@linuxfoundat=
ion.org> wrote:
> >>
> >> On Sat, Jul 25, 2020 at 02:20:03PM -0300, Daniel Gutson wrote:
> >> > El s=C3=A1b., 25 jul. 2020 2:56 a. m., Greg Kroah-Hartman <
> >> > gregkh@linuxfoundation.org> escribi=C3=B3:
> >> >
> >> >
> >> > 1) I just did the same that intel-spi.c does.
> >>
> >> No need to copy bad examples :)
> >
> >
> > Didn't know it was a bad example. What's is the current modern mechanis=
m that replaces initialization-time configuration?
>
> I'd say you'd generally want this to be a per-instance setting, which
> could be a sysfs attribute of the physical device, or an ioctl for an
> existing user space abstraction.

But still, they are not equivalent. The initial configuration remains
constant for the rest of the life of the driver, whereas the
sysfs attribute is set after the initialization and can be re-set over
time. I'm not asking module parameters "to come back" if
they are now considered obsolete, I'm just trying to understand.

>
> In the changelog, you should also explain what this is used for. Do
> you actually want to write to a device that is marked read-only, or
> are you just trying to make the interface more consistent between the
> two drivers?

The device can either be locked or unlocked. If it is unlocked, it can
be set writable depending on the module
argument in intel-spi, or straight writable in intel-spi-pci. Which is
dangerous.
I wanted to make, as you say, the interface consistent.
Exposing an interface to the user (via a sysfs attribute) to try to
make the driver writable is definitively a bad idea.
I'd rather do nothing (no module arg) rather than open that
here-be-dragons door.
>
>      Arnd



--=20
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
