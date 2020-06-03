Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E8AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8C42074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgFCSj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:39:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41243 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725821AbgFCSj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:39:27 -0400
Received: (qmail 26852 invoked by uid 1000); 3 Jun 2020 14:39:26 -0400
Date:   Wed, 3 Jun 2020 14:39:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     qiang.zhang@windriver.com
Cc:     gregkh@linuxfoundation.org, kt0755@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: usbtest: fix missing kfree(dev->buf) in
 usbtest_disconnect
Message-ID: <20200603183926.GA26504@rowland.harvard.edu>
References: <20200603030506.31577-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603030506.31577-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 11:05:06AM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
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
> 
> Fixes: fabbf2196d0d ("USB: usbtest fix coding style")

This patch doesn't really fix that commit.  In fact, it has nothing to 
do with that commit.  You shouldn't just put random commit IDs into your 
Changelog.

> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  drivers/usb/misc/usbtest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
> index 98ada1a3425c..bae88893ee8e 100644
> --- a/drivers/usb/misc/usbtest.c
> +++ b/drivers/usb/misc/usbtest.c
> @@ -2873,6 +2873,7 @@ static void usbtest_disconnect(struct usb_interface *intf)
>  
>  	usb_set_intfdata(intf, NULL);
>  	dev_dbg(&intf->dev, "disconnect\n");
> +	kfree(dev->buf);
>  	kfree(dev);
>  }
>  
> -- 
> 2.24.1

Aside from that one issue,

Acked-by: Alan Stern <stern@rowland.harvard.edu>
