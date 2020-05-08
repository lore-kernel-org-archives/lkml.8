Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2991C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FD721841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHN6cLQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEHPb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgEHPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:31:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:31:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so2126094ljl.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8/qxcCinVx3qpG+wTYhBsTLLj5bq0SQmN1OViQlqAY4=;
        b=mHN6cLQ/jyiWNFTX0ilsa6opS9C0RTaizC1N7pClSFFg27OCAD0/ygl/UQlLwoKol0
         +rSkIV2addeHFq1Rsjmhx9JqdrGcN+k7pMa8PZz3jI4gdktnCo3lW7qKftPdOR4Hm/D9
         NT1RbH7wuhg+HAajeVRIIqwvlFKKkJ9eywwHTF3aiwjnpBO5hNi4XHXXsxRJoM6+0aSN
         MQNAO2edZ7k67N5f/RHllOKnTO0b+apfDrmVmQCSVSP4mU5HOwWNpBO9wGBlcJ5MOTZF
         zA/quJjBsV/RtQJgQv1lh4nFvfUOqyD1S+HIepoy8jGR6FRDKj8yldRbheTXXOtUDDQR
         wwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8/qxcCinVx3qpG+wTYhBsTLLj5bq0SQmN1OViQlqAY4=;
        b=I2u6khXK8A+EmDtCK0BFv8xYk22SNqsCsSu80eAAfXPxTOo9nC/PcNgx+I5CKHpwRb
         31oBMJlFDiCmq87wJrPB1Mvqg4g1E0FTIo0j0LK/iohR5FVy+OAUSLT4srIqzI/nVCnm
         nlXtu+8EpWwSQmD/b0EQSx5EJPDjcc4cboBsdkeUSoaZO34D3BK28G0aOAOjb5o6LIYp
         ynu4Sf8i5mYAqKA63ge9ny1FHDJlZN89VxdAEyismBWIZqI2tYnmTJH5FLHIgqG//HYr
         2b8HpIUHxJvMqZXBpjQQCIVfVnoJTs5Bd/OHJ7Nz1DdPz1g52Q8bqtE3ou7oez94f4Df
         Qp7g==
X-Gm-Message-State: AOAM533NF4GDAQGMimtIYnXCmGBnl6YyYxOTyfFKrjrj1WjD9r5h8vco
        QiUaXS+kQ2RX5rRAUezoqBuIpU2FFzZyDdsTJavZYg==
X-Google-Smtp-Source: ABdhPJzPV4bHTT+T/V0EKBt+F5F7R6D899CO+cKJO5jtnj7kRjYgK7jSXBYSc6fb+mNmgo0QmyVGSfHHMut2WjTii8U=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr1978985ljp.209.1588951912361;
 Fri, 08 May 2020 08:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ> <20200505142711.GA12952@vingu-book>
 <20200508130118.GA4514@iZj6chx1xj0e0buvshuecpZ>
In-Reply-To: <20200508130118.GA4514@iZj6chx1xj0e0buvshuecpZ>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 May 2020 17:31:40 +0200
Message-ID: <CAKfTPtDRxrSvLMy1WD-J2zK7=OxE+ozjX052fvtwmFy96w14hg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 at 15:01, Peng Liu <iwtbavbm@gmail.com> wrote:
>
> On Tue, May 05, 2020 at 04:27:11PM +0200, Vincent Guittot wrote:
> > Le mardi 05 mai 2020 =C3=A0 21:40:56 (+0800), Peng Liu a =C3=A9crit :
> >
>
> [...]
>
> >
> > Your proposal below looks quite complex. IMO, one solution would be to =
move the
> > update of nohz.next_balance before calling rebalance_domains(this_rq, C=
PU_IDLE)
> > so you are back to the previous behavior.
> >
> > The only difference is that in case of an break because of need_resched=
, it
> > doesn't update nohz.next_balance. But on the other hand, we haven't yet
> > finished run rebalance_domains for all CPUs and some load_balance are s=
till
> > pending. In fact, this will be done during next tick by an idle CPU.
> >
> > So I would be in favor of something as simple as :
> >
>
> Vincent, could you refine this patch with some changelog?

Hi Peng , I'm going to prepare it and another one for the case that we
discussed about kicking a new ilb in case of abort

> And have my reported-by if possible.

Yes I will

>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04098d678f3b..e028bc1c4744 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10457,6 +10457,14 @@ static bool _nohz_idle_balance(struct rq *this=
_rq, unsigned int flags,
> >                 }
> >         }
> >
> > +       /*
> > +        * next_balance will be updated only when there is a need.
> > +        * When the CPU is attached to null domain for ex, it will not =
be
> > +        * updated.
> > +        */
> > +       if (likely(update_next_balance))
> > +               nohz.next_balance =3D next_balance;
> > +
> >         /* Newly idle CPU doesn't need an update */
> >         if (idle !=3D CPU_NEWLY_IDLE) {
> >                 update_blocked_averages(this_cpu);
> > @@ -10477,14 +10485,6 @@ static bool _nohz_idle_balance(struct rq *this=
_rq, unsigned int flags,
> >         if (has_blocked_load)
> >                 WRITE_ONCE(nohz.has_blocked, 1);
> >
> > -       /*
> > -        * next_balance will be updated only when there is a need.
> > -        * When the CPU is attached to null domain for ex, it will not =
be
> > -        * updated.
> > -        */
> > -       if (likely(update_next_balance))
> > -               nohz.next_balance =3D next_balance;
> > -
> >         return ret;
> >  }
> >
