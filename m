Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA5C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405EF20722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btEZXQZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDTV3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726748AbgDTV3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:29:36 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CFCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:29:35 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o127so12822133iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSDaWHzMe9uROB6JLc5gJdxIqAiYObHmWWZCnpO31b4=;
        b=btEZXQZMjfh27gEorJkra7C5siyCvtLFbsKQHzYVZvUVQk4fDPjeVeALcIS2d5MTXf
         /nea74KdSBRj/+fkL0PPIlQnySEinJlvP+t8RCMQtmGDXbbcbUB5OwSUkPMOVrenhajZ
         z6GGAV7I85Rdsz9DRCfuOrY3kQzIrIM9RGt7jLuEmyOHNqRWNIVhER8ZIxoSJMwrijM7
         mSDaC1iZ4R4cgWzQmAMAf/TNo9ZjsI+jnp0f7S4mTph2xJPVZyk5UUEPYGYGOux1fwjG
         zjVfnzJcP5jSDPmNLPwbNUbQLZRGATJywsoNkx3GYz1MDOOM6X40acbSHXovI5e3dLjT
         fotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSDaWHzMe9uROB6JLc5gJdxIqAiYObHmWWZCnpO31b4=;
        b=i7EfcnEjF358+cLpaYfUg9bnd3gWsrBbPn9vT6qbsazzevwCOGAnGCj1MyFnnD7w0i
         i0jI8eWTlVqqQEnAHPviJrxsfPLl5zAjAjMxD+bCJ+/odwQ+EdFHQe7e6vs2WuW6thGt
         OFNihBpHJ+CV9X/Ld7z2wZBgMj0Z8k0vKJEKqTLGO72OyKZnE5kBp/DoonqCfjbzXu1r
         FHEFWwW87JUBfTmfDKltgTk2cIZqCzewFVAQR8e0TVjOTACdr03BjVltapkXSu4Ho2ae
         Y/mcsgbfFBQIzIRhIHMbl8GBWhueFA3sCZEaeeuaAxGCiJQVa7p/L7F33fnglY5v26qa
         DH2Q==
X-Gm-Message-State: AGi0PuY9YnGsnDglR/Bkmwl2+R8R1C1Yb1zX3oXn43qGwCTZdN781BUD
        Ci7k6PaXwZP5Lo39wfvRLjBtlroMX2cChJiWP3ki4w==
X-Google-Smtp-Source: APiQypIHktBDogLNJlNnacxM7dWBVaqZm/5SWnHa2I8cMsaNYMMolqh8ce/dKdAWisVMdPxc/PLamZCIDOgIgRbFe5I=
X-Received: by 2002:a02:b88e:: with SMTP id p14mr11961241jam.36.1587418174992;
 Mon, 20 Apr 2020 14:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-3-mathieu.poirier@linaro.org> <e980e9e6-04d6-60b8-c921-d2fb1f2b9a1b@st.com>
In-Reply-To: <e980e9e6-04d6-60b8-c921-d2fb1f2b9a1b@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 20 Apr 2020 15:29:24 -0600
Message-ID: <CANLsYkwYFDYeG8SZ+0S_-cY7GA3iFbU5czKyKgGmkObXXpgc2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] remoteproc: Split firmware name allocation from rproc_alloc()
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>,
        Alex Elder <elder@linaro.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Mon, 20 Apr 2020 at 03:24, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Mathieu,
>
> On 4/15/20 10:48 PM, Mathieu Poirier wrote:
> > Make the firmware name allocation a function on its own in an
> > effort to cleanup function rproc_alloc().
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
> >  1 file changed, 39 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 80056513ae71..4dee63f319ba 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
> >       .release        = rproc_type_release,
> >  };
> >
> > +static int rproc_alloc_firmware(struct rproc *rproc,
> > +                             const char *name, const char *firmware)
>
> nitpicking: here you do not allocate memory for the firmware but for its name
> The name of the function seems to me quite confusing...

Ok, I'll see if I can find something better.

>
> Else LGTM for the series

V3 will be out shortly and it will be fairly different from this one.

>
> Thanks,
>
> Arnaud
>
> > +{
> > +     char *p, *template = "rproc-%s-fw";
> > +     int name_len;
> > +
> > +     if (!firmware) {
> > +             /*
> > +              * If the caller didn't pass in a firmware name then
> > +              * construct a default name.
> > +              */
> > +             name_len = strlen(name) + strlen(template) - 2 + 1;
> > +             p = kmalloc(name_len, GFP_KERNEL);
> > +             if (!p)
> > +                     return -ENOMEM;
> > +             snprintf(p, name_len, template, name);
> > +     } else {
> > +             p = kstrdup(firmware, GFP_KERNEL);
> > +             if (!p)
> > +                     return -ENOMEM;
> > +     }
> > +
> > +     rproc->firmware = p;
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * rproc_alloc() - allocate a remote processor handle
> >   * @dev: the underlying device
> > @@ -2007,42 +2034,21 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >                         const char *firmware, int len)
> >  {
> >       struct rproc *rproc;
> > -     char *p, *template = "rproc-%s-fw";
> > -     int name_len;
> >
> >       if (!dev || !name || !ops)
> >               return NULL;
> >
> > -     if (!firmware) {
> > -             /*
> > -              * If the caller didn't pass in a firmware name then
> > -              * construct a default name.
> > -              */
> > -             name_len = strlen(name) + strlen(template) - 2 + 1;
> > -             p = kmalloc(name_len, GFP_KERNEL);
> > -             if (!p)
> > -                     return NULL;
> > -             snprintf(p, name_len, template, name);
> > -     } else {
> > -             p = kstrdup(firmware, GFP_KERNEL);
> > -             if (!p)
> > -                     return NULL;
> > -     }
> > -
> >       rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> > -     if (!rproc) {
> > -             kfree(p);
> > +     if (!rproc)
> >               return NULL;
> > -     }
> > +
> > +     if (rproc_alloc_firmware(rproc, name, firmware))
> > +             goto free_rproc;
> >
> >       rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> > -     if (!rproc->ops) {
> > -             kfree(p);
> > -             kfree(rproc);
> > -             return NULL;
> > -     }
> > +     if (!rproc->ops)
> > +             goto free_firmware;
> >
> > -     rproc->firmware = p;
> >       rproc->name = name;
> >       rproc->priv = &rproc[1];
> >       rproc->auto_boot = true;
> > @@ -2091,6 +2097,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >       rproc->state = RPROC_OFFLINE;
> >
> >       return rproc;
> > +
> > +free_firmware:
> > +     kfree(rproc->firmware);
> > +free_rproc:
> > +     kfree(rproc);
> > +     return NULL;
> >  }
> >  EXPORT_SYMBOL(rproc_alloc);
> >
> >
