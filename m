Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A362C20775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXNdRwbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391032AbgFYQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390935AbgFYQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:49:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B6DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:49:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t6so5868292otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpLir0KN1fSiFUAnU5SYwq+aUgno301uMg/TCjtgcTs=;
        b=UXNdRwbZrO+vE+usgaoKsP0CdDAddXk1tIGwLHSU7cQWnP66wJ5t+/8TVUtaFEmrdL
         kP3+HCYqgFoH0pZUK8uVe5Dupj+fm7WgK3mHRQucL0MVLif+yQbwSWWZ2NXuxLhUF8HE
         sHHqz5wtXZp5Yksu3OSyEyPIKOBQQ5FSA3CwJ3Eb3HjkppNX5e8YUJG3BZEm5tIYH3Ct
         aXoS7CekNFO6dy7x7GSbjbTZ5BqLnQ50RNdzYXPLf9DfGhGyTtEf5YvdfYuWi9amIenU
         yvX9GDgdQG01p5d+xcfSw8p1zFz7czjpeSaRVZ8y3JpgLQ71xeyy5Q6SM7D3ykCF3SE2
         QoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpLir0KN1fSiFUAnU5SYwq+aUgno301uMg/TCjtgcTs=;
        b=EcfLbBIuD9NRBZ9ZfsiCQmNVs8+0tP4FlNTBSxajIAD8Sh2tGJU8gKh6jhdjyKr58N
         CecSA325AXY+XXL+DrKPtwM/XBttuxs3N6pZuGpBY5jkP5IWoiNAfhCUe1aZJgL/atca
         oG6EsGWIIDa1j1d84i36hW3lQnRxAroKrG0SavaJqRhywfCiDhgFGU1y3cweAMKBX47B
         xm1kJBquxk6RJMYPG6vazv58kbtqduB5RofgB9AVI7biDIQJEGBEtNLgfG6+x9GTqgp1
         LTsRcgyWFwMt9eISKQ+g9Qx6Z6Rl9vOARzE+4zO3eAkctQ5xEEV2+mLFFx2SiWINNJhk
         t6GQ==
X-Gm-Message-State: AOAM530XX9Avu43XYR39a87JOwSbl2aCvWunH7tJAc2rr6pNyLhvDEjM
        o3YHv2bD128pwC4D5zyvTDEiJXGbvbbnXqYtFnD6ag==
X-Google-Smtp-Source: ABdhPJw75jtpWcrsgg4j8jrmGbPCwKktdzBqBh3bNDPjFrGgR+iMpgHLcNYj//oxt1QnvrS8FRMtCSTvI2wwXfGC13w=
X-Received: by 2002:a9d:6048:: with SMTP id v8mr29627919otj.231.1593103763385;
 Thu, 25 Jun 2020 09:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jun 2020 09:48:47 -0700
Message-ID: <CAGETcx8AQPZ92vKKwq6-U8fbToCWtHvu4OT4hXzOGiCUst15fw@mail.gmail.com>
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

Dropping Feng Kan <fkan@apm.com> and Toan Le <toanle@apm.com> because
their mails are bouncing.

On Thu, Jun 25, 2020 at 8:19 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 25, 2020 at 5:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Under the following conditions:
> > - driver A is built in and can probe device-A
> > - driver B is a module and can probe device-B
> > - device-A is supplier of device-B
> >
> > Without this patch:
> > 1. device-A is added.
> > 2. device-B is added.
> > 3. dpm_list is now [device-A, device-B].
> > 4. driver-A defers probe of device-A.
> > 5. deferred probe of device-A is reattempted
> > 6. device-A is moved to end of dpm_list.
> > 6. dpm_list is now [device-B, device-A].
> > 7. driver-B is loaded and probes device-B.
> > 8. dpm_list stays as [device-B, device-A].
> >
> > Suspend (which goes in the reverse order of dpm_list) fails because
> > device-A (supplier) is suspended before device-B (consumer).
> >
> > With this patch:
> > 1. device-A is added.
> > 2. device-B is added.
> > 3. dpm_list is now [device-A, device-B].
> > 4. driver-A defers probe of device-A.
> > 5. deferred probe of device-A is reattempted later.
> > 6. dpm_list is now [device-B, device-A].
> > 7. driver-B is loaded and probes device-B.
> > 8. dpm_list is now [device-A, device-B].
> >
> > Suspend works because device-B (consumer) is suspended before device-A
> > (supplier).
> >
> > Fixes: 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
> > Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/dd.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 9a1d940342ac..52b2148c7983 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -109,6 +109,8 @@ static void deferred_probe_work_func(struct work_struct *work)
> >                  * probe makes that very unsafe.
> >                  */
> >                 device_pm_move_to_tail(dev);
> > +               /* Greg/Rafael: SHOULD I DELETE THIS? ^^ I think I should, but
> > +                * I'm worried if it'll have some unintended consequeneces. */
>
> Yes, this needs to go away if you make the other change.
>
> >
> >                 dev_dbg(dev, "Retrying from deferred list\n");
> >                 bus_probe_device(dev);
> > @@ -557,6 +559,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >                 goto re_probe;
> >         }
> >
> > +       /*
> > +        * The devices are added to the dpm_list (resume/suspend (reverse
> > +        * order) list) as they are registered with the driver core. But the
> > +        * order the devices are added doesn't necessarily match the real
> > +        * dependency order.
> > +        *
> > +        * The successful probe order is a much better signal. If a device just
> > +        * probed successfully, then we know for sure that all the devices that
> > +        * probed before it don't depend on the device. So, we can safely move
> > +        * the device to the end of the dpm_list. As more devices probe,
> > +        * they'll automatically get ordered correctly.
> > +        */
> > +       device_pm_move_to_tail(dev);
>
> But it would be good to somehow limit this to the devices affected by
> deferred probing or we'll end up reordering dpm_list unnecessarily for
> many times in the actual majority of cases.

Yes, lots of unnecessary reordering, but doing it only for deferred
probes IS the problem. In the example I gave, the consumer is never
deferred probe because the supplier happens to finish probing before
the consumer probe is even attempted.

I'm open to other suggestions, but I think this is needed for all the
cases or at least more cases to be handled correctly.

One alternative I was thinking was not adding the device to the
dpm_list until it's probed. But I have the vague feeling of other
things between device_add() and device probe that expect the device to
be in the dpm_list.

-Saravana
