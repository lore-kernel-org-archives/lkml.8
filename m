Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C6A206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593170852;
	bh=HMQZ2gONB7nhi+LufmPkRPnv6T8Qn6r9O3UhnDR81JY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nWA4Iqm8pDkKVuX/F8Ria02ZUrkhpJjKNYV2nGcDzclcBUPLSj0+yRe8JRvDti6SJ
	 PBYxz8YMDyKxvinnkad0Px+Xzs3vi+xnVcseEFE8CFgdkplJevAVumNhOmpJLYAxol
	 UGv5vKafYgnfb5FzCz4AXH6fySGgGxVB3JL1csp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgFZL1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:27:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44101 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgFZL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:27:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id 5so6274475oty.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJM2YZ8FuB0rwJc0eaWFy+gB1ZVxh+nnW2v11JuJigs=;
        b=sOcVLSYwgwsINQR8L3YmWn/K7P/tH95/Au1zVIT/uEJjfzTQCPjNA1pryh75eR7EZE
         U27fUqUf2JlXgj5YPFk3uTYBdGxXGxYiW6XnWmxXrQAjqjxiXENt++ZqmKrGgzbMrmHG
         UQmfUhesvfXN0qz3cDWwI038+80IXYs05Iu+LXGsYQvoIU87Ou7uj1C30zH+9/fnbfDq
         NLG2x79w+QnJUdR8qDhBtsSaq49Qv2hzlRP4zdmCKwwGIucZu/YixVDf8h//m4V7JL0I
         HOJHObxeDFcdUa5B9f7Z6RYjhs01HAT2ueu/OLNzFe//HdEr1omVuF8lm1leyFHsFj7z
         9cUA==
X-Gm-Message-State: AOAM531ZrA2MFQTkXXJBnhZbAYSQOEwd+JglZ7/M59wMKKNA2kdyoPMp
        G7HzmSDdIV6wZ1lgAZYRLSfopTc0ULmUWSYB9Pw=
X-Google-Smtp-Source: ABdhPJxDX1lu2+r+a+EBqy+HFWSZUNRAf+shnClf9EZMJDFqYdcyEOdpgXKlQUcakicgERZrpzUaZymkhyeV3g4kfNA=
X-Received: by 2002:a4a:3e48:: with SMTP id t69mr2012267oot.38.1593170848703;
 Fri, 26 Jun 2020 04:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
 <CAGETcx8AQPZ92vKKwq6-U8fbToCWtHvu4OT4hXzOGiCUst15fw@mail.gmail.com>
 <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
 <CAGETcx8J5fs42_HMVyYvbX1=gqGTnavEuDOH+LHprZYRbXvUzw@mail.gmail.com>
 <CAJZ5v0i-ySdNmToh=ExT9H_88bhHVeUNfTNWxXG1SzaP8a5j-w@mail.gmail.com>
 <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com>
 <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com> <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
