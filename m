Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25470C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CE320678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxWn5dS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440822AbgDNPnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440812AbgDNPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:43:35 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D4C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:43:34 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b18so170006ilf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVLS9Ai08OPfxLm48X/SePV3ZDqp6/dSkFQuslL/8FE=;
        b=LxWn5dS4CgxTQNcs4w83JJyQD27eFCNjOl47eKoSvbtU/G+4BbfikWMfOcRhC/3Q3c
         dBfc+Q6yL9+SpaJrKkU3ud40/xG6nuFQ5jbZzKtcnj7AOrCgnmOfTlSqY6FiMo3M7TTC
         rYM0Va3g4L22+wZjANo7csIwf2fNObAXPrlVWwgdh1lVkZY1uS7Q5tdRLsHYVSbB7CFw
         e9vebkwQoAdqisY57PaO/AtFjudW40fbsyyukstPPr5pcqzcw/QAQGWXYc7RVsmkFLHu
         43SPpMnBrzhq9juigDya6lHtfA8pwnmCYGiyNSZ300X0w91WIOWeh864eDGkdqs/hl4Y
         jm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVLS9Ai08OPfxLm48X/SePV3ZDqp6/dSkFQuslL/8FE=;
        b=TbTMER8lGQUVU1eWMy1LyBJQaxuqYVcC2vO45ugIZ5cJ72qDGxqwAeyVpFvXgOmsV+
         jxgQHIHJ8n9otLmoScG/QX/9zAtMRyC1pf19BxCaORIFxTABNaFAZHTXukXqt5cNzYr+
         cvGZff0RMzyT1t5NC8OMSPF+B8eMXjlqxx6R+o8YUuA8PBR5HDedsdieNfv6+XA8LHlE
         fp4ezt8u+sFbY4acQZxr5WIBrbv/4LmK/O3JmDp19UHefnpqzIgni2tg7AfY4iUMrSHq
         Q9Ni9xyFdEJH+awBgABgGWDIK+D/bSONICb7M2O43+2uq7mekuS3KNkypof1k30qQONd
         zpfw==
X-Gm-Message-State: AGi0PuYDL3kM/SbS5cgOd1U9KwCowEN4Fcf42hh9f0p/s76UscSzdNXN
        sS6zCPhJov3I93/lf47rke1WdjCv7GsV1WPpU1AnUw==
X-Google-Smtp-Source: APiQypJ4WPRxpgG3J1PS6bP25BZLPYttAmK4ZLhXeXL4c5emjyAPvO8lVjCYmeFWQcCOpghRQnkUBk484AiLddSfa7A=
X-Received: by 2002:a92:740e:: with SMTP id p14mr827341ilc.57.1586879014077;
 Tue, 14 Apr 2020 08:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200413193401.27234-1-mathieu.poirier@linaro.org>
 <20200413193401.27234-3-mathieu.poirier@linaro.org> <bd8cc8d5-94c1-5767-d089-535731fc1055@linaro.org>
 <20200414005506.GG20625@builder.lan>
In-Reply-To: <20200414005506.GG20625@builder.lan>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 14 Apr 2020 09:43:22 -0600
Message-ID: <CANLsYkx69cZotLUrt170XYiYxpkTGKBNC8FUioBD=OSnDYm46Q@mail.gmail.com>
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

Hi guys,

