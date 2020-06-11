Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFC3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5B9206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bI0QHc97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFKByO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgFKByH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:54:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5154C08C5C4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:54:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so1709662plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68tOX7LFGwg3KdrWFaND58PhUb0yFjG30aqSPFP4qOo=;
        b=bI0QHc97vrE2ixZB3Ft5YFX2q3YGOLN8XZOWaIdcXk6oSwQhBoTngxIbHYA/p5H2eF
         qKJkFpEX566vocBObSrMWXEaJzhz2aKnfSqWJuOBpJn36aATpUouuOcI/APl14505Bb1
         mPhuGpAqDeS9MhAu1xh1uMBniCzK4iZQ2HZSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68tOX7LFGwg3KdrWFaND58PhUb0yFjG30aqSPFP4qOo=;
        b=sQS1KBeDpcuF3TK+pW8xGS7KOQ0TKGysTBNb/k6oDTKLuikKcF9wllHMoREMX282sQ
         1liCsyjyJeiVjtLbpBIs+MV4Zf7RVYaBGM8v6BlNxoVZrMY2ynszrGq5J5b81W1VwrPl
         Gt1FpTqiNIoka5FsnCDQrp069EMMkWWTRwvex7IRueMGnmOw+6XhSjbNg99vNKxquFIm
         p+58pR5D9DZQgm9SJLUS7Obg5unq9sRdKLSapp+UVDGPz2Xc6EKp4Z9Kv3kYXaGdeh/H
         BSvx5u/7+SsKvm3q3Trr31cccYB8/LvcGOiNVdVpjvvSzrEf52ZoCWAocUVE3ahbiV1A
         8aug==
X-Gm-Message-State: AOAM531eqssGw0NqpGCeecZcdihSOlIEdYY8uEtNa0bsw7zi48GngInZ
        qtsbR4YBTWLdTICG1VZff9NqWA==
X-Google-Smtp-Source: ABdhPJyB39hYptqE3xQPM4crTPBVQQmD7IFP/wMWPf+cpsmhSEX6xrwYWTCiONcgocktbarjbC642Q==
X-Received: by 2002:a17:90a:898a:: with SMTP id v10mr5470622pjn.95.1591840445210;
        Wed, 10 Jun 2020 18:54:05 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b191sm998661pga.13.2020.06.10.18.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:54:04 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtman.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        mka@chromium.org, dianders@chromium.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: btmrvl_sdio: Implement prevent_wake
Date:   Wed, 10 Jun 2020 18:53:54 -0700
Message-Id: <20200610185214.2.I317eb69189c90ed26ba88e996f7df59ee62c2495@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200611015355.186666-1-abhishekpandit@chromium.org>
References: <20200611015355.186666-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the parent device's power/wakeup to control whether we support
remote wake. If remote wakeup is disabled, Bluetooth will not enable
scanning for incoming connections.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/btmrvl_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 47e450903af423..8b9d78ce6bb29e 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -587,6 +587,14 @@ static int btmrvl_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static bool btmrvl_prevent_wake(struct hci_dev *hdev)
+{
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
+	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
+
+	return !device_may_wakeup(&card->func->dev);
+}
+
 /*
  * This function handles the event generated by firmware, rx data
  * received from firmware, and tx data sent from kernel.
@@ -688,6 +696,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	hdev->send  = btmrvl_send_frame;
 	hdev->setup = btmrvl_setup;
 	hdev->set_bdaddr = btmrvl_set_bdaddr;
+	hdev->prevent_wake = btmrvl_prevent_wake;
 	SET_HCIDEV_DEV(hdev, &card->func->dev);
 
 	hdev->dev_type = priv->btmrvl_dev.dev_type;
-- 
2.27.0.278.ge193c7cf3a9-goog

