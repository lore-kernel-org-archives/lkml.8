Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C23C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FE021744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8RR31Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDSNTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:19:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725905AbgDSNTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587302360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GOqxiV3atL/IAOKyuTTc32sUymZemGTCv2nV26Qy1pM=;
        b=L8RR31BmUDzIVaPBGwE3LMdk8p4U8WtOlvLUeILSFqNkuWHFiuy4xw0Dm8rL5v5E/cx/jL
        C5siff5p26gg7YiDbJT1jfmq/oOQBRM9mtMXHZrmJl091JBC7u/bYCYCo0bvBj4OcxqTe3
        ZVc7LKyG6b+i9YtnAFwmQE9hhMpw5dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-adhVtCVcNM2NpoPUesEXzw-1; Sun, 19 Apr 2020 09:19:14 -0400
X-MC-Unique: adhVtCVcNM2NpoPUesEXzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C983DB20;
        Sun, 19 Apr 2020 13:19:13 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A9D210027AD;
        Sun, 19 Apr 2020 13:19:10 +0000 (UTC)
Date:   Sun, 19 Apr 2020 09:19:09 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Paul Wise <pabs3@bonedaddy.net>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dm raid/raid1: enable discard support when any
 devices support discard
Message-ID: <20200419131908.GA22398@redhat.com>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419073026.197967-1-pabs3@bonedaddy.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19 2020 at  3:30am -0400,
Paul Wise <pabs3@bonedaddy.net> wrote:

> This makes dm raid and dm raid1 (mirroring) consistent with md raid,
> which supports discard when only some of the devices support discard.
> 
> Another patch will be needed to fix the queue discard limits sysfs files,
> fixing `fstrim --fstab`, but these patches suffice to fix `fstrim /` and
> I haven't finished figuring out how the queue discard limits are set yet.
> 
> Paul Wise (3):
>   dm: add support for targets that allow discard when one device does
>   dm raid: only check for RAID 4/5/6 once during discard support setup
>   dm raid/raid1: enable discard support when any devices support discard
> 
>  drivers/md/dm-cache-target.c  |  2 +-
>  drivers/md/dm-clone-target.c  |  2 +-
>  drivers/md/dm-log-writes.c    |  2 +-
>  drivers/md/dm-raid.c          | 21 ++++++++++-----------
>  drivers/md/dm-raid1.c         |  1 +
>  drivers/md/dm-table.c         | 32 +++++++++++++++++++++-----------
>  drivers/md/dm-thin.c          |  8 ++++----
>  drivers/md/dm-zoned-target.c  |  2 +-
>  include/linux/device-mapper.h | 13 ++++++++-----
>  include/uapi/linux/dm-ioctl.h |  4 ++--
>  10 files changed, 50 insertions(+), 37 deletions(-)

You went overboard with implementation before checking to see if your
work would be well received.  Your 2/3 patch header shows you're
capable of analyzing past commits to explain the evolution of code,
etc.  But yet you make no mention of this commit header which explicitly
speaks to why what you're proposing is _not_ acceptable:

commit 8a74d29d541cd86569139c6f3f44b2d210458071
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Tue Nov 14 15:40:52 2017 -0500

    dm: discard support requires all targets in a table support discards

    A DM device with a mix of discard capabilities (due to some underlying
    devices not having discard support) _should_ just return -EOPNOTSUPP for
    the region of the device that doesn't support discards (even if only by
    way of the underlying driver formally not supporting discards).  BUT,
    that does ask the underlying driver to handle something that it never
    advertised support for.  In doing so we're exposing users to the
    potential for a underlying disk driver hanging if/when a discard is
    issued a the device that is incapable and never claimed to support
    discards.

    Fix this by requiring that each DM target in a DM table provide discard
    support as a prereq for a DM device to advertise support for discards.

    This may cause some configurations that were happily supporting discards
    (even in the face of a mix of discard support) to stop supporting
    discards -- but the risk of users hitting driver hangs, and forced
    reboots, outweighs supporting those fringe mixed discard
    configurations.

    Cc: stable@vger.kernel.org
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>

I haven't looked closely at MD raid in this area but if you trully think
underlying MD raid can cope with issuing discards to devices that don't
support them (or that it avoids issuing them?) then please update
dm-raid.c to conditionally set ti->discard_supported (if not all devices
support discard).  That is how to inform DM core that the target knows
better and it will manage discards issued to it.  It keeps the change
local to dm-raid.c without the flag-day you're proposing.

Mike

