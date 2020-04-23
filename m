Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA7C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77312075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va+AcBBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgDWFKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:10:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725863AbgDWFKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587618642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U40nhfdJJbB+Icncn6AK7VjEAKFmoP4SFbc4aKF2RZk=;
        b=Va+AcBBbklVhV29hXzgEH3qsstxUS3NfpQJuvixncj3sGAHiw4HMHI3LFSkvqAnRqujPmy
        C44idsWatfx+NoIau2FyqEm+B2oFI6pP5MpbQtFzOn0yx2SxaBMFI6bn/XcdVa+lkJ+kC1
        fIc+e8284ki5VOe5ONlEWpzSXn9C/Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-hEGdBmBdOcmc-jiBbwohhA-1; Thu, 23 Apr 2020 01:10:39 -0400
X-MC-Unique: hEGdBmBdOcmc-jiBbwohhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28EAE18C43C0;
        Thu, 23 Apr 2020 05:10:38 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-113-207.phx2.redhat.com [10.3.113.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 696EF5DA66;
        Thu, 23 Apr 2020 05:10:37 +0000 (UTC)
Date:   Thu, 23 Apr 2020 00:10:36 -0500
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, zaitcev@redhat.com
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
Message-ID: <20200423001036.41324bd4@suzdal.zaitcev.lan>
In-Reply-To: <20200422032323.8536-1-hdanton@sina.com>
References: <00000000000046503905a3cec366@google.com>
        <20200422032323.8536-1-hdanton@sina.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 11:23:23 +0800
Hillf Danton <hdanton@sina.com> wrote:

> Do cleanup for lp after submitted urb completes.
> 
> --- a/drivers/usb/class/usblp.c
> +++ b/drivers/usb/class/usblp.c
> @@ -1376,8 +1376,10 @@ static void usblp_disconnect(struct usb_
>  	usblp_unlink_urbs(usblp);
>  	mutex_unlock(&usblp->mut);
>  
> -	if (!usblp->used)
> +	if (!usblp->used) {
> +		wait_event(usblp->rwait, usblp->rcomplete != 0);
>  		usblp_cleanup(usblp);
> +	}
>  	mutex_unlock(&usblp_mutex);
>  }

I do not agree with this kind of workaround. The model we're following
is for usb_kill_urb() to cancel the transfer. The usblp invokes it
through usb_kill_anchored_urbs() and usblp_unlink_urbs(), as seen
above. There can be no timer hitting anything once it returns.

At this point I suspect the fake HCD that the test harness invokes
fails to termine the transfer properly and then a timer hits.

Here's the bot's evidence and how I read it:

> Tue, 21 Apr 2020 08:35:18 -0700
> > Reported-by: syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com

This is where the problem is tripped, notice that it comes
because gadget runs a timer:

> >  kasan_report+0xe/0x20 mm/kasan/common.c:641
> >  __lock_acquire+0x31af/0x3b60 kernel/locking/lockdep.c:3827
> >  lock_acquire+0x130/0x340 kernel/locking/lockdep.c:4484
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
> >  usblp_bulk_read+0x211/0x270 drivers/usb/class/usblp.c:303
> >  __usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1648
> >  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1713
> >  dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
> >  call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
> >  expire_timers kernel/time/timer.c:1449 [inline]
> >  __run_timers kernel/time/timer.c:1773 [inline]
> >  __run_timers kernel/time/timer.c:1740 [inline]

At this point the whole struct usblp is freed, including the
spinlock which we're trying to lock.

> > Allocated by task 3361:
> >  save_stack+0x1b/0x80 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  __kasan_kmalloc mm/kasan/common.c:515 [inline]
> >  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
> >  kmalloc include/linux/slab.h:555 [inline]
> >  kzalloc include/linux/slab.h:669 [inline]
> >  usblp_probe+0xed/0x1200 drivers/usb/class/usblp.c:1104
> >  usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
> >  really_probe+0x290/0xac0 drivers/base/dd.c:551
> >  driver_probe_device+0x223/0x350 drivers/base/dd.c:724

1104 is kzalloc for struct usblp.

> > Freed by task 12266:
> >  save_stack+0x1b/0x80 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  kasan_set_free_info mm/kasan/common.c:337 [inline]
> >  __kasan_slab_free+0x117/0x160 mm/kasan/common.c:476
> >  slab_free_hook mm/slub.c:1444 [inline]
> >  slab_free_freelist_hook mm/slub.c:1477 [inline]
> >  slab_free mm/slub.c:3034 [inline]
> >  kfree+0xd5/0x300 mm/slub.c:3995
> >  usblp_disconnect.cold+0x24/0x29 drivers/usb/class/usblp.c:1380
> >  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:436
> >  __device_release_driver drivers/base/dd.c:1137 [inline]
> >  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1168
> >  bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533

1380 is an inlined call to usblp_cleanup, which is just
a bunch of kfree.

The bug report is still a bug report, but I'm pretty sure the
culprit is the emulated HCD and/or the gadget layer. Unfortunately,
I'm not up to speed in that subsystem. Maybe Alan can look at it?

-- Pete

