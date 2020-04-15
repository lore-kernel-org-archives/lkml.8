Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2147F20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwIi8YWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411920AbgDOTfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634549AbgDOTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:34:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CCC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:34:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z13so4508976ilp.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4wJ8PCRsH9dLwOsuZUafOwTir/wwe6pyfgswo3kFgU=;
        b=PwIi8YWvIKc4jePjFvM5awvxAr6DD9/VWlipVrwhDCX5pidDChl8xMFFxeSJTyArOs
         94XKH+Wvr2cR9uKljFtsuOe/PnY88JdD/fyo1gJaZ54rbBMHm1LQ4F7RXv+xyjtPNRET
         sYpzOA+OqP69pgZdRlRKXJ8gBXKFTk4mP5cJdu9B1QWt+ILXJm/fT+o4G5QhxY5LCrgG
         GadwMAVMRxRVPvX1B65fEfZrRDGZ4v0l/7viQPabD+XpHtl9pmJONthzuYSGeq6lG7do
         ziMUlgKsGgkHuGc2f5ObfvSxpYxe4LLmKG8wXt0CZ538tC/ZoGnEvgzLewyPS8zem6Wt
         rmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4wJ8PCRsH9dLwOsuZUafOwTir/wwe6pyfgswo3kFgU=;
        b=ubE4tqB6z6XblEEsT1jbU/QIl/gWhBDJhGQVzcKuQbIf29nDBO404cxeqWSGZbVMAT
         0VFLF6Z0rNCRxKN5ffrDYlgfVKQxHQ6Qp/v30pVB+SgrYJWRsgftbs2vDxKgQVEofb8Y
         Nstxnrj9TJLV8VCHTbrqH4PwCsi7MjDqKwnQ1rsyfubWMUbeSttsj///Z3Q0oeTx6lLP
         Pq+rbyc/OASEymPa6EmwUdf1STfL/jT914WNs9x5WwZX0fqUMJOMcypkcLYlq9dp3y3T
         xuPnOP6Non+9zzWQQ6KKpiQbVE/+tIKSNgbRyXp1Le/Ot5VjtxXg5oztCAllH9tNwnnW
         7E1w==
X-Gm-Message-State: AGi0Pubij2R/+6eHd+qEdUbqPuOiBf8vdIc3tpJXD8SRWMS7sw6KeNVo
        g7sv8FcI0kcAFI+IHgkmWWE60bFskB73U/HcDdS/9WCL
X-Google-Smtp-Source: APiQypIvBqwo1b067evgJIMqsswMjNt/4NZSHBs2ekLDZj0cJSiZamL9K6jkm9NuKddJO5WDCXu7Aed2LUzevNnpxRc=
X-Received: by 2002:a92:9a0a:: with SMTP id t10mr7402579ili.50.1586979277430;
 Wed, 15 Apr 2020 12:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200413193401.27234-1-mathieu.poirier@linaro.org>
 <20200413193401.27234-3-mathieu.poirier@linaro.org> <bd8cc8d5-94c1-5767-d089-535731fc1055@linaro.org>
 <20200414005506.GG20625@builder.lan> <20200414194441.GA25931@xps15> <20200414231601.GI892431@yoga>
In-Reply-To: <20200414231601.GI892431@yoga>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 15 Apr 2020 13:34:25 -0600
Message-ID: <CANLsYkx2cV4QMPTvWxUhXDvSbNmrSR33L6pNzA=x9ZscpQk=6Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] remoteproc: Split firmware name allocation from rproc_alloc()
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Suman Anna <s-anna@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 at 17:16, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 14 Apr 12:44 PDT 2020, Mathieu Poirier wrote:
>
> > Hey Bjorn,
> >
> > On Mon, Apr 13, 2020 at 05:55:06PM -0700, Bjorn Andersson wrote:
> > > On Mon 13 Apr 13:56 PDT 2020, Alex Elder wrote:
> > >
> > > > On 4/13/20 2:33 PM, Mathieu Poirier wrote:
> > > > > Make the firmware name allocation a function on its own in order to
> > > > > introduce more flexibility to function rproc_alloc().
> > > > >
> > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > >
> > > > I didn't look at the larger context (MCU series); I'm only looking
> > > > at this (and the others in this series) in isolation.  I like
> > > > that you're encapsulating this stuff into functions but doing so
> > > > doesn't really add any flexibility.
> > > >
> > > > Two small suggestions for you to consider but they're truly
> > > > more about style so it's entirely up to you.  Outside of that
> > > > this looks straightforward to me, and the result of the series
> > > > is an improvement.
> > > >
> > > > I'll let you comment on my suggestions before offering my
> > > > "reviewed-by" indication.
> > > >
> > > >                                   -Alex
> > > >
> > > > > ---
> > > > >  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
> > > > >  1 file changed, 39 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > > index 80056513ae71..4dee63f319ba 100644
> > > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > > @@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
> > > > >         .release        = rproc_type_release,
> > > > >  };
> > > > >
> > > > > +static int rproc_alloc_firmware(struct rproc *rproc,
> > > > > +                               const char *name, const char *firmware)
> > > > > +{
> > > > > +       char *p, *template = "rproc-%s-fw";
> > > > > +       int name_len;
> > > >
> > > > Not a big deal (and maybe it's not consistent with other nearby
> > > > style) but template and name_len could be defined inside the
> > > > "if (!firmware)" block.
> > > >
> > >
> > > I prefer variables declared in the beginning of the function, so I'm
> > > happy with this.
> > >
> > > > > +       if (!firmware) {
> > > > > +               /*
> > > > > +                * If the caller didn't pass in a firmware name then
> > > > > +                * construct a default name.
> > > > > +                */
> > > > > +               name_len = strlen(name) + strlen(template) - 2 + 1;
> > > > > +               p = kmalloc(name_len, GFP_KERNEL);
> > > >
> > > >
> > > > I don't know if it would be an improvement, but you could
> > > > check for a null p value below for both cases.  I.e.:
> > > >
> > > >           if (p)
> > > >                   snprintf(p, ...);
> > > >
> > >
> > > Moving the common NULL check and return out seems nice, but given that
> > > we then have to have this positive conditional I think the end result is
> > > more complex.
> > >
> > > That said, if we're not just doing a verbatim copy from rproc_alloc() I
> > > think we should make this function:
> > >
> > >     if (!firmware)
> > >             p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
> > >     else
> > >             p = kstrdup_const(firmware, GFP_KERNEL);
> >
> > If you really want to use kstrdup_const() the return value has to be casted to a
> > "char *".  Variable 'p' can't be declared const "char *" because rproc->firmware is not
> > a "const".  Simply put somewhere the "const" will need to be dropped or casted out.
> >
>
> The firmware parameter to rproc_alloc() is const char * and there's a
> couple of places where a really const string is passed, so by using
> kstrdup_const() we don't end up duplicating const data on the heap.
>
> And afaict we can make both p and rproc->firmware const char * to allow
> this, or am I missing something?

I wasn't sure you were willing to go as far as making rproc->firmware
a const char *.  In that case it is quite easy...

>
> Regards,
> Bjorn
