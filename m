Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD63C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE6420870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r26kDvC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgCDJ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:28:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42355 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCDJ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:28:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id r6so821230qtt.9;
        Wed, 04 Mar 2020 01:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gl3g5C4doThdblYBOeODrU4pmYehX5lqS+8eZ4iN7/Y=;
        b=r26kDvC9lBQ1HNsWqqH5S1iJQtOa1Q+KXEUuQj9kuVfSHp+OuwXFYrsjlobeGq071G
         hemnXer0bN2JRivuTfcJu3+ncIzYCcCXhwPLbMIMsxAWoQcGVhZ7kronSA4eHOx0EhU8
         T4pEorlb47urXAyFrugIQHPSMnibfWB54+TPZBtXG7QLvUMm55x2r7P3SympuQvpLiKU
         Jl6XiYVKSHZI5Ji+IC/NApyfGMJCdlSI8XKhdRZAlNNAu7BbFvsGyyqvf08qOh5zYiBY
         K8lZSeAM/4R/ekMvlm0gWxqH1Cmlw0ETdQBD0PPizdgsQB4KfJ3pY4XeLrD6seN0Fb4v
         SPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gl3g5C4doThdblYBOeODrU4pmYehX5lqS+8eZ4iN7/Y=;
        b=uKjTx7nXRoMAP4LBDR6bhGS75s44WS4pEOMl6vLnouJNoruV2Z2fCYx6F0N5tytFYf
         +k/5IPXS8bfKpZ+ySvR0Lqmz757cKlLVzT0WemWctUSY8aKyM/eDzTG19Qoi5BgFOgT+
         h5JJRVKBLviJnxYsOZgLREiFOWdqClD0tlMeu/929vwgfOOwxSGE97WUmB+eo6cAIuU7
         TjM7TZw/xnyoIB3Rbtc83I2MBQ8zrwfShxY6aCzNG9IkbzSmz+KTH9BsVme96CBMTlWZ
         2EwJqAN+Qcygj1HU2X672XWmIYyeP5PU6RHxEA2HL/Y8oZ5k1UOLw42ueX1EduZBx7bj
         uxzQ==
X-Gm-Message-State: ANhLgQ2Rf61smJE16GE91Lm2GodeyWD+BkUVfYlVUIvNaBUWW9g0uT6P
        aUTbIb3MWqx35ZKMRdUMHETvADmb5fomwBBqnm0=
X-Google-Smtp-Source: ADFU+vtgHfNj4f1ZC6fJvJ1rKV9j+lW+K5iTmAt624xC6daTEyvWzedVfl4fqV6SITV4mEOb/8XVindTCxoIY6qNljk=
X-Received: by 2002:ac8:7090:: with SMTP id y16mr1495169qto.356.1583314081349;
 Wed, 04 Mar 2020 01:28:01 -0800 (PST)
MIME-Version: 1.0
References: <5e4b4889.1c69fb81.bc072.65a9@mx.google.com> <50f9ce8b-c303-3b25-313b-cfb62d7e8735@collabora.com>
 <158215618721.184098.2077489323832918966@swboyd.mtv.corp.google.com>
 <20200225133815.fjc6apts3ns5zcm5@gilmour.lan> <CAFqH_52T7QATdhJktDQPx7CeBTKocZfZ8LPAZp4+RMqsOHu0gw@mail.gmail.com>
In-Reply-To: <CAFqH_52T7QATdhJktDQPx7CeBTKocZfZ8LPAZp4+RMqsOHu0gw@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 4 Mar 2020 10:27:50 +0100
Message-ID: <CAFqH_5018cMsKRW1cztq7uno51iwD6huxTnWYPm2rQ6ensNhHg@mail.gmail.com>
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

