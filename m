Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A655C20709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHBIRx0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgETQcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgETQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:32:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C551C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:32:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci21so1543383pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eb41g2AQad/byf93tKxgnf75XG7RNiTm+eUN7CnVN4Y=;
        b=dHBIRx0wpM2xPNmVoPIb1MI54tyUz4U0r9wZNgrRDJWNV61AMhQKsEJ58rB/1ir/iD
         FPiWFAnqxut8ERkHSt4eacFJaoXHkdCyo7oq7/+ZPicKJx0FDdGJVix+TjKCCis3yzwU
         6mBFCM4rN9d4a6+hTurOvL4Aep2yJwl4r2Puw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eb41g2AQad/byf93tKxgnf75XG7RNiTm+eUN7CnVN4Y=;
        b=HJ2Td88Ci+KjQegBIsoEurXHFv28O6vz0xmUxJd4XbXFwhLloM6+3akgT1s/WApUib
         uoiUK0Z5te1OdrDRSqpcRqsvCQQE2nCGMiECHOB56iJRoo7M2KoVoC4jo4/KAVcd1yDM
         YdPGyLhFH64qGNT6N40OJoOVHysYliQRvq1LzqlOmlFedDCLklMo7m/T6l0hgjhkaJKa
         97h5nXbu4KAd/v4QJqUdSBqzcdW19FUJKWEarLaTlVPCi9Y0mczwOfSV15aVnQ2fhaUx
         BlEjqE9hUDTb5HU2srFtx2P0AFOBWAqJamh1w6HxDyyB5I2M/rov8Hfq+ojvQhxBeToP
         RpoQ==
X-Gm-Message-State: AOAM532hxS+n/+0y46xccSJ27zUYDOFzOr51d+kcG53u10fUlUudDCRr
        RwAieamRnhnocNwW8LsHu6ShSw==
X-Google-Smtp-Source: ABdhPJxniiNq3ehWpj5I8r6TNirnznzrwfENT/hACu0Fau8x0GZmekPmzIEMagJxmoErHrgs2d0qrA==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr6547868pjo.127.1589992363972;
        Wed, 20 May 2020 09:32:43 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id n23sm2349648pjq.18.2020.05.20.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:32:43 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     dan.carpenter@oracle.com, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix uninitialized access to hdev
Date:   Wed, 20 May 2020 09:32:28 -0700
Message-Id: <20200520093206.1.I1a56163c173e14d1cc7a8b639147466171525eab@changeid>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdev is always allocated and not only when power control is required.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 26efe822f6e58..e4a68238fcb93 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1947,8 +1947,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
+	hdev = qcadev->serdev_hu.hdev;
+
 	if (power_ctrl_enabled) {
-		hdev = qcadev->serdev_hu.hdev;
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		hdev->shutdown = qca_power_off;
 	}
-- 
2.27.0.rc0.183.gde8f92d652-goog

