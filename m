Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7260620709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579856458;
	bh=Hl4kEm4grSzZIXP2uT1VKvKMUMvMS1624hf5PeMeYUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T2un678AtOBQdbbgRLjqTrRwzDX1LLBvxCye7GI4GhnNYX3HEDLTG/aHGIt5/rX3Y
	 M3WO0mi+t48BuTluMZOzaOFXtqqKoeR/i5CGQ6rGmQfHvYMzZK9CAloDTTUcV2rs/A
	 c7utZlgqmgb4zv+6lDxxM462r3MENIruw0aSsUNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgAXJA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAXJA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:00:57 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA59D20702;
        Fri, 24 Jan 2020 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579856456;
        bh=Hl4kEm4grSzZIXP2uT1VKvKMUMvMS1624hf5PeMeYUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gpd/00s7q56kKB8rWf7TiUspunVnyDMWVE0KRtiv6D0/KPg+epV5l94A4kVhGr2cZ
         ZfJs+4moUKqyanNchL0aFDjTq8cb4DeoJZBa5o/hg7VeLv0nwLBxWW8BvFXWS3xEKn
         4S46RZe1TrwD/2g2TaecmO7bqTqL/Maph1gyfKJI=
Date:   Fri, 24 Jan 2020 10:00:52 +0100
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
Message-ID: <20200124090052.GA2958140@kroah.com>
References: <20200120104909.13991-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120104909.13991-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:49:09AM +0100, David Hildenbrand wrote:
> We can have rare cases where the removal of a device races with
> somebody trying to online it (esp. via sysfs). We can simply check
> if the device is already removed or getting removed under the dev->lock.
> 
> E.g., right now, if memory block devices are removed (remove_memory()),
> we do a:
> 
> remove_memory() -> lock_device_hotplug() -> mem_hotplug_begin() ->
> lock_device() -> dev->dead = true
> 
> Somebody coming via sysfs (/sys/devices/system/memory/memoryX/online)
> triggers a:
> 
> lock_device_hotplug_sysfs() -> device_online() -> lock_device() ...
> 
> So if we made it just before the lock_device_hotplug_sysfs() but get
> delayed until remove_memory() released all locks, we will continue
> taking locks and trying to online the device - which is then a zombie
> device.
> 
> Note that at least the memory onlining path seems to be protected by
> checking if all memory sections are still present (something we can then
> get rid of). We do have other sysfs attributes
> (e.g., /sys/devices/system/memory/memoryX/valid_zones) that don't do any
> such locking yet and might race with memory removal in a similar way. For
> these users, we can then do a
> 
> device_lock(dev);
> if (!device_is_dead(dev)) {
> 	/* magic /*
> }
> device_unlock(dev);
> 
> Introduce and use device_is_dead() right away.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Am I missing any obvious mechanism in the device core that handles
> something like this already? (especially also for other sysfs attributes?)

So is a sysfs attribute causing the device itself to go away?  We have
problems with that in the past, look at how the scsi layer handled it, I
think there's a specific call you should be making instead of trying to
rely on this "dead" flag.

thanks,

greg k-h
