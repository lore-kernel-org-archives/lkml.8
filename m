Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544AAC433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2845020656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XAIKwqvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgG2Bmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730670AbgG2Bmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:42:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 18:42:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so13365780pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBfnuzv8V/FS7CoKVmoMtrjti5jBBE6yafdUJVDo5Po=;
        b=XAIKwqvY7po1TDCttQKQqO/e8Ma4OJJxW1T7PIH7joYSz1wRad0wSNfTy589TpD044
         Y/YZjJnATRIfGlCUGLFIT6eh/4FfuiICRwEPHELE/uCuNCoonPbraCn+Uta4RZKvu/Lp
         eXHEnZkEU2hePZ5Tn8pUOcG4eaydYHRI0kR/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBfnuzv8V/FS7CoKVmoMtrjti5jBBE6yafdUJVDo5Po=;
        b=OXTI2XijRpnqvTtPt+pYnS9gabDTt4k/63bwM5I7BmtkFLq284NiSuNOeyp/K6lyif
         QNU7weBFu4fXPDJnMz/BjiYL6bK0prb2x5Z99SuEbQfM8pC6HaeLOn1d+66mSq+tUEjE
         cg8RDGcjb/QmSqM1Y2Dt4fJsS9HSQrQX4nWZkw1Ov76+yf3j9RaoBT0Rs2dsGGpKjz4u
         mEk1x7OAj4A1N48viAsfZUp3Ps6Pduq7h/kx5SB8ZMm0BSsHsgCiaiCAgJ0Ntn8jlxOb
         eBsaP5yp/GknGQ5C2eEt2DjSmDolJLqkCqSvYa2jdt86M5Fa58VnEt5LNQHHT6WFhnve
         K79Q==
X-Gm-Message-State: AOAM532/y3/06jtKhdaMba6SfUiZssMI0Yl1K8iwfuQxLUavt5BvGf2o
        lR0SER6pzJSkDy/8EWPb3q+JW81GV0c=
X-Google-Smtp-Source: ABdhPJxYRdtAaml7y8yAJ+rrQl2TGi33yo+vrV97Qz+dt2ids7LCidVHdRJ93RKUkmsFGZ3RSn/e6Q==
X-Received: by 2002:a63:2482:: with SMTP id k124mr6002008pgk.332.1595986961855;
        Tue, 28 Jul 2020 18:42:41 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id e124sm280678pfe.176.2020.07.28.18.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:42:41 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/3] Bluetooth: Add suspend reason for device disconnect
Date:   Tue, 28 Jul 2020 18:42:24 -0700
Message-Id: <20200728184205.2.Ib9bb75b65362d32104df86ffad479761680bb2cb@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200729014225.1842177-1-abhishekpandit@chromium.org>
References: <20200729014225.1842177-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device disconnect event with reason 0x5 to indicate that device
disconnected because the controller is suspending.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d9a88cab379555..1a98f836aad126 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -840,6 +840,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
 #define MGMT_DEV_DISCONN_AUTH_FAILURE	0x04
+#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND	0x05
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1c89ae819207ac..fcda479134c756 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8124,6 +8124,10 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.reason = reason;
 
+	/* Report disconnects due to suspend */
+	if (hdev->suspended)
+		ev.reason = MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND;
+
 	mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
 
 	if (sk)
-- 
2.28.0.rc0.142.g3c755180ce-goog

