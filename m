Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E3C4BA1D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE1206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXDH/CMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgBZRPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:15:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46590 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:15:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id u124so85331qkh.13;
        Wed, 26 Feb 2020 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5CxkaIVTY0HaJ9D8eCB6WdnU+YVYJtVOwAoTc9aGqs=;
        b=WXDH/CMDQZYGSi/eYGAv/ziZ/Kath+bSx6jYB4GgTHD1m/q6tAb2ftqED/bmvqDkja
         RS1qOwLC29AdSDKuQJNCf560UMMTg/iP4n3uou8F7rfZjletWYFtvbRIk86kC2wvgaGG
         7Kr07LDtT1p0XW+VMSuqxduPva0ovFrcwYgAC4TBaZJK7lA0GibCM6fT7T7IyLdv+Dlo
         Z7Ey1VCllHYQ0nuuEILba3eBMtQwSLgDE0VNPU5Mz6ecMc/h23Jt0SWtIuUSaUhf+Rdg
         VcxRQP6NGfMtmqZH2Z+f1OJxWlULafkyR48fBcU7Iqh4Be3STgE8GAH+k+a3NnrFv6+R
         3Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5CxkaIVTY0HaJ9D8eCB6WdnU+YVYJtVOwAoTc9aGqs=;
        b=a0iuUOuip5tDXrwmTbBJFCpm3oWFeVNIdXr0PeV+s5ICBIx+nFiHevn858P9nOfTCD
         MWwFuf28JKLn6faGqWS53rXTEBRtCC1jFd3zQs88VE6VoRbqeZ9k2xBrTva2Lq12Vm/U
         EIRr3B8QtA9A3RxRdtS0Ucp280Zh27UfvNJ00dW452fKwBJvfP5luWnHYH/iFuMS9YnI
         /2M7oEXlgQEc2dsvjVNnatlGkuZzfOgNPl+07OWDr2cYun0hGz8/P5EhSwXKRXLzKPVO
         Xg9PiRXoGxuax8U+HAG7cnSjRjfT2yVokUp8anACN/8exEG4OJavVHSx+tksk6PfYE5W
         3BBw==
X-Gm-Message-State: APjAAAVZQKMnaS1GvY1QgCLnZa2laBRLoHy2xRk2XA8Us50cisOaLFNa
        rP5ubwyQtjAmjj3v43Ey1/XJ6iqmH+Y0HOe9Dgyzns6+ixM=
X-Google-Smtp-Source: APXvYqwRVpJ+rNp2Wc3lNOmF5kn+eN1/4ttVSLtk+NtQMQ6cs0LrcaTVF3D1uBty6j577ThS87zLPgJvA/V4ZP/T0hM=
X-Received: by 2002:a37:b744:: with SMTP id h65mr109687qkf.85.1582737349337;
 Wed, 26 Feb 2020 09:15:49 -0800 (PST)
MIME-Version: 1.0
References: <5e4b4889.1c69fb81.bc072.65a9@mx.google.com> <50f9ce8b-c303-3b25-313b-cfb62d7e8735@collabora.com>
 <158215618721.184098.2077489323832918966@swboyd.mtv.corp.google.com> <20200225133815.fjc6apts3ns5zcm5@gilmour.lan>
