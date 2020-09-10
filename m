Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB611C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9002521D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Y+eo6iz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgIJDJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIJDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:08:18 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF1C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 20:08:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j11so6566070ejk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 20:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+5q3xGL1nHZB00+ew0QJmqWRuBGR2SupPBxFEZiggQ=;
        b=Y+eo6iz0kU1zd9R0JHjSL9PrdhWcFHDUG29LiKaSOSAwibWV1zfMHyDdNWfYtRJifr
         ShicgtbBF7Hma5FXvkMstjNdFUynDDqTiOxj0SJt979RZ936AQ3xE4yAmjr0plHQVLRC
         LanabjPwDKli2rFVgpxYFFmqLKnIwlsjoe6IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+5q3xGL1nHZB00+ew0QJmqWRuBGR2SupPBxFEZiggQ=;
        b=hiJWmsXK/K72Dm4rIwbZHGx28Nl8L6e+x3PucjM9lsG/QVVtXVkFAIstlCHbeaICkC
         ZmLlf1LCCM4nObRACTon6i0YMA7Rri0x9G8X5Fm9UYpxIR05tkIX7m4s/iyil7WYRyVb
         d3KPO0pODhJTwIwfNmJTDf7IW45DFugph/5B+NQjmXoy2VuxVZI1mXPMqR9pIak0lrNd
         JNKT7J+/d1eN5BeLG06YgFxOlWmi5oXVQGrY4LRUg5jEha5/gSkSgBH48g83+b+m5vpY
         eZ3bS/ZL6IlS8QkZC14/bZNX5mO0UCRoiSyZgRwNG8R9Gd/UMxFCClRnvpB5ZYtl+Ozr
         u/Ig==
X-Gm-Message-State: AOAM533SV5HDk5g8ApjX4VSKf8zHsm2n4EPe4TJnIxnsNmwSr4+YzC9p
        3Sx2hvLiJ6XnGhBJiywvzBLVFQ9o0L1D95TX3pI=
X-Google-Smtp-Source: ABdhPJx8iM/WU+SzKn+c+T79bN73xos+cZitoR52UC2+IovPS/ouxIrzAldRj1RCts3x1dhXgaKsvN9GumQR1XU1kTA=
X-Received: by 2002:a17:906:4c58:: with SMTP id d24mr7056648ejw.108.1599707296448;
 Wed, 09 Sep 2020 20:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071518.430515-1-joel@jms.id.au> <20200724071518.430515-3-joel@jms.id.au>
 <d5722caa-cf98-15c4-2e45-9c569ca959b3@roeck-us.net>
In-Reply-To: <d5722caa-cf98-15c4-2e45-9c569ca959b3@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Sep 2020 03:08:04 +0000
Message-ID: <CACPK8XcnyO+T18W0pk6dRahg1aanaJYsVfxtXtZN31phub+=TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsi/sbefifo: Fix reset timeout
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-fsi@lists.ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistar Popple <alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 14:34, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/24/20 12:15 AM, Joel Stanley wrote:
> > From: Joachim Fenkes <FENKES@de.ibm.com>
> >
> > On BMCs with lower timer resolution than 1ms, msleep(1) will take
> > way longer than 1ms, so looping 10k times won't wait for 10s but
> > significantly longer.
> >
> > Fix this by using jiffies like the rest of the code.
> >
> > Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
> > Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  drivers/fsi/fsi-sbefifo.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> > index 655b45c1f6ba..3ad9510ad4a4 100644
> > --- a/drivers/fsi/fsi-sbefifo.c
> > +++ b/drivers/fsi/fsi-sbefifo.c
> > @@ -325,6 +325,7 @@ static int sbefifo_up_write(struct sbefifo *sbefifo, __be32 word)
> >  static int sbefifo_request_reset(struct sbefifo *sbefifo)
> >  {
> >       struct device *dev = &sbefifo->fsi_dev->dev;
> > +     unsigned long end_time;
> >       u32 status, timeout;
> >       int rc;
> >
> > @@ -341,7 +342,8 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
> >       }
> >
> >       /* Wait for it to complete */
> > -     for (timeout = 0; timeout < SBEFIFO_RESET_TIMEOUT; timeout++) {
> > +     end_time = jiffies + msecs_to_jiffies(SBEFIFO_RESET_TIMEOUT);
> > +     while (!time_after(jiffies, end_time)) {
> >               rc = sbefifo_regr(sbefifo, SBEFIFO_UP | SBEFIFO_STS, &status);
> >               if (rc) {
> >                       dev_err(dev, "Failed to read UP fifo status during reset"
> > @@ -355,7 +357,7 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
> >                       return 0;
> >               }
> >
> > -             msleep(1);
> > +             cond_resched();
>
> A hot loop ? Are you sure ? usleep_range() might make more sense here.

Thanks for the review.

Joachim, I can fix this up for you.

Do you have a suggestion for how long to wait? What's the best case
completion time for a sbe reset?

We also have a hot loop in sbefifo_wait. I'm open to suggestions for
how long that should delay for.

Cheers,

Joel
