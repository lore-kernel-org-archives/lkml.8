Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E1CC761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDDB206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgBQJov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:44:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36669 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgBQJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:44:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so19932474edp.3;
        Mon, 17 Feb 2020 01:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5Mm0UcTlrataEbH992JlC3fdkxaoZqbYWxeVKMRIWw=;
        b=jWgfccxGpx5X99Jdq1GPF+lR7GDPHUCstjwpezl8tQiBesecEdNEvEYY8glKK9c621
         oEt/mg7E2cGNshJdEDTKhM6Zct/8CrKpkXPdVS1UlchSIeUScrQdQbFR2sIPpgL9HuU0
         dEzYF3b72/nBCtcBZPog1idY8wQh448bHzqXpZnvyZE6t3vj/2IeM+XjoRF8RZZ2qKCb
         WbOSz+AKIjufiuDmd9V8WQz51gPhGgiEOgf7pKMUn0b6FM+c6cFHCrAMOyAHaI45iIm6
         JwEw2nvmvNooWJqRBSFowtL+zyik0/10nFDfaiM3/y3fqzCROlobSpM6DpcfIZV78jgZ
         FeDw==
X-Gm-Message-State: APjAAAX2R92PBw/SYd6E8Rylf0kTEjdYlhHcqNKOX5waykrBDBAzXH11
        zevkJt9N0hRDEOxYI9LFpm7bYyDNG50=
X-Google-Smtp-Source: APXvYqy7Yl1wsueKhXtMs7/CsRvCCTNOODw03MGDEoUVCQwRihqNzfAEgymQefn7DKym6QnxmTD+OA==
X-Received: by 2002:a05:6402:c08:: with SMTP id co8mr13971476edb.197.1581932688791;
        Mon, 17 Feb 2020 01:44:48 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id qw15sm840177ejb.92.2020.02.17.01.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 01:44:47 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id g1so16403668wmh.4;
        Mon, 17 Feb 2020 01:44:47 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr21930702wmd.77.1581932686942;
 Mon, 17 Feb 2020 01:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217091423.y2muniz3hosquho6@gilmour.lan>
In-Reply-To: <20200217091423.y2muniz3hosquho6@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 17:44:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GuwLdJ3Rkt1cyU6EroWZ6pim7-sGry5jYBoi=mubpUg@mail.gmail.com>
Message-ID: <CAGb2v65GuwLdJ3Rkt1cyU6EroWZ6pim7-sGry5jYBoi=mubpUg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/34] sun8i-codec fixes and new features
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 5:14 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Mon, Feb 17, 2020 at 12:42:16AM -0600, Samuel Holland wrote:
> > The sun8i-codec driver, as used in the Allwinner A33 and A64, currently
> > only exposes a small subset of the available hardware features. In order
> > to use the A64 in a smartphone (the PinePhone), I've added the necessary
> > functionality to the driver:
> >   * The full set of supported DAI format options
> >   * Support for AIF2 and AIF3
> >   * Additional routing knobs
> >   * Additional volume controls
> >
> > Unfortunately, due to preexisting issues with the driver, there are some
> > breaking changes, as explained further in the commit messages:
> >   * The LRCK inversion issue means we need a new compatible for the A64.
> >   * Some controls are named inaccurately, so they are renamed.
> >   * Likewise, the DAPM widgets used in device trees were either named
> >     wrong, or the device trees were using the wrong widgets in the first
> >     place. (Specifically, the links between the analog codec and digital
> >     codec happen at the ADC and DAC, not AIF1.)
> >
> > I tended to take the philosophy of "while I'm breaking things, I might
> > as well do them right", so I've probably made a few more changes than
> > absolutely necessary. I'm not sure about where all of the policy
> > boundaries are, about how far I should go to maintain compatibility. For
> > example, for the DT widget usage, I could:
> >   * Rename everything and update the DTS files (which is what I did)
> >   * Keep the old (misleading/wrong) name for the widgets, but repurpose
> >     them to work correctly
> >       (i.e. "ADC Left" would be named "AIF1 Slot 0 Left ADC", but it
> >        would work just like "ADC Left" does in this patchset)
> >   * Keep the old widgets around as a compatibility layer, but add new
> >     widgets and update the in-tree DTS files to use them
> >       (i.e. "ADC Left" would have a path from "AIF1 Slot 0 Left ADC",
> >        but "AIF1 Slot 0 Left ADC" would be a no-op widget)
> >   * Something else entirely
>
> I'm not sure this is really a concern here. We need to maintain the
> compatibility with old DT's, but those will have an A33 compatible
> too, and as far as I can see, you're not changing anything for that
> compatible, so we're in the clear?
>
> If not, then the third option would probably be the best, especially
> since it's only a couple of them.

Unfortunately the description for both chips are shared, and they're wrong.
So we probably need a new compatible (or a new driver)... or like options
2 or 3, keep the DT visible endpoints (but deprecate them), and route them
to a new set of proper widgets.

ChenYu
