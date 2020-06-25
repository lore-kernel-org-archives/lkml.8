Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF84C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB59020768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BC5QnNm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390967AbgFYX0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390262AbgFYX0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:26:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEC0C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so1752000pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcg6bLKAHJ0/BxsC+brekPNOiBl21FKQYq+hY1Ge/R8=;
        b=BC5QnNm/L9fi0/7m8QzEN2dxwRm+UEWAUD0wfyKtJN3dH3RSF2OfNu+WtclANsPrj0
         tccUpSmsJU6AXH4UrZsO6uoZhCt2UkUkc+F3mD5CpUKXZYyuWLUNOGBNl2XGZYTF3WZr
         ijY/VFyXQ74HchwLZNMFyPvcLQOxOcA/UoQ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcg6bLKAHJ0/BxsC+brekPNOiBl21FKQYq+hY1Ge/R8=;
        b=r8Sh7lndVNQAQCedDQbcaMziCc/pX94iRAEUUzOY0A1jqNAWabFzPOr59t+S2HTlSo
         H2+DTGd/Ou8umnYRyQCU1UyLysqSQFjHPhnj7/Ov6Llye0NwibIjE2/HnoAIlu/z7bg8
         hZTCgDUiRwmOhnVkvsx35ZbbBP5aM0XltXybgajYmXqsjuuFEwNbcECMV3H1k6sE8eMH
         yxODcWe4MfFaNCpedlfJv0qgyfLFbyn3dVvmH0XFQWZZ2gnSXl9vRyjYehqfwanUmBTt
         S2PNFVydheyZFPn20SIzd4dXclhVj6wg5ndqUyGXWLhqAe5/j9KnbQ+KNzfYLTTj5PuL
         nXVQ==
X-Gm-Message-State: AOAM533Y6N6vFLU2u8Qsfa1SPPtu/4gUbj/R0jlDsoZNwUsph0pMV9UT
        n5Eo2Wr1VZZYT0JhPDRUCgKNZAsLm/E=
X-Google-Smtp-Source: ABdhPJxbIKdpaqZK2+wHlfbZwwz6bF78GirDWwQUzayQq/pWbTr2e2gviyY7c0WS4IBaYh/15HOjxg==
X-Received: by 2002:a63:182:: with SMTP id 124mr232820pgb.288.1593127594156;
        Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id f207sm8901936pfa.107.2020.06.25.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:26:33 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, Oliver Neukum <oneukum@suse.com>,
        linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Comment on unbalanced pm reference
Date:   Thu, 25 Jun 2020 16:26:27 -0700
Message-Id: <20200625162544.1.Iea2fbf7a284191c0f09c2ffbe8c14b872d0f68b2@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment clarifying that a PM reference in btusb_qca_cmd_timeout is
not unbalanced because it results in a device reset.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f8a71fdabb3d1b..0e143c0cecf2a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -581,6 +581,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
+	/* This is not an unbalanced PM reference since the device will reset */
 	err = usb_autopm_get_interface(data->intf);
 	if (!err)
 		usb_queue_reset_device(data->intf);
-- 
2.27.0.111.gc72c7da667-goog

