Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7EAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450B020757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbgDCGld convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:41:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48113 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388006AbgDCGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:41:32 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 133C4CECF9;
        Fri,  3 Apr 2020 08:51:05 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] bluetooth: hci_bcm: fix freeing not-requested IRQ
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b46b003a5984d1f178a851a5bb2f3463d695f199.1585831987.git.mirq-linux@rere.qmqm.pl>
Date:   Fri, 3 Apr 2020 08:41:31 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8D205F06-4D72-4FD0-AB49-BDFCDADAB9A1@holtmann.org>
References: <d01cfc2df21f016ef6c790e1ed8f3ed933cf5ad3.1585831987.git.mirq-linux@rere.qmqm.pl>
 <b46b003a5984d1f178a851a5bb2f3463d695f199.1585831987.git.mirq-linux@rere.qmqm.pl>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

> When BT module can't be initialized, but it has an IRQ, unloading
> the driver WARNs when trying to free not-yet-requested IRQ. Fix it by
> noting whether the IRQ was requested.
> 
> WARNING: CPU: 2 PID: 214 at kernel/irq/devres.c:144 devm_free_irq+0x49/0x4ca
> [...]
> WARNING: CPU: 2 PID: 214 at kernel/irq/manage.c:1746 __free_irq+0x8b/0x27c
> Trying to free already-free IRQ 264
> Modules linked in: hci_uart(-) btbcm bluetooth ecdh_generic ecc libaes
> CPU: 2 PID: 214 Comm: rmmod Tainted: G        W         5.6.1mq-00044-ga5f9ea098318-dirty #928
> [...]
> [<b016aefb>] (devm_free_irq) from [<af8ba1ff>] (bcm_close+0x97/0x118 [hci_uart])
> [<af8ba1ff>] (bcm_close [hci_uart]) from [<af8b736f>] (hci_uart_unregister_device+0x33/0x3c [hci_uart])
> [<af8b736f>] (hci_uart_unregister_device [hci_uart]) from [<b035930b>] (serdev_drv_remove+0x13/0x20)
> [<b035930b>] (serdev_drv_remove) from [<b037093b>] (device_release_driver_internal+0x97/0x118)
> [<b037093b>] (device_release_driver_internal) from [<b0370a0b>] (driver_detach+0x2f/0x58)
> [<b0370a0b>] (driver_detach) from [<b036f855>] (bus_remove_driver+0x41/0x94)
> [<b036f855>] (bus_remove_driver) from [<af8ba8db>] (bcm_deinit+0x1b/0x740 [hci_uart])
> [<af8ba8db>] (bcm_deinit [hci_uart]) from [<af8ba86f>] (hci_uart_exit+0x13/0x30 [hci_uart])
> [<af8ba86f>] (hci_uart_exit [hci_uart]) from [<b01900bd>] (sys_delete_module+0x109/0x1d0)
> [<b01900bd>] (sys_delete_module) from [<b0101001>] (ret_fast_syscall+0x1/0x5a)
> [...]
> 
> Cc: stable@vger.kernel.org
> Fixes: 6cc4396c8829 ("Bluetooth: hci_bcm: Add wake-up capability")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> drivers/bluetooth/hci_bcm.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

