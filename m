Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED15CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D552065F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss+c31OQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGUC5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGUC5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:57:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F8DC061794;
        Mon, 20 Jul 2020 19:57:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w9so6005167ejc.8;
        Mon, 20 Jul 2020 19:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3JdCJR2g5rc0/sk91yNgBSkmWQJyhTVgrDHkUGVHjw=;
        b=Ss+c31OQAohgVfaRucUoILyjm6J/RThUhKr6ofrstPJujUivtlfDotidMEUMZKHB+0
         6Wd6QUhcvkfDapbavhErmJ80xEwYbu9YZytMwRbP3eIdEmtSgbBxJUO3oPmjUHf9Ni8f
         27bk0w+qnBMTTEKloJighsCyGrB0kBIe/tJh8WlNOo5GaoaYyVSaMRJ2vt5Q8APzYigr
         AXzCk+Y704447zXoZzuMh+A90Z5uB7ZVUSMz2YbKXDFDObY4VJkICExQraK7UJVYlCtj
         OdyImGMjFLv1Vl5UrvH9yK0dRDbbO/IC2odAOVT4JoaadEul+SqJy2UkDNLexg7REcBO
         GxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3JdCJR2g5rc0/sk91yNgBSkmWQJyhTVgrDHkUGVHjw=;
        b=T70sxmGq6tgpYOpn/NRPRwfEvm2AtWVeJeSYUKRjLide9F6sFsKSQN6DE3cUkMgfVQ
         xzFqFjYS1czz66WiD1/0lwvuNYduekWf324n3HtrIR7hTlt0OJ6n+CERQLT/YA0BAbGp
         NDwoicXS2Q4vrZV0ykbOSElo9tOng5YY91Um1sAiT6hS2COegp8QDinM3OEDaf7itnQf
         DcaQS2+jc4XEitOHuaGzN+eiB8k4GsGNxQwwdrFZldy3OzIuN3XHoGxHqa95KRU8pTJn
         rzHd5lXnyj6s6aftpglGMDDa0uG8WDfgvy+e783CI3SCuGeuW70pW/YR4351KcRvhnpR
         FnKA==
X-Gm-Message-State: AOAM531W14eRiMuAKmzjJi7z4PpOD+uw5ImyDA1HtolikcPJ+NIjBWCx
        YpyfnbjNUPsTcZ08kXYnrZ+KUiiEji8DrjBovOU=
X-Google-Smtp-Source: ABdhPJxwgJlH0PXNzdQwqlPRE5KW+3uZUS5mN2weS9bw8M9k15h4pa+fCzhaVK9NIYfSd8sazWjt2MCDtc2a5bKHZ9o=
X-Received: by 2002:a17:906:494a:: with SMTP id f10mr24210363ejt.428.1595300243613;
 Mon, 20 Jul 2020 19:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184125.15114-1-khsieh@codeaurora.org> <159527632812.1987609.6364896740387949838@swboyd.mtv.corp.google.com>
 <91a8eef836c1939cb57942c6fdcf2772@codeaurora.org> <159528794676.3847286.1584696687662833591@swboyd.mtv.corp.google.com>
In-Reply-To: <159528794676.3847286.1584696687662833591@swboyd.mtv.corp.google.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Jul 2020 19:57:59 -0700
Message-ID: <CAF6AEGs0+=tpOWtY0kUc=Vt7EdEEwQjEffMXxFtDo142gRYRhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     khsieh@codeaurora.org, Sean Paul <sean@poorly.run>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        aravindh@codeaurora.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 4:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting khsieh@codeaurora.org (2020-07-20 15:48:13)
> > On 2020-07-20 13:18, Stephen Boyd wrote:
> > > Quoting Kuogee Hsieh (2020-07-07 11:41:25)
> > >>  drivers/gpu/drm/msm/dp/dp_power.c           |  32 +-
> > >>  drivers/gpu/drm/msm/dp/dp_power.h           |   1 +
> > >>  drivers/gpu/drm/msm/dp/dp_reg.h             |   1 +
> > >>  17 files changed, 861 insertions(+), 424 deletions(-)
> > >
> > > It seems to spread various changes throughout the DP bits and only has
> > > a
> > > short description about what's changing. Given that the series above
> > > isn't merged it would be better to get rid of this change and make the
> > > changes in the patches that introduce these files.
> > >
> >
> > Yes, the base DP driver is not yet merged as its still in reviews and
> > has been for a while.
> > While it is being reviewed, different developers are working on
> > different aspects of DP such as base DP driver, DP compliance, audio etc
> > to keep things going in parallel.
> > To maintain the authorship of the different developers, we prefer having
> > them as separate changes and not merge them.
> > We can make all these changes as part of the same series if that shall
> > help to keep things together but would prefer the changes themselves to
> > be separate.
> > Please consider this and let us know if that works.
> >
>
> I'm not the maintainer here so it's not really up to me, but this is why
> we have the Co-developed-by tag, to show that multiple people worked on
> some patch. The patch is supposed to logically stand on its own
> regardless of how many people worked on it. Authorship is a single
> person but the Co-developed-by tag helps express that more than one
> person is the actual author of the patch. Can you use that tag instead
> and then squash this into the other DP patches?

The dpu mega-patches are hard enough to review already.. I'd really
appreciated it if the dpu dev's sort out some way to squash later
fixups into earlier patches

BR,
-R