In-Reply-To: <20200225133815.fjc6apts3ns5zcm5@gilmour.lan>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 26 Feb 2020 18:15:38 +0100
Message-ID: <CAFqH_52T7QATdhJktDQPx7CeBTKocZfZ8LPAZp4+RMqsOHu0gw@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on sun8i-h2-plus-orangepi-zero
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>, mgalka@collabora.com,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Missatge de Maxime Ripard <maxime@cerno.tech> del dia dt., 25 de febr.
2020 a les 15:34:
>
> On Wed, Feb 19, 2020 at 03:49:47PM -0800, Stephen Boyd wrote:
> > Adding some Allwinner folks. Presumably there is some sort of clk that
> > is failing to calculate a phase when it gets registered. Maybe that's
> > because the parent isn't registered yet?
>
> It's simpler than that :)
>
> > Quoting Guillaume Tucker (2020-02-17 23:45:41)
> > > Hi Stephen,
> > >
> > > Please see the bisection report below about a boot failure.
> > >
> > > Reports aren't automatically sent to the public while we're
> > > trialing new bisection features on kernelci.org but this one
> > > looks valid.
> > >
> > > There's nothing in the serial console log, probably because it's
> > > crashing too early during boot.  I'm not sure if other platforms
> > > on kernelci.org were hit by this in the same way, it's tricky to
> > > tell partly because there is no output.  It should possible to
> > > run it again with earlyprintk enabled in BayLibre's test lab
> > > though.
> > >
> > > Thanks,
> > > Guillaume
> > >
> > >
> > > On 18/02/2020 02:14, kernelci.org bot wrote:
> > > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > > * This automated bisection report was sent to you on the basis  *
> > > > * that you may be involved with the breaking commit it has      *
> > > > * found.  No manual investigation has been done to verify it,   *
> > > > * and the root cause of the problem may be somewhere else.      *
> > > > *                                                               *
> > > > * If you do send a fix, please include this trailer:            *
> > > > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > > > *                                                               *
> > > > * Hope this helps!                                              *
> > > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > >
> > > > next/master bisection: baseline.login on sun8i-h2-plus-orangepi-zero
> > > >
> > > > Summary:
> > > >   Start:      c25a951c50dc Add linux-next specific files for 20200217
> > > >   Plain log:  https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.txt
> > > >   HTML log:   https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.html
> > > >   Result:     2760878662a2 clk: Bail out when calculating phase fails during clk registration
> > > >
> > > > Checks:
> > > >   revert:     PASS
> > > >   verify:     PASS
> > > >
> > > > Parameters:
> > > >   Tree:       next
> > > >   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > >   Branch:     master
> > > >   Target:     sun8i-h2-plus-orangepi-zero
> > > >   CPU arch:   arm
> > > >   Lab:        lab-baylibre
> > > >   Compiler:   gcc-8
> > > >   Config:     multi_v7_defconfig
> > > >   Test case:  baseline.login
> > > >
> > > > Breaking commit found:
> > > >
> > > > -------------------------------------------------------------------------------
> > > > commit 2760878662a290ac57cff8a5a8d8bda8f4dddc37
> > > > Author: Stephen Boyd <sboyd@kernel.org>
> > > > Date:   Wed Feb 5 15:28:02 2020 -0800
> > > >
> > > >     clk: Bail out when calculating phase fails during clk registration
> > > >
> > > >     Bail out of clk registration if we fail to get the phase for a clk that
> > > >     has a clk_ops::get_phase() callback. Print a warning too so that driver
> > > >     authors can easily figure out that some clk is unable to read back phase
> > > >     information at boot.
> > > >
> > > >     Cc: Douglas Anderson <dianders@chromium.org>
> > > >     Cc: Heiko Stuebner <heiko@sntech.de>
> > > >     Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> > > >     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > >     Link: https://lkml.kernel.org/r/20200205232802.29184-5-sboyd@kernel.org
> > > >     Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> > > >
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index dc8bdfbd6a0c..ed1797857bae 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -3457,7 +3457,12 @@ static int __clk_core_init(struct clk_core *core)
> > > >        * Since a phase is by definition relative to its parent, just
> > > >        * query the current clock phase, or just assume it's in phase.
> > > >        */
> > > > -     clk_core_get_phase(core);
> > > > +     ret = clk_core_get_phase(core);
> > > > +     if (ret < 0) {
> > > > +             pr_warn("%s: Failed to get phase for clk '%s'\n", __func__,
> > > > +                     core->name);
> > > > +             goto out;
> > > > +     }
>
> The thing is, clk_core_get_phase actually returns the phase on success :)
>
> So, when you actually have a phase returned, and not an error, you end
> up with a positive, non-zero, value for ret.
>
> And since it's the latest assignment of that value, and that we return
> ret all the time, even on success, we end up returning that positive,
> non-zero value to __clk_register, which in turn tests whether it's
> non-zero for success (it's not), and then proceeds to garbage collect
> everything.
>
> I guess we're just the odd ones actually returning non-zero phases at
> init time and in kernelci.
>

Just to note that not only Allwiner is affected, Rockchip is also
affected by this issue. Reverting the patch fixes the issue for me,
but the patch proposed by Maxime [1] does _NOT_ fixes the issue for
Rockchip, there is something else, I'll take a look. I can't answer
that patch because didn't reach my inbox.

Regards,
 Enric

[1] https://patchwork.kernel.org/patch/11403837/


> I'll send a patch
>
> Maxime
