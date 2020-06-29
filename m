Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B7CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EAD20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKInGCNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgF2TEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgF2TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15234C030F27
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:37:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so13316382qtf.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfrSRiuaUcbTXY2m2QdS9YaH7D3dVduFk5gDSZ3KdZU=;
        b=kKInGCNGk07E5wciAlG19BexLANCTvTVpJiVyDkKBcr9tsb4oTRSV9NMlNT7XlTH8O
         QHGuoyYMYxHbIGVTx9G9nLD+yR1qCUgZIG26pL1LlQuwCWfNDRyAru3QKW/lk2OH+f/y
         Wpk4VHooSMyZV/VUX+opV0hfniJIMUcgQu8Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfrSRiuaUcbTXY2m2QdS9YaH7D3dVduFk5gDSZ3KdZU=;
        b=mix+HDN9diu+z6GRNmpTUPD1NeJex0lQQiCbCQfrMPkJkTcr4UvKd3hOYkxwHJ3xt9
         BqU9v1ROIze9gBIX2vBIxQSpsX5REKRPmi8HhuaJxSCvwH8Kko9JYEh66A0PsDjxht/L
         HPw/AaUs5zoZlqRet/zLj8KFVBTbZH2NHJ330G4kgwL6rSH0Ftfaf3yGRZeJaHXZ23An
         MCt23SHXHoYEfzKETFyo5OLQlDoNs5FW5k1OmmPDzGuGL/Z32J8Tm+NnGLkmU+OFdUir
         V9G9fJqCfBsD6JL9HvCWK+qkENxHMZnPR2WI8V9Qjz0wmfB3Wnuk0yaaAR1nzsUQ7fVA
         I9sQ==
X-Gm-Message-State: AOAM532RZTiQXTaMRx71ZBVMgCPPpjAac7+Rsv76dTWVhg/1WVFyvOvC
        8sJ1L8tGvvm0uNG1YEGyk04dXMYrwM6yFUDIN3PuwA==
X-Google-Smtp-Source: ABdhPJwnA10PM+XPfpnUgL/Is0+pWE2mhZzTnaxYYkAi+NVt9vJ9J7Hsws20B8vnvznKVbrmWTVyS2fod8IkHjZI1Qs=
X-Received: by 2002:ac8:1991:: with SMTP id u17mr15979446qtj.93.1593448653276;
 Mon, 29 Jun 2020 09:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200629161333.2110327-1-pmalani@chromium.org> <CABXOdTcSOUru-B_nbB0Z9k1_EUrL5ENZ7zQhuXoG+e1gZmz4qw@mail.gmail.com>
In-Reply-To: <CABXOdTcSOUru-B_nbB0Z9k1_EUrL5ENZ7zQhuXoG+e1gZmz4qw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 29 Jun 2020 09:37:21 -0700
Message-ID: <CACeCKaf6MG4Hcg4my+jigYgEeZ6jvrHDKkTvY4f4Nx=PO0zSzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Use workqueue for
 port update
To:     Guenter Roeck <groeck@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for the review!

On Mon, Jun 29, 2020 at 9:24 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Jun 29, 2020 at 9:13 AM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Use a work queue to call the port update routines, instead of doing it
> > directly in the PD notifier callback. This will prevent other drivers
> > with PD notifier callbacks from being blocked on the port update routine
> > completing.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes in v2:
> > - No changes.
> >
> >  drivers/platform/chrome/cros_ec_typec.c | 28 ++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 0c041b79cbba..630170fb2cbe 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -58,6 +58,7 @@ struct cros_typec_data {
> >         /* Array of ports, indexed by port number. */
> >         struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
> >         struct notifier_block nb;
> > +       struct work_struct port_work;
> >  };
> >
> >  static int cros_typec_parse_port_props(struct typec_capability *cap,
> > @@ -619,18 +620,29 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> >         return 0;
> >  }
> >
> > -static int cros_ec_typec_event(struct notifier_block *nb,
> > -                              unsigned long host_event, void *_notify)
> > +static void cros_typec_port_work(struct work_struct *work)
> >  {
> > -       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> > -                                                    nb);
> > -       int ret, i;
> > +       struct cros_typec_data *typec = container_of(work,
> > +                                                    struct cros_typec_data,
> > +                                                    port_work);
>
> Nit, but the upstream line length limit is now 100 characters, and
> this is a perfect example where this would come handy.

Done.
>
> > +       int ret;
> > +       int i;
> >
> >         for (i = 0; i < typec->num_ports; i++) {
> >                 ret = cros_typec_port_update(typec, i);
> >                 if (ret < 0)
> >                         dev_warn(typec->dev, "Update failed for port: %d\n", i);
> >         }
> > +}
> > +
> > +
> > +static int cros_ec_typec_event(struct notifier_block *nb,
> > +                              unsigned long host_event, void *_notify)
> > +{
> > +       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> > +                                                    nb);
> > +
> ... and even more so here.

Done.

>
> > +       schedule_work(&typec->port_work);
> >
> >         return NOTIFY_OK;
> >  }
> > @@ -689,6 +701,12 @@ static int cros_typec_probe(struct platform_device *pdev)
> >         if (ret < 0)
> >                 return ret;
> >
> > +       INIT_WORK(&typec->port_work, cros_typec_port_work);
> > +
> > +       /*
> > +        * Safe to call port update here, since we haven't registered the
> > +        * PD notifier yet.
> > +        */
> >         for (i = 0; i < typec->num_ports; i++) {
> >                 ret = cros_typec_port_update(typec, i);
> >                 if (ret < 0)
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
