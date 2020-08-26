Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD757C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A948D206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hunhi80i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZWrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgHZWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 18:47:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A39C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 15:47:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so1590083pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTV2RlnMnYfEfU+n6J7LxKvHGWuogRfWUjxo9oBtDWg=;
        b=hunhi80imRT79pQZiQ6L3lKxUljVv11uqwzOckeYlSW2xC/1XGMNrtCJoldSMClPz6
         LLho8FdrvVzbnWU6iQtwlGYc5JfAhX03Cz8UiUfxOW/JAs04Gjx6L1onY5EalO1ukw5S
         lRgunltwr0SCkQ5/7jkBVzavGV8Nkhvy6GTGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTV2RlnMnYfEfU+n6J7LxKvHGWuogRfWUjxo9oBtDWg=;
        b=n3vn26x3fPsJnNKXjLgoOCRvApP9rQ3mHGu8r3F9mpLHm9OKYFJLe9fSdOFpunkx8h
         Kaku2j9Oajs5+O1GFCjEH/u+ZvQfrenlKgSZvklb29HyApKxUo+UYterhEQQ2rxaC6Qx
         2HhKkREnXhg96GXt22IOl8ONOl1J7L5NW82npPcFsMbevI/I9Ghh4H2XR+UZ6h8cpi19
         I0dS9FFs5m63NYcnQSzuLzsmdvWubfFH1oVXnyViNRbMDUs7rP7oo9E7n57+28YIW3AX
         sJUcJiWQyr/QFWVeVAhuAoAGUUJzBW2PYliq+21X1bzOl1iPnCSlAeZ9MIoyqu13HVue
         U1xg==
X-Gm-Message-State: AOAM532rV2+z7C7V9BBNW/+kMSvOPQyHF5e8H7MkhMxMXexS+VRjPNKM
        r9jv3qF8YncEYqwcDOVfQjtgaforca5wnw==
X-Google-Smtp-Source: ABdhPJzp3CSsjDcKg/29/X87IL09PfgN+zVZmYuop0NFK3+uXle3rQu5a8WZU1dDdQPrIdlRbbCi9g==
X-Received: by 2002:a17:90a:8817:: with SMTP id s23mr8065795pjn.158.1598482048667;
        Wed, 26 Aug 2020 15:47:28 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id s10sm123093pjl.37.2020.08.26.15.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 15:47:28 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH] Bluetooth: Clear suspend tasks on unregister
Date:   Wed, 26 Aug 2020 15:47:22 -0700
Message-Id: <20200826154719.1.I24fb6cc377d03d64d74f83cec748afd12ee33e37@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While unregistering, make sure to clear the suspend tasks before
cancelling the work. If the unregister is called during resume from
suspend, this will unnecessarily add 2s to the resume time otherwise.

Fixes: 4e8c36c3b0d73d (Bluetooth: Fix suspend notifier race)
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
This was discovered with RT8822CE using the btusb driver. This chipset
will reset on resume during system suspend and was unnecessarily adding
2s to every resume. Since we're unregistering anyway, there's no harm in
just clearing the pending events.

 net/bluetooth/hci_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 68bfe57b66250f..ed4cb3479433c0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3442,6 +3442,16 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	}
 }
 
+static void hci_suspend_clear_tasks(struct hci_dev *hdev)
+{
+	int i;
+
+	for (i = 0; i < __SUSPEND_NUM_TASKS; ++i)
+		clear_bit(i, hdev->suspend_tasks);
+
+	wake_up(&hdev->suspend_wait_q);
+}
+
 static int hci_suspend_wait_event(struct hci_dev *hdev)
 {
 #define WAKE_COND                                                              \
@@ -3785,6 +3795,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->power_on);
 
 	unregister_pm_notifier(&hdev->suspend_notifier);
+	hci_suspend_clear_tasks(hdev);
 	cancel_work_sync(&hdev->suspend_prepare);
 
 	hci_dev_do_close(hdev);
-- 
2.28.0.297.g1956fa8f8d-goog

