Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99141C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7127D20575
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKA2nH/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgDTUsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:48:11 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:48:10 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d74so851639vka.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+ddsi5VGRAjSUDzYFLvM4SMaW8xDMNOr5MejZ6LqjQ=;
        b=CKA2nH/nooYDOCpIHm+FZyrE3QSdUeH80aEVskTZhJ5hvmFNeeuqWGmlcYLV3kD80X
         k867cXGkm9KVgnlM6zq7bkXRIuVsY1jL0IbWduWO5Dihn2SDF4qjYXCxjuzD3dq+1hXR
         bf6rXnMLqg0Pl90SvjAdOAciFvULAXvAfh/Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+ddsi5VGRAjSUDzYFLvM4SMaW8xDMNOr5MejZ6LqjQ=;
        b=HamSirgijvPSg2GvUihXugV9rhXxsO895ymNi4yO92RbgTGHnbIS2Wj2Np0uOOGoG9
         wETDYBsE1mb14opo7KShEzjAp2/T3OMxx1GYzbI8dBkai+U/T6wVNw03MB7bF7IycUxp
         RIhQ/Xj6Ihas43HUp1HpILxSNEemHMju86zktyPRWtuwNs8hG4F4xpsLqjQnNc7mH6ml
         +ca9hvHxnDyxx4ijUhaDb1FBnjBoJYyqN3Y9nXcwbum5UhF/fbHPItWysFDNrVF3yuKz
         Sga1bq74IRPP7uEzr7Si1o/f/H/nLzYMdWjA+fafhrBvr6dSusX6pe4xn6E49Q/cc5cw
         hwLQ==
X-Gm-Message-State: AGi0Pub73mwR7tyrCozc8/wly/BUdXX5C6nOzPw35UWW6tpyQ0RpOsc9
        vXwLuNvfacS9bkcjwkLYlXxaZAQndlg=
X-Google-Smtp-Source: APiQypKopT8m8ZADa9aWlFUztkPB+dtACT+ICKkXHrUteqcaEmiBwktqkgQyHtkZEz7A5IdWRiOaEA==
X-Received: by 2002:a1f:3190:: with SMTP id x138mr12987301vkx.41.1587415689132;
        Mon, 20 Apr 2020 13:48:09 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id q125sm166387vke.4.2020.04.20.13.48.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:48:08 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id n26so2510187uap.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:48:08 -0700 (PDT)
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr9683072uab.8.1587415687643;
 Mon, 20 Apr 2020 13:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid>
 <20200420203107.GR576963@builder.lan>
In-Reply-To: <20200420203107.GR576963@builder.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Apr 2020 13:47:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVqdpNyCmtDFb1t_BZiu=7QbMNTr91Pfm1Jd3V6CMhrA@mail.gmail.com>
Message-ID: <CAD=FV=WVqdpNyCmtDFb1t_BZiu=7QbMNTr91Pfm1Jd3V6CMhrA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh: Dirt can only make you dirtier, not cleaner
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 20, 2020 at 1:30 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 17 Apr 14:15 PDT 2020, Douglas Anderson wrote:
>
> > Adding an item into the cache should never be able to make the cache
> > cleaner.  Use "|=" rather than "=" to update the dirty flag.
> >
>
> This is correct...
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> > Fixes: bb7000677a1b ("soc: qcom: rpmh: Update dirty flag only when data changes")
> > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/soc/qcom/rpmh.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> > index 3abbb08cd6e1..d1626a1328d7 100644
> > --- a/drivers/soc/qcom/rpmh.c
> > +++ b/drivers/soc/qcom/rpmh.c
> > @@ -151,10 +151,10 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
> >               break;
> >       }
> >
> > -     ctrlr->dirty = (req->sleep_val != old_sleep_val ||
> > -                     req->wake_val != old_wake_val) &&
> > -                     req->sleep_val != UINT_MAX &&
> > -                     req->wake_val != UINT_MAX;
> > +     ctrlr->dirty |= (req->sleep_val != old_sleep_val ||
> > +                      req->wake_val != old_wake_val) &&
> > +                      req->sleep_val != UINT_MAX &&
> > +                      req->wake_val != UINT_MAX;
>
> ...but this logic says dirty "if either sleep or wake has changed and
> both sleep and wake are requested".
>
> So what if we have an entry with only sleep wake changed, then the
> controller won't be dirty and hence the hardware won't know about this
> request - until another "fully specified" request comes in, which would
> cause the controller to be dirty and flush out the "partially specified"
> request as well.
>
> Is this really the expected behavior?

IIRC, this has to do with how is_req_valid() works and how it's called
from rpmh_flush().  ...but since I clearly screwed up the "|=" in the
past let's see if I screwed this up too.  ...errr, what I mean to say
is that I never make any mistakes.  Ever.  How dare you accuse me of
such a thing?  ;-)

So is_req_valid() says that a request is valid if all three of these are true
* Sleep is not UINT_MAX
* Wake is not UINT_MAX
* Sleep is not equal to wake

If a request is not valid then rpmh_flush will ignore it, it won't be
sent, and it's as if it wasn't even in the cache.  Also: It's not
expected that anyone will ever change a value _to_ UINT_MAX, so once
something is initialized it's never uninitialized (NOTE: I don't think
anything actually enforces this).

The above means that until both sleep and wake have changed away from
their default of UINT_MAX that they can't really dirty the cache
because we act as if they're not even in the cache.  Once they get
something then the cache gets dirty if either sleep changes or wake
changes.


So I think the logic is right...  Does that make sense?


-Doug
