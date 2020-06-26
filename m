Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2177C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BA020E65
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgFZORC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:17:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgFZORC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:17:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9DD5AAE8;
        Fri, 26 Jun 2020 14:16:59 +0000 (UTC)
Received: from localhost (webern.olymp [local])
        by webern.olymp (OpenSMTPD) with ESMTPA id 986dd79c;
        Fri, 26 Jun 2020 15:16:58 +0100 (WEST)
Date:   Fri, 26 Jun 2020 15:16:58 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Lyude <lyude@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: Warning triggered in drm_dp_delayed_destroy_work workqueue
Message-ID: <20200626141658.GA23513@suse.de>
References: <20200625102221.GA66817@suse.de>
 <CAKMK7uECFfCTZc2wihY4ztZ0WiKR6foUEv2ScbJ79bqt6YQELQ@mail.gmail.com>
 <20200626140600.GA6112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626140600.GA6112@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 05:06:00PM +0300, Ville Syrjälä wrote:
> On Fri, Jun 26, 2020 at 03:40:20PM +0200, Daniel Vetter wrote:
> > Adding Lyude, she's been revamping all the lifetime refcouting in the
> > dp code last few kernel releases. At a glance I don't even have an
> > idea what's going wrong here ...
> 
> Already fixed by Imre I believe.
> 
> 7d11507605a7 ("drm/dp_mst: Fix the DDC I2C device unregistration of an MST port")
> 

Ah!  It does seems to be the same issue indeed!  Thanks a lot for pointing
me at this commit.  Hopefully this fix can be included in 5.8.  Not that
I'm seeing this WARNING frequently, but frequent enough to annoy me :-)

Cheers,
--
Luis

> > -Daniel
> > 
> > On Thu, Jun 25, 2020 at 12:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> > >
> > > Hi!
> > >
> > > I've been seeing this warning occasionally, not sure if it has been
> > > reported yet.  It's not a regression as I remember seeing it in, at least,
> > > 5.7.
> > >
> > > Anyway, here it is:
> > >
> > > ------------[ cut here ]------------
> > > sysfs group 'power' not found for kobject 'i2c-7'
> > > WARNING: CPU: 1 PID: 17996 at fs/sysfs/group.c:279 sysfs_remove_group+0x74/0x80
> > > Modules linked in: ccm(E) dell_rbtn(E) iwlmvm(E) mei_wdt(E) mac80211(E) libarc4(E) uvcvideo(E) dell_laptop(E) videobuf2_vmalloc(E) intel_rapl_>
> > >  soundcore(E) intel_soc_dts_iosf(E) rng_core(E) battery(E) acpi_pad(E) sparse_keymap(E) acpi_thermal_rel(E) intel_pch_thermal(E) int3402_therm>
> > >  sysfillrect(E) intel_lpss(E) sysimgblt(E) fb_sys_fops(E) idma64(E) scsi_mod(E) virt_dma(E) mfd_core(E) drm(E) fan(E) thermal(E) i2c_hid(E) hi>
> > > CPU: 1 PID: 17996 Comm: kworker/1:1 Tainted: G            E     5.8.0-rc2+ #36
> > > Hardware name: Dell Inc. Precision 5510/0N8J4R, BIOS 1.14.2 05/25/2020
> > > Workqueue: events drm_dp_delayed_destroy_work [drm_kms_helper]
> > > RIP: 0010:sysfs_remove_group+0x74/0x80
> > > Code: ff 5b 48 89 ef 5d 41 5c e9 79 bc ff ff 48 89 ef e8 01 b8 ff ff eb cc 49 8b 14 24 48 8b 33 48 c7 c7 90 ac 8b 93 e8 de b1 d4 ff <0f> 0b 5b>
> > > RSP: 0000:ffffb12d40c13c38 EFLAGS: 00010282
> > > RAX: 0000000000000000 RBX: ffffffff936e6a60 RCX: 0000000000000027
> > > RDX: 0000000000000027 RSI: 0000000000000086 RDI: ffff8e37de097b68
> > > RBP: 0000000000000000 R08: ffff8e37de097b60 R09: ffffffff93fb4624
> > > R10: 0000000000000904 R11: 000000000001002c R12: ffff8e37d3081c18
> > > R13: ffff8e375f1450a8 R14: 0000000000000000 R15: ffff8e375f145410
> > > FS:  0000000000000000(0000) GS:ffff8e37de080000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000000000000 CR3: 00000004ab20a001 CR4: 00000000003606e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  device_del+0x97/0x3f0
> > >  cdev_device_del+0x15/0x30
> > >  put_i2c_dev+0x7b/0x90 [i2c_dev]
> > >  i2cdev_detach_adapter+0x33/0x60 [i2c_dev]
> > >  notifier_call_chain+0x47/0x70
> > >  blocking_notifier_call_chain+0x3d/0x60
> > >  device_del+0x8f/0x3f0
> > >  device_unregister+0x16/0x60
> > >  i2c_del_adapter+0x247/0x300
> > >  drm_dp_port_set_pdt+0x90/0x2c0 [drm_kms_helper]
> > >  drm_dp_delayed_destroy_work+0x2be/0x340 [drm_kms_helper]
> > >  process_one_work+0x1ae/0x370
> > >  worker_thread+0x50/0x3a0
> > >  ? process_one_work+0x370/0x370
> > >  kthread+0x11b/0x140
> > >  ? kthread_associate_blkcg+0x90/0x90
> > >  ret_from_fork+0x22/0x30
> > > ---[ end trace 16486ad3c2627482 ]---
> > > ------------[ cut here ]------------
> > >
> > > Cheers,
> > > --
> > > Luis
> > 
> > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel

