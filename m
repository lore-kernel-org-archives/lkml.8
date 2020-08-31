Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223AFC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81FC20707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UzOsZYDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgHaQvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgHaQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:51:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:51:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so892652pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0vvOvvHJGYF7a0Genu2fCkpngsUdQSUu8uEc44Bpec=;
        b=UzOsZYDpZRtoa3zdZGrzH2kjQLR4VT+DZn2shy2vnsl06x55wm8y65FeOgjXRxV55e
         HxkvO7V6BZW0+16tOURbnBnIHu/WjsjRe9An0i0j5mw2bIKBCkKXWhXmb0BSwWQ3b5/h
         WQ0S+FTtmqLPVmcYWDS4petTsGSqZhWjRFA0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0vvOvvHJGYF7a0Genu2fCkpngsUdQSUu8uEc44Bpec=;
        b=kONJdPHMz4aSZr8l18nOMTMgnAEWf30hxOIW86NfkbJV2GULaSmAKCQKUT5DE4Ztrh
         ixq5k/G0SZ+NjscLgvQzSeK4CUFUDN+MDLbmpONwVvekwKUMhxduGu7H5kHXv2YJpdpL
         R7z3Qtlb8oYHgl9p1UcvgAFTATlekYfde6a0QKPl+uv+YJA3zGkLCYFn/f4cxzsxwygB
         hGGMDkL58x6I6bqD0+9CWn/EYFxMWm8Pz4LEKGTmui7T2Kf8rHRO1Lqkn41KrlzrZAaQ
         uXIZhFDf29yrl2lM5JaahQ/LMHC5z6ht6vsPrJHCseyG68ZvhABK9w+8XhYd4wCbqMpK
         p2dA==
X-Gm-Message-State: AOAM532AT0I9JvpIInDyy53UxfbGZI0MW/7ivkyXdaUEufb1Izr3tXsV
        7yVaT8VCUKosYXumx/ltPvLoMA==
X-Google-Smtp-Source: ABdhPJx+lLDch40/FsX48QUf1KjmhYjA47S013g5ttuztFBm4bL4RjoNUNMuail4dby1mDZKmeW8+g==
X-Received: by 2002:a63:5160:: with SMTP id r32mr2003729pgl.112.1598892696285;
        Mon, 31 Aug 2020 09:51:36 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id k5sm8189082pgk.78.2020.08.31.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 09:51:35 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH v2] Bluetooth: Clear suspend tasks on unregister
Date:   Mon, 31 Aug 2020 09:51:27 -0700
Message-Id: <20200831095119.v2.1.I24fb6cc377d03d64d74f83cec748afd12ee33e37@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
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

Changes in v2:
- ++i to i++

 net/bluetooth/hci_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 68bfe57b66250f..efc0fe2b47dac2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3442,6 +3442,16 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	}
 }
 
+static void hci_suspend_clear_tasks(struct hci_dev *hdev)
+{
+	int i;
+
+	for (i = 0; i < __SUSPEND_NUM_TASKS; i++)
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
2.28.0.402.g5ffc5be6b7-goog

