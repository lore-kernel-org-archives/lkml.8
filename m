Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8927C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90814206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFfVnD4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgFBUgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgFBUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:36:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E3C08C5C0;
        Tue,  2 Jun 2020 13:36:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so14280965ljn.4;
        Tue, 02 Jun 2020 13:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/6WN4wkCmG7SU9YaUC+sl2e2YPCsY4XAbfPevLlAGZA=;
        b=qFfVnD4uwQATrddMqS75/jMaK6yDvM0UIo6dFaBSv8BnTdJHZHescduFSARi1oUhBl
         aaKyC3Shiz6nf3zuLL8cqQzlPz/GIwCsYCILAdhsjcg9Vs0h0gWoeU70lc/xRX9uIpXF
         C7qEDlBtxHbkQ6jjHT6pxeIjDoBoF7O1Ab1YHkHmOqR8JMdnUG/75d4IuClf5z3Ixg1I
         hYDRfi5AWSBhOCbc1OnzMby03n0ac0b8AWZMGhh5oYhWtYa/aWghoph43pr0wZWGt4UU
         pwcFHAn9YM6Sz3/cOmcCaAAa48pHFK4Ogwy1vjBA2xhJh0haDIZmlD49pfb/9Xl8CiqD
         Jsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/6WN4wkCmG7SU9YaUC+sl2e2YPCsY4XAbfPevLlAGZA=;
        b=EvkHmMH5p8gIiptCPBLNcm17kMCPujW0DD60Ukgm+jAJO0Ao+f8Ez3YJxOZV2Q6Tws
         TxUBWPbCHFtiMhvk+BhLJg6ZSd8k5Saa3AmKZquRIVaXhfsfY1Ix6th75FTrIU7rZ85w
         7E1jAggdYvCJ6r2jnU3SOZRyPa25LW9dLPoEkSIkXNv/4Yxp2vhrOwyov5ijZyn/jIcm
         wqk7K5oeJnO1b/6VojmU2xl1lXymDz50R6EBJ1rmPg4/ZlXsHcNHmqzVYvc1Mm+WWLu2
         op2BmJpIn9pD6CeU0WuE0/XyGnIeELZ0IltCxHedE3MZMZngKttUvS4BE8koazjGKAEn
         +cfw==
X-Gm-Message-State: AOAM530k8WLDCH7jV7Cl740yYzdZ/AFJWc+cyUghV13KlFB66s7PlXUz
        81I6n5WO2zO3wfDmf88RrpbZcc1+jFnJmyYvPX8LbamD7/4=
X-Google-Smtp-Source: ABdhPJyHbROa60FqjVXQ22VDCg1ms51met8akvI1qNhBQjCmHsBvksYwZCE8Z+GXG/az795mNHKAejrS7L+j7ry+4Z8=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr443201ljj.270.1591130193295;
 Tue, 02 Jun 2020 13:36:33 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 2 Jun 2020 16:36:22 -0400
Message-ID: <CAEAjamut9BM4q1-EGAt-G9ef640aDvzAgnoaNtiNBdpYvfexag@mail.gmail.com>
Subject: memory leak in usbtest_probe
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dave Tian <dave.jing.tian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.6.11) found by FuzzUSB (a modified version
of syzkaller)

The buf of an usbtest_dev instance (dev->buf) allocated in
usbtest_probe() leaked.

The usbtest_dev instance holding the buf is attached to a
corresponding device instance
through usb_set_intfdata().
But later, the usbtest_dev instance seems to be freed without
deallocating its buf field ahead.

kernel config: https://kt0755.github.io/etc/config_v5.6.11

==================================================================
BUG: memory leak
unreferenced object 0xffff888055046e00 (size 256):
  comm "kworker/2:9", pid 2570, jiffies 4294942129 (age 1095.500s)
  hex dump (first 32 bytes):
    00 70 04 55 80 88 ff ff 18 bb 5a 81 ff ff ff ff  .p.U......Z.....
    f5 96 78 81 ff ff ff ff 37 de 8e 81 ff ff ff ff  ..x.....7.......
  backtrace:
    [<00000000d121dccf>] kmemleak_alloc_recursive
include/linux/kmemleak.h:43 [inline]
    [<00000000d121dccf>] slab_post_alloc_hook mm/slab.h:586 [inline]
    [<00000000d121dccf>] slab_alloc_node mm/slub.c:2786 [inline]
    [<00000000d121dccf>] slab_alloc mm/slub.c:2794 [inline]
    [<00000000d121dccf>] kmem_cache_alloc_trace+0x15e/0x2d0 mm/slub.c:2811
    [<000000005c3c3381>] kmalloc include/linux/slab.h:555 [inline]
    [<000000005c3c3381>] usbtest_probe+0x286/0x19d0
drivers/usb/misc/usbtest.c:2790
    [<000000001cec6910>] usb_probe_interface+0x2bd/0x870
drivers/usb/core/driver.c:361
    [<000000007806c118>] really_probe+0x48d/0x8f0 drivers/base/dd.c:551
    [<00000000a3308c3e>] driver_probe_device+0xfc/0x2a0 drivers/base/dd.c:724
    [<000000003ef66004>] __device_attach_driver+0x1b6/0x240
drivers/base/dd.c:831
    [<00000000eee53e97>] bus_for_each_drv+0x14e/0x1e0 drivers/base/bus.c:431
    [<00000000bb0648d0>] __device_attach+0x1f9/0x350 drivers/base/dd.c:897
    [<00000000838b324a>] device_initial_probe+0x1a/0x20 drivers/base/dd.c:944
    [<0000000030d501c1>] bus_probe_device+0x1e1/0x280 drivers/base/bus.c:491
    [<000000005bd7adef>] device_add+0x131d/0x1c40 drivers/base/core.c:2504
    [<00000000a0937814>] usb_set_configuration+0xe84/0x1ab0
drivers/usb/core/message.c:2030
    [<00000000e3934741>] generic_probe+0x6a/0xe0 drivers/usb/core/generic.c:210
    [<0000000098ade0f1>] usb_probe_device+0x90/0xd0
drivers/usb/core/driver.c:266
    [<000000007806c118>] really_probe+0x48d/0x8f0 drivers/base/dd.c:551
    [<00000000a3308c3e>] driver_probe_device+0xfc/0x2a0 drivers/base/dd.c:724
==================================================================
