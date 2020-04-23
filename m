Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BDC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F302077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgDWLNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgDWLNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B198B08C;
        Thu, 23 Apr 2020 11:13:47 +0000 (UTC)
Message-ID: <1587640413.23108.7.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
From:   Oliver Neukum <oneukum@suse.com>
To:     Pete Zaitcev <zaitcev@redhat.com>, Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 23 Apr 2020 13:13:33 +0200
In-Reply-To: <20200423001036.41324bd4@suzdal.zaitcev.lan>
References: <00000000000046503905a3cec366@google.com>
         <20200422032323.8536-1-hdanton@sina.com>
         <20200423001036.41324bd4@suzdal.zaitcev.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 23.04.2020, 00:10 -0500 schrieb Pete Zaitcev:
> 
> I do not agree with this kind of workaround. The model we're following
> is for usb_kill_urb() to cancel the transfer. The usblp invokes it
> through usb_kill_anchored_urbs() and usblp_unlink_urbs(), as seen
> above. There can be no timer hitting anything once it returns.

Right. It seems to me that the problem is not killing an existing
transfer but a failure to check in case of new transfers whether
the device has been disconnected.

> 1104 is kzalloc for struct usblp.
> 
> > > Freed by task 12266:
> > >  save_stack+0x1b/0x80 mm/kasan/common.c:72
> > >  set_track mm/kasan/common.c:80 [inline]
> > >  kasan_set_free_info mm/kasan/common.c:337 [inline]
> > >  __kasan_slab_free+0x117/0x160 mm/kasan/common.c:476
> > >  slab_free_hook mm/slub.c:1444 [inline]
> > >  slab_free_freelist_hook mm/slub.c:1477 [inline]
> > >  slab_free mm/slub.c:3034 [inline]
> > >  kfree+0xd5/0x300 mm/slub.c:3995
> > >  usblp_disconnect.cold+0x24/0x29 drivers/usb/class/usblp.c:1380
> > >  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:436
> > >  __device_release_driver drivers/base/dd.c:1137 [inline]
> > >  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1168
> > >  bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
> 
> 1380 is an inlined call to usblp_cleanup, which is just
> a bunch of kfree.

But that must never happen while while the device is open.
If that ever happens something is wrong with usblp->used.

> The bug report is still a bug report, but I'm pretty sure the
> culprit is the emulated HCD and/or the gadget layer. Unfortunately,
> I'm not up to speed in that subsystem. Maybe Alan can look at it?

I doubt it. Operation by a timer triggering a timeout must work.

	Regards
		Oliver


