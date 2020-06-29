Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1444C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF4920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mAWpO12g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404291AbgF2VsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404256AbgF2VsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:48:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF1CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:48:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so16747447qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rhjte5jWrAhyGvMxE0MXsgdqdZRVtcLBxHhVknMbJA=;
        b=mAWpO12gFlXBWTug6YkplBwnVvvEtixSxtt6VWIoSerCuVakRgfsxPLWCsq+F0otd7
         nc1vUOj7rtTAS6cELC8Roh9tMwM9LC5h5enwzFx5Xx34xui4x/FAkc0w6zx6XZeWXFdu
         nKN6gAFEECq8OyEF2pi063LI5TaZIGdu5eSJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rhjte5jWrAhyGvMxE0MXsgdqdZRVtcLBxHhVknMbJA=;
        b=WaxtXoEQ7/VRz5jZri1R6AON/cHaWUjfRf+uoQi3OCkFJAqVgKo5hOEodeJTvDdpwD
         gimd8R67nKWpi1ppczrH1bcTIIIICjmuA6VGsoRfZ1QuXaJJ1ztAqu80QrA0YVWiNet6
         sOp4qsC5QxAkeHxWDcoFPDn46WhMECs0ed3Nl0fDUL4N/NUe91+Ikcd6p2LSMF7dkn5d
         4mVUrz7ZeX76YdBMY9pde/FyDcMRlsLBSbtPfyAwYd2ENzl4SesnforwnmkdotdkIdCF
         Zy3ukBfpGkWLQcy9q4dyAo239UsnPRQyJpj2pFKgQPGgbScfa72+b8E+D1JsYtHc0tCX
         uw0g==
X-Gm-Message-State: AOAM531Xyzp/ldD/Fo9YRNxeRY2SV7uE/j67zGrci95AHy5vDB4FVIJW
        dm4WOAYU7bG9+4khgthQ8XJ0XVshGMN5yyt2R+4wNA==
X-Google-Smtp-Source: ABdhPJxsNjFp58TXX16Z0L4XYVcEek9YkUooE1uzFX0jDjaLBpB0cyNZOn37PcfllsCFLGnqYa4DO2YOOEaDUbz/NRo=
X-Received: by 2002:a37:5603:: with SMTP id k3mr16905807qkb.90.1593467287799;
 Mon, 29 Jun 2020 14:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200629211329.2185342-1-pmalani@chromium.org> <CABXOdTfoks7+hmQA8rj98TsSGF6oabkrOOJzrd0NTKrzHNqjPg@mail.gmail.com>
In-Reply-To: <CABXOdTfoks7+hmQA8rj98TsSGF6oabkrOOJzrd0NTKrzHNqjPg@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 29 Jun 2020 14:47:56 -0700
Message-ID: <CACeCKaeMHt_3Vhq92Qg9t4vbBqoQAGGNp2g+Jp6zRM0mZ_nJ7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Use workqueue for
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

On Mon, Jun 29, 2020 at 2:18 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Jun 29, 2020 at 2:13 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Use a work queue to call the port update routines, instead of doing it
> > directly in the PD notifier callback. This will prevent other drivers
> > with PD notifier callbacks from being blocked on the port update routine
> > completing.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> I can see you are having fun with me :-)

Haha, my apologies , I'm being forgetful :)
>
> > -       int ret, i;
> > +       int i, ret;
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>
> > ---
> >
> > Changes in v4:
> > - Removed extra newline.
> > - Moved both variable declarations into one line.
> >
> > Changes in v3:
> > - Use new 100 character line length limit.
> >
> > Changes in v2:
> > - No changes.
> >
> >  drivers/platform/chrome/cros_ec_typec.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 0c041b79cbba..69c4118e280c 100644
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
> > @@ -619,18 +620,24 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
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
> > +       int i, ret;
> >
> >         for (i = 0; i < typec->num_ports; i++) {
> >                 ret = cros_typec_port_update(typec, i);
> >                 if (ret < 0)
> >                         dev_warn(typec->dev, "Update failed for port: %d\n", i);
> >         }
> > +}
> > +
> > +static int cros_ec_typec_event(struct notifier_block *nb,
> > +                              unsigned long host_event, void *_notify)
> > +{
> > +       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
> > +
> > +       schedule_work(&typec->port_work);
> >
> >         return NOTIFY_OK;
> >  }
> > @@ -689,6 +696,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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
