Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9000020658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l38dTQyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGNV2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgGNV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:28:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B870C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:28:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 8so277211ybc.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5Behtcws30Pp0nDQ23hDNBtqNP5bqp4CSfxyj349GYE=;
        b=l38dTQyw2IrM5kbznrKVpPLablAiGcaqv+lkFFedxeNwW16nlKSBZdJAhX3/TV/Brm
         MvKr6yC3Gq4BiJIZq4CgxKwEaSknQXLkSggaBC7wGg7rLgA29O6Wi4fsisqlhv18s2LP
         WF/w1jNMYA8enA7rWZlwg4NIDV2y+gazD7a1IVsQa/VIKEYTkAly9Mfqp0RboPwfXt9w
         6L2wfqEGoZ+oUtcRaJQs6g1ThE2GKuQjfqCXwwZkzTCs3UNqe5zXasjKdFaNdE/6E49H
         f+x0X+uXn3V88VHKuTu9rjhhu4WQmFA3PTgJorReU1jMrw23CaHbLF8ZORS9+KFdazK4
         P3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5Behtcws30Pp0nDQ23hDNBtqNP5bqp4CSfxyj349GYE=;
        b=OU5J8griXTEONHzdcocglGBhJm0ft/QseWf2UzfzN3ZGPm1Z8XORnM3XThchF2mRBi
         GF2LH74jcTHR4oIGmqJmm6EfF9BJvCmj84AtBwW4sKRKZD9lj7/M+l7bZqCXU4THfRmX
         rgG6iXVxPsd2kLUsBlpp8OyARTHCkFf1AzLkTJwBvi6LJhP+yWhIqzJU1+YVFJRgcwu3
         AzIyOETxHHoYXviYyE8tgEsQRMMSe7wQE5CCdfjkXFYeUyd10cxLg1mA2eIhH1j9FtWQ
         MCWZMTwDT0oi3wlwC/UWber4aICZLd7akwEq5326yd+SW+1Fd1B3ySWhZhpiHkZB2Gba
         7cIw==
X-Gm-Message-State: AOAM531CIY7kztej4yPxgIT7hILLiFiLWT/B+MzeDMlbjxpvWTC/57au
        U5TavsS2Sxz5hwldJbB1D7KvWqxOnHYvdbdZ6C+J
X-Google-Smtp-Source: ABdhPJzuhzn0stnH04Y0xmiGPJJI6ddjd4INyuVFCT9ZvtB9fwZLNAJ1DPmpkDN9PNJIDYgcFx+WfgfepQ4EHN++vCRa
X-Received: by 2002:a25:b90e:: with SMTP id x14mr11855088ybj.8.1594762103396;
 Tue, 14 Jul 2020 14:28:23 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:28:17 -0700
Message-Id: <20200714142741.v2.1.Icd35ad65fb4136d45dd701ef9022fa8f7c9e5d65@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v2] Bluetooth: Add per-instance adv disable/remove
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Shyh-In Hwang <josephsih@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality to disable and remove advertising instances,
and use that functionality in MGMT add/remove advertising calls.

Signed-off-by: Daniel Winkler <danielwinkler@google.com>
Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---
Hi Maintainers,

Currently, advertising is globally-disabled, i.e. all instances are
disabled together, even if hardware offloading is available. This
patch adds functionality to disable and remove individual adv
instances, solving two issues:

1. On new advertisement registration, a global disable was done, and
then only the new instance was enabled. This meant only the newest
instance was actually enabled.

2. On advertisement removal, the structure was removed, but the instance
was never disabled or removed, which is incorrect with hardware offload
support.

Patch has been tested on advertising test suite and with manual testing
to verify instances are added/removed properly on kernel 4.19 on hatch
chromebook.

Best,
Daniel

Changes in v2:
- Re-add commit notes

 net/bluetooth/hci_conn.c    |  2 +-
 net/bluetooth/hci_request.c | 59 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_request.h |  2 ++
 net/bluetooth/mgmt.c        |  6 ++++
 4 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8805d68e65f2a..be67361ff2f00 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -931,7 +931,7 @@ static void hci_req_directed_advertising(struct hci_request *req,
 		 * So it is required to remove adv set for handle 0x00. since we use
 		 * instance 0 for directed adv.
 		 */
-		hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(cp.handle), &cp.handle);
+		__hci_req_remove_ext_adv_instance(req, cp.handle);
 
 		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 770b937581122..7c0c2fda04adf 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1179,13 +1179,8 @@ static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 void __hci_req_disable_advertising(struct hci_request *req)
 {
 	if (ext_adv_capable(req->hdev)) {
-		struct hci_cp_le_set_ext_adv_enable cp;
+		__hci_req_disable_ext_adv_instance(req, 0x00);
 
-		cp.enable = 0x00;
-		/* Disable all sets since we only support one set at the moment */
-		cp.num_of_sets = 0x00;
-
-		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp), &cp);
 	} else {
 		u8 enable = 0x00;
 
@@ -1950,13 +1945,59 @@ int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance)
 	return 0;
 }
 
+int __hci_req_disable_ext_adv_instance(struct hci_request *req, u8 instance)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *adv_set;
+	u8 data[sizeof(*cp) + sizeof(*adv_set) * 1];
+	u8 req_size;
+
+	/* If request specifies an instance that doesn't exist, fail */
+	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
+		return -EINVAL;
+
+	memset(data, 0, sizeof(data));
+
+	cp = (void *)data;
+	adv_set = (void *)cp->data;
+
+	/* Instance 0x00 indicates all advertising instances will be disabled */
+	cp->num_of_sets = !!instance;
+	cp->enable = 0x00;
+
+	adv_set->handle = instance;
+
+	req_size = sizeof(*cp) + sizeof(*adv_set) * cp->num_of_sets;
+	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE, req_size, data);
+
+	return 0;
+}
+
+int __hci_req_remove_ext_adv_instance(struct hci_request *req, u8 instance)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	/* If request specifies an instance that doesn't exist, fail */
+	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
+		return -EINVAL;
+
+	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(instance), &instance);
+
+	return 0;
+}
+
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
+	struct adv_info *adv_instance = hci_find_adv_instance(hdev, instance);
 	int err;
 
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-		__hci_req_disable_advertising(req);
+	/* If instance isn't pending, the chip knows about it, and it's safe to
+	 * disable
+	 */
+	if (adv_instance && !adv_instance->pending)
+		__hci_req_disable_ext_adv_instance(req, instance);
 
 	err = __hci_req_setup_ext_adv_instance(req, instance);
 	if (err < 0)
@@ -2104,7 +2145,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
 
-	if (next_instance)
+	if (next_instance && !ext_adv_capable(hdev))
 		__hci_req_schedule_adv_instance(req, next_instance->instance,
 						false);
 }
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 0e81614d235e9..bbe892ab078ab 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -86,6 +86,8 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
 int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance);
+int __hci_req_disable_ext_adv_instance(struct hci_request *req, u8 instance);
+int __hci_req_remove_ext_adv_instance(struct hci_request *req, u8 instance);
 void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 686ef47928316..f45105d2de772 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7504,6 +7504,12 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
+	/* If we use extended advertising, instance is disabled and removed */
+	if (ext_adv_capable(hdev)) {
+		__hci_req_disable_ext_adv_instance(&req, cp->instance);
+		__hci_req_remove_ext_adv_instance(&req, cp->instance);
+	}
+
 	hci_req_clear_adv_instance(hdev, sk, &req, cp->instance, true);
 
 	if (list_empty(&hdev->adv_instances))
-- 
2.27.0.389.gc38d7665816-goog

