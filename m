Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99467C2D0F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ADD20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ohDWv12O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbgDBMzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:55:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36702 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388332AbgDBMzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:55:22 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tNMX2ZGMzHd;
        Thu,  2 Apr 2020 14:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585832120; bh=aHNL2/KGosIZfGJPSq9g/S4QzmyubMu5Xs648XxruJc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ohDWv12OW4HTE/v/HtsqOo6NnyHs6wGqLl67g90OAPnO3DtNMJaQV4A/tqfF9NEK1
         FiIbJo2Nl6lgWEaaTnO6+8U/gsGO5j4AWjFNSNfIRd29i1xPfGHGde+7lruqTPkJx3
         hmpPnGu8+vxYm1rGken0Db2EEeDRTq1F83A464OR1Ik5m8T3XApsGi6O9dzxNrVcUn
         ll2ldbozsXqtNk6GvRx9Rim3E1EO1LzyoOnIZVr2088l0EyJIlodVOloRYuqbe/qKn
         L6PSjhOs8sT0jySDjXLD41Ja8srlhgJpjXqsfDvoqEBNrogsapwKExXHd+wz3Ugppo
         mOH8UuKKVSlpQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 14:55:20 +0200
Message-Id: <b46b003a5984d1f178a851a5bb2f3463d695f199.1585831987.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <d01cfc2df21f016ef6c790e1ed8f3ed933cf5ad3.1585831987.git.mirq-linux@rere.qmqm.pl>
References: <d01cfc2df21f016ef6c790e1ed8f3ed933cf5ad3.1585831987.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] bluetooth: hci_bcm: fix freeing not-requested IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When BT module can't be initialized, but it has an IRQ, unloading
the driver WARNs when trying to free not-yet-requested IRQ. Fix it by
noting whether the IRQ was requested.

WARNING: CPU: 2 PID: 214 at kernel/irq/devres.c:144 devm_free_irq+0x49/0x4ca
[...]
WARNING: CPU: 2 PID: 214 at kernel/irq/manage.c:1746 __free_irq+0x8b/0x27c
Trying to free already-free IRQ 264
Modules linked in: hci_uart(-) btbcm bluetooth ecdh_generic ecc libaes
CPU: 2 PID: 214 Comm: rmmod Tainted: G        W         5.6.1mq-00044-ga5f9ea098318-dirty #928
[...]
[<b016aefb>] (devm_free_irq) from [<af8ba1ff>] (bcm_close+0x97/0x118 [hci_uart])
[<af8ba1ff>] (bcm_close [hci_uart]) from [<af8b736f>] (hci_uart_unregister_device+0x33/0x3c [hci_uart])
[<af8b736f>] (hci_uart_unregister_device [hci_uart]) from [<b035930b>] (serdev_drv_remove+0x13/0x20)
[<b035930b>] (serdev_drv_remove) from [<b037093b>] (device_release_driver_internal+0x97/0x118)
[<b037093b>] (device_release_driver_internal) from [<b0370a0b>] (driver_detach+0x2f/0x58)
[<b0370a0b>] (driver_detach) from [<b036f855>] (bus_remove_driver+0x41/0x94)
[<b036f855>] (bus_remove_driver) from [<af8ba8db>] (bcm_deinit+0x1b/0x740 [hci_uart])
[<af8ba8db>] (bcm_deinit [hci_uart]) from [<af8ba86f>] (hci_uart_exit+0x13/0x30 [hci_uart])
[<af8ba86f>] (hci_uart_exit [hci_uart]) from [<b01900bd>] (sys_delete_module+0x109/0x1d0)
[<b01900bd>] (sys_delete_module) from [<b0101001>] (ret_fast_syscall+0x1/0x5a)
[...]

Cc: stable@vger.kernel.org
Fixes: 6cc4396c8829 ("Bluetooth: hci_bcm: Add wake-up capability")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/bluetooth/hci_bcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 36b7f0d00c4b..19e4587f366c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -118,6 +118,7 @@ struct bcm_device {
 	u32			oper_speed;
 	int			irq;
 	bool			irq_active_low;
+	bool			irq_acquired;
 
 #ifdef CONFIG_PM
 	struct hci_uart		*hu;
@@ -333,6 +334,8 @@ static int bcm_request_irq(struct bcm_data *bcm)
 		goto unlock;
 	}
 
+	bdev->irq_acquired = true;
+
 	device_init_wakeup(bdev->dev, true);
 
 	pm_runtime_set_autosuspend_delay(bdev->dev,
@@ -514,7 +517,7 @@ static int bcm_close(struct hci_uart *hu)
 	}
 
 	if (bdev) {
-		if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0) {
+		if (IS_ENABLED(CONFIG_PM) && bdev->irq_acquired) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 			pm_runtime_disable(bdev->dev);
-- 
2.20.1

