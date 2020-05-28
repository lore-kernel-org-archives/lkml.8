Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7DDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72795206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oEx9e+wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437951AbgE1X4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437869AbgE1XzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:55:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C3DC08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:55:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg4so256938plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tWYn+OZGqld5yzYYoOp7tvbT27PKpSr1rap+/a2yfg=;
        b=oEx9e+wRZ8Melg8KvpxagHHoEE6/Y99xUp26xBf7h+yduioFHHkV5MwFqL6kJTPc5d
         y7P71HEv6vNeFJ9+xIZCI0ZxAZRRaqA/H50svikAwWXmTUY5aeY6G6tXFT3uy5qmg08W
         jx9/1Rh5ETFR9BVpRzb/cBvsc5Ky4Ng7orqd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tWYn+OZGqld5yzYYoOp7tvbT27PKpSr1rap+/a2yfg=;
        b=RaqFsHvECw+ra55aIkX1U7V7BYq0Vb9/G2Ij379CBVfHXfVHVtnPWRY7QfW//6oIx3
         hAK67EaXV5P9cRKYQi+P0G1rQ0GzjKsAWX6VhikNYxPdz8ESy9MP9lmTVx4CBITiJ2oK
         s2f7cS/BxUlFikohXpyt+59Q9ScdzOuDDh0V5Yv9UTG0VOBmIHALw/YEKCc8FZNoPw57
         VSWD0ObBZ38HaegnEMCAwLXpG4k6hrSPIQZmDABlPyb8ct9fIk4RsXiQnc15w6sJwv+l
         M+8XlX4HCAk/HqoDpWg4cSqYtkNUONa3jqcVZv10VFsHWqsI+T+HXtUI4tgojr1iahMr
         hPDQ==
X-Gm-Message-State: AOAM532YzzgFfSVouVKj47v2jJE3PWhw8gcBkYAAXO6LYnTvdP19aJ1O
        LHgYcQmu1MbBC7iscs9G5VLXsGDcm30=
X-Google-Smtp-Source: ABdhPJwaDE/Fyxh80I00aZskozEL8RXne9iEit6GBV1GHb6h7L+k8iB8XG/Y+DZ5SIbc0cEocvxayg==
X-Received: by 2002:a17:902:bc82:: with SMTP id bb2mr6083664plb.107.1590710117324;
        Thu, 28 May 2020 16:55:17 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id f18sm5022591pga.75.2020.05.28.16.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 16:55:16 -0700 (PDT)
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
Subject: [PATCH v1 3/7] Bluetooth: Add handler of MGMT_OP_ADD_ADV_PATTERNS_MONITOR
Date:   Thu, 28 May 2020 16:54:51 -0700
Message-Id: <20200528165324.v1.3.Iea5d308a1936ac26177316c977977cdf7de42de8@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165324.v1.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200528165324.v1.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the request handler of MGMT_OP_ADD_ADV_PATTERNS_MONITOR command.
Note that the controller-based monitoring is not yet in place. This tracks
the content of the monitor without sending HCI traffic, so the request
returns immediately.

The following manual test was performed.
- Issue btmgmt advmon-add with valid and invalid inputs.
- Issue btmgmt advmon-add more the allowed number of monitors.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

 include/net/bluetooth/hci_core.h |   2 +
 net/bluetooth/hci_core.c         |  40 +++++++++++++
 net/bluetooth/mgmt.c             | 100 +++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 431fe0265dcfb..862d94f711bc0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1240,6 +1240,8 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 
 void hci_adv_monitors_clear(struct hci_dev *hdev);
+void hci_free_adv_monitor(struct adv_monitor *monitor);
+int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 23bfe4f1d1e9d..93c16bfc6da15 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2998,9 +2998,49 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 /* This function requires the caller holds hdev->lock */
 void hci_adv_monitors_clear(struct hci_dev *hdev)
 {
+	struct adv_monitor *monitor;
+	int handle;
+
+	idr_for_each_entry(&hdev->adv_monitors_idr, monitor, handle)
+		hci_free_adv_monitor(monitor);
+
 	idr_destroy(&hdev->adv_monitors_idr);
 }
 