On Mon, 13 Apr 2020 at 18:54, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 13 Apr 13:56 PDT 2020, Alex Elder wrote:
>
> > On 4/13/20 2:33 PM, Mathieu Poirier wrote:
> > > Make the firmware name allocation a function on its own in order to
> > > introduce more flexibility to function rproc_alloc().
> > >
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> > I didn't look at the larger context (MCU series); I'm only looking
> > at this (and the others in this series) in isolation.  I like
> > that you're encapsulating this stuff into functions but doing so
> > doesn't really add any flexibility.
> >
> > Two small suggestions for you to consider but they're truly
> > more about style so it's entirely up to you.  Outside of that
> > this looks straightforward to me, and the result of the series
> > is an improvement.
> >
> > I'll let you comment on my suggestions before offering my
> > "reviewed-by" indication.
> >
> >                                       -Alex
> >
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
> > >  1 file changed, 39 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 80056513ae71..4dee63f319ba 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
> > >     .release        = rproc_type_release,
> > >  };
> > >
> > > +static int rproc_alloc_firmware(struct rproc *rproc,
> > > +                           const char *name, const char *firmware)
> > > +{
> > > +   char *p, *template = "rproc-%s-fw";
> > > +   int name_len;
> >
> > Not a big deal (and maybe it's not consistent with other nearby
> > style) but template and name_len could be defined inside the
> > "if (!firmware)" block.
> >
>
> I prefer variables declared in the beginning of the function, so I'm
> happy with this.
>
> > > +   if (!firmware) {
> > > +           /*
> > > +            * If the caller didn't pass in a firmware name then
> > > +            * construct a default name.
> > > +            */
> > > +           name_len = strlen(name) + strlen(template) - 2 + 1;
> > > +           p = kmalloc(name_len, GFP_KERNEL);
> >
> >
> > I don't know if it would be an improvement, but you could
> > check for a null p value below for both cases.  I.e.:
> >
> >               if (p)
> >                       snprintf(p, ...);
> >
>
> Moving the common NULL check and return out seems nice, but given that
> we then have to have this positive conditional I think the end result is
> more complex.
>
> That said, if we're not just doing a verbatim copy from rproc_alloc() I
> think we should make this function:
>
>         if (!firmware)
>                 p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
>         else
>                 p = kstrdup_const(firmware, GFP_KERNEL);
>
>         rproc->firmware = p;
>
>         return p ? 0 : -ENOMEM;

At this time I was going for a pure re-arrangement of the code and
avoiding further improvement.  This is simple enough that it can be
rolled-in the next revision.

Thanks,
Mathieu

>
> Regards,
> Bjorn
>
> > (more below)
> >
> > > +           if (!p)
> > > +                   return -ENOMEM;
> > > +           snprintf(p, name_len, template, name);
> > > +   } else {
> > > +           p = kstrdup(firmware, GFP_KERNEL);
> > > +           if (!p)
> > > +                   return -ENOMEM;
> > > +   }
> > > +
> >
> >       if (!p)
> >               return -ENOMEM;
> >
> > > +   rproc->firmware = p;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  /**
> > >   * rproc_alloc() - allocate a remote processor handle
> > >   * @dev: the underlying device
> > > @@ -2007,42 +2034,21 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> > >                       const char *firmware, int len)
> > >  {
> > >     struct rproc *rproc;
> > > -   char *p, *template = "rproc-%s-fw";
> > > -   int name_len;
> > >
> > >     if (!dev || !name || !ops)
> > >             return NULL;
> > >
> > > -   if (!firmware) {
> > > -           /*
> > > -            * If the caller didn't pass in a firmware name then
> > > -            * construct a default name.
> > > -            */
> > > -           name_len = strlen(name) + strlen(template) - 2 + 1;
> > > -           p = kmalloc(name_len, GFP_KERNEL);
> > > -           if (!p)
> > > -                   return NULL;
> > > -           snprintf(p, name_len, template, name);
> > > -   } else {
> > > -           p = kstrdup(firmware, GFP_KERNEL);
> > > -           if (!p)
> > > -                   return NULL;
> > > -   }
> > > -
> > >     rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> > > -   if (!rproc) {
> > > -           kfree(p);
> > > +   if (!rproc)
> > >             return NULL;
> > > -   }
> > > +
> > > +   if (rproc_alloc_firmware(rproc, name, firmware))
> > > +           goto free_rproc;
> > >
> > >     rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> > > -   if (!rproc->ops) {
> > > -           kfree(p);
> > > -           kfree(rproc);
> > > -           return NULL;
> > > -   }
> > > +   if (!rproc->ops)
> > > +           goto free_firmware;
> > >
> > > -   rproc->firmware = p;
> > >     rproc->name = name;
> > >     rproc->priv = &rproc[1];
> > >     rproc->auto_boot = true;
> > > @@ -2091,6 +2097,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> > >     rproc->state = RPROC_OFFLINE;
> > >
> > >     return rproc;
> > > +
> > > +free_firmware:
> > > +   kfree(rproc->firmware);
> > > +free_rproc:
> > > +   kfree(rproc);
> > > +   return NULL;
> > >  }
> > >  EXPORT_SYMBOL(rproc_alloc);
> > >
> > >
> >
