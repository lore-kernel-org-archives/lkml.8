Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDDD206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h90L6CtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgFDOpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgFDOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:45:31 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AFEC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:45:31 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h39so1383941ybj.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZKHwtfyBCV5upqngI9dBMaL1/1fLbc0WNsqlGuWezI=;
        b=h90L6CtCQfj4hiqNXjc5U6lg7npWpoCZxsJOwAg+LC2zVPINJxcdTBipIfJD3jwAQd
         SHudpUBYr/SUN7xDKUVzxGPFZFig5NrqJ3H4Fo8x4JD5La95WvX9+wpvmTupY64r69T7
         J80RdZL5ZVQR8MD00xZudy2aJDdas0PskIWn0BO1+cAmmt6qFXbOjVEnGKSF+9ebjMGb
         ZcPwuz+APbZi9wKRFkF0qXJwZP91Rq5SFKJltei8SLIYOK1o81/pGLIuH2Fcw/i5nkp/
         DB6dKeE7uRTYV3Nun6FDuYXBcJwgZGIF4D2JtUB/cZNpzo1YrJb3wWw7PkJEwV0EscAS
         KKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZKHwtfyBCV5upqngI9dBMaL1/1fLbc0WNsqlGuWezI=;
        b=XsOO3j6DIK2mvA6DI+6WmEIYXBEOqzs9Wf4RCimijpxXiWCW3ErkCqRLTP7YCqUirI
         zwsW7VE9xE6v12DmuExJCDl3NGdVHSVUWn+FMNPUqfKvxnwDtx0b8sWBSenQ0gkwsDwY
         dYicyHwWagRIq6VOHM/l5c8lhZ/hPe0WcKkpGDn/Z4nXhA5CkJifKm3cV2oDJa8lCF87
         ZYbaWRgL6JR3W79H2xhfJwBfdl/TUchuMienbSK9MmTTcXISX71zFrxpFug6hL0U37lY
         n96maew6r5utn/9kwARn9GDuX0L86CthKBOx6jYQ1mDa/pTlrbd7tcQGqLW/EqT8Mibp
         xMDw==
X-Gm-Message-State: AOAM533SBA90Qc/hfYr0Ps2oOJTfFx2bKxwTCs4vSsCuwNdUORDt8EnK
        XtQqw6eh0jNxKI4WVhimUdUqM/UnfGUEqm4fsC8kTfpL
X-Google-Smtp-Source: ABdhPJyU+cmROs86wDnvcksxpA8HC81zK0gwoi91iDExK6AQtKTqMybxUmlXVZ4g61mFoiOCOp+1JAP3TaQQECuUK+I=
X-Received: by 2002:a25:4f08:: with SMTP id d8mr9102960ybb.125.1591281930627;
 Thu, 04 Jun 2020 07:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <202006031618.DA25142@keescook> <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
 <CAD8XO3bezWoM7Pc0VoiFgoDWTLMN6VwV1vEFL7PR=_iohV82Ag@mail.gmail.com> <97eb5b4e4db4b50462032b1da0788dd61ed0a30e.camel@perches.com>
In-Reply-To: <97eb5b4e4db4b50462032b1da0788dd61ed0a30e.camel@perches.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 4 Jun 2020 17:45:19 +0300
Message-ID: <CAD8XO3YM5OttTiFAhwTonmn4hy=LV--ATyPq2kfO4tS4exdcYw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 10:29, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-06-04 at 09:55 +0300, Maxim Uvarov wrote:
> > On Thu, 4 Jun 2020 at 03:39, Joe Perches <joe@perches.com> wrote:
>
> Hi Maxim.
>
> > > btw: My codespell dictionary file moved to
> > > /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt
> > >
> > > and I had to use --codespell --codespellfile=(above) so
> > > maybe there should be multiple lookups for this file
> > > like the array below.
> > >
> > > Are there other standard codespell dictionary locations?
> >
> > It might be better to support standard and non standard locations.
>
> It already does with the --codespellfile=<location> opti.
>

I mean if codespess is in your PATH then it will be good to query
dictinary.txt. Even if you install codespell to your $HOME it still is
possible to use it without manually specifying where is the file.


> > I think it's better to request from codespell where his dictionary is.
>
> Maybe a good idea, but looking at the codespell git, for
> versions 1.17 on there are several standard dictionaries.
> https://github.com/codespell-project/codespell/tree/v1.17.1/codespell_lib/data
>
> > I created ticket for this:
> > https://github.com/codespell-project/codespell/issues/1540
>
> Even if codespell is updated, the script would have to deal
> with older versions that don't support requesting that option.
>

Yes, we have to support old versions.

> cheers, Joe
>
>
