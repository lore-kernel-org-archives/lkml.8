Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F5720737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rt0AQ2x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgGXTuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:50:09 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F7EC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:50:09 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so863831vsl.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI0f9ZG0XZavxVCgci5KzYO+fu3sbeQ813eMYl4khUs=;
        b=Rt0AQ2x73oWij0mw9oc1EtbPqzzscl3mgAmVCzhc40j76TnbYno0SLKddCJrZeMn/h
         Mn5rqXRcFD2iBaGVWy3gExG+DGlbd3PDqJ20BBRwWFP/we3eoua7c8D2tuDCfRjDzeHg
         4WnP9Pb9X3Nkqi9YsXSEr+/aIgzac9zApPWvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI0f9ZG0XZavxVCgci5KzYO+fu3sbeQ813eMYl4khUs=;
        b=g6Mq7drIYsx/bjbU3Ty/3+bawOpGdBU4v58qfJQ+4EPfTe8rnwELUqDSDsPlkz3CwY
         AuWwSbQqOUcXx/R/5l62lqtemcrtA+Kp0mqscOVCjY5//LEMHe92+u4B+d8+ZRMNjNz0
         KnUMjtjgCQ0HLzPH7FhM6jZcfVE3HcmN8zR/0SEpY9WtUJ/tg1nFOGyPmkmw+ZBZXwjQ
         RA5zBhiJZuWbsk2mzUXzxKEQ/uUa4OVEEN+wZn0HtowC/f3i1gpzLC3u0cbPWt8IHOmC
         /PkTIGRixF6avkRFPu6+aSRyI4CaKzyAbSc04d4+SQPOdlyJgc2BcJ4aAfpJ3Jy5TtxI
         pnkw==
X-Gm-Message-State: AOAM531A0TW9LgtkKualV9JbA1r/o1+qkQeIIot1S7t3aTfeRUIZNEW1
        yGy7DisQEdEKZl9OQ/dtzA7AaxPEi4g=
X-Google-Smtp-Source: ABdhPJzq1GAjReow/yCQ5l3REp9mTViDpZcEln36bYAbBoM/g8G1fsaq9qODGOsqgX3zIsl0GgqkfQ==
X-Received: by 2002:a67:5cc6:: with SMTP id q189mr9307667vsb.3.1595620208676;
        Fri, 24 Jul 2020 12:50:08 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id j15sm166746vki.8.2020.07.24.12.50.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 12:50:08 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id o184so5538426vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:50:08 -0700 (PDT)
X-Received: by 2002:a67:69c1:: with SMTP id e184mr9797505vsc.119.1595620207670;
 Fri, 24 Jul 2020 12:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010137.3127584-1-swboyd@chromium.org> <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com>
 <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com>
In-Reply-To: <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 12:49:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com>
Message-ID: <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com>
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

On Fri, Jul 24, 2020 at 12:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > > -       if (ret)
> > > -               goto unlock;
> > >
> > > -       ret = find_free_tcs(tcs);
> > > -       if (ret < 0)
> > > -               goto unlock;
> > > -       tcs_id = ret;
> > > +       wait_event_lock_irq(drv->tcs_wait,
> > > +                           (tcs_id = claim_tcs_for_req(drv, tcs, msg)) >= 0,
> >
> > Even though claim_tcs_for_req() only returns 0 or -EBUSY today (IOW it
> > never returns error codes other than -EBUSY), should we handle it?  If
> > we don't, claim_tcs_for_req() should be very clear that it shouldn't
> > return any errors other than -EBUSY.
>
> Do you mean you want to change it to be
>
>         (tcs_id = claim_tcs_for_req(drv, tcs, msg)) != -EBUSY
>
> instead of >= 0? It should return the tcs_id that was claimed, not just
> 0 or -EBUSY.

Ah, right.  Yes, you got it right.  Of course then we have to add a
"if (tcd_id < 0) goto unlock", too.  If you think it's not worth
adding this then we just need to make sure it's super obvious in
claim_tcs_for_req() that it's not allowed to return other errors.

-Doug
