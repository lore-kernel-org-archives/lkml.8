Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8790EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6821220772
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nQINTuhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgFFQxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgFFQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 12:53:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C581C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 09:53:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n23so6652753pgb.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5IVH1RwzvBNNs3Ev+MESymL21dtR3SdkYna0gV8RxU=;
        b=nQINTuhWAAicRnz2ghEqTIn25FM3Ewcis2VL8L5y6Hb4kXs/eCAqK801+466JhsDnp
         2ikJYEE69xieRXEEXoaBPkPEMnc/4ifwCiKFLzAUB1pa9mf9S+41+J1jah+f5RH4FrWG
         kp8CFiE3mrweQUzkZpKavdekq4It5mFYjOrQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5IVH1RwzvBNNs3Ev+MESymL21dtR3SdkYna0gV8RxU=;
        b=GC1zKGJzbhAcoaM1ghRSH0/YPLn/No9C0kQEFU8TGmDpM5YeUPk7EyiSC6WuM01XX4
         8EHUieoImKm44rmjgd3/mIGYsTcJCjz9A7K60xAcPIX6O7k2Lrux5vWFmgS3M+kcYWZ1
         D0XyPRVHw7mgU+T6cJSMgPGG1WGW6SwOQi9hlHt/ONbn8HFiM+DKgLe560ADGlbbpMbx
         E/r7PLP/ElXBG6e26e5fDXUvt63WQckKjkX/k/IlbRzN8hNw8xh7A9bcJmL7s62qXPWs
         7R2jcQswk7PkjvEzYaI0e3E6mAIyDcb1cjckqpqtZ8lJTo4iaGGfUFq5B5xeT7lE+80C
         +zEg==
X-Gm-Message-State: AOAM530ORaefawhu2WaEFCvm+nejlVtnVzGCgS1XnlIoTXvrtvh/ux5i
        z/mzAcRm+nSS1zO+JvENLisnNPHU0LM=
X-Google-Smtp-Source: ABdhPJzzkMi+G5IoPOU0HA2fN/Lr7dQh0S9WHWfDRe//TUqC//7tGTTL5PZjjABfnQbfxON0vUDU8w==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr13980299pfu.164.1591462390161;
        Sat, 06 Jun 2020 09:53:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s197sm2796539pfc.188.2020.06.06.09.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 09:53:09 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: Simplify determination of serial clock on/off state from votes
Date:   Sat,  6 Jun 2020 09:53:06 -0700
Message-Id: <20200606095259.1.I0683ea838b69285993c176396349b084562b4e19@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serial clocks should be on when there is a vote for at least one
of the clocks (RX or TX), and off when there is no 'on' vote. The
current logic to determine the combined state is a bit redundant
in the code paths for different types of votes, use a single
statement in the common path instead.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/bluetooth/hci_qca.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 836949d827ee9..997ddab26a33b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -289,25 +289,21 @@ static void serial_clock_vote(unsigned long vote, struct hci_uart *hu)
 	case HCI_IBS_TX_VOTE_CLOCK_ON:
 		qca->tx_vote = true;
 		qca->tx_votes_on++;
-		new_vote = true;
 		break;
 
 	case HCI_IBS_RX_VOTE_CLOCK_ON:
 		qca->rx_vote = true;
 		qca->rx_votes_on++;
-		new_vote = true;
 		break;
 
 	case HCI_IBS_TX_VOTE_CLOCK_OFF:
 		qca->tx_vote = false;
 		qca->tx_votes_off++;
-		new_vote = qca->rx_vote | qca->tx_vote;
 		break;
 
 	case HCI_IBS_RX_VOTE_CLOCK_OFF:
 		qca->rx_vote = false;
 		qca->rx_votes_off++;
-		new_vote = qca->rx_vote | qca->tx_vote;
 		break;
 
 	default:
@@ -315,6 +311,8 @@ static void serial_clock_vote(unsigned long vote, struct hci_uart *hu)
 		return;
 	}
 
+	new_vote = qca->rx_vote | qca->tx_vote;
+
 	if (new_vote != old_vote) {
 		if (new_vote)
 			__serial_clock_on(hu->tty);
-- 
2.27.0.278.ge193c7cf3a9-goog

