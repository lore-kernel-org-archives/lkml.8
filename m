Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C81C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11242051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUpjT9gH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBJMS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:18:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42044 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJMS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:18:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so4022735lfl.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRc8fo3vz8PCS1Yui1Bgio/cnoEmzs/JvTxaOe6eVas=;
        b=GUpjT9gHuQx2gQlQVFcoYwwo7YeMBzcjPIF7A+HVsnA+0I9rO3R8a0Eyxx60R5i3Im
         AA77t2iY2P0+4ZeNr+LGv/BxOH2W63DqpCcMOaulkrQaFtm9mENZPAwDjxM52WHVBAru
         1+IZrr1Or5ixBjrOhR+Tl644dSDbKaowXjR0k7uETEMHl9DjlloiXa+QIxHffLJ8gwQF
         npLg1Yp8d5fxcv5ZBoF9cZnuJAm0fbLm5oA+cIaVA/UV7c1O5FkfBmQWxlapSxPU0rqc
         UQaso90wxPeeHl1d2l0mV95dNxUDSm0IJcG+c1JzXIu3GxZW5QAokIUI3b0f+FnzUF0H
         PRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRc8fo3vz8PCS1Yui1Bgio/cnoEmzs/JvTxaOe6eVas=;
        b=eH/wJa4zkK8ahy7ll/xXi4/AvAjeeXX6lZ2FKAn4wN24C4O7NAYPfj+L7FkdyEcMVy
         XJjmx4jN082ZoiMMYGS/r+etoD5bT2vp33zG2z5H/BImZS+OYYB5l6nWz2QXM/DiO5fo
         Xx9OQHEQKoxmwVhF9rbDUn5wLdvEe0X6We0nI/Umfg+tjHUrLD8uzu/u/40/e0mYwEhU
         Uw97jwLXOGsC4x1+IAKoIPNtgpgjzL1Vdgi/fMPaXlLXN+kmNEBNoBxcJ8GLHi+AHz6W
         cYb4sWNTy57JGODEuxtSs52bdnWQexfIBpoxizSGz9zKw3RXVyfO/DBqfbprmhMrNFpJ
         8dwQ==
X-Gm-Message-State: APjAAAXmQy6DfryrfcdLdYejLaULYJOCimhWeVYwBoFcZtRTguzJ3uR4
        sXl0FgTO6F9ONgZBSG69PzGJwPZ9tay9hgde0D3ygQ==
X-Google-Smtp-Source: APXvYqw9v3mzj35qFJVR63kJU8jEJlDWyo91EsiOJGUIDkaX08FbvJDH5iQCPLZy99seAO1pGZP0RFPsAW/1pkLCgTo=
X-Received: by 2002:a19:850a:: with SMTP id h10mr650759lfd.89.1581337106340;
 Mon, 10 Feb 2020 04:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20200121183748.68662-1-swboyd@chromium.org> <CACRpkdbgfNuJCgOWMBGwf1FoF+9cpQACnGH7Uon5Y6X+kN+x_w@mail.gmail.com>
 <5e29f186.1c69fb81.61d8.83b9@mx.google.com> <CAD=FV=W=NjMf5UqpSaY-VZfE013Ut=qe2EgSY2UErXM3eqpsGQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W=NjMf5UqpSaY-VZfE013Ut=qe2EgSY2UErXM3eqpsGQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Feb 2020 13:18:15 +0100
Message-ID: <CACRpkdZDYT4m4i0cbuLRbr4H4sJPHjpf7hirMf1LkNttyuKWGA@mail.gmail.com>
Subject: Re: [PATCH] spmi: pmic-arb: Set lockdep class for hierarchical irq domains
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>, Douglas Anderson
        <dianders@chromium.org>, Brian Masney <masneyb@onstation.org>, Lina Iyer
        <ilina@codeaurora.org>, Maulik Shah <mkshah@codeaurora.org>, Bjorn
        Andersson" <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 8:02 PM Doug Anderson <dianders@chromium.org> wrote:
> On Thu, Jan 23, 2020 at 11:18 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Linus Walleij (2020-01-23 07:29:31)

> > > > Fixes: 12a9eeaebba3 ("spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips")
> > > > Cc: Douglas Anderson <dianders@chromium.org>
> > > > Cc: Brian Masney <masneyb@onstation.org>
> > > > Cc: Lina Iyer <ilina@codeaurora.org>
> > > > Cc: Maulik Shah <mkshah@codeaurora.org>
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > >
> > > LGTM
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thanks. I was hoping you would apply it given that the commit it's
> > fixing was applied by you. I can send it to Gregkh or have some qcom
> > person pick it up though if you prefer.
>
> It appears that the commit this is Fixing is now in Linus's tree but
> Stephen's fix is still nowhere to be found.  Any update on what the
> plan is?

I just applied the patch, it's a simple solution :D

I was just worried whether I have jurisdiction over driver/spmi
but let's hope noone gets angry.

Yours,
Linus Walleij
