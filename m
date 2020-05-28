Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C565FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD7E206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcTzCDqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437908AbgE1Xze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437845AbgE1XzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:55:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CC3C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:55:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so243908plv.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3Ddd9xAVc9PvNCd/pKZsNEG7UV+4uuv8lSwcrZKJdw=;
        b=NcTzCDqWPedxY47On0jdVEO1c82MGzc8Tcu85w8/J9aokJSb0sbSxQytxwTVzjTGPX
         pndqi6qLYF7OOYElty89Qrs0odbtWr2On2ynzGtAmOwueuER6l9CtN6aeT8GE+oSbD3/
         XskSo3quj4AiaI3RYYIsxQApcy9yq8jhfYv8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3Ddd9xAVc9PvNCd/pKZsNEG7UV+4uuv8lSwcrZKJdw=;
        b=MbxamZF+3tnKuEplHkwwXu0R1h4mz/C/Y7wkZzW7x4yGuR7tCW/hXbaQhZ61EYSaXJ
         ZJScer84uzJTNWL10dT70CMK0zZVvvvCh/qE/asNqLnK0QJ9DTwsnE3+HPiSLG1RSrN1
         kwDVfY7axQVZ1sZYj28M6eNZ937E7uMXHQmQ1jrDuTcKLkIFYQMmh38yUj1KbNELA6Zr
         3QF/k9CCFyGG4izOz8Vi1+Ra9uJY/hGI/RoYIR/H9/CDZs1XWGZoNTfcAHeaWFNeBqTu
         DMGTgRqMZthIHhHldiD2bBnRXXh+pkcRgpSMPZrxp0hL55NHda8HFYi89mPX/3/5D+RY
         3WoQ==
X-Gm-Message-State: AOAM530fg+Ps1QDzrElg6wDPtoWGIXwApOTYs9J4jLRt/sBS0xKWSmLl
        c32Wsit0TZllz5Vh3bzhPv/OVw==
X-Google-Smtp-Source: ABdhPJwDjU58jgQyoww8wQ2KDcbOGC0Q7ZRxVe4RCLnIyv0STOahyAc/lGrOCuxFzMqBXez1zOz/SQ==
X-Received: by 2002:a17:902:aa4a:: with SMTP id c10mr6344331plr.0.1590710124106;
        Thu, 28 May 2020 16:55:24 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id f18sm5022591pga.75.2020.05.28.16.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 16:55:23 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 6/7] Bluetooth: Notify adv monitor removed event
Date:   Thu, 28 May 2020 16:54:54 -0700
Message-Id: <20200528165324.v1.6.If1a82f71eb63f969de3d5a5da03c2908b58a721a@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165324.v1.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200528165324.v1.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This notifies management sockets on MGMT_EV_ADV_MONITOR_REMOVED event.

The following test was performed.
- Start two btmgmt consoles, issue a btmgmt advmon-remove command on one
console and observe a MGMT_EV_ADV_MONITOR_REMOVED event on the other.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

 net/bluetooth/mgmt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index da65b6ab2e3a0..728d79663cbcf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -156,6 +156,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_PHY_CONFIGURATION_CHANGED,
 	MGMT_EV_EXP_FEATURE_CHANGED,
 	MGMT_EV_ADV_MONITOR_ADDED,
+	MGMT_EV_ADV_MONITOR_REMOVED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -3864,6 +3865,16 @@ static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADV_MONITOR_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
+static void mgmt_adv_monitor_removed(struct sock *sk, struct hci_dev *hdev,
+				     u16 handle)
+{
+	struct mgmt_ev_adv_monitor_added ev;
+
+	ev.monitor_handle = handle;
+
+	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk);
+}
+
 static int read_adv_monitor_features(struct sock *sk, struct hci_dev *hdev,
 				     void *data, u16 len)
 {
@@ -4014,12 +4025,15 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_remove_adv_monitor *cp = data;
 	struct mgmt_rp_remove_adv_monitor rp;
+	unsigned int prev_adv_monitors_cnt;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
 	hci_dev_lock(hdev);
 
+	prev_adv_monitors_cnt = hdev->adv_monitors_cnt;
+
 	err = hci_remove_adv_monitor(hdev, cp->monitor_handle);
 	if (err == -ENOENT) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADV_MONITOR,
@@ -4027,6 +4041,9 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	if (hdev->adv_monitors_cnt < prev_adv_monitors_cnt)
+		mgmt_adv_monitor_removed(sk, hdev, cp->monitor_handle);
+
 	hci_dev_unlock(hdev);
 
 	rp.monitor_handle = cp->monitor_handle;
-- 
2.26.2

