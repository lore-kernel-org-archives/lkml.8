Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ACAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5F207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590755429;
	bh=rp2b8rWaD3B9YlhcDDtcfPJDfthWSHlXIfqwbA4J2mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qYJPSEGFuThtYVFh9ywqn2AaypEg84DwzXapE7kBLBHoM9084OMxFMmvz5I21KiHS
	 izUZMZRVV/aeH7tztps3JGECRvdhMMLq3PNtd2A2/VI89fPGmiYH2q7Z6JIiKkR5xj
	 jumzyn+zmfzShbap1zHsBMYkTGKGYIAq4fPtVKpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgE2Ma2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgE2Ma2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:30:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 170BE206E2;
        Fri, 29 May 2020 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590755427;
        bh=rp2b8rWaD3B9YlhcDDtcfPJDfthWSHlXIfqwbA4J2mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IW85YkPfDOytODuyVvF5uGzi+PcUOgUwF4SPceFv7a4blGFfhuLKzzsm6a2Oulwen
         EESmw/UOKGXHy4qwXGFtZv0Ma8bMNKZydX8eHXUHo5MUY5ay10qAL8Oj6EFVZDHtFk
         aHh2M+wG8csug7wy1ZUzgmfbkMnXZXEMeY6U4u/c=
Date:   Fri, 29 May 2020 14:30:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
Message-ID: <20200529123025.GA1710508@kroah.com>
References: <20200521191800.136035-1-saravanak@google.com>
 <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 02:18:23PM -0700, Saravana Kannan wrote:
> On Thu, May 21, 2020 at 12:18 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > With fw_devlink and with sync_state() callback features, there's a lot
> > of device/device link related information that's not available in sysfs.
> >
> > Exposing these details to user space can be very useful in understanding
> > suspend/resume issues, runtime pm issues, probing issues, figuring out
> > the modules that'd be needed for first stage init, etc. In fact, an
> > earlier verion of this series was very helpful in debugging and
> > validating the recent memory leak fix[1].
> >
> > This series is based on driver-core-next and [1] cherry-picked on top of
> > it.
> >
> > [1] - https://lore.kernel.org/lkml/20200519063000.128819-1-saravanak@google.com/
> >
> > v1->v2:
> > Patch 1/4
> > - New patch
> > Patch 2/4
> > - Fixed the warnings I saw before that were related to incorrect
> >   sysfs removal code when a device link is deleted.
> > - Fixed error handling in device_link_add()
> > - Split up flags into more meaningful files.
> > - Added status file.
> > Patch 3/4
> > - Fixed error handling that Greg pointed out before.
> > Patch 4/4
> > - New patch
> >
> > v2->v3:
> > - Dropped patch 1/4 from v2 since it was already picked up. So numbering
> >   has shifted.
> > Patch 1/3
> > - Added documentation
> >
> > Saravana Kannan (3):
> >   driver core: Expose device link details in sysfs
> >   driver core: Add state_synced sysfs file for devices that support it
> >   driver core: Add waiting_for_supplier sysfs file for devices
> >
> >  Documentation/ABI/testing/sysfs-class-devlink | 126 ++++++++++
> >  .../ABI/testing/sysfs-devices-consumer        |   8 +
> >  .../ABI/testing/sysfs-devices-state_synced    |  24 ++
> >  .../ABI/testing/sysfs-devices-supplier        |   8 +
> >  .../sysfs-devices-waiting_for_supplier        |  17 ++
> >  drivers/base/core.c                           | 237 +++++++++++++++++-
> >  drivers/base/dd.c                             |  22 ++
> >  include/linux/device.h                        |  58 ++---
> >  8 files changed, 464 insertions(+), 36 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-devlink
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-consumer
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-supplier
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-waiting_for_supplier
> 
> Friendly reminder.

Looks semi-sane, but it's too close to the merge window at the moment
for me to take this.  If there's no objections by the time 5.8-rc1 is
out, I'll queue it up in my tree for 5.9-rc1.

thanks,

greg k-h
