Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC79C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431D6206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sIPL13O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406502AbgFYRBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403979AbgFYRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:01:49 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C86C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:01:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n6so5963487otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64VPefnsbQoWBq6A9WZXqMpfXmQG6FPx55U7Pt6B69Y=;
        b=sIPL13O3JOangM1cATexqMLVN8Ly8bPUGCPnSfbNN1OM7W0b8ZdvCoLTTlW8PgrKIa
         xZsAPlgTSIBkijuiCXIavg0qjmJVlwEkPFzp+BRzMIllgvj2uUf1L8GRPwN3LWu0lyij
         GTrpNH1wHWKs3wMVR9O6dgx9jpVqrmwmjvIf+JyI9Zx1++aW1MYVqZOyv6ayTqEvZOso
         ZvNR3JZLJvWLMSLvFHDovX9bX3QITMGqewQPxzidUDwkOi6VoXP4tNP43zF6beD+gpbO
         DZ8s93KiPG3xqsXnagTuV/4qX7UkNNEZoJwsRmWPiOF5SPVrzf9WvUoOJuKqQCFwVFYm
         8nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64VPefnsbQoWBq6A9WZXqMpfXmQG6FPx55U7Pt6B69Y=;
        b=kET1+ra2z8rpAnkj4Ew3/isysxqxfYa+3CfILd2D2OYxwAzSn6CE024NVwCcKXvGYn
         OdRj2xYit0QiZRh96hAjT4pBs+56/u4emyarEIcOzSMYKuRsjLpJc4YJp8FRobTALNXR
         JawZ6ps5PmoiL67QWg/B3oezUrg2LOq0jMqR1Ft6jvGun6VrdBbPK+NI73wa9cTJAlza
         NTogBYQz/Sy3lfkZ7Bhx3hkQDN6ekzrCFWeUhafcLOxeJSdmLHlgSTZTZHWgrik3/+E1
         Mhet3NRlu8MydQimwD9ySMlVPfNgRhZD/xvoEulVHmRtOkTDSFtpPCAKVrsoH6aNOcv4
         pUjg==
X-Gm-Message-State: AOAM531XrS6a/UZEZy4v2eZLblJ8gBUarAeJtpcMRmhHkeUZkf6hpzG1
        JjIO59zfTgRPRvnlxVOHPjl+8ymzrwkS7bg7sVqtc0lq
X-Google-Smtp-Source: ABdhPJw8JnvAmv9wxY2uRqUiB2sSYGahLsgBkAtLnWQxuueCesRJZ5Tu2+ADJ/w6CzTMzmZoo+4VtbnefFC/cPY9oF8=
X-Received: by 2002:a9d:6048:: with SMTP id v8mr29678987otj.231.1593104508245;
 Thu, 25 Jun 2020 10:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
 <CAGETcx8AQPZ92vKKwq6-U8fbToCWtHvu4OT4hXzOGiCUst15fw@mail.gmail.com> <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jun 2020 10:01:12 -0700
Message-ID: <CAGETcx8J5fs42_HMVyYvbX1=gqGTnavEuDOH+LHprZYRbXvUzw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 9:58 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 25, 2020 at 6:49 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Dropping Feng Kan <fkan@apm.com> and Toan Le <toanle@apm.com> because
> > their mails are bouncing.
> >
> > On Thu, Jun 25, 2020 at 8:19 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Jun 25, 2020 at 5:24 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Under the following conditions:
> > > > - driver A is built in and can probe device-A
> > > > - driver B is a module and can probe device-B
> > > > - device-A is supplier of device-B
> > > >
> > > > Without this patch:
> > > > 1. device-A is added.
> > > > 2. device-B is added.
> > > > 3. dpm_list is now [device-A, device-B].
> > > > 4. driver-A defers probe of device-A.
> > > > 5. deferred probe of device-A is reattempted
> > > > 6. device-A is moved to end of dpm_list.
> > > > 6. dpm_list is now [device-B, device-A].
> > > > 7. driver-B is loaded and probes device-B.
> > > > 8. dpm_list stays as [device-B, device-A].
> > > >
> > > > Suspend (which goes in the reverse order of dpm_list) fails because
> > > > device-A (supplier) is suspended before device-B (consumer).
> > > >
> > > > With this patch:
> > > > 1. device-A is added.
> > > > 2. device-B is added.
> > > > 3. dpm_list is now [device-A, device-B].
> > > > 4. driver-A defers probe of device-A.
> > > > 5. deferred probe of device-A is reattempted later.
> > > > 6. dpm_list is now [device-B, device-A].
> > > > 7. driver-B is loaded and probes device-B.
> > > > 8. dpm_list is now [device-A, device-B].
> > > >
> > > > Suspend works because device-B (consumer) is suspended before device-A
> > > > (supplier).
> > > >
> > > > Fixes: 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
> > > > Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/dd.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > index 9a1d940342ac..52b2148c7983 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -109,6 +109,8 @@ static void deferred_probe_work_func(struct work_struct *work)
> > > >                  * probe makes that very unsafe.
> > > >                  */
> > > >                 device_pm_move_to_tail(dev);
> > > > +               /* Greg/Rafael: SHOULD I DELETE THIS? ^^ I think I should, but
> > > > +                * I'm worried if it'll have some unintended consequeneces. */
> > >
> > > Yes, this needs to go away if you make the other change.
> > >
> > > >
> > > >                 dev_dbg(dev, "Retrying from deferred list\n");
> > > >                 bus_probe_device(dev);
> > > > @@ -557,6 +559,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> > > >                 goto re_probe;
> > > >         }
> > > >
> > > > +       /*
> > > > +        * The devices are added to the dpm_list (resume/suspend (reverse
> > > > +        * order) list) as they are registered with the driver core. But the
> > > > +        * order the devices are added doesn't necessarily match the real
> > > > +        * dependency order.
> > > > +        *
> > > > +        * The successful probe order is a much better signal. If a device just
> > > > +        * probed successfully, then we know for sure that all the devices that
> > > > +        * probed before it don't depend on the device. So, we can safely move
> > > > +        * the device to the end of the dpm_list. As more devices probe,
> > > > +        * they'll automatically get ordered correctly.
> > > > +        */
> > > > +       device_pm_move_to_tail(dev);
> > >
> > > But it would be good to somehow limit this to the devices affected by
> > > deferred probing or we'll end up reordering dpm_list unnecessarily for
> > > many times in the actual majority of cases.
> >
> > Yes, lots of unnecessary reordering, but doing it only for deferred
> > probes IS the problem. In the example I gave, the consumer is never
> > deferred probe because the supplier happens to finish probing before
> > the consumer probe is even attempted.
>
> But why would the supplier be moved to the end of dpm_list without
> moving the consumer along with it?

There is no device link between the supplier/consumer in this case.
Sadly there are plenty of cases where device links aren't present to
capture supplier/consumer dependencies.

-Saravana
