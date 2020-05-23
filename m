Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E75FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CB92072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQXHMmc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbgEWN3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbgEWN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:29:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A2C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:29:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so6494091pfb.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+FPFwRhltX4t06LDrX6KmQdYzDg4FvUett4kFw8QMc=;
        b=XQXHMmc7gB+7CSURak3ch6r32rYtwMiz6tDdwQWHmDqg4qwb2jnnrjgWPhRkTAT+kA
         BZVYzIY6CCbTTld7jPxtGmiuixqYDrzStoG7zjF0gRIcLXmNR5hBZ+MDAw8I5iuDnAZQ
         6WqJ3tjTK6ELc1efZybl+gWFj/R9GJMgTZlpgQ2hcBWV7YE9zLYghqIOll40ShVMrpvd
         7crmsLOxAcSqzF8nQEPGr5kXY4b2X60IxIywPFWH5ETJ4iW8Y8RnBe2EEqRE4gjgrIEL
         qfRQe6ctjNt25pXH6TsVZU/vQr1RjRnwTOW/FvwdcyunDqrSt/IPIeaCZnVp8QMTLMyn
         01yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+FPFwRhltX4t06LDrX6KmQdYzDg4FvUett4kFw8QMc=;
        b=GBpm6fn5L5Xl0iXc7D5t2DL8Rrqgql89T4wY42n2W/Vv3uGoNr/P4PdsScf2xOSnES
         U3WDIfYJF0qSUw/DFElFWzTMVCw7auSw5cHBN0sj0RvuJcFOc/inbpBcP8WC33UD/hZO
         bW/Fcz/2aqNwBo9AXlfCgQrADx2IIO7Vptd7SfxIkvN/AOwKLNgQZBlWVfiDTQ6V8yOy
         +DVm96duhzBfK+SLSMfnXe9YRT/L2hvyaLNhdKg5cL4oi+Sanl0mcXq8bIGnq90sOKpj
         YzBj3J8CGZbRsnNRFSfTuI+/d9moe/0Mm/DJz/8KTQj25bvBgXMMruKzCtEBZtPnm3CO
         1qVw==
X-Gm-Message-State: AOAM5324ZyH+4KtQ3Txa4zVf6SR1IDObaVXYEfqgDAsHB8lphZJBis/S
        9JO73C00ulGatMqcU9yyBO0=
X-Google-Smtp-Source: ABdhPJwF495plh/MV5k3gHb9bMijESPrzFOA3ejnBn0D9YBxHr3/G7Z8LVWn2Itg3Ok02YVHOVLZpQ==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr16484015pgf.405.1590240594614;
        Sat, 23 May 2020 06:29:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2sm8993591pfc.106.2020.05.23.06.29.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 May 2020 06:29:53 -0700 (PDT)
Date:   Sat, 23 May 2020 06:29:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200523132952.GA168554@roeck-us.net>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523132101.GA76443@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523132101.GA76443@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 06:21:01AM -0700, Guenter Roeck wrote:
> On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> > In the function kobject_cleanup(), kobject_del(kobj) is
> > called before the kobj->release(). That makes it possible to
> > release the parent of the kobject before the kobject itself.
> > 
> > To fix that, adding function __kboject_del() that does
> 
> s/kboject/kobject/
> 
> > everything that kobject_del() does except release the parent
> > reference. kobject_cleanup() then calls __kobject_del()
> > instead of kobject_del(), and separately decrements the
> > reference count of the parent kobject after kobj->release()
> > has been called.
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> All my arm64be (arm64 big endian) boot tests crash with this patch
> applied. Reverting it fixes the problem. Crash log and bisect results
> (from pending-fixes branch) below.
> 

arm64 images don't crash but report lots of "poison overwritten" backtraces
like the one below. On arm, I see "refcount_t: underflow", also attached.
I didn't bisect those, but given the context I would suspect the same
culprit.

Guenter

---
[   15.017361] =============================================================================
[   15.017561] BUG kmalloc-2k (Not tainted): Poison overwritten
[   15.017632] -----------------------------------------------------------------------------
[   15.017632]
[   15.017757] Disabling lock debugging due to kernel taint
[   15.017900] INFO: 0x(____ptrval____)-0x(____ptrval____) @offset=8272. First byte 0x6a instead of 0x6b
[   15.018039] INFO: Allocated in i2cdev_attach_adapter.part.10+0x44/0x180 age=18 cpu=0 pid=1
[   15.018122] 	__slab_alloc.isra.91+0x5c/0xc8
[   15.018182] 	kmem_cache_alloc_trace+0x228/0x248
[   15.018235] 	i2cdev_attach_adapter.part.10+0x44/0x180
[   15.018284] 	i2cdev_notifier_call+0x70/0x88
[   15.018329] 	notifier_call_chain+0x54/0x98
[   15.018372] 	blocking_notifier_call_chain+0x5c/0x80
[   15.018423] 	device_add+0x3bc/0x770
[   15.018462] 	device_register+0x20/0x30
[   15.018502] 	i2c_register_adapter+0xf0/0x400
[   15.018546] 	i2c_add_adapter+0x80/0xd8
[   15.018587] 	i2c_add_numbered_adapter+0x2c/0x38
[   15.018634] 	unittest_i2c_bus_probe+0x9c/0xf0
[   15.018679] 	platform_drv_probe+0x54/0xa8
[   15.018722] 	really_probe+0xd8/0x330
[   15.018762] 	driver_probe_device+0x58/0xf0
[   15.018805] 	device_driver_attach+0x74/0x80
[   15.018871] INFO: Freed in i2cdev_dev_release+0x14/0x20 age=4 cpu=0 pid=1
[   15.018933] 	kfree+0x3d0/0x3e0
[   15.018969] 	i2cdev_dev_release+0x14/0x20
[   15.019011] 	device_release+0x2c/0x88
[   15.019054] 	kobject_put+0x7c/0x138
[   15.019092] 	kobject_put+0x90/0x138
[   15.019133] 	cdev_del+0x2c/0x40
[   15.019169] 	cdev_device_del+0x40/0x50
[   15.019210] 	put_i2c_dev+0x94/0xb0
[   15.019248] 	i2cdev_detach_adapter.part.5+0x20/0x30
[   15.019296] 	i2cdev_notifier_call+0x80/0x88
[   15.019339] 	notifier_call_chain+0x54/0x98
[   15.019381] 	blocking_notifier_call_chain+0x5c/0x80
[   15.019428] 	device_del+0x84/0x3b0
[   15.019466] 	device_unregister+0x18/0x38
[   15.019508] 	i2c_del_adapter+0x1e8/0x240
[   15.019549] 	unittest_i2c_bus_remove+0x18/0x28
[   15.019632] INFO: Slab 0x(____ptrval____) objects=5 used=5 fp=0x0000000000000000 flags=0xffff00000010200
[   15.019717] INFO: Object 0x(____ptrval____) @offset=8192 fp=0x(____ptrval____)
[   15.019717]

