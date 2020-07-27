Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5DDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8763520809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjyHM/wY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgG0VW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0VWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:22:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467FCC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:22:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so10688119pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utU3ypLjQOA4QshSQAJBKI2d0qo7ScTec5y8sMLYM0s=;
        b=fjyHM/wYzqCrthuAjiCo7Q8zcYcjLGiRwhJ9AljY6LotLvI/TAxBVCdeEe8o82dTpu
         tAQph9QJ9ehJ+T+sZ50ioIJNGYQLk/rmG7SS6tiJG87XqLQzDfo7o5TzX6VpcTPqW1E3
         kU68mv5gn2cE+FeTMwF5kOkLrUOCCS0svLBeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utU3ypLjQOA4QshSQAJBKI2d0qo7ScTec5y8sMLYM0s=;
        b=I5w7OaqefUIb1BAzFXvQ3m4KVS5rVgoczlnCXZgRMHZ2Wl1CVQBDQrV6Z2qDac6V4k
         pyWMFJRpGHx2Wj/1j797LLtT7A8Rc5XHU11qAG2UyxZDN8Gsy7pUTddnxaXBKWCZVV5r
         WxTrpSZM377zy8l7lKu3Kyf8+7eI1m1Gm/ffMcY+U4XtnQMyyekEzCZPyQjTR5jlDNHH
         9jdvSfouvM029jJtrzA/LBMaML9omu8kqgNC/su2VwEGO3JFTQnbhxwFflUHs2DnLgke
         Ac1TQNKln7i5sx0F+IkYvFN5XryUkm/XSE4Mz1RCfSCPxm/Xfp5VZlxOsypqWQL0WyRJ
         HPyg==
X-Gm-Message-State: AOAM533aTw7Jp4gtkz9imjOqzp8uGaCu67ZbaED8szTKOWwNzgdWbMtU
        8PJSKhIrI1B4LzTzWIb/gpGhVg==
X-Google-Smtp-Source: ABdhPJxWhcqwAmUemUB9Vs0QMZ9njkmN/7vQG5K6xg/Cea8uqkvrdRSDIdxbslAIlaOTnxtWhXg4Ow==
X-Received: by 2002:a63:e442:: with SMTP id i2mr21886170pgk.105.1595884974482;
        Mon, 27 Jul 2020 14:22:54 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id u14sm15601968pgf.51.2020.07.27.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:22:53 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] Bluetooth: Fix suspend notifier race
Date:   Mon, 27 Jul 2020 14:22:47 -0700
Message-Id: <20200727142231.1.I7ebe9eaf684ddb07ae28634cb4d28cf7754641f1@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister from suspend notifications and cancel suspend preparations
before running hci_dev_do_close. Otherwise, the suspend notifier may
race with unregister and cause cmd_timeout even after hdev has been
freed.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Hi Marcel,

This fixes a race between hci_unregister_dev and the suspend notifier.
Without these changes, we encountered the following kernel panic when
a USB disconnect (with btusb) occurred on resume:

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

The suspend notifier handler seemed to be scheduling commands even after
it was cleaned up and this was resulting in a panic in cmd_timeout (when
it tries to requeue the cmd_timer).

This was tested on 5.4 kernel with a suspend+resume stress test for 500+
iterations. I also confirmed that after a usb disconnect, the suspend
notifier times out before the USB device is probed again (fixing the
original race between the usb_disconnect + probe and the notifier).

Thanks
Abhishek


 net/bluetooth/hci_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6509f785dd1481..97221d1fa883d1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3765,9 +3765,10 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
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
2.28.0.rc0.142.g3c755180ce-goog

