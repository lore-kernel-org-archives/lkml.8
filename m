Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C482074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M0NxdjdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFPAZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgFPAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:25:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD4C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:25:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v11so395931pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uPmlz6E5Mye5GEYnU+lDI+kTtDHFK9E+FduYF6ExfLU=;
        b=M0NxdjdQyBPilvf/RqbvqYntyieuS68cH1pQHsVQvuKpY5O74xY9BTY5/FvLztDU4t
         hBPg4kuXxr8JXhGcnNZij6fDNYWDZjfUFkodk4IMrT3T6dodWYeD924IFtqOj47c0kkb
         myNMPDSPNsTwblpsePiXjLWlBTIv3egLGPuUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPmlz6E5Mye5GEYnU+lDI+kTtDHFK9E+FduYF6ExfLU=;
        b=DsEg1NEi+siwlL7UPsZHcu4hv++fKT3wywvw0/o09TUR9X/iSyWdwc4BFC7mOWJ0TW
         h6eYoH8YgnBVd9q/M4R0bH8TdnxHa96tqQspo4KVFnBEZOBtDr52w1RF33HdoRXKxk4Q
         KAXy2lVKr3S+XuHjeWln8vs7KvRhISVJ2P48eNDflCeR8JMzexNqMVBn54G447QY+uQG
         bjywrikdLzLqeq6Q5lIwaepH1v5z3J0x6thFghNkDJ/3fSHMv7ne5x15EOE6QediwQu0
         EUUXRllUFsbXDKR3eFpWMRD4+FXT3TYrIk+8MGtWUdQ4t/9fIwt0SOxXWikLu4n8E/yg
         l46g==
X-Gm-Message-State: AOAM533EUYrfCEvZalHyFUjhxh0hk3lDcVkIwoWeoS/wqgs3W7Lr9qLu
        6Mnp3fFHwVispegsXEnAX7livQ==
X-Google-Smtp-Source: ABdhPJy3ewheBWA2ZLUS29ejDkdmyAyjBbxGBJBbFBaz6Un9YxM2haUk50Rlyz+ZJi4tcIrKdlS81Q==
X-Received: by 2002:a05:6a00:1486:: with SMTP id v6mr172693pfu.83.1592267116189;
        Mon, 15 Jun 2020 17:25:16 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id x2sm14783781pfr.186.2020.06.15.17.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 17:25:15 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 5/7] Bluetooth: Notify adv monitor added event
Date:   Mon, 15 Jun 2020 17:25:03 -0700
Message-Id: <20200615172440.v5.5.Idb2c6bf4deb8728c363c3938b1d33057e07ca9c9@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
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

Changes in v5: None
Changes in v4: None
Changes in v3:
- Convert the endianness of the returned handle.

Changes in v2: None

 net/bluetooth/mgmt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 559d077a88b24..f4dffd06c3aa2 100644
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
+	ev.monitor_handle = cpu_to_le16(handle);
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
 
 	rp.monitor_handle = cpu_to_le16(m->handle);
-- 
2.26.2

