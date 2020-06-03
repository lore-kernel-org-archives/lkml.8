Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4303FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2008D206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591168751;
	bh=mSICe9XPh8wNHseU/SsQKI1JdtwOoz/Og30hbCOZdrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=REafTsOMnlslnL54XME82TqdnEoI6lZ0GSX4EUN7TsAl9+4QfmZbdGAK4WGi6paPb
	 /x++0M7eJA4KMJCi+pC5ry2Yfv/T/rWSri0ZLG2Z2gPvbvzEM3w7LchcT0Yg2HgiOM
	 Zc3W4v159cmFeMsCToBv2MFOBJ3dmmUyjTjAXWSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgFCHTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCHTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:19:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65114207D3;
        Wed,  3 Jun 2020 07:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591168748;
        bh=mSICe9XPh8wNHseU/SsQKI1JdtwOoz/Og30hbCOZdrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftnFtIcK2o9TqiwntWRMZs0H1IHQVOwL4+vSbzTdsPxVYvkM8othvyN0XYHdAbd+Z
         qM0vjNV/BSCCB5hqJpg48gDCW6zOdutw2vaeFAvKGOvnrdyyBYBrS1RKJwu1y4RgCU
         FqEbDZkfL9EsD6MQGiZUjqbMwepLUIYAmG2u6+G4=
Date:   Wed, 3 Jun 2020 09:19:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: memory leak in usbtest_probe
Message-ID: <20200603071906.GC612108@kroah.com>
References: <CAEAjamut9BM4q1-EGAt-G9ef640aDvzAgnoaNtiNBdpYvfexag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamut9BM4q1-EGAt-G9ef640aDvzAgnoaNtiNBdpYvfexag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:36:22PM -0400, Kyungtae Kim wrote:
> We report a bug (in linux-5.6.11) found by FuzzUSB (a modified version
> of syzkaller)
> 
> The buf of an usbtest_dev instance (dev->buf) allocated in
> usbtest_probe() leaked.
> 
> The usbtest_dev instance holding the buf is attached to a
> corresponding device instance
> through usb_set_intfdata().
> But later, the usbtest_dev instance seems to be freed without
> deallocating its buf field ahead.
> 
> kernel config: https://kt0755.github.io/etc/config_v5.6.11
> 
> ==================================================================
> BUG: memory leak
> unreferenced object 0xffff888055046e00 (size 256):
>   comm "kworker/2:9", pid 2570, jiffies 4294942129 (age 1095.500s)
>   hex dump (first 32 bytes):
>     00 70 04 55 80 88 ff ff 18 bb 5a 81 ff ff ff ff  .p.U......Z.....
>     f5 96 78 81 ff ff ff ff 37 de 8e 81 ff ff ff ff  ..x.....7.......
>   backtrace:
>     [<00000000d121dccf>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:43 [inline]
>     [<00000000d121dccf>] slab_post_alloc_hook mm/slab.h:586 [inline]
>     [<00000000d121dccf>] slab_alloc_node mm/slub.c:2786 [inline]
>     [<00000000d121dccf>] slab_alloc mm/slub.c:2794 [inline]
>     [<00000000d121dccf>] kmem_cache_alloc_trace+0x15e/0x2d0 mm/slub.c:2811
>     [<000000005c3c3381>] kmalloc include/linux/slab.h:555 [inline]
>     [<000000005c3c3381>] usbtest_probe+0x286/0x19d0
> drivers/usb/misc/usbtest.c:2790
>     [<000000001cec6910>] usb_probe_interface+0x2bd/0x870
> drivers/usb/core/driver.c:361
>     [<000000007806c118>] really_probe+0x48d/0x8f0 drivers/base/dd.c:551
>     [<00000000a3308c3e>] driver_probe_device+0xfc/0x2a0 drivers/base/dd.c:724
>     [<000000003ef66004>] __device_attach_driver+0x1b6/0x240
> drivers/base/dd.c:831
>     [<00000000eee53e97>] bus_for_each_drv+0x14e/0x1e0 drivers/base/bus.c:431
>     [<00000000bb0648d0>] __device_attach+0x1f9/0x350 drivers/base/dd.c:897
>     [<00000000838b324a>] device_initial_probe+0x1a/0x20 drivers/base/dd.c:944
>     [<0000000030d501c1>] bus_probe_device+0x1e1/0x280 drivers/base/bus.c:491
>     [<000000005bd7adef>] device_add+0x131d/0x1c40 drivers/base/core.c:2504
>     [<00000000a0937814>] usb_set_configuration+0xe84/0x1ab0
> drivers/usb/core/message.c:2030
>     [<00000000e3934741>] generic_probe+0x6a/0xe0 drivers/usb/core/generic.c:210
>     [<0000000098ade0f1>] usb_probe_device+0x90/0xd0
> drivers/usb/core/driver.c:266
>     [<000000007806c118>] really_probe+0x48d/0x8f0 drivers/base/dd.c:551
>     [<00000000a3308c3e>] driver_probe_device+0xfc/0x2a0 drivers/base/dd.c:724
> ==================================================================


Can you send a patch to fix this so that you get full credit for
finding, and fixing the issue?

thanks,

greg k-h
