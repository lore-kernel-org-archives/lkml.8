Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7D6CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8873F206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSaX/vRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgEMIYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMIYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:24:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDFC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:24:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so12857251lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCnyp8DCf8CZS+zvYVx3/wo57tr3YdAZ4e/hQh/qGcs=;
        b=NSaX/vRORpmKcgHTGXqFERaoMDjDF+QKGnIBBeEfxXLunp5oOjByaFxkxCqB1bOLUz
         ziDPzYeWjw2LzzZX6LTgXFF5VT7C8rxeEN4zYz+2Ngv+DLz76YD9hLjgHhinTWdYKfEc
         8huLU09Xc0QYvyfmeAGvAuSz938gw+pGIfOMX9wM7fZlKkDjylhLiYNxnaQud5fkpA0i
         tK+dqg+vB/UGtEfAAJg8NBBqwI72H8aet+FTUlR+TpOTg8fMvMxL0W8VC1HVy+19pcii
         uUKV+RFm40CJ8/QBotiXF5XThr/zaUoE0njy5JKsDnJry+4kF8vfoOVa4wHBNf3xRBU8
         Lppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCnyp8DCf8CZS+zvYVx3/wo57tr3YdAZ4e/hQh/qGcs=;
        b=FoKYh3T1LQTh82zNGvPdctGVBgfjW1if6/o6QGt/J0FN1Nb0SY/gnTlvO46POOhoAB
         pDoaGUVb1wSPkLx6RcVSlw6zf2HGQFl/p8jKHxvBhPjpXBdWpjUxp0i5yZLDoaslPo5h
         IEUPJRP7+kcVMxY/6iBWsPhbb6Tr+N0tS4kd/yPfw9HJjELBiOa5RH4SjrKBnyQ+/f56
         0c08RxKErFLO3yS0UtQOZFR7hj/oKRtMmYC4MVQWmfvapTXKu2KTy2oWfSkcnJ3qSIcF
         YczywU3hNrkNVn6MXtpL63o8RNWX3ORBtBxOg3I6DsZot3nYlbb2H8aPE4Ztd4U9ovrQ
         k6fw==
X-Gm-Message-State: AOAM5310UDrK5XgVSDDgUONLWxOo/7qEo2ofEUvQzePO8vJkNmU8wU+4
        b4rUT8OwYOBZD0hdputolcThhGE7qDZT0dxb3LU1n8bJ8UU=
X-Google-Smtp-Source: ABdhPJyhtD47Sp6q4yJaOB3jGxHH1xzgbhIpHzYkUjSKYlDknt3/k2WCjTsNXvKZmwZXOyX8XFpGN8/geq/9HNk9HJU=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr17202258lfi.21.1589358250625;
 Wed, 13 May 2020 01:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
 <20200513003625.651340-1-vlad.babchuk@gmail.com> <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
In-Reply-To: <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 13 May 2020 13:53:59 +0530
Message-ID: <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com>
Subject: Re: [PATCH] optee: don't fail on unsuccessful device enumeration
To:     Volodymyr Babchuk <vlad.babchuk@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jerome Forissier <jerome@forissier.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr,

On Wed, 13 May 2020 at 13:30, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Volodymyr,
>
> On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
> <vlad.babchuk@gmail.com> wrote:
> >
> > optee_enumerate_devices() can fail for multiple of reasons. For
> > example, I encountered issue when Xen OP-TEE mediator NACKed
> > PTA_CMD_GET_DEVICES call.

Could you share a detailed description of the issue which you are
facing? optee_enumerate_devices() is a simple invocation of pseudo TA
and cases where OP-TEE doesn't provide corresponding pseudo TA are
handled very well.

> > This should not result in driver
> > initialization error because this is an optional feature.

I wouldn't call it an optional feature as there might be real kernel
drivers dependent on this enumeration. Also, it is a simple example to
self test OP-TEE functionality too. So I am not sure how much
functional OP-TEE would be if this basic TA invocation fails.

-Sumit

> >
> > Thus, it is better to print warning, instead of termination driver
> > initialization.
> >
> > Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> > ---
>
> Looks good. Didn't apply directly at latest, but the conflict was easy
> enough to resolve.
>
> I'll pick up this in a day unless someone objects.
>
> I'll add a
>     Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Line.
>
> Thanks,
> Jens
>
> >
> > resend: fixed email in s-o-b tag. Sorry for the noise
> >
> > drivers/tee/optee/core.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 34409c916882..a053930032f2 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -728,10 +728,8 @@ static int __init optee_driver_init(void)
> >                 return PTR_ERR(optee);
> >
> >         rc = optee_enumerate_devices();
> > -       if (rc) {
> > -               optee_remove(optee);
> > -               return rc;
> > -       }
> > +       if (rc)
> > +               pr_warn("can't enumerate optee devices: %d\n", rc);
> >
> >         pr_info("initialized driver\n");
> >
> > --
> > 2.26.2
> >
