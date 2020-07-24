Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265D42070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iwSz087a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGXUMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXUMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:12:16 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0CC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:12:15 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 1so895640vsl.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM5eS2EeRGKww+dYskRfhmE9ybbsR8gCTRM+LVzEnYc=;
        b=iwSz087aaVUaiSy1oH9aa8XJaarVKSzVfLzp/O4LysKy3u1QVPScnmr13iFwMv3SCT
         0gIzFILLrv2w2raEeGSNDRBWD+3817WlhnydMdgxhGKHReLuPGu6kF6KAWjIGa2MzykV
         JruC9nRwh9hvoMlHT7vihvIaF/VdfgBjqJfLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM5eS2EeRGKww+dYskRfhmE9ybbsR8gCTRM+LVzEnYc=;
        b=Y9cSNQm395gM5J++RqC1Fah7SvKG7GXKfemJBz5onNEWVXG60hlrsk8AWobm6muxXQ
         0L7PsHeCxDlrO5kL3c7k5MQByNxZ4/zcoIJeyhHM6CjPdj8lVNQhtzyvOg6zLJNR9CZ7
         8qY7ki6oeCdrWX+lTBb6motklvWssyOWP9mXRVnfe0zuO5hSuDqcaxFaHb5DNnr5Z0yB
         gCKTRGqMJsiTk+GjLNwChj4KPHEmQzm5BqgJwXrhsi0ND1ZXFOwPwgn+FzFEdhpeb0W3
         0chrZfKi+F7gYJdwiuyOb/oyohQxB72EYG1/43TmLa1izu397UnWEel+29HIDZ0VeVaC
         2q4w==
X-Gm-Message-State: AOAM533jI84Kwny3gKAS474EIcHTbzeoWz6C5CFdZrBo9gZjDACpqN23
        C2ehQAJLQyy8Ub3OXQPBjsQuJy4cGE4=
X-Google-Smtp-Source: ABdhPJwiXJO57s71XGPkkhlnpTglmyZ7q0tgaRvgPW5l0IjdtqtmkQkMtPMgGWfFX+DbKAqT4D8Isg==
X-Received: by 2002:a05:6102:126a:: with SMTP id q10mr8614894vsg.35.1595621533792;
        Fri, 24 Jul 2020 13:12:13 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id j189sm215776vsd.24.2020.07.24.13.12.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:12:12 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id m6so5525164vsl.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:12:12 -0700 (PDT)
X-Received: by 2002:a67:ec0f:: with SMTP id d15mr8730677vso.121.1595621531870;
 Fri, 24 Jul 2020 13:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010137.3127584-1-swboyd@chromium.org> <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com>
 <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com>
 <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com> <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com>
In-Reply-To: <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:11:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUSwsP_xrHsufLjZqbWdn5V8rybtv2DWad2nBfU+VJ9w@mail.gmail.com>
Message-ID: <CAD=FV=VUSwsP_xrHsufLjZqbWdn5V8rybtv2DWad2nBfU+VJ9w@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 1:01 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-07-24 12:49:56)
> > Hi,
> >
> > On Fri, Jul 24, 2020 at 12:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > > > -       if (ret)
> > > > > -               goto unlock;
> > > > >
> > > > > -       ret = find_free_tcs(tcs);
> > > > > -       if (ret < 0)
> > > > > -               goto unlock;
> > > > > -       tcs_id = ret;
> > > > > +       wait_event_lock_irq(drv->tcs_wait,
> > > > > +                           (tcs_id = claim_tcs_for_req(drv, tcs, msg)) >= 0,
> > > >
> > > > Even though claim_tcs_for_req() only returns 0 or -EBUSY today (IOW it
> > > > never returns error codes other than -EBUSY), should we handle it?  If
> > > > we don't, claim_tcs_for_req() should be very clear that it shouldn't
> > > > return any errors other than -EBUSY.
> > >
> > > Do you mean you want to change it to be
> > >
> > >         (tcs_id = claim_tcs_for_req(drv, tcs, msg)) != -EBUSY
> > >
> > > instead of >= 0? It should return the tcs_id that was claimed, not just
> > > 0 or -EBUSY.
> >
> > Ah, right.  Yes, you got it right.  Of course then we have to add a
> > "if (tcd_id < 0) goto unlock", too.  If you think it's not worth
> > adding this then we just need to make sure it's super obvious in
> > claim_tcs_for_req() that it's not allowed to return other errors.
> >
>
> Hmm right now the code will wait forever for the condition to become
> true, so it will only ever continue past this point if tcs_id >= 0. We
> could add a timeout here in another patch, but I didn't want to change
> the behavior of what is there in this patch. I don't really care if >= 0
> or != -EBUSY is used here so I can change it to -EBUSY to provide
> clarity.
>
> If we add a timeout here, it would be better to change this driver to
> use a pull model instead of the push model it is using today so that the
> timeout isn't necessary. That would entail making a proper kthread that
> pulls requests off a queue of messages and then this asnyc call would
> append messages to the end of the queue and return immediately. That
> would be necessary if we want the async calls to work from non-sleeping
> contexts for example. I think Lina was alluding to this earlier in this
> thread.

I wasn't suggesting adding a timeout.  I was just saying that if
claim_tcs_for_req() were to ever return an error code other than
-EBUSY that we'd need a check for it because otherwise we'd interpret
the result as a tcs_id.

-Doug
