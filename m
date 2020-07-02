Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F6BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71A5214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653226;
	bh=8lDwIAjwoJzdRpd1GRXHOuW1Z9xpybbkr+0s/hLXxP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGBnkI5Vzuyn5GRJ2BRVrBYNSqsHzf3Vs4wbeiDeO0sZA2OHz2QN+53jZlV2lTCxb
	 otZ7Fn4D/0cFM9UtBVpNZ1mrIRcXBjLQqOuGN4hBw1KKFhZ3oruHYgb5zzYZ45DWgB
	 2jhbsZ7unxD4Dr7Nnp/m0LjNgnpwrq6jdAkjQFbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgGBB1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgGBB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 803F720899;
        Thu,  2 Jul 2020 01:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653184;
        bh=8lDwIAjwoJzdRpd1GRXHOuW1Z9xpybbkr+0s/hLXxP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQhcN9PYeU3FVw4/5wmAVaNkrk7kjrMY9IfJ1o0WwufcBe6uLl/N3fdJV5vPoHZHH
         eAvYrIhSgnR8rVBOPTi4dgBRo5FUQbRWfrgGU/j8qdmWtIwosZz9j4gtVFUng1jM8e
         Fohcr4s5tTnSZlvRs4J27Y8zk4D74qpvNQ2Z0ZyI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zqiang <qiang.zhang@windriver.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kyungtae Kim <kt0755@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/27] usb: usbtest: fix missing kfree(dev->buf) in usbtest_disconnect
Date:   Wed,  1 Jul 2020 21:25:55 -0400
Message-Id: <20200702012615.2701532-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012615.2701532-1-sashal@kernel.org>
References: <20200702012615.2701532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

[ Upstream commit 28ebeb8db77035e058a510ce9bd17c2b9a009dba ]

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

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Kyungtae Kim <kt0755@gmail.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Link: https://lore.kernel.org/r/20200612035210.20494-1-qiang.zhang@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/usbtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index c7f82310e73ec..fc3fc9d48a553 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -2853,6 +2853,7 @@ static void usbtest_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 	dev_dbg(&intf->dev, "disconnect\n");
+	kfree(dev->buf);
 	kfree(dev);
 }
 
-- 
2.25.1

