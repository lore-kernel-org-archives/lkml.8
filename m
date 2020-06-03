Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B08FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20817221FE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gfsZlg9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgFCXDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:03:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37028 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgFCXDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:03:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so2647629pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kC933bC/o6W3DoaIvvQnUEH+2IZYCDgVag7G5gA4fAo=;
        b=gfsZlg9lLlGC+rjIyNrOwuLK/VTnbtcPSj0pwJ0/SjsftoMYjxNX8hu0nV8mnDoWPa
         EC+tamBrD1GhBxfHcO0ZFZV3sE34HtdvoD9VGXayUB3r/eeYo4wvvrNebkl+MpozGIbd
         zDDhA4cwfSTqKxchDdk8AlD0qwGEDJKVIdi0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kC933bC/o6W3DoaIvvQnUEH+2IZYCDgVag7G5gA4fAo=;
        b=SyFrp1J/50vBa343ertjWiT8ldEN9Q3H2efBb8Si4gDO0SCDJm78TjXknuzIy2Xo4+
         Xrzwovh9R4iNC9JOxC4cOuzg5SbPQ2sPbMVeSeNGKK0XKxhRKDFPc9g20ElyPHGo7Tdc
         E2or2Qcm1cXbqM0evyr4eiKtEzpMk5LopM+3wKGw6JmOtHsd7tZWc6dBEGoaIgehz0qV
         81gI5ZWVarSMToGpNAalyd3nBd9K7FfUpD/nby8CmngrCpTbAgV9ipBjgYE4Zsx9WRKm
         3E9k2gOdmKCUA0IWxMNiUyoDVa0iDaA1MHNTx2js47FeNmS6Z79YfnVO5MPl14YJeHcD
         qvsA==
X-Gm-Message-State: AOAM532rrpvT2Wcb5hIYXKsGK8pny52mwh92qf1/50QpPwuD5LE1LsSS
        MbbSGpeH8P6SsWcb+z2r/IK6CQ==
X-Google-Smtp-Source: ABdhPJyH46TgKsE5dh1LaaDXvjQq4nmwyeffuTV76HmOuOI32eL0bFDQ/7fwLAKv6fbRK/niaPXoiA==
X-Received: by 2002:a65:4903:: with SMTP id p3mr1593201pgs.318.1591225340505;
        Wed, 03 Jun 2020 16:02:20 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id b11sm2715999pfd.178.2020.06.03.16.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 16:02:19 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 5/7] Bluetooth: Notify adv monitor added event
Date:   Wed,  3 Jun 2020 16:01:48 -0700
Message-Id: <20200603160058.v2.5.Idb2c6bf4deb8728c363c3938b1d33057e07ca9c9@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603160058.v2.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200603160058.v2.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This notifies management sockets on MGMT_EV_ADV_MONITOR_ADDED event.

The following test was performed.
- Start two btmgmt consoles, issue a btmgmt advmon-add command on one
console and observe a MGMT_EV_ADV_MONITOR_ADDED event on the other

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2: None

 net/bluetooth/mgmt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a43a1e6d17cf9..59a806f11a494 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -155,6 +155,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_EXT_INFO_CHANGED,
 	MGMT_EV_PHY_CONFIGURATION_CHANGED,
 	MGMT_EV_EXP_FEATURE_CHANGED,
+	MGMT_EV_ADV_MONITOR_ADDED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -3853,6 +3854,16 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			       MGMT_STATUS_NOT_SUPPORTED);
 }
 
+static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
+				   u16 handle)
+{
+	struct mgmt_ev_adv_monitor_added ev;
+
+	ev.monitor_handle = handle;
+
+	mgmt_event(MGMT_EV_ADV_MONITOR_ADDED, hdev, &ev, sizeof(ev), sk);
+}
+
 static int read_adv_monitor_features(struct sock *sk, struct hci_dev *hdev,
 				     void *data, u16 len)
 {
@@ -3905,8 +3916,8 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_rp_add_adv_patterns_monitor rp;
 	struct adv_monitor *m = NULL;
 	struct adv_pattern *p = NULL;
+	unsigned int mp_cnt = 0, prev_adv_monitors_cnt;
 	__u8 cp_ofst = 0, cp_len = 0;
-	unsigned int mp_cnt = 0;
 	int err, i;
 
 	BT_DBG("request for %s", hdev->name);
@@ -3970,6 +3981,8 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
+	prev_adv_monitors_cnt = hdev->adv_monitors_cnt;
+
 	err = hci_add_adv_monitor(hdev, m);
 	if (err) {
 		if (err == -ENOSPC) {
@@ -3980,6 +3993,9 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	if (hdev->adv_monitors_cnt > prev_adv_monitors_cnt)
+		mgmt_adv_monitor_added(sk, hdev, m->handle);
+
 	hci_dev_unlock(hdev);
 
 	rp.monitor_handle = m->handle;
-- 
2.26.2

