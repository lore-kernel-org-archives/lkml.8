Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFED6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7E420734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGuDoDjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgFBBn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgFBBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:43:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 18:43:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so14980691ybn.21
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3SD2wXCrnpqqqGjUo6uJ3X+OXN7BvMIdCCqQSQJ14xI=;
        b=VGuDoDjLffnb36Mz+dHxNMFnAXp2hgYxwrQnwJj6V/JqLJq/LAuENWgNkf1SQFlBUI
         mRQsj7QkIlcA2G+1seDqPjg6CE7H7MHaxHMve8iERkXT+GgSGcJN2QwNaAhma0q04+h+
         4q8UtRz1CwcfA9zQF/NINeFh3lVqRN2mzgz6AKKKfk4TfnGvWFAe8PIyu3t3gsteSJu1
         B7MGN4XgQjqu4DyORjQdFOvVDpDCf/b6dLPV8/oIlhhEK+uYT0uC1xvx9JIIs8xEmuwF
         0qcElEZekbxwd3OWMNeYIr1GB3kYIzYu51HR+8hlnmEVak7pSl9GqwDOO4dp6KFVLzps
         FS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3SD2wXCrnpqqqGjUo6uJ3X+OXN7BvMIdCCqQSQJ14xI=;
        b=hczkLV+EJA2HNOTP+V9zZ/R++AvGTf2mZAHYcbbshlaHzz2EknuqMESoQNz0vpzarK
         g2gOBKGbMWrue0lt/rjJZVrdxDkA5sNMBkRg6zCRybw9cy+8xNcIUIvil7Fqul/OlkEu
         MKtr7fAEO8OBj/mwayNTDChIIAgVD9GhKFTNPWziVue2m8hdwdr5VxPcL1oXB2BorD75
         968ik4q8Y36ei8ibp4D3mtad/KDRbF1RextXp6RmSidIeQSdbFjclFfBeqGPEf4g0k3/
         MWjfYSOwc4dtExPfbK+Z5U4w6Pt+F5gXnXAg455c6kEuGX0Vv11dkLODJhTJ1W/KwpUu
         rnXQ==
X-Gm-Message-State: AOAM532F2Q7p/Iwv8Xmh7b0lPuu9cAQUTdYSog7mR5CMX9JJwJC92FiE
        3pvdJUdo2Sn7CN23E43fYGhlBl4stzgFLA==
X-Google-Smtp-Source: ABdhPJzvSDdGNn7xHWKBGxaSlUL77s0Uk7gIgVjBgWa1SmrYs3n77rFdUSAvuBEmmcSC+hcPI8jDWwD413gYuQ==
X-Received: by 2002:a25:b8cb:: with SMTP id g11mr35775711ybm.189.1591062206411;
 Mon, 01 Jun 2020 18:43:26 -0700 (PDT)
Date:   Mon,  1 Jun 2020 18:42:51 -0700
Message-Id: <20200601184223.1.I281c81384150e8fefbebf32fa79cb091d0311208@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] Bluetooth: Check scan state before disabling during suspend
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     abhishekpandit@chromium.org, linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check current scan state by checking HCI_LE_SCAN flag and send scan
disable command only if scan is already enabled.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/hci_request.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1fc55685da62d..1acf5b8e0910c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -998,8 +998,9 @@ static void hci_req_set_event_filter(struct hci_request *req)
 
 static void hci_req_config_le_suspend_scan(struct hci_request *req)
 {
-	/* Can't change params without disabling first */
-	hci_req_add_le_scan_disable(req);
+	/* Before changing params disable scan if enabled */
+	if (hci_dev_test_flag(req->hdev, HCI_LE_SCAN))
+		hci_req_add_le_scan_disable(req);
 
 	/* Configure params and enable scanning */
 	hci_req_add_le_passive_scan(req);
@@ -1065,8 +1066,9 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		page_scan = SCAN_DISABLED;
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
 
-		/* Disable LE passive scan */
-		hci_req_add_le_scan_disable(&req);
+		/* Disable LE passive scan if enabled */
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+			hci_req_add_le_scan_disable(&req);
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
-- 
2.27.0.rc2.251.g90737beb825-goog

