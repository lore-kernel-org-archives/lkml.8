Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD740C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4D321D82
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dKaJvdnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIJDJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIJDJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:09:11 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1211C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 20:09:10 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n22so4785286edt.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yqJpgD/qGjr0SYMeo4+6PrK1MUaDvagaWIkQvVPhiE=;
        b=dKaJvdnX3n7J91DaXSq46OtRpctKVKNEaz6WAwYENFMc/IZ9wZhE+S7JpxMJKEFe9c
         CF5goYPuiAyKk5CtfhQ/P6JWg01ST6yAYeG2+8KYuVjKbCOlAXE5bTcA/kDTG5egDMoS
         bHOlTIT4iy9m1mtHnnZYRo86nRw55C1LVr8PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yqJpgD/qGjr0SYMeo4+6PrK1MUaDvagaWIkQvVPhiE=;
        b=LTbWhqL2UagUnJoOJalbw5t9uAqYhVfItEfJoTTOEwLevQ/XI5WQ4boRZ/9rjKoq1r
         pwcmsad3kupxdITcDAJE77X8VS652GDSbWRp9v8wDaR+XGJ9SyKouHewEC7w0ratVjVa
         tvR1GOepYOhhMI/AnXo75GJaaDcqfcQRV/OzPHHDsL38Kew+qa6tKq6DBj2eox+RjsSs
         kd1Nm7cr5eY+wZ4B/KK4QMndtRBlaryXJRDC3E/yqFctRSQnIwLWEsA7vtryQU6vtp8T
         LcZ7yEYD1JzaNGtrTU3VBWt5rRrxJj6do3Feh+ZSbrIWWoonta14txcrg4LddQswJzmC
         MIhQ==
X-Gm-Message-State: AOAM531YF1CqN5jKZ0danVJnu7nvfoM63gmtx8W4dbHDlmPZGKvoE5EQ
        0PqYc59O1sXY5H9DtKeTHj7IBTPMMps6BmhamPg=
X-Google-Smtp-Source: ABdhPJzl08G+CrpXRCf6JD5aGcSCnOrgyxLpLCNBE81BAjCiBOs0I1sp6k345ME824ib3VxZO7F/lIUlgmF9bWHAyHY=
X-Received: by 2002:a05:6402:18d:: with SMTP id r13mr6942734edv.267.1599707349594;
 Wed, 09 Sep 2020 20:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071518.430515-1-joel@jms.id.au> <20200724071518.430515-2-joel@jms.id.au>
 <e7d9923c14a423f9e6e9427ad5437a539734a363.camel@kernel.crashing.org>
In-Reply-To: <e7d9923c14a423f9e6e9427ad5437a539734a363.camel@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Sep 2020 03:08:56 +0000
Message-ID: <CACPK8XeddtzwL+zwOWwkyYKCSYg7m=jHR1gpoOG6qx2gDjcosQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsi/sbefifo: Clean up correct FIFO when receiving
 reset request from SBE
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-fsi@lists.ozlabs.org, Joachim Fenkes <FENKES@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 at 05:51, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Fri, 2020-07-24 at 16:45 +0930, Joel Stanley wrote:
> > From: Joachim Fenkes <FENKES@de.ibm.com>
> >
> > When the SBE requests a reset via the down FIFO, that is also the
> > FIFO we should go and reset ;)
>
> Is it ?
>
> I no longer work for IBM and dont have access to any of the
> documentation here but I had vague memories that we would get a reset
> request in the down fifo in order to reset the up one since we control
> the up one and the host controls the down one, no ?

Joachim, can you clarify the situation here?

>
> > Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
> > Signed-off-by: Joachim Fenkes <FENKES@de.ibm.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  drivers/fsi/fsi-sbefifo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> > index f54df9ebc8b3..655b45c1f6ba 100644
> > --- a/drivers/fsi/fsi-sbefifo.c
> > +++ b/drivers/fsi/fsi-sbefifo.c
> > @@ -400,7 +400,7 @@ static int sbefifo_cleanup_hw(struct sbefifo
> > *sbefifo)
> >       /* The FIFO already contains a reset request from the SBE ? */
> >       if (down_status & SBEFIFO_STS_RESET_REQ) {
> >               dev_info(dev, "Cleanup: FIFO reset request set,
> > resetting\n");
> > -             rc = sbefifo_regw(sbefifo, SBEFIFO_UP,
> > SBEFIFO_PERFORM_RESET);
> > +             rc = sbefifo_regw(sbefifo, SBEFIFO_DOWN,
> > SBEFIFO_PERFORM_RESET);
> >               if (rc) {
> >                       sbefifo->broken = true;
> >                       dev_err(dev, "Cleanup: Reset reg write failed,
> > rc=%d\n", rc);
>
