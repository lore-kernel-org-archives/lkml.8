Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED6FC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432FE248A6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E0DvGB4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgDFPeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:34:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35345 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgDFPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:34:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id u11so99489vsg.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cMvg7h/oulOhGRqUiRCctY34trH980/U/Kq5XqfKrw=;
        b=E0DvGB4hrP97mss+BsJg46f1cmsxu437DfT1QJitEIvdJiVPNsiOco+dY5/jRQAV/D
         IJNRoFnMdOoGbnrlvm3TqWUo79zzcAE49wFNBdiONcfRXyfP6ckrH/oUSV6HAiQNbJYy
         cXLsNIH66kgWP2PmQG/RhlOhDCsS1MW4gKPx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cMvg7h/oulOhGRqUiRCctY34trH980/U/Kq5XqfKrw=;
        b=DkoHGOQH/aHneXCbQwLotQDYGd7vBRvwj9fABfQtwBUfEaf+LZofNpaVGMLeJT7sMf
         vsJ6eLAhjL5jr9ujQbc4nWzjcZF9t0DJnuad1OOviyPZ0EECethBV/N0KBp/0++D8VIP
         t73e4BHr1oCmo8ff+c7YrvRB17oztWrqUtUJ2HxwZFYiI2hLOYtJbfWMNkXg3RtxuhMH
         lgc3lJtC8KYHciklIWE6ht3z/XjQ/Cjr6TswuitldPZFxvmJewK2dVTWeOXrj+BEtrHf
         9hJlYKankFiBCDZVDCthCa5BKPpCbDj8h+Ogp505fBPGn/1QA92Lc8ctNXbQxnwoQKXV
         GWww==
X-Gm-Message-State: AGi0PuZsQeyR3X9UKC98Mm3iWT10HyEHRNUkitxfX+2btaAcIxbScpST
        3oRt//ebKpL+uBWURb+UL0IxBpOit2k=
X-Google-Smtp-Source: APiQypKNRq3gvUSp1ib52Dd3l7b7Prfp92OvZQpXbTUOHXLql8G/iSSliqJ+1ZOB9JvCzPTPIiJ1sg==
X-Received: by 2002:a05:6102:3104:: with SMTP id e4mr155859vsh.61.1586187251980;
        Mon, 06 Apr 2020 08:34:11 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id s186sm4707335vkg.2.2020.04.06.08.34.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:34:10 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id l18so83671uak.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:34:10 -0700 (PDT)
X-Received: by 2002:ab0:1d10:: with SMTP id j16mr26743uak.91.1586187250041;
 Mon, 06 Apr 2020 08:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <1585660782-23416-1-git-send-email-mkshah@codeaurora.org>
 <1585660782-23416-7-git-send-email-mkshah@codeaurora.org> <CAD=FV=UqaTR7=i=5BApvnptZXpqVJiF1AE+Q+6H9Y4QdYfjfUQ@mail.gmail.com>
 <855bb87e-6c5c-8fee-e237-f48f9d95e2ac@codeaurora.org>
In-Reply-To: <855bb87e-6c5c-8fee-e237-f48f9d95e2ac@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Apr 2020 08:33:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wi1bbc-Q2PYq3+tohYcx+hguFJ8A8FyuQCzgUYjEJOHw@mail.gmail.com>
Message-ID: <CAD=FV=Wi1bbc-Q2PYq3+tohYcx+hguFJ8A8FyuQCzgUYjEJOHw@mail.gmail.com>
Subject: Re: [PATCH v15 6/7] soc: qcom: rpmh-rsc: Clear active mode
 configuration for wake TCS
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 5, 2020 at 10:08 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 4/3/2020 1:44 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Mar 31, 2020 at 6:21 AM Maulik Shah <mkshah@codeaurora.org> wrote:
> >> @@ -243,6 +279,14 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
> >>                  }
> >>
> >>                  trace_rpmh_tx_done(drv, i, req, err);
> >> +
> >> +               /*
> >> +                * If wake tcs was re-purposed for sending active
> >> +                * votes, clear AMC trigger & enable modes and
> >> +                * disable interrupt for this TCS
> >> +                */
> >> +               if (!drv->tcs[ACTIVE_TCS].num_tcs)
> >> +                       __tcs_set_trigger(drv, i, false);
> > Still seems weird that we have to do the untrigger in the IRQ routine
> > here and also weird that we _don't_ do it in the IRQ routine for
> > non-borrowed TCSes.  I guess it's not the end of the world, though.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks Doug for the review.
>
> IRQ is only needed to be enabled for TCSes used as ACTIVE_TCS.
>
> When we have dedicated ACTIVE_TCS, we leave IRQ always enabled from
> probe (one time configuration), since the TCS won't be used for anything
> other than to send ACTIVE transaction.
>
> When we don't have dedicated ACTIVE_TCS, we enable it when borrowed TCS
> is used for ACTIVE transaction and then once its done using it, we
> disable it again to leave it in its original configuration.

Sure, I get the concept.  ...but:

* It seems like it would be ideal to not call __tcs_set_trigger() from
the IRQ handler.  It uses write_tcs_reg_sync() which has a wait loop
in it.  That's not something you normally want in an IRQ handler.

* It seems like it would be a common case for the WAKE_TCS to be
borrowed several times in-between actually using it as a WAKE_TCS.

To make both of the above things better, it seems like you could just
leave the WAKE_TCS configured for active-mode transfers and just
switch all that stuff off when you actually need it as a WAKE_TCS.  To
some extent we could conceptually re-envision this and think of this
as being the ACTIVE_TCS that is occasionally borrowed to make up for
not having a WAKE_TCS.


In any case, I think the patch you have right now is good enough and
it feels like it's overdue to land this series.  I'd suggest against
spinning at this point.  Maybe we can try to improve this in a future
patch after your series lands.

-Doug
