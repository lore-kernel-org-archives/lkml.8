Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64037C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FA20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579857148;
	bh=Fq3+zx0s5V/xStBZnry+GHegrfjY2pcIunqVZ90V2FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PyILEhlAGLelGzHoLhaqve1uoO9kundsQ4exzsm1ULukIkTjBlCLghA5MAH/MUCpd
	 GBc0S1Sd+ZR60UjEQrJ/CgnKi2rKJohDpDP0Q9HfGnRtI9ix3UW0keZU3Y5ZrLaS7A
	 fPyoxb1Z2iOXR8Qj5Iu38HN4xZ2fipUgOMsmEuCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgAXJM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbgAXJM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:12:26 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1352071A;
        Fri, 24 Jan 2020 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579857145;
        bh=Fq3+zx0s5V/xStBZnry+GHegrfjY2pcIunqVZ90V2FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqfEhZdTRH4XPf+z7sgCiEElcRguEOhF1VxASnhOqtPJY2AdxujmpwxkBBofpcuc7
         UmHMgz0x1dV+UW9OIKYGz9EmfWX9B8KOOJPmyM8hoOwvkGt94H0f+YH1WtSOYIfXSJ
         5dGaTmHpjzoDQb+9SrFM1cJWb+q2briq/jTOqeI4=
Date:   Fri, 24 Jan 2020 10:12:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1] driver core: check for dead devices before
 onlining/offlining
Message-ID: <20200124091221.GA2983380@kroah.com>
References: <20200120104909.13991-1-david@redhat.com>
 <20200124090052.GA2958140@kroah.com>
 <6dd0ea5a-e5c3-c4b6-2b2e-93537571d7d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd0ea5a-e5c3-c4b6-2b2e-93537571d7d6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:09:03AM +0100, David Hildenbrand wrote:
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
> >> 	/* magic /*
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

But the idea is the same, it comes from the driver, not the driver core.

> Regarding this patch: Is there anything prohibiting the possible
> scenario I document above (IOW, is this patch applicable, or is there
> another way to fence it properly (e.g., the "specific call" you mentioned))?

I think it's the same thing, look at how scsi does it.

thanks,

greg k-h
