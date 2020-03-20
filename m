Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F77C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA73206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEvD6Q64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCTAHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:07:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42224 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgCTAHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:07:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id x2so2296658pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQXtrFBK0FlZQNQPvUALv+UR85FSVb3kUvsKXL/U5Nc=;
        b=TEvD6Q64qVYmIQlbmaLjnNAY+7OlBcvgfXNGmoM8H/sSiTi7kDeL1NdArsDpd6XdQP
         UopKYZ+HGb4EiFgFJNZUtac5kGMrZRQpz/m4OuxcwNtKFmoTQbeDusSuIIgC+Gpg1MUt
         +3+VGvMUj5tfzJ/QcW1KuKU/1IEDdJdPTfRQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQXtrFBK0FlZQNQPvUALv+UR85FSVb3kUvsKXL/U5Nc=;
        b=V0ztJG2MfZP9pvZAjTh4A7arCfcNbVEQSN+4SCJrCvbAWvm02JiyBBpgDgljQ506H2
         5yLI72Th9JAs+9ic70ODAx3G76VhrKn83t3d3U5ywDAZYhZQy7ArFGG+hmveAWzBG8+x
         8+H7DY0RH7ZiwBvlas3HWDkBEG+SeLG5HkIen3WsNwTbDkJcedKlW/1TkfwEin7PI2kJ
         RI6Gn5Psjd7sGg3ca5WsDmkv4cFv1+3CURlJLSTYo71biEUI0n14AC4/eLg/WOMjo0Pv
         V+edQOIRyAvLQXMS34kYaZlDEt4/zhh6n5U76i2H/pCFcv8aVOExQBYUvcjwDxUsrKhS
         55OA==
X-Gm-Message-State: ANhLgQ1B44Tsrbh31UXK84PaAbBZpVcfrzsBS4Cfc3XVnSpiRUZFJ5TG
        v2Rw/hIKyDfDHAvhwU8IvKEh5Q==
X-Google-Smtp-Source: ADFU+vtOCz6ZIdxB66p7W+0Ice1rjK2QrirMgDN1ixu5hAnGyJU2ZhDTWPnn8LAZR5Dj63+UeS+nxw==
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr6580091pfo.311.1584662850242;
        Thu, 19 Mar 2020 17:07:30 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id m12sm2928292pjf.25.2020.03.19.17.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:07:29 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/2] Bluetooth: Restore running state if suspend fails
Date:   Thu, 19 Mar 2020 17:07:12 -0700
Message-Id: <20200319170708.1.I83970586f8340022b3909dccac1d79d191c6c70a@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320000713.32899-1-abhishekpandit@chromium.org>
References: <20200320000713.32899-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Bluetooth fails to enter the suspended state correctly, restore the
state to running (re-enabling scans). PM_POST_SUSPEND is only sent to
notifiers that successfully return from PM_PREPARE_SUSPEND notification
so we should recover gracefully if it fails.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 net/bluetooth/hci_core.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbd2ad3a26ed..2e7bc2da8371 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3305,6 +3305,15 @@ static void hci_prepare_suspend(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static int hci_change_suspend_state(struct hci_dev *hdev,
+				    enum suspended_state next)
+{
+	hdev->suspend_state_next = next;
+	set_bit(SUSPEND_PREPARE_NOTIFIER, hdev->suspend_tasks);
+	queue_work(hdev->req_workqueue, &hdev->suspend_prepare);
+	return hci_suspend_wait_event(hdev);
+}
+
 static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 				void *data)
 {
@@ -3330,32 +3339,24 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 		 *    connectable (disabling scanning)
 		 *  - Second, program event filter/whitelist and enable scan
 		 */
-		hdev->suspend_state_next = BT_SUSPEND_DISCONNECT;
-		set_bit(SUSPEND_PREPARE_NOTIFIER, hdev->suspend_tasks);
-		queue_work(hdev->req_workqueue, &hdev->suspend_prepare);
-		ret = hci_suspend_wait_event(hdev);
+		ret = hci_change_suspend_state(hdev, BT_SUSPEND_DISCONNECT);
 
-		/* If the disconnect portion failed, don't attempt to complete
-		 * by configuring the whitelist. The suspend notifier will
-		 * follow a cancelled suspend with a PM_POST_SUSPEND
-		 * notification.
-		 */
-		if (!ret) {
-			hdev->suspend_state_next = BT_SUSPEND_COMPLETE;
-			set_bit(SUSPEND_PREPARE_NOTIFIER, hdev->suspend_tasks);
-			queue_work(hdev->req_workqueue, &hdev->suspend_prepare);
-			ret = hci_suspend_wait_event(hdev);
-		}
+		/* Only configure whitelist if disconnect succeeded */
+		if (!ret)
+			ret = hci_change_suspend_state(hdev,
+						       BT_SUSPEND_COMPLETE);
 	} else if (action == PM_POST_SUSPEND) {
-		hdev->suspend_state_next = BT_RUNNING;
-		set_bit(SUSPEND_PREPARE_NOTIFIER, hdev->suspend_tasks);
-		queue_work(hdev->req_workqueue, &hdev->suspend_prepare);
-		ret = hci_suspend_wait_event(hdev);
+		ret = hci_change_suspend_state(hdev, BT_RUNNING);
 	}
 
+	/* If suspend failed, restore it to running */
+	if (ret && action == PM_SUSPEND_PREPARE)
+		hci_change_suspend_state(hdev, BT_RUNNING);
+
 done:
 	return ret ? notifier_from_errno(-EBUSY) : NOTIFY_STOP;
 }
+
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
 {
-- 
2.25.1.696.g5e7596f4ac-goog

