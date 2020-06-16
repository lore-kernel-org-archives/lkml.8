Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE53C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191E02074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THwEaCWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgFPAZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgFPAZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:25:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F36C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:25:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so622933pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLq2NrggdehV65XNxPfn6TchBUv8G4Z4xRck+Y6S+V0=;
        b=THwEaCWLW+4RIucqjjY6ijgrNXhywBQuNLf4XrkyvE38o9qmXWqyDcKmJLb4WxyZmU
         ocIY1X6HvfcwhcZDTQNpBguYZa+zoTrPd3Mds33hSs2KF9507tk/5xdcdWHFXJJsUt1D
         n9/QuRHrD2LmHAjuliEBpTR1rMSX4ce9mXMBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLq2NrggdehV65XNxPfn6TchBUv8G4Z4xRck+Y6S+V0=;
        b=tAAPG4HIn+ivLTwi4z+mCQQsId/VSXrLWw2L0/6+PC/d9y30yXi02V9XKf2bsruFr9
         lZlHUm5UjGUpt77b0KZ/tS1xIFyoOl0OB4eXXhZv6zDj2kUCXE69Mn9aQz6IRTdAYvK7
         7fsCkdl3xJ6/jI5fmvNMT4/p11CFrJNDq6Y/ARqhbbLkF0JAFT59d1qDLhPD+fZjiunm
         mJLpy/QkVUqnRjJZUvLjw9PpenPywBxsDwhpMpHJAkcoixObU265HzrbBaY9bo+QGk5k
         xjdtmvGtkSv+DYRjMofk4mVxMQ+Q/L9IJxAnEXkJtdCI1W4FmMtMeh9lSeB4UtXU9aa+
         m33A==
X-Gm-Message-State: AOAM530WkmhECAOpHoGESWsVxg4wrvARs3caGafn53fZ2qOjb6nNgPyx
        ipU4h2adAZKRyMS4beINOSnZag==
X-Google-Smtp-Source: ABdhPJwZX3Z+UjwH+6x0C2hxS23QN1oCq/D/tPLQEzfxXaSrtKoGQ6l9dpdHjaEGuteeS1YIbTmkeQ==
X-Received: by 2002:a17:90b:2042:: with SMTP id ji2mr252845pjb.68.1592267113275;
        Mon, 15 Jun 2020 17:25:13 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id x2sm14783781pfr.186.2020.06.15.17.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 17:25:12 -0700 (PDT)
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
Subject: [PATCH v5 3/7] Bluetooth: Add handler of MGMT_OP_ADD_ADV_PATTERNS_MONITOR
Date:   Mon, 15 Jun 2020 17:25:01 -0700
Message-Id: <20200615172440.v5.3.Iea5d308a1936ac26177316c977977cdf7de42de8@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
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

Changes in v5: None
Changes in v4: None
Changes in v3:
- Update the opcode in the mgmt table.
- Convert the endianness of the returned handle.

Changes in v2: None

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
index bfcf00e4dfa92..fdbb58eb2fb22 100644
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
index 63536d6332d45..8e0d4ccf81f15 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -113,6 +113,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_SET_EXP_FEATURE,
 	MGMT_OP_READ_ADV_MONITOR_FEATURES,
+	MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
 };
 
 static const u16 mgmt_events[] = {
@@ -3896,6 +3897,103 @@ static int read_adv_monitor_features(struct sock *sk, struct hci_dev *hdev,
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
+	rp.monitor_handle = cpu_to_le16(m->handle);
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
@@ -7351,6 +7449,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, // 0x004F
 	{ NULL }, // 0x0050
 	{ read_adv_monitor_features, MGMT_READ_ADV_MONITOR_FEATURES_SIZE },
+	{ add_adv_patterns_monitor, MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.26.2

