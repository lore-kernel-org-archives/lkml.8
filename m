Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F988C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC7620731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFEKLFgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgIJEXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJEXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 00:23:42 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A18C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 21:23:41 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x8so3248539ybm.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 21:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eMi6Tr0LlsDBlM6QiOu6xP2+hAoSjCKsAUIpkGtlPA=;
        b=XFEKLFgxSjtgby5dZNg9BUlFoRVUhE+9I9O2rx/YpQivcHJ8V+rXoPjVL4RBnXHBiX
         Pn0sJZjHH1QU7avB24ZbL4K8+ZiEpyWvFs6+niw1f1mg1EVF/CtRtMS/2N2XPskz5ZMt
         6hA08B2Lmvi1eV/sBGcBQF8nvB+rVC9zYUaarzaqqT0XUIzE/pao4IS0AsdGySOWndS+
         C1cV0IbAJEQha+ggd5oifWIOTHjLuNFzvKRIJHobi8Ck9jPSXK5L4OXZSHXo70Nw27gR
         IC7Xt+O6SbrgwtfKt5FJEFIp4I4p8SF1UG0E02x+iSt+6plzvCaBfvfbJerHUI/anc8b
         LuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eMi6Tr0LlsDBlM6QiOu6xP2+hAoSjCKsAUIpkGtlPA=;
        b=dqpKdDuWIsJ24fSz9iVD8vS2JlBqF+tfLCbV8eGWQaqE1b+XAm4czmFzgcFtejfm5w
         Q25dg9lbnG3250YVDYh0H3PD+NFDgSo474klaWjlLAQeheXG9RjjMl8xsqRAN3CJ1TYl
         zRELB1Nxj7AuYS6ojB6cXRm48vUqxf5FU1dXl5DHfRFmkEpvgP+ZwXd9A8B4bUbJqCvS
         wfx7Rzcax+NF0rEc+IsKENORyT9YYsL176tFleuw3Vnvd7NXiYUJD2avqQ2tIv/7retj
         bGGPhk/rNKUlRQalYbDYzNZuGnbG6cm09hhcX3LT2b4JVQVTgHHd6n1PjH0Mez7DlWwb
         Nlfg==
X-Gm-Message-State: AOAM531hzz6OpmxgO88ozXwmbzmc9YBUyxXQlBYq6tRhj8xmkMrV0aEc
        sJA9aDsyHGBIQJLbtGIE2Pgdbn7hWlNBeM9ARDymSzAvUuE=
X-Google-Smtp-Source: ABdhPJx2TXiTER+LYCqBPMv17tIEsx6ZuvO/+P6A+Nn9JA+Vm/7lsXf2boUmHrOKzudz1ZjRrBaAFWjASSSY2IuUUq0=
X-Received: by 2002:a25:c07:: with SMTP id 7mr9862909ybm.200.1599711821234;
 Wed, 09 Sep 2020 21:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200812204952.1921587-1-jcline@redhat.com> <CACAvsv71oxCYB1+LCAUHD5v_NGAP-DpxPY_dPz53iw2=91KAJg@mail.gmail.com>
 <CACO55tvv6REmNzZZyyRSJyRT5z-xEf38+tk9cDnft63DX5JQUw@mail.gmail.com> <20200909140706.GA27322@dev.jcline.org>
In-Reply-To: <20200909140706.GA27322@dev.jcline.org>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 10 Sep 2020 14:23:30 +1000
Message-ID: <CACAvsv5Pr_=ns89XqY2JbLNo8vPHdv6CJW3LJpFb4c+HAjiK8Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Add fine-grain temperature reporting
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 at 00:07, Jeremy Cline <jcline@redhat.com> wrote:
>
> On Wed, Sep 09, 2020 at 10:22:14AM +0200, Karol Herbst wrote:
> > On Wed, Sep 9, 2020 at 6:06 AM Ben Skeggs <skeggsb@gmail.com> wrote:
> > >
> > > On Thu, 13 Aug 2020 at 06:50, Jeremy Cline <jcline@redhat.com> wrote:
> > > >
> > > > Commit d32656373857 ("drm/nouveau/therm/gp100: initial implementation of
> > > > new gp1xx temperature sensor") added support for reading finer-grain
> > > > temperatures, but continued to report temperatures in 1 degree Celsius
> > > > increments via nvkm_therm_temp_get().
> > > >
> > > > Rather than altering nvkm_therm_temp_get() to report finer-grain
> > > > temperatures, which would be inconvenient for other users of the
> > > > function, a second interface has been added to line up with hwmon's
> > > > native unit of temperature.
> > > Hey Jeremy,
> > >
> > > Sorry this slipped past me until now.  I'm OK with adding support for
> > > millidegree temperature reporting, but don't think we need to keep
> > > both interfaces around and would rather see the existing code
> > > converted to return millidegrees (even on GPUs that don't support it)
> > > instead of degrees.
> > >
> > > Thanks!
> > > Ben.
> > >
> >
> > just a note as I was trying something like that in the past: we have a
> > lot of code which fetches the temperature and there are a lot of
> > places where we would then do a divide by 1000, so having a wrapper
> > function at least makes sense. If we want to keep the func pointers?
> > well.. I guess the increased CPU overhead wouldn't be as bad if all
> > sub classes do this static * 1000 as well either. I just think we
> > should have both interfaces in subdev/therm.h so we can just keep most
> > of the current code as is.
> >
>
> Indeed. My initial plan was to change the meaning of temp_get() and
> adjust all the users, but there's around a dozen of them and based on my
> understanding of the users none of them cared much about such accuracy.
>
> However, I do find having one way to do things appealing, so if there's
> a strong preference for it, I'm happy to produce a somewhat more
> invasive patch where all users expect millidegrees.
Yeah, I do have a strong preference for not having to keep multiple
interfaces around unnecessarily.  It'd be somewhat different if we had
external interactions, but this is all stuff within the module and we
should be able to make these kinds of changes without too much pain.

Ben.

>
> - Jeremy
>