+void hci_free_adv_monitor(struct adv_monitor *monitor)
+{
+	struct adv_pattern *pattern;
+	struct adv_pattern *tmp;
+
+	if (!monitor)
+		return;
+
+	list_for_each_entry_safe(pattern, tmp, &monitor->patterns, list)
+		kfree(pattern);
+
+	kfree(monitor);
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
+{
+	int min, max, handle;
+
+	if (!monitor)
+		return -EINVAL;
+
+	min = HCI_MIN_ADV_MONITOR_HANDLE;
+	max = HCI_MIN_ADV_MONITOR_HANDLE + HCI_MAX_ADV_MONITOR_NUM_HANDLES;
+	handle = idr_alloc(&hdev->adv_monitors_idr, monitor, min, max,
+			   GFP_KERNEL);
+	if (handle < 0)
+		return handle;
+
+	hdev->adv_monitors_cnt++;
+	monitor->handle = handle;
+	return 0;
+}
+
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
 					 bdaddr_t *bdaddr, u8 type)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8d8275ee9718b..9c1704ca6ad1e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -113,6 +113,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_SET_EXP_FEATURE,
 	MGMT_OP_READ_ADV_MONITOR_FEATURES,
+	MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
 };
 
 static const u16 mgmt_events[] = {
@@ -3894,6 +3895,103 @@ static int read_adv_monitor_features(struct sock *sk, struct hci_dev *hdev,
 				 MGMT_STATUS_SUCCESS, rp, rp_size);
 }
 
+static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
+				    void *data, u16 len)
+{
+	struct mgmt_cp_add_adv_patterns_monitor *cp = data;
+	struct mgmt_rp_add_adv_patterns_monitor rp;
+	struct adv_monitor *m = NULL;
+	struct adv_pattern *p = NULL;
+	__u8 cp_ofst = 0, cp_len = 0;
+	unsigned int mp_cnt = 0;
+	int err, i;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (len <= sizeof(*cp) || cp->pattern_count == 0) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto failed;
+	}
+
+	m = kmalloc(sizeof(*m), GFP_KERNEL);
+	if (!m) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	INIT_LIST_HEAD(&m->patterns);
+	m->active = false;
+
+	for (i = 0; i < cp->pattern_count; i++) {
+		if (++mp_cnt > HCI_MAX_ADV_MONITOR_NUM_PATTERNS) {
+			err = mgmt_cmd_status(sk, hdev->id,
+					      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+					      MGMT_STATUS_INVALID_PARAMS);
+			goto failed;
+		}
+
+		cp_ofst = cp->patterns[i].offset;
+		cp_len = cp->patterns[i].length;
+		if (cp_ofst >= HCI_MAX_AD_LENGTH ||
+		    cp_len > HCI_MAX_AD_LENGTH ||
+		    (cp_ofst + cp_len) > HCI_MAX_AD_LENGTH) {
+			err = mgmt_cmd_status(sk, hdev->id,
+					      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+					      MGMT_STATUS_INVALID_PARAMS);
+			goto failed;
+		}
+
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (!p) {
+			err = -ENOMEM;
+			goto failed;
+		}
+
+		p->ad_type = cp->patterns[i].ad_type;
+		p->offset = cp->patterns[i].offset;
+		p->length = cp->patterns[i].length;
+		memcpy(p->value, cp->patterns[i].value, p->length);
+
+		INIT_LIST_HEAD(&p->list);
+		list_add(&p->list, &m->patterns);
+	}
+
+	if (mp_cnt != cp->pattern_count) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto failed;
+	}
+
+	hci_dev_lock(hdev);
+
+	err = hci_add_adv_monitor(hdev, m);
+	if (err) {
+		if (err == -ENOSPC) {
+			mgmt_cmd_status(sk, hdev->id,
+					MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+					MGMT_STATUS_NO_RESOURCES);
+		}
+		goto unlock;
+	}
+
+	hci_dev_unlock(hdev);
+
+	rp.monitor_handle = m->handle;
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+				 MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+
+unlock:
+	hci_dev_unlock(hdev);
+
+failed:
+	hci_free_adv_monitor(m);
+	return err;
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -7343,6 +7441,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_VAR_LEN |
 						HCI_MGMT_HDEV_OPTIONAL },
 	{ read_adv_monitor_features, MGMT_READ_ADV_MONITOR_FEATURES_SIZE },
+	{ add_adv_patterns_monitor, MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.26.2

