Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEA6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178E520656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kkVk4vA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbgF2Vnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgF2Sht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:49 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451F2C0307BC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:08:45 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t7so7866819qvl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQexXlGBKJdk3D0CRqMaYBwtQzQ2Na2WWKz2a9JUMcM=;
        b=kkVk4vA2nur6Ml4FZZwrw8YeLgGwNqqa4dh75/DY22m+lPTOkfIr04r4MUkXHwMw52
         3Qq2S9tSvfvY9hy7OsJ9keWL3GBzxD+aI3k/i5794r+rdHuOsfJVfQCDmjV6CUwU37UB
         OmrGrKuM/J5SyX78ZJShUM8IYT62sSLpP3PIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQexXlGBKJdk3D0CRqMaYBwtQzQ2Na2WWKz2a9JUMcM=;
        b=FW8saY8EUPT5dOrn8/H4LvDW4OF9wPN3DqQvZ0nKNHftWaiJb31RdPO4M3i0RUue37
         qHqHGtZNg/m+QVivz69nJ2CyN33EnOT4JyhON5/0A1kYTyUh0LTc8WHVJhyBa48gDO5e
         9hrmASn10lDdhvrfJbninN1rofv7gSM+X1Kevh/TV5xOR/FrqZUrwoRBdgl3dTK6u8Ct
         AlJ+HUnynMCpGjhm4CaAYvxxNik/lKjt3bw++hJXkxtvsTzJXULqC6AccfyDdOa318is
         /gK/+KoC5oUigNxMwcZ88lRt97cFq8YhSyF5feiHYR2t0UUIFOWhc3ucoV6amji5v46o
         CD0g==
X-Gm-Message-State: AOAM533eegjcoslzz0hNgurq774nbPq6zurm//Ck2OWaVO7a7E0Z7UIm
        71W1NzdiOnzFfz54tP4QbFchrbG/8eGr9LeRm+tB/A==
X-Google-Smtp-Source: ABdhPJw7oYxe86+vPz7ga8OTzT65uq/FKjKsrrMcs9OJqqprO2kMPcZz7RR93Rcxm6Eq7BLnP6mTa1hgWoaD/Unue64=
X-Received: by 2002:a0c:b507:: with SMTP id d7mr15066362qve.133.1593446924258;
 Mon, 29 Jun 2020 09:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200627045840.1314019-1-pmalani@chromium.org>
 <20200627045840.1314019-2-pmalani@chromium.org> <cf26168d-bc97-7e35-6f86-a769a36fcc4a@collabora.com>
In-Reply-To: <cf26168d-bc97-7e35-6f86-a769a36fcc4a@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 29 Jun 2020 09:08:32 -0700
Message-ID: <CACeCKacaGvAshk0DgMfem23YRppdnSHU=Ewj5qAjUv2x-bqyCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Add PM support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for reviewing the patch.

On Mon, Jun 29, 2020 at 3:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> Thank you for the patch.
>
> On 27/6/20 6:58, Prashant Malani wrote:
> > Define basic suspend resume functions for cros-ec-typec. On suspend, we
> > simply ensure that any pending port update work is completed, and on
> > resume, we re-poll the port state to account for any
> > changes/disconnections that might have occurred during suspend.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 34 +++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 630170fb2cbe..68f15a47450c 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -725,11 +725,45 @@ static int cros_typec_probe(struct platform_device *pdev)
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +
> > +static int cros_typec_suspend(struct device *dev)
>
> I'd prefer if you can mark these function as __maybe_unused (to avoid the
> compiler warning) rather than wrapping it in a preprocessor conditional, it
> makes the code a bit more simple.

Done.

>
> > +{
> > +     struct cros_typec_data *typec = dev_get_drvdata(dev);
> > +
> > +     cancel_work_sync(&typec->port_work);
> > +
> > +     return 0;
> > +}
> > +
> > +static int cros_typec_resume(struct device *dev)
>
> __maybe_unused ?

Done.

>
> > +{
> > +     struct cros_typec_data *typec = dev_get_drvdata(dev);
> > +
> > +     /* Refresh port state. */
> > +     schedule_work(&typec->port_work);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops cros_typec_pm_ops = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
> > +};
> > +
> > +#define DEV_PM_OPS   (&cros_typec_pm_ops)
> > +
> > +#else
> > +
> > +#define DEV_PM_OPS   NULL
> > +
> > +#endif /* CONFIG_PM_SLEEP */
>
> and remove the ifdefy
>

Done.

> > +
> >  static struct platform_driver cros_typec_driver = {
> >       .driver = {
> >               .name = DRV_NAME,
> >               .acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
> >               .of_match_table = of_match_ptr(cros_typec_of_match),
> > +             .pm = DEV_PM_OPS,
>
>                 .pm = &cros_typec_pm_ops,
>
> >       },
> >       .probe = cros_typec_probe,
> >  };
> >
>
> Thanks,
>  Enric
