Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095FBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EE92072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VRbXBbK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAXWgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:36:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35108 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:36:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so3200030otd.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mBourID/V31s1BqOnMDmszxezNKUWSz9yLVpgK+p3f8=;
        b=VRbXBbK4ZNxdkISIFbwomjrEEBDQRn7MmG6xDT3e/Cr6y4LESCsd+kdFdg3khXVVS7
         TSrKvNBUpfhzrs8AZsR4Ve6hRd6hDhcZcAiqEPaWFfwUxiBLaP0GV646n6UXmXdCYkda
         pAp2InFYQqpGhMvcue+YX8MhaFbXbb6W66+LrZIkrOTZU7hg9buN4LUp/2jPrcEIgx1i
         A20FT31LaX019U4jOte/SUP3CuPfXkbqTUIzhF2NBxoBlhHAdlrf+wV0yGQrJ6GqMGyc
         aeL8D9bK1HgmbugfdJL4ofYXVxsfFHX5HE8r8SBGM6w62O/SUVdNfNFtoGl9MXyKd5NM
         Cnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mBourID/V31s1BqOnMDmszxezNKUWSz9yLVpgK+p3f8=;
        b=HFGdrF75fh/4hrML+LSWcAdXhkJ3v2WwjtE/OIiQcCJH7LTqGDPxzUigbRujYppHsT
         s1WhzX1Vi+EjexoW8lqHouH1qDjjzcXecGHg1lflS30FiRyWqKr8+iDfqCSiAPQgvjvR
         Gz7Xy1TyBFqQZfZFoGKYSFLEx9f/VCGvyMfjhCihWYLQCljPQoD26mAJ7E4fDEC8hrAl
         MBuwJFaym4huEBVmusmCIt+e9EkZpcTyiFGwtDWAAyZGsrU42ajecrzIj3uoCfWiNcaH
         E8i/18Czdp3kVEHkCVPO1417SpuuKbXvqaNyGtcyJF+RgPVd+SO1/iRnspy6+VQsXNb5
         1mgw==
X-Gm-Message-State: APjAAAX9vOmpVhVV2xT6MyDX28x6ZViqgfKXFuZ2zpD7Jr34o/rme1xW
        UyQFvXZWYn14Awf5mPmBgXWSb40/P4O1lWiUd8Rf8aq+V0I=
X-Google-Smtp-Source: APXvYqzAbyvoyz5xvOAHtCLmbZ26SAfhc1dRuiI+nQmo4eNm98pZXZO9Du2608NOVkOrdM5R9vkq+pfLj9HJBKUn0EU=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr4583894otk.363.1579905375819;
 Fri, 24 Jan 2020 14:36:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gJRuk7pZFvqJNY3niJeoW6CtFwp_sZauBSTdWPP+i+wA@mail.gmail.com>
 <77F513E2-220E-4122-B0BB-26FB64D0C598@redhat.com>
In-Reply-To: <77F513E2-220E-4122-B0BB-26FB64D0C598@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 24 Jan 2020 14:36:04 -0800
Message-ID: <CAPcyv4hFi+u5J5obO6sknjcgdpPbAfD=bQa4V+qd=q5K1-nXvw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:58 AM David Hildenbrand <david@redhat.com> wrote=
:
>
>
>
> > Am 24.01.2020 um 19:41 schrieb Dan Williams <dan.j.williams@intel.com>:
> >
> > =EF=BB=BFOn Fri, Jan 24, 2020 at 9:14 AM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >>> On 20.01.20 11:49, David Hildenbrand wrote:
> >>> We can have rare cases where the removal of a device races with
> >>> somebody trying to online it (esp. via sysfs). We can simply check
> >>> if the device is already removed or getting removed under the dev->lo=
ck.
> >>>
> >>> E.g., right now, if memory block devices are removed (remove_memory()=
),
> >>> we do a:
> >>>
> >>> remove_memory() -> lock_device_hotplug() -> mem_hotplug_begin() ->
> >>> lock_device() -> dev->dead =3D true
> >>>
> >>> Somebody coming via sysfs (/sys/devices/system/memory/memoryX/online)
> >>> triggers a:
> >>>
> >>> lock_device_hotplug_sysfs() -> device_online() -> lock_device() ...
> >>>
> >>> So if we made it just before the lock_device_hotplug_sysfs() but get
> >>> delayed until remove_memory() released all locks, we will continue
> >>> taking locks and trying to online the device - which is then a zombie
> >>> device.
> >>>
> >>> Note that at least the memory onlining path seems to be protected by
> >>> checking if all memory sections are still present (something we can t=
hen
> >>> get rid of). We do have other sysfs attributes
> >>> (e.g., /sys/devices/system/memory/memoryX/valid_zones) that don't do =
any
> >>> such locking yet and might race with memory removal in a similar way.=
 For
> >>> these users, we can then do a
> >>>
> >>> device_lock(dev);
> >>> if (!device_is_dead(dev)) {
> >>>      /* magic /*
> >>> }
> >>> device_unlock(dev);
> >>>
> >>> Introduce and use device_is_dead() right away.
> >>>
> >>
> >> So, I just added the following:
> >>
> >> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >> index 01cd06eeb513..49c4d8671073 100644
> >> --- a/drivers/base/core.c
> >> +++ b/drivers/base/core.c
> >> @@ -1567,6 +1567,7 @@ static ssize_t online_store(struct device *dev,
> >> struct device_attribute *attr,
> >>        if (ret < 0)
> >>                return ret;
> >>
> >> +       msleep(10000);
> >>        ret =3D lock_device_hotplug_sysfs();
> >>        if (ret)
> >>                return ret;
> >>
> >> Then triggered
> >>        echo 1 > /sys/devices/system/memory/memory51/online
> >> And quickly afterwards unplugged the DIMM.
> >>
> >> Good news is that we get (after 10 seconds)
> >>        sh: echo: write error: No such device
> >>
> >> Reason is that unplug will not finish before all sysfs attributes have
> >> been exited by other threads.
> >
> > The unplug thread gets blocked for 10 seconds waiting for this thread
> > in online_store() to exit?
> >
>
> Yes, that=E2=80=98s what I observed.

Nice. This obviously wasn't in my mental model of what sysfs/kernfs guarant=
eed.

/me digs a bit...

So it's kernfs_drain() that is saving us. That waits for all active
nodes to deactivate and that guarantees that removal can be used as a
barrier. It also indicates that the lockdep splat I saw can't trigger
a deadlock unless mem_hotplug_begin() is being acquired within a
memblock-sysfs ops handler that is trying to remove memory. In all
cases I can audit it's always a 3rd-party sysfs attribute triggering
that removal.

So, simply moving remove_memory_block_devices() outside of
mem_hotplug_begin() should be a sufficient fix, no other invalidation
data needed. I'll respin that fix.
