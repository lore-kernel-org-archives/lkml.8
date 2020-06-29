Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF08C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016272076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Prw+e3qT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbgF2VIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390439AbgF2VIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:08:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D5C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:08:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g13so14009474qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbUqdK1otFEuJAwkKU1CGhmnKqFJa2aBCYhP9X9TuK8=;
        b=Prw+e3qTN9JwuIoiIug0Niirg1ym+zVjLsyNSzSMsWW/rrTwPpz6oR3SZgBTuZZKyr
         qqHnF0cFCgyKjCq1GNdB0P5a9qFBHfo1z3qfvmHCMugOFPVjpffw4PF3nYMsh8FMzacd
         QOo3cKUkDXvrUmL0ueE6l7YrQH23TQwpl3bSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbUqdK1otFEuJAwkKU1CGhmnKqFJa2aBCYhP9X9TuK8=;
        b=hDUN51wpcr8CBVcRqeHE7gUIXzpxjOrxrR8iC9/TGmTxy5edfY4rbA2EPjzm0l037v
         tYj+UHiKdADZvs7nxjdpzGi5yV/hWzBXEGqQKRxKC3gV4ANZJROlibWYTxUoPFH/LVz6
         m5MiT9r45M57snHLkOSUXoiXmUdiqAWBBLCWDRRK1YXfl8DjFhLGJi6+XbYnsJJvq+Q6
         e6ZHtyzUnE4n4DEqfEMut/1JmeU2tp610qC5sn9XfAiC2WU9bpL3uVeMPYEBHY4+cqtq
         s+SYOvqlN/K14unBk6fRucsHR7otzgeDjNteXNILQ77i36GM5YjkSwi916wF3b6+6MFY
         kwbQ==
X-Gm-Message-State: AOAM532jTcShKY361FwM4KTrOw2o1nb3bIiV7p4AiRxhSyuXFdQOOfmP
        aAuk8H5qG1ajztGjWbsvsj6Vaxw6PiZWHFH0ZV9QTQ==
X-Google-Smtp-Source: ABdhPJxVPp7ZUB1Hy3lQG+5hOinD9KhlF5RhGa4Utgi0hBsSBGgXhKCXFd15P2JzxT7RwmVyK03V4nMGut8WCru7OHg=
X-Received: by 2002:ac8:2a3d:: with SMTP id k58mr2187470qtk.265.1593464923410;
 Mon, 29 Jun 2020 14:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200629163851.2130450-1-pmalani@chromium.org> <CABXOdTe-hY98YFusFkS+C8iVWZANVWcavpKSmaYtjC11yMgFrg@mail.gmail.com>
In-Reply-To: <CABXOdTe-hY98YFusFkS+C8iVWZANVWcavpKSmaYtjC11yMgFrg@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 29 Jun 2020 14:08:31 -0700
Message-ID: <CACeCKaeqw7Lj7z3DYDvR0j6x+ud3BcxVgxb9-sQ3ZS0ks_f7gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/chrome: cros_ec_typec: Use workqueue for
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

Thanks for the comments.

On Mon, Jun 29, 2020 at 2:05 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Jun 29, 2020 at 9:38 AM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Use a work queue to call the port update routines, instead of doing it
> > directly in the PD notifier callback. This will prevent other drivers
> > with PD notifier callbacks from being blocked on the port update routine
> > completing.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Use new 100 character line length limit.
> >
> > Changes in v2:
> > - No changes.
> >
> >  drivers/platform/chrome/cros_ec_typec.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 0c041b79cbba..0beb62bf5adf 100644
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
> > @@ -619,18 +620,26 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
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
> > +       struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
> > +       int ret;
> > +       int i;
> >
>
> I know I am getting picky here, but this seems like a personal
> preference change. There is no "one variable declaration per line"
> coding style rule.

Done.
>
> >         for (i = 0; i < typec->num_ports; i++) {
> >                 ret = cros_typec_port_update(typec, i);
> >                 if (ret < 0)
> >                         dev_warn(typec->dev, "Update failed for port: %d\n", i);
> >         }
> > +}
> > +
> > +
>
> ... but anyway, there should be no double empty lines.
>

Done.
> > +static int cros_ec_typec_event(struct notifier_block *nb,
> > +                              unsigned long host_event, void *_notify)
> > +{
> > +       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
> > +
> > +       schedule_work(&typec->port_work);
> >
> >         return NOTIFY_OK;
> >  }
> > @@ -689,6 +698,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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
