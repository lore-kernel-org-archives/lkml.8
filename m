Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6382072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ym0xVqEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391433AbgAXSk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:40:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34031 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388064AbgAXSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:40:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so483056oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEX2XLRijeuSJZp7wwl6e4j7OXHV8hmVU5+FKRIFc14=;
        b=ym0xVqEAP0KuLa714APgwQhngjsP5SlxeysbIHdrwcmxVd4/Rwftrvn/NQrwPWMlt3
         LJMfVWS6NfBUr5Nw/0ppJmwirJbktnsXA50a3etaNsXoQ6IwvnG2IVkOa+Gh2fOmkQDg
         RUY/vPr9u+NziVeFxWLeCUutwX13CzUOZyQ6KaBCiVYZpugcgzT9tX0ZwzJAKpTtRS/1
         JJY68vgB9uDHGV4Dp2ukpTNPTFX0GiEg3XXJg5LZnBLkeh7yW6i5b57Jj1aJM7e2Whku
         b1/xQcaC+hY6c99pvhc/DxCs8IHdc8ucsK1eII3a/8M/zQTsSb3F9Mv4m/PFiA1KvU/1
         wakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEX2XLRijeuSJZp7wwl6e4j7OXHV8hmVU5+FKRIFc14=;
        b=ZFloURkr2aqRUslJXb/vEtpqAPrfK1QUa205DkK2eBPoNl94Nkl9PTRc5xXi6RdcPi
         kEzr8kuJBAgW8xxt1tXq7ImpHJWAwUGJKJ4TDQH2WFVqHueTFUEhr3crRNUsZftYQFjU
         Pv4yrRanSuvEctPXA8qlSUT5RGhP+e/kuNlMvsPrOWhZBt5m4kOPPbbynuoGkI51ZGOq
         HEK9E8aXc/0AiYyrx451bFcWS1W14fzSxSvEo3R81fK/GFrKaRgVgCOr9gCvAqpGzUSw
         1Zv5SKdysd0strgrzCfRvOxNWYbkS77bWdhgFyj8djLymihi33ZLi5lqggCCyM+yJu1x
         R/Tw==
X-Gm-Message-State: APjAAAXEpWcpGukY6u5gZls6SmmRZBUZ01kw85QgOM4kapsWoaAQh8EO
        b1vbdWHu52xXGlOd3usm/Nkj8hgZl/e+oZNBc42Arw==
X-Google-Smtp-Source: APXvYqzVZg1E4IIVynRByvKw/cKwqHMFcil2qw+/FTTtW7F+ZuEguSI5seidRPRnfG7YWaV2IwZV81WCPgOxY3mcseQ=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr109404oij.149.1579891258032;
 Fri, 24 Jan 2020 10:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20200120104909.13991-1-david@redhat.com> <1580c2bb-5e94-121d-8153-c8a7230b764b@redhat.com>
In-Reply-To: <1580c2bb-5e94-121d-8153-c8a7230b764b@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 24 Jan 2020 10:40:46 -0800
Message-ID: <CAPcyv4gJRuk7pZFvqJNY3niJeoW6CtFwp_sZauBSTdWPP+i+wA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: check for dead devices before onlining/offlining
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 9:14 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.01.20 11:49, David Hildenbrand wrote:
> > We can have rare cases where the removal of a device races with
> > somebody trying to online it (esp. via sysfs). We can simply check
> > if the device is already removed or getting removed under the dev->lock.
> >
> > E.g., right now, if memory block devices are removed (remove_memory()),
> > we do a:
> >
> > remove_memory() -> lock_device_hotplug() -> mem_hotplug_begin() ->
> > lock_device() -> dev->dead = true
> >
> > Somebody coming via sysfs (/sys/devices/system/memory/memoryX/online)
> > triggers a:
> >
> > lock_device_hotplug_sysfs() -> device_online() -> lock_device() ...
> >
> > So if we made it just before the lock_device_hotplug_sysfs() but get
> > delayed until remove_memory() released all locks, we will continue
> > taking locks and trying to online the device - which is then a zombie
> > device.
> >
> > Note that at least the memory onlining path seems to be protected by
> > checking if all memory sections are still present (something we can then
> > get rid of). We do have other sysfs attributes
> > (e.g., /sys/devices/system/memory/memoryX/valid_zones) that don't do any
> > such locking yet and might race with memory removal in a similar way. For
> > these users, we can then do a
> >
> > device_lock(dev);
> > if (!device_is_dead(dev)) {
> >       /* magic /*
> > }
> > device_unlock(dev);
> >
> > Introduce and use device_is_dead() right away.
> >
>
> So, I just added the following:
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 01cd06eeb513..49c4d8671073 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1567,6 +1567,7 @@ static ssize_t online_store(struct device *dev,
> struct device_attribute *attr,
>         if (ret < 0)
>                 return ret;
>
> +       msleep(10000);
>         ret = lock_device_hotplug_sysfs();
>         if (ret)
>                 return ret;
>
> Then triggered
>         echo 1 > /sys/devices/system/memory/memory51/online
> And quickly afterwards unplugged the DIMM.
>
> Good news is that we get (after 10 seconds)
>         sh: echo: write error: No such device
>
> Reason is that unplug will not finish before all sysfs attributes have
> been exited by other threads.

The unplug thread gets blocked for 10 seconds waiting for this thread
in online_store() to exit?
