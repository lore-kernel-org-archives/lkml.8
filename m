Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3ADC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D522087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858758;
	bh=wW3JKCK5E8fpJXMYl9IbICwhzzTti/2W3Tk3h5Wj07E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vka9Yqi740lZ8CJk2ErSln2Dl84aVloCxEFaC5CT91Zpb4w0TxA6nOzPs1SX4NvfK
	 aw4hmVwcdkmEFKLpJfZzg3IWM5HQ69ZAZzbPZn6EmNvjmb7xuyyqOV6r9qbqk3zkg4
	 CnvQDpZjpXWAmpOAkKelKwa0khxRK2aBVeGXNN98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbgAXJjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:39:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41816 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbgAXJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:39:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so1031147otc.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiV1c6wrp94w+IHJVeAB9MSJJhCX1k8bVyzQM9PAZU0=;
        b=pchzY+3TjivETzxd8jhVPMcAwo9v121q36h6UWhV/C1UCB4L2tV04XWJPXyIkppn3i
         y11I7rjHncspMjgSNHCrxLwBZ/kjTeZ31QLabMjg2abni/4tzZAWKlWsyyWrot+/O75k
         aOP7K391ySa15JXofUhq+d/rC+fBdDon5dBbwBIedWZKBCqSbU6KjtT1/+69pyzyauXW
         /CD6q36C8AZnnxhTpHB4DQU8bbFqpLMOD9PSqyBCb7u4l3HNF8OsCVv0hSVn4UwxlcIk
         wRfr8cWmmDMOeQuQ51wkhCE9gxrAHka5SVAQ5HQzLX4Uwzcjliyc4gJRVZC8dC2pFoJh
         RUfA==
X-Gm-Message-State: APjAAAUbRyM+Yb8rHVifmV1rFncCy2FaeNuiGgmhpJG4D52gbH/18rHW
        YLSHd7CR21wajRkHK6A2Ug9eW1Iqafu4xrs63k8WJw==
X-Google-Smtp-Source: APXvYqwVtRSh0P5Y+CM+jxdNi08h9wIsY+nrQY5/l2/DgblmmCOL9JA68fv4cLDJadXXkjGORwiIIO6GnqX000Lljhs=
X-Received: by 2002:a05:6830:d5:: with SMTP id x21mr1725342oto.262.1579858744718;
 Fri, 24 Jan 2020 01:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20200120104909.13991-1-david@redhat.com> <20200124090052.GA2958140@kroah.com>
 <6dd0ea5a-e5c3-c4b6-2b2e-93537571d7d6@redhat.com>
In-Reply-To: <6dd0ea5a-e5c3-c4b6-2b2e-93537571d7d6@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Jan 2020 10:38:53 +0100
Message-ID: <CAJZ5v0iJJfTjZ6mZRDJSkZp+Cn1+VjFz=D8nLM15r6WtTRa88w@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: check for dead devices before onlining/offlining
To:     David Hildenbrand <david@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:09 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 24.01.20 10:00, Greg Kroah-Hartman wrote:
> > On Mon, Jan 20, 2020 at 11:49:09AM +0100, David Hildenbrand wrote:
> >> We can have rare cases where the removal of a device races with
> >> somebody trying to online it (esp. via sysfs). We can simply check
> >> if the device is already removed or getting removed under the dev->lock.
> >>
> >> E.g., right now, if memory block devices are removed (remove_memory()),
> >> we do a:
> >>
> >> remove_memory() -> lock_device_hotplug() -> mem_hotplug_begin() ->
> >> lock_device() -> dev->dead = true
> >>
> >> Somebody coming via sysfs (/sys/devices/system/memory/memoryX/online)
> >> triggers a:
> >>
> >> lock_device_hotplug_sysfs() -> device_online() -> lock_device() ...
> >>
> >> So if we made it just before the lock_device_hotplug_sysfs() but get
> >> delayed until remove_memory() released all locks, we will continue
> >> taking locks and trying to online the device - which is then a zombie
> >> device.
> >>
> >> Note that at least the memory onlining path seems to be protected by
> >> checking if all memory sections are still present (something we can then
> >> get rid of). We do have other sysfs attributes
> >> (e.g., /sys/devices/system/memory/memoryX/valid_zones) that don't do any
> >> such locking yet and might race with memory removal in a similar way. For
> >> these users, we can then do a
> >>
> >> device_lock(dev);
> >> if (!device_is_dead(dev)) {
> >>      /* magic /*
> >> }
> >> device_unlock(dev);
> >>
> >> Introduce and use device_is_dead() right away.
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Cc: Saravana Kannan <saravanak@google.com>
> >> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>
> >> Am I missing any obvious mechanism in the device core that handles
> >> something like this already? (especially also for other sysfs attributes?)
> >
> > So is a sysfs attribute causing the device itself to go away?  We have
>
> nope, removal is triggered via the driver, not via a sysfs attribute.
>
> Regarding this patch: Is there anything prohibiting the possible
> scenario I document above (IOW, is this patch applicable, or is there
> another way to fence it properly (e.g., the "specific call" you mentioned))?

For the devices that support online/offline (like CPUs in memory), the
idea is that calling device_del() on them while they are in use may
cause problems like data loss to occur and note that device_del()
itself cannot fail (because it needs to handle surprise removal too).
However, offline can fail, so the rule of thumb is to do the offline
(and handle the errors possibly returned by it) and only call
device_del() if that is successful.

Of course, if surprise removal is possible, offline is kind of
pointless, but if it is supported anyway it should return success when
the device is physically not present already.
