Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E269C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D084720739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbq+fbIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCTJ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:26:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43005 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgCTJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:26:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so5601352ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xb2+TkejQMyeRgV2FN7crNaJyjiX8rMU6p7e/O+WXs0=;
        b=tbq+fbIOQCPDoIaCZyKPTLUNOGRkJRUrZkJZAQgonMZpLrWXjWX7Qtc+As8KQ5LXdG
         sTWgnaH15HiCIBzv4PNxsm/oEkGNFwjnF3FFhpvXSm2a0Cxoxbi+DZihSyN5j3+h8RZA
         UJfIbNdNm5vzWcpNFnkp8nIYwubgVmtCTwheuBGl5A1KEQZR2w4QGAul1X4jx6ilWgqq
         e7W+zpYkxhoss0ivMVNoGTH87T4HRNDcMqQ9J+tvCiQOWHZa8Eiqjd0kgx0tQ864WYn9
         jAXVKp5AI3xJmdEDtOJgME9RmxQvtjMvVByhDfeX3DY3a7HmxlcC82UHbIwmjWXnUIH0
         Y5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xb2+TkejQMyeRgV2FN7crNaJyjiX8rMU6p7e/O+WXs0=;
        b=XqnMpuoWNqlZ2GbKW1YEF+7H+ugfOlmq/Gm8QuZLlk883lx8aoHRjiBE4hbOFT6O4l
         npVvAyfCMf8lcy0AnRDSR2Csx2O+ebdeXnvjPlIX5Fvv/EPMVIj18UQxHLkLIvJDy0Sh
         5bZSxLP0clspL5oUzSlMyTynhHeUQB5PsslWXocA3Sbgym0gqMijBL/PvZzc/eZVjx/m
         VX7DXs1AbPbvpmL2b7KB5x/SeS/yW/8y+bdGI5IKOSL+wXv9mAqT53hV6V9sd7SbPQeu
         SBKszTHMjEm4PxjTN9HhdYO4RPn4D2f/aBz9mPzv+pT55idSjmNuOL0bI6lWWB25mUeg
         xNgQ==
X-Gm-Message-State: ANhLgQ0Qp2XwJYjbDDJ0XoUJIBHywy5LnvcYZO99vArVgwvHebu6elDi
        QOq/4n1LO5gxvj9ZEMF5GSC8Xb9Kxk3e/82pQFYTEw==
X-Google-Smtp-Source: ADFU+vtuJ0t8Nqq40yxEBdJE/UuZY+X1aSolICR4o1I8kWzUt2hZ40fB2rvEyc9S2cEgGGbq33gRugkfewIJCU8F73I=
X-Received: by 2002:a2e:8ecf:: with SMTP id e15mr4982788ljl.223.1584696412508;
 Fri, 20 Mar 2020 02:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190617221134.9930-1-f.fainelli@gmail.com> <20191114181243.q37rxoo3seds6oxy@pengutronix.de>
 <7322163f-e08e-a6b7-b143-e9d59917ee5b@gmail.com> <20191115070842.2x7psp243nfo76co@pengutronix.de>
 <20191115114416.ba6lmwb7q4gmepzc@pengutronix.de> <60bda4a9-f4f8-3641-2612-17fab3173b29@gmail.com>
 <CACRpkdYJR3gQCb4WXwF4tGzk+tT7jMcV9=nDK0PFkeh+0G11bA@mail.gmail.com>
 <2639dfb0-9e48-cc0f-27e5-34308f790293@gmail.com> <CACRpkdZ8JA=DXOxzYwyvBxCMd2Q5uzLTn87AVK7wdrxHFo5ydQ@mail.gmail.com>
 <20200305094328.sizz4vm4wamywdct@pengutronix.de>
In-Reply-To: <20200305094328.sizz4vm4wamywdct@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Mar 2020 10:26:40 +0100
Message-ID: <CACRpkdYzSZY0r=YYiosvi2CA7mia5oiXAWUkbYSqjU1PZ_6w=g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Hocko <mhocko@suse.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        David Howells <dhowells@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Abbott Liu <liuwenliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        drjones@redhat.com, Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Landley <rob@landley.net>, philip@cog.systems,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 10:44 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> On 20-03-05 09:43, Linus Walleij wrote:
> > Hi Florian,
> >
> > On Fri, Jan 17, 2020 at 8:55 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > > Let me submit and rebase v7 get the auto builders some days to see if it
> > > exposes a new build issue and then we toss it to RMK's patch tracker and
> > > fix bugs from there?
> >
> > Sorry for hammering, can we get some initial patches going into
> > Russell's patch tracker here? I can sign them off and put them in
> > if you don't have time.
>
> I've tested the branch on several imx6 based boards with different
> toolchains. Some boards booting normal and some of them are lost in
> space... I didn't debugged it yet just wanted to inform you.

Hm. I will bring up the KASan stack on more boards.

If the system is anywhere close to being low on memory they
will naturally crash, this is an unavoidable side effect of KASan
or anything else that just chew of a big chunk of memory, that I ran into,
as I was booting from initramfs on very memory
constrained systems.

Yours,
Linus Walleij