In-Reply-To: <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 13:27:16 +0200
Message-ID: <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 7:52 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jun 25, 2020 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jun 25, 2020 at 7:09 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Thu, Jun 25, 2020 at 10:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Jun 25, 2020 at 7:01 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > On Thu, Jun 25, 2020 at 9:58 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Jun 25, 2020 at 6:49 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > >
> > > > > > > Dropping Feng Kan <fkan@apm.com> and Toan Le <toanle@apm.com> because
> > > > > > > their mails are bouncing.
> > > > > > >
> > > > > > > On Thu, Jun 25, 2020 at 8:19 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jun 25, 2020 at 5:24 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Under the following conditions:
> > > > > > > > > - driver A is built in and can probe device-A
> > > > > > > > > - driver B is a module and can probe device-B
> > > > > > > > > - device-A is supplier of device-B
> > > > > > > > >
> > > > > > > > > Without this patch:
> > > > > > > > > 1. device-A is added.
> > > > > > > > > 2. device-B is added.
> > > > > > > > > 3. dpm_list is now [device-A, device-B].
> > > > > > > > > 4. driver-A defers probe of device-A.
> > > > > > > > > 5. deferred probe of device-A is reattempted
> > > > > > > > > 6. device-A is moved to end of dpm_list.
> > > > > > > > > 6. dpm_list is now [device-B, device-A].
> > > > > > > > > 7. driver-B is loaded and probes device-B.
> > > > > > > > > 8. dpm_list stays as [device-B, device-A].
> > > > > > > > >
> > > > > > > > > Suspend (which goes in the reverse order of dpm_list) fails because
> > > > > > > > > device-A (supplier) is suspended before device-B (consumer).
> > > > > > > > >
> > > > > > > > > With this patch:
> > > > > > > > > 1. device-A is added.
> > > > > > > > > 2. device-B is added.
> > > > > > > > > 3. dpm_list is now [device-A, device-B].
> > > > > > > > > 4. driver-A defers probe of device-A.
> > > > > > > > > 5. deferred probe of device-A is reattempted later.
> > > > > > > > > 6. dpm_list is now [device-B, device-A].
> > > > > > > > > 7. driver-B is loaded and probes device-B.
> > > > > > > > > 8. dpm_list is now [device-A, device-B].
> > > > > > > > >
> > > > > > > > > Suspend works because device-B (consumer) is suspended before device-A
> > > > > > > > > (supplier).
> > > > > > > > >
> > > > > > > > > Fixes: 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
> > > > > > > > > Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> > > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/base/dd.c | 16 ++++++++++++++++
> > > > > > > > >  1 file changed, 16 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > > > > > > index 9a1d940342ac..52b2148c7983 100644
> > > > > > > > > --- a/drivers/base/dd.c
> > > > > > > > > +++ b/drivers/base/dd.c
> > > > > > > > > @@ -109,6 +109,8 @@ static void deferred_probe_work_func(struct work_struct *work)
> > > > > > > > >                  * probe makes that very unsafe.
> > > > > > > > >                  */
> > > > > > > > >                 device_pm_move_to_tail(dev);
> > > > > > > > > +               /* Greg/Rafael: SHOULD I DELETE THIS? ^^ I think I should, but
> > > > > > > > > +                * I'm worried if it'll have some unintended consequeneces. */
> > > > > > > >
> > > > > > > > Yes, this needs to go away if you make the other change.
> > > > > > > >
> > > > > > > > >
> > > > > > > > >                 dev_dbg(dev, "Retrying from deferred list\n");
> > > > > > > > >                 bus_probe_device(dev);
> > > > > > > > > @@ -557,6 +559,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> > > > > > > > >                 goto re_probe;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > +       /*
> > > > > > > > > +        * The devices are added to the dpm_list (resume/suspend (reverse
> > > > > > > > > +        * order) list) as they are registered with the driver core. But the
> > > > > > > > > +        * order the devices are added doesn't necessarily match the real
> > > > > > > > > +        * dependency order.
> > > > > > > > > +        *
> > > > > > > > > +        * The successful probe order is a much better signal. If a device just
> > > > > > > > > +        * probed successfully, then we know for sure that all the devices that
> > > > > > > > > +        * probed before it don't depend on the device. So, we can safely move
> > > > > > > > > +        * the device to the end of the dpm_list. As more devices probe,
> > > > > > > > > +        * they'll automatically get ordered correctly.
> > > > > > > > > +        */
> > > > > > > > > +       device_pm_move_to_tail(dev);
> > > > > > > >
> > > > > > > > But it would be good to somehow limit this to the devices affected by
> > > > > > > > deferred probing or we'll end up reordering dpm_list unnecessarily for
> > > > > > > > many times in the actual majority of cases.
> > > > > > >
> > > > > > > Yes, lots of unnecessary reordering, but doing it only for deferred
> > > > > > > probes IS the problem. In the example I gave, the consumer is never
> > > > > > > deferred probe because the supplier happens to finish probing before
> > > > > > > the consumer probe is even attempted.
> > > > > >
> > > > > > But why would the supplier be moved to the end of dpm_list without
> > > > > > moving the consumer along with it?
> > > > >
> > > > > There is no device link between the supplier/consumer in this case.
> > > >
> > > > So this is the real problem, isn't it?
> > > >
> > > > > Sadly there are plenty of cases where device links aren't present to
> > > > > capture supplier/consumer dependencies.
> > > >
> > > > And so that's why you want to add a ton of overhead to driver probing
> > > > in all of the cases in which that is not an issue?
> > >
> > > Well, until all/most of the frameworks add device links or
> > > fw_devlink=on by default, it doesn't hurt to have suspend/resume work
> > > in more platforms.
> >
> > In the presence of deferred probing, that is.
> >
> > Note that deferred probing gets in the way here and so the problem is
> > related to it.
>
> I mean, we officially support deferred probing. Shouldn't we fix it so
> that it doesn't break suspend/resume?

Yes, we should fix deferred probing.

> Also, it's pretty easy to have
> cases where one module probes multiple device instances and loading it
> in one order would break dpm_list order for one device and loading it
> in another order would break it for another device. And there would be
> no "proper" order to load modules (because module order != device
> order).

I'm not saying that the current code is perfect.  I'm saying that the
fix as proposed adds too much cost for everybody who may not care IMO.

>
> > > What about the option of not adding to dpm_list until a device is
> > > probed? Is it DOA?
> >
> > Yes, it is, I'm afraid.  There are devices without drivers. :-)
>
> Devices that still suspend/resume without drivers?! I didn't know that
> was possible.

There are "class" devices, "type" devices and devices that simply have
no drivers, but the bus type code may still want to touch them during
system-wide suspend/resume.

Modules may still not be loaded when the system is suspended for the
first time etc.
