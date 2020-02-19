Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF84C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA112064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582104278;
	bh=iTP3x6vEprYutbkTyFGnFfyvngn3Bw24niNqLaYA43U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Huzf5lLQAwd8D+lzllg3+iVNO2Y5Zlf7ApblDLVK3YHn4IjxeAlub/GoW4X8lCyGM
	 9lgZ53BZJHkr1HaD4vm17R1SzYyzIwsWa3729D2cCMmdU+eXkNB433/dkhF/kkcerh
	 TMggenHIw2RxHFXCx/RgTG7YSKHl7xc39YssPurg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSJYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:24:37 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32638 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBSJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:24:37 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 01J9ODcc024014;
        Wed, 19 Feb 2020 18:24:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 01J9ODcc024014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582104254;
        bh=DF+/evkLClqtfnRvGjBml/csN+45+NlnkxxMv7DJLo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UyoUnKbo+w6EdQGG5oAobMsEyzSwFO61oBEYLdBUsXnUXVaaEEuWhWnpzWI7QSi7l
         1qWbTufAyZqG9nWVta90KSitwnNwPYCksFaKQGrFsEvkdmhsGlYQWPkuV3xKXNM9lg
         csC6/h1FBEdt3tepDh5L5GIOret/no3ZJn/SP9RpFxP2YfTCJN/5W8f+ZW+fluzQ/a
         awepQt4yyAaD4oILvhWNT2rXTX+DI/VU1zCEUA0OgfPl4HD+WFNTKDITkGzRYguFD4
         azVXqFIrhopIHTFzr9/ix7g4CvWYEERLIRAPEAQLE3nhUo9Nzt/5udMTrKdnPj69uV
         WAPbJjjs1ByBw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id r18so14969537vso.5;
        Wed, 19 Feb 2020 01:24:14 -0800 (PST)
X-Gm-Message-State: APjAAAW0DEJ395PVAQo9sNgPHjgvFONImvq63fGM5g/4NIwvi8+WJmRT
        w7dxyLgVigTM1SqcLJsisYLCtzSOZz1/2PE5Bj4=
X-Google-Smtp-Source: APXvYqyeXY+yDTz5fVQ/i3trWzuurgasd9/7mE2NxciVsAyJ4GwudLgazC3Yja9jl5t4/CoTN8jYVeOUtSFg4iKCrbM=
X-Received: by 2002:a67:6485:: with SMTP id y127mr14029090vsb.54.1582104252914;
 Wed, 19 Feb 2020 01:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20200219074950.23344-1-masahiroy@kernel.org> <CAMuHMdU7=jRNCWvtiFhJwUM6P4xNmqwXdPX14qvE=6by1V7APA@mail.gmail.com>
In-Reply-To: <CAMuHMdU7=jRNCWvtiFhJwUM6P4xNmqwXdPX14qvE=6by1V7APA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Feb 2020 18:23:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATKh9Y_QmO19iPw+zXT8RG-HfXBFY5bvpX0YSyOO-=NGA@mail.gmail.com>
Message-ID: <CAK7LNATKh9Y_QmO19iPw+zXT8RG-HfXBFY5bvpX0YSyOO-=NGA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: make 'imply' obey the direct dependency
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 5:42 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Yamada-san,
>
> On Wed, Feb 19, 2020 at 8:51 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > The 'imply' statement may create unmet direct dependency when the
> > implied symbol depends on m.
> >
> > [Test Code]
> >
> >   config FOO
> >           tristate "foo"
> >           imply BAZ
> >
> >   config BAZ
> >           tristate "baz"
> >           depends on BAR
> >
> >   config BAR
> >           def_tristate m
> >
> >   config MODULES
> >           def_bool y
> >           option modules
> >
> > If you set FOO=y, BAZ is also promoted to y, which results in the
> > following .config file:
> >
> >   CONFIG_FOO=y
> >   CONFIG_BAZ=y
> >   CONFIG_BAR=m
> >   CONFIG_MODULES=y
> >
> > This ignores the dependency "BAZ depends on BAR".
> >
> > Unlike 'select', what is worse, Kconfig never shows the
> > "WARNING: unmet direct dependencies detected for ..." for this case.
> >
> > Because 'imply' should be weaker than 'depends on', Kconfig should
> > take the direct dependency into account.
> >
> > Describe this case in Documentation/kbuild/kconfig-language.rst for
> > clarification.
> >
> > Commit 237e3ad0f195 ("Kconfig: Introduce the "imply" keyword") says that
> > a symbol implied by y is restricted to y or n, excluding m.
> >
> > As for the combination of FOO=y and BAR=m, the case of BAZ=m is excluded
> > by the 'imply', and BAZ=y is also excluded by 'depends on'. So, only the
> > possible value is BAZ=n.
> >
> > Having said that, this case was probably "We don't care" at that time
> > because Kconfig did not handle 'depends on m' correctly until
> > commit f622f8279581 ("kconfig: warn unmet direct dependency of tristate
> > symbols selected by y") fixed it.
> >
> > Backporting this to 4.19+ will probably be fine. If you care this
> > problem on 4.14.x, you need to backport f622f8279581 as well.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Thanks a lot! This fixes the build issues in
> https://lore.kernel.org/alsa-devel/CAMuHMdW8SvDgQJyenTtEm4Xn2Ma6PK9pfwKR2_gn60t2AqNWXg@mail.gmail.com/
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

Even if this patch fixes the build issues,
the result may not be what you expect.

The very subtle part of 'imply' is that
symbols implied by 'y' cannot be 'm'.

When CONFIG_SND_SOC_ALL_CODECS=y,
the select'ed drivers were previously able to be 'm'.

After ea00d95200d02, drivers that were previously
'm' are now 'n'.

Probably, it shrunk the test-coverage.

I'd recommend to compare the .config file.


-- 
Best Regards
Masahiro Yamada
