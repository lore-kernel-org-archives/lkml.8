Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2672C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0C420718
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuNBL5qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBOD51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:57:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43199 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgBOD51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 22:57:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so13579032edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 19:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ollLJfhVgjUki+vmHDfSX/9qq4hzYWk5uY+i/fNGY/A=;
        b=iuNBL5qFtUBSfh6kVkOj8JWteBqbgrzGESX7mHuoMe8bQ7jNhbK5Z8ASD5j/MHBO64
         gGCDrT42pL0FcwijZtfg19ejOVGXovoTnx/Dp/wc8rW8Ek/ufwumt5VjvmISaFy2Ngb8
         ZDpk1JvzQ14OAtik6xDgCE2ID5F1x/tsLbjoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ollLJfhVgjUki+vmHDfSX/9qq4hzYWk5uY+i/fNGY/A=;
        b=RD/P0XXQgC5lj9q3ohc3BM1vzYMmVZRaOvobpv3/SA7gLwbHq1HCJNgBVPUc99l9Ew
         KDN6fxjkyFdS0cFBKIavlpgCMiuskIOVgjrRD44BnalRUIy3sPvQw8IHWo1Bwpy18V86
         aXIBX9oSIYOfeN/TszZQv/rEIqI7cbBddEj3xUjUhwkgmVneM/ioJHWuOE7hIuNQgO40
         un2tJrJp6P1Jwda3mpCAN3jvYvWf8pZa3Vc/X106EwxnIfVkRs4RnTDBG4JLPjKSYM2K
         XRc/LjyGfJ6pQhJ6wxPQDkSnvkUKOnoFTgh17P1wiJdGo4Zv/IjQmIzOUjsrFY0aoOPO
         L7gA==
X-Gm-Message-State: APjAAAWLAUCuhjs3eseFJ7GEBSs+nogJ0vh39792/mwUIaKHMblCiNn0
        5DOUaAqfonine3SXmalB2x+FlyuKFrgrVnWPbgo7FA==
X-Google-Smtp-Source: APXvYqxm2O3uUCa5BrdGlaLQo8c8ecYcdhZcDn7oAX8EQw7AY3J0R9PT31aK6GszRHCpOOpEfxuDGyWEPB3OkBUd/W0=
X-Received: by 2002:aa7:c616:: with SMTP id h22mr5165255edq.352.1581739044206;
 Fri, 14 Feb 2020 19:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20200214082638.92070-1-pihsun@chromium.org> <83b03af1-5518-599a-3f82-ee204992edbf@collabora.com>
In-Reply-To: <83b03af1-5518-599a-3f82-ee204992edbf@collabora.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Sat, 15 Feb 2020 11:56:48 +0800
Message-ID: <CANdKZ0fuK1Nm_fPNKAss29pqghCcwjN3acYHi6Ez5==envgKgA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Fix race with host event.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Fri, Feb 14, 2020 at 11:10 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Pi-Hsun,
>
> On 14/2/20 9:26, Pi-Hsun Shih wrote:
> > Host event can be sent by remoteproc by any time, and
> > cros_ec_rpmsg_callback would be called after cros_ec_rpmsg_create_ept.
> > But the cros_ec_device is initialized after that, which cause host event
> > handler to use cros_ec_device that are not initialized properly yet.
> >
>
> I don't have the hardware to test but, can't we call first cros_ec_register and
> then cros_ec_rpmsg_create_ept?
>
> Start receiving driver callbacks before finishing to probe the drivers itself
> sounds weird to me.
>
> Thanks,
>  Enric

Since cros_ec_register calls cros_ec_query_all, which sends message to
remoteproc using cros_ec_pkt_xfer_rpmsg (to query protocol version),
the ec_rpmsg->ept need to be ready before calling cros_ec_register.

>
> > Fix this by don't schedule host event handler before cros_ec_register
> > returns. Instead, remember that we have a pending host event, and
> > schedule host event handler after cros_ec_register.
> >
> > Fixes: 71cddb7097e2 ("platform/chrome: cros_ec_rpmsg: Fix race with host command when probe failed.")
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_rpmsg.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> > index dbc3f5523b83..7e8629e3db74 100644
> > --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> > +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> > @@ -44,6 +44,8 @@ struct cros_ec_rpmsg {
> >       struct completion xfer_ack;
> >       struct work_struct host_event_work;
> >       struct rpmsg_endpoint *ept;
> > +     bool has_pending_host_event;
> > +     bool probe_done;
> >  };
> >
> >  /**
> > @@ -177,7 +179,14 @@ static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> >               memcpy(ec_dev->din, resp->data, len);
> >               complete(&ec_rpmsg->xfer_ack);
> >       } else if (resp->type == HOST_EVENT_MARK) {
> > -             schedule_work(&ec_rpmsg->host_event_work);
> > +             /*
> > +              * If the host event is sent before cros_ec_register is
> > +              * finished, queue the host event.
> > +              */
> > +             if (ec_rpmsg->probe_done)
> > +                     schedule_work(&ec_rpmsg->host_event_work);
> > +             else
> > +                     ec_rpmsg->has_pending_host_event = true;
> >       } else {
> >               dev_warn(ec_dev->dev, "rpmsg received invalid type = %d",
> >                        resp->type);
> > @@ -240,6 +249,11 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
> >               return ret;
> >       }
> >
> > +     ec_rpmsg->probe_done = true;
> > +
> > +     if (ec_rpmsg->has_pending_host_event)
> > +             schedule_work(&ec_rpmsg->host_event_work);
> > +
> >       return 0;
> >  }
> >
> >
> > base-commit: b19e8c68470385dd2c5440876591fddb02c8c402
> >