---
[   22.415374] ### dt-test ### EXPECT / : i2c i2c-1: Added multiplexed i2c bus 3
[   22.419097] ------------[ cut here ]------------
[   22.419586] WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 i2cdev_notifier_call+0x54/0x5c
[   22.419708] refcount_t: underflow; use-after-free.
[   22.419860] Modules linked in:
[   22.420074] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6-00275-gdbacbfd47d67 #1
[   22.420227] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
[   22.420440] [<c03128e0>] (unwind_backtrace) from [<c030c900>] (show_stack+0x10/0x14)
[   22.420593] [<c030c900>] (show_stack) from [<c08c8df8>] (dump_stack+0xe0/0x10c)
[   22.420715] [<c08c8df8>] (dump_stack) from [<c0348380>] (__warn+0xf4/0x10c)
[   22.420867] [<c0348380>] (__warn) from [<c0348410>] (warn_slowpath_fmt+0x78/0xbc)
[   22.420989] [<c0348410>] (warn_slowpath_fmt) from [<c0eed4c8>] (i2cdev_notifier_call+0x54/0x5c)
[   22.421142] [<c0eed4c8>] (i2cdev_notifier_call) from [<c03745dc>] (notifier_call_chain+0x48/0x84)
[   22.421264] [<c03745dc>] (notifier_call_chain) from [<c0374dc0>] (blocking_notifier_call_chain+0x44/0x5c)
[   22.421386] [<c0374dc0>] (blocking_notifier_call_chain) from [<c0ba9c5c>] (device_del+0x80/0x3d4)
[   22.421508] [<c0ba9c5c>] (device_del) from [<c0ba9fbc>] (device_unregister+0xc/0x20)
[   22.421600] [<c0ba9fbc>] (device_unregister) from [<c0ee83d4>] (i2c_del_adapter+0x1ac/0x1f8)
[   22.421722] [<c0ee83d4>] (i2c_del_adapter) from [<c0eee888>] (i2c_mux_del_adapters+0x90/0xc8)
[   22.421874] [<c0eee888>] (i2c_mux_del_adapters) from [<c0fd4d50>] (unittest_i2c_mux_remove+0xc/0x14)
[   22.421997] [<c0fd4d50>] (unittest_i2c_mux_remove) from [<c0ee7b1c>] (i2c_device_remove+0x54/0xa8)
[   22.422119] [<c0ee7b1c>] (i2c_device_remove) from [<c0baea40>] (device_release_driver_internal+0xe8/0x1b8)
[   22.422241] [<c0baea40>] (device_release_driver_internal) from [<c0baeb6c>] (driver_detach+0x44/0x80)
[   22.422363] [<c0baeb6c>] (driver_detach) from [<c0bad6e4>] (bus_remove_driver+0x4c/0xa0)
[   22.422485] [<c0bad6e4>] (bus_remove_driver) from [<c1ca89e4>] (of_unittest_overlay+0xc90/0x11a8)
[   22.422576] [<c1ca89e4>] (of_unittest_overlay) from [<c1cab52c>] (of_unittest+0x24a0/0x2af0)
[   22.422698] [<c1cab52c>] (of_unittest) from [<c03022d4>] (do_one_initcall+0x8c/0x3bc)
[   22.422821] [<c03022d4>] (do_one_initcall) from [<c1c0103c>] (kernel_init_freeable+0x1a0/0x204)
[   22.422943] [<c1c0103c>] (kernel_init_freeable) from [<c11fe8c8>] (kernel_init+0x8/0x118)
[   22.423065] [<c11fe8c8>] (kernel_init) from [<c0300174>] (ret_from_fork+0x14/0x20)
[   22.423187] Exception stack(0xcb0bdfb0 to 0xcb0bdff8)
[   22.423339] dfa0:                                     00000000 00000000 00000000 00000000
[   22.423492] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   22.423645] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   22.423797] irq event stamp: 774333
[   22.423919] hardirqs last  enabled at (774341): [<c03c1ab0>] console_unlock+0x458/0x648
[   22.424011] hardirqs last disabled at (774348): [<c03c171c>] console_unlock+0xc4/0x648
[   22.424163] softirqs last  enabled at (774258): [<c0301664>] __do_softirq+0x3bc/0x5b4
[   22.424255] softirqs last disabled at (774235): [<c03519a4>] irq_exit+0x160/0x170
[   22.424377] ---[ end trace ae0b985481f6b675 ]---
