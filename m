Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B0AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532B8204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597681880;
	bh=LIxqRBPcvOoUtOkQW4c43VrIb8itUKAS0rSS5ci8yC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pe4tyQ/cm+yhO5HdE/t0U95mKTHFk3DSilFlUOHO99hus/Kh0/4z0EmJgvrkPYLAu
	 v9v/d33peqGNVsQGiZvHnIDQWNtIkynqR8BfbjWj34Dv4mEmJY88MHRWLRAWdMtQb2
	 YiO55Em9PtANzc7yO/cSrqdOIiD+5hpAOAMX5//c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgHQQbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387980AbgHQPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:54:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86D8F2245C;
        Mon, 17 Aug 2020 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679660;
        bh=LIxqRBPcvOoUtOkQW4c43VrIb8itUKAS0rSS5ci8yC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6mzhF5jEqDiO2ZVdoT6yJvgPlp3lzRQn0YB8avHUK4SbuxEjvB33J12ZXBXxZVaD
         XxZUzUNqEjj3GoQl0qAucmtHIO+2lz5y8jWjhORl9R4rtafvnsllRiypQOZe5xodN5
         tHqoF3odPdCyMiisLYyq9WZHi7NsiU5feG44gHFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 259/393] Bluetooth: Fix suspend notifier race
Date:   Mon, 17 Aug 2020 17:15:09 +0200
Message-Id: <20200817143832.174128402@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

[ Upstream commit 4e8c36c3b0d73d46aa27cfd4308aaa445a1067df ]

Unregister from suspend notifications and cancel suspend preparations
before running hci_dev_do_close. Otherwise, the suspend notifier may
race with unregister and cause cmd_timeout even after hdev has been
freed.

Below is the trace from when this panic was seen:

[  832.578518] Bluetooth: hci_core.c:hci_cmd_timeout() hci0: command 0x0c05 tx timeout
[  832.586200] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  832.586203] #PF: supervisor read access in kernel mode
[  832.586205] #PF: error_code(0x0000) - not-present page
[  832.586206] PGD 0 P4D 0
[  832.586210] PM: suspend exit
[  832.608870] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  832.613232] CPU: 3 PID: 10755 Comm: kworker/3:7 Not tainted 5.4.44-04894-g1e9dbb96a161 #1
[  832.630036] Workqueue: events hci_cmd_timeout [bluetooth]
[  832.630046] RIP: 0010:__queue_work+0xf0/0x374
[  832.630051] RSP: 0018:ffff9b5285f1fdf8 EFLAGS: 00010046
[  832.674033] RAX: ffff8a97681bac00 RBX: 0000000000000000 RCX: ffff8a976a000600
[  832.681162] RDX: 0000000000000000 RSI: 0000000000000009 RDI: ffff8a976a000748
[  832.688289] RBP: ffff9b5285f1fe38 R08: 0000000000000000 R09: ffff8a97681bac00
[  832.695418] R10: 0000000000000002 R11: ffff8a976a0006d8 R12: ffff8a9745107600
[  832.698045] usb 1-6: new full-speed USB device number 119 using xhci_hcd
[  832.702547] R13: ffff8a9673658850 R14: 0000000000000040 R15: 000000000000001e
[  832.702549] FS:  0000000000000000(0000) GS:ffff8a976af80000(0000) knlGS:0000000000000000
[  832.702550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  832.702550] CR2: 0000000000000000 CR3: 000000010415a000 CR4: 00000000003406e0
[  832.702551] Call Trace:
[  832.702558]  queue_work_on+0x3f/0x68
[  832.702562]  process_one_work+0x1db/0x396
[  832.747397]  worker_thread+0x216/0x375
[  832.751147]  kthread+0x138/0x140
[  832.754377]  ? pr_cont_work+0x58/0x58
[  832.758037]  ? kthread_blkcg+0x2e/0x2e
[  832.761787]  ret_from_fork+0x22/0x40
[  832.846191] ---[ end trace fa93f466da517212 ]---

Fixes: 9952d90ea2885 ("Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND")
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e5ecc2c9602d..c17e1a3e8218c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3597,9 +3597,10 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	cancel_work_sync(&hdev->power_on);
 
-	hci_dev_do_close(hdev);
-
 	unregister_pm_notifier(&hdev->suspend_notifier);
+	cancel_work_sync(&hdev->suspend_prepare);
+
+	hci_dev_do_close(hdev);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
 	    !hci_dev_test_flag(hdev, HCI_SETUP) &&
-- 
2.25.1



