Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4DDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7385D2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0/twXqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgG2XRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgG2XRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:17:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EE7C0619D4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:17:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l2so7597624pff.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9HgHOXqVNgKdIpZbWbUHoQKwYNiPIQ6hR37SC3F4W0=;
        b=F0/twXqvlLuXWYfAcB2/sK2KH7Vo0KM8YEPTPxzUM+c2KUAX7hft542jNg7au6To8O
         8PuIdaDMGVV5WZp/uxoUnbVtdsAVB/RUeKN8N5AUFaYRbM5lwNU1YrcS1zzoGccQpTVY
         MZ40lheu2dCFtdbdnR6bI6mqIJPN7Cj2Gfroc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9HgHOXqVNgKdIpZbWbUHoQKwYNiPIQ6hR37SC3F4W0=;
        b=ri4UBjs20zkJCrUCnz8f76EhGkGTHKi/swQvv57IX3YyI8mIfeisbbtCunyIqWSe4M
         0R9QM+543lijXOvc9DoRTy9wVk4qY08BfPlMl+5ZGHXfIannUTENTrHl88uB+rq1u/a5
         xmAZye2H8hsQ+GHC2U6NcqOwBafqQzY62Ra/w7ZtBD+mnnBcUC+EAPIjN/IhNJkV7nx/
         CdR9YoIqVwt51gnMTLol6ihoE/WY9Ap1XadCVBc+UNLU+bHIsXWI7pFyL9cfcXGvyEWj
         TfcGG5Z1qdyWcDZL5pvyN1jXCoB3+oN7XbNmrKYbWw/zBOLQ8zsSgo9bVReyr93fVT7F
         kixQ==
X-Gm-Message-State: AOAM531E2vdi8zCrKWZHPZMI2ednaQvYMo8vDUdeGqQvdQUlfMhxtwdd
        dGJzikANLWn+JJeB9x6sMrNJwA==
X-Google-Smtp-Source: ABdhPJxHKfvbjFH/RI2aP1uExJ+na8MkvlhpokW2aSYM8Li6Xk9CijHIwGwIwEeK6WqpBK5kymCzJQ==
X-Received: by 2002:aa7:93a6:: with SMTP id x6mr377357pff.37.1596064670156;
        Wed, 29 Jul 2020 16:17:50 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x18sm3538093pfc.93.2020.07.29.16.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 16:17:49 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth@vger.kernel.org, Alex Lu <alex_lu@realsil.com.cn>,
        linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "Bluetooth: btusb: Disable runtime suspend on Realtek devices"
Date:   Wed, 29 Jul 2020 16:17:43 -0700
Message-Id: <20200729161740.1.Ib03d0827c8e48fc3df887fec698f79fa335c9274@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7ecacafc240638148567742cca41aa7144b4fe1e.

Testing this change on a board with RTL8822CE, I found that enabling
autosuspend has no effect on the stability of the system. The board
continued working after autosuspend, suspend and reboot.

The original commit makes it impossible to enable autosuspend on working
systems so it should be reverted. Disabling autosuspend should be done
via module param or udev in userspace instead.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
We have a few Chromebooks using the RTL 8822CE part over USB and they
are running without problems with autosuspend enabled. While bringing up
a new board, I found some power regressions that I was able to narrow
down to this change so I'm requesting a revert.

I tested this on Hp Chromebook 14a (running 4.14 kernel and 5.4 kernel)
with this revert:
* Enabled autosuspend, used it normally with a HID device
* Suspended the Chromebook and verified it worked normally on resume
* Rebooted the Chromebook and verified Bluetooth was working on next
  boot

I didn't see the issue that was originally reported with this fix. For
the original reporter, if you're still seeing this issue, there are
other ways to disable autosuspend for your device:
* set module param: enable_autosuspend=0
* change your kconfig so BT_HCIBTUSB_AUTOSUSPEND=n
* use a udev rule to disable autosuspend for specific vid:pid

Keeping this change in the kernel makes it impossible to enable
autosuspend so it should be reverted.

 drivers/bluetooth/btusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1f51494f581812..8d2608ddfd0875 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4086,10 +4086,6 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags);
 		else
 			bt_dev_err(hdev, "Device does not support ALT setting 1");
-
-		err = usb_autopm_get_interface(intf);
-		if (err < 0)
-			goto out_free_dev;
 	}
 
 	if (!reset)
-- 
2.28.0.rc0.142.g3c755180ce-goog