Missatge de Enric Balletbo Serra <eballetbo@gmail.com> del dia dc., 26
de febr. 2020 a les 18:15:
>
> Hi all,
>
> Missatge de Maxime Ripard <maxime@cerno.tech> del dia dt., 25 de febr.
> 2020 a les 15:34:
> >
> > On Wed, Feb 19, 2020 at 03:49:47PM -0800, Stephen Boyd wrote:
> > > Adding some Allwinner folks. Presumably there is some sort of clk that
> > > is failing to calculate a phase when it gets registered. Maybe that's
> > > because the parent isn't registered yet?
> >
> > It's simpler than that :)
> >
> > > Quoting Guillaume Tucker (2020-02-17 23:45:41)
> > > > Hi Stephen,
> > > >
> > > > Please see the bisection report below about a boot failure.
> > > >
> > > > Reports aren't automatically sent to the public while we're
> > > > trialing new bisection features on kernelci.org but this one
> > > > looks valid.
> > > >
> > > > There's nothing in the serial console log, probably because it's
> > > > crashing too early during boot.  I'm not sure if other platforms
> > > > on kernelci.org were hit by this in the same way, it's tricky to
> > > > tell partly because there is no output.  It should possible to
> > > > run it again with earlyprintk enabled in BayLibre's test lab
> > > > though.
> > > >
> > > > Thanks,
> > > > Guillaume
> > > >
> > > >
> > > > On 18/02/2020 02:14, kernelci.org bot wrote:
> > > > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > > > * This automated bisection report was sent to you on the basis  *
> > > > > * that you may be involved with the breaking commit it has      *
> > > > > * found.  No manual investigation has been done to verify it,   *
> > > > > * and the root cause of the problem may be somewhere else.      *
> > > > > *                                                               *
> > > > > * If you do send a fix, please include this trailer:            *
> > > > > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > > > > *                                                               *
> > > > > * Hope this helps!                                              *
> > > > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > > >
> > > > > next/master bisection: baseline.login on sun8i-h2-plus-orangepi-zero
> > > > >
> > > > > Summary:
> > > > >   Start:      c25a951c50dc Add linux-next specific files for 20200217
> > > > >   Plain log:  https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.txt
> > > > >   HTML log:   https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.html
> > > > >   Result:     2760878662a2 clk: Bail out when calculating phase fails during clk registration
> > > > >
> > > > > Checks:
> > > > >   revert:     PASS
> > > > >   verify:     PASS
> > > > >
> > > > > Parameters:
> > > > >   Tree:       next
> > > > >   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > > >   Branch:     master
> > > > >   Target:     sun8i-h2-plus-orangepi-zero
> > > > >   CPU arch:   arm
> > > > >   Lab:        lab-baylibre
> > > > >   Compiler:   gcc-8
> > > > >   Config:     multi_v7_defconfig
> > > > >   Test case:  baseline.login
> > > > >
> > > > > Breaking commit found:
> > > > >
> > > > > -------------------------------------------------------------------------------
> > > > > commit 2760878662a290ac57cff8a5a8d8bda8f4dddc37
> > > > > Author: Stephen Boyd <sboyd@kernel.org>
> > > > > Date:   Wed Feb 5 15:28:02 2020 -0800
> > > > >
> > > > >     clk: Bail out when calculating phase fails during clk registration
> > > > >
> > > > >     Bail out of clk registration if we fail to get the phase for a clk that
> > > > >     has a clk_ops::get_phase() callback. Print a warning too so that driver
> > > > >     authors can easily figure out that some clk is unable to read back phase
> > > > >     information at boot.
> > > > >
> > > > >     Cc: Douglas Anderson <dianders@chromium.org>
> > > > >     Cc: Heiko Stuebner <heiko@sntech.de>
> > > > >     Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > >     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > >     Link: https://lkml.kernel.org/r/20200205232802.29184-5-sboyd@kernel.org
> > > > >     Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > >
> > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > index dc8bdfbd6a0c..ed1797857bae 100644
> > > > > --- a/drivers/clk/clk.c
> > > > > +++ b/drivers/clk/clk.c
> > > > > @@ -3457,7 +3457,12 @@ static int __clk_core_init(struct clk_core *core)
> > > > >        * Since a phase is by definition relative to its parent, just
> > > > >        * query the current clock phase, or just assume it's in phase.
> > > > >        */
> > > > > -     clk_core_get_phase(core);
> > > > > +     ret = clk_core_get_phase(core);
> > > > > +     if (ret < 0) {
> > > > > +             pr_warn("%s: Failed to get phase for clk '%s'\n", __func__,
> > > > > +                     core->name);
> > > > > +             goto out;
> > > > > +     }
> >
> > The thing is, clk_core_get_phase actually returns the phase on success :)
> >
> > So, when you actually have a phase returned, and not an error, you end
> > up with a positive, non-zero, value for ret.
> >
> > And since it's the latest assignment of that value, and that we return
> > ret all the time, even on success, we end up returning that positive,
> > non-zero value to __clk_register, which in turn tests whether it's
> > non-zero for success (it's not), and then proceeds to garbage collect
> > everything.
> >
> > I guess we're just the odd ones actually returning non-zero phases at
> > init time and in kernelci.
> >
>
> Just to note that not only Allwiner is affected, Rockchip is also
> affected by this issue. Reverting the patch fixes the issue for me,
> but the patch proposed by Maxime [1] does _NOT_ fixes the issue for
> Rockchip, there is something else, I'll take a look. I can't answer
> that patch because didn't reach my inbox.
>
> Regards,
>  Enric
>
> [1] https://patchwork.kernel.org/patch/11403837/
>

For the record, the patch that fixes the issue on Rockchip is this:

* https://lkml.org/lkml/2020/3/3/1353

Thanks,
  Enric

>
> > I'll send a patch
> >
> > Maxime
