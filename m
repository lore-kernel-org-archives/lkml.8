Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DA6206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="noElnCmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGUChd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:37:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6261C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:37:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a24so10010911pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iFj+VYGc+pNg7a3sKnrHzO0tOtNEDnzb7gZ2GZVQs8=;
        b=noElnCmRRcf07/EwPZXseNlTjLl7oyF5hncD1UoH/a7QU9ljzes9KOXJQPW87AG8oJ
         35HwfsZuhrgIrCJPNU2o0mgDT9nhrM7OHmgQbsUHAPPv6rjVJptumWmlZb5aCkcmG9wp
         UVVRUS3MO+8/cFaXKzHgNabWiaZzRRLLUfogo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iFj+VYGc+pNg7a3sKnrHzO0tOtNEDnzb7gZ2GZVQs8=;
        b=YMQsXw1c6XMRU0JqC3Qp8UfCrK4yf4+/SLZ2D7uyc3zww9HTmyfbh1Bp2UzXVs5v3p
         +GX52eG/qCLm69icIpGCueXj5mjk0rWuDo/E4AXsKPs5q4+DOBY/01KPMu81ITsAEITw
         KN74Nc/xmBut1SQCX6A1oB+6wT8KsoiAJ4ZlRZNlEEJ0wFTrfsLjCLUf/xh0DHeeTTIj
         l+JnSxSgti1/HYzWasSV7w32/ww0P5qySFwKrChSA2rFe10Cv+nVKcPnv9oZ8o/ZdNqT
         RvSSrqpv67qPRT4BqwyxNn056jd0cebbHkiMQm89+RYPM7QoMUuZGvN3j+8gzWtsZD88
         EzLA==
X-Gm-Message-State: AOAM530HiBp36z6Ibb6R25ZrhapdOdAxylocgQbJr0VNMM2JeMhajppY
        d8egTnYz1JAzBf7stzP1zoUDAA==
X-Google-Smtp-Source: ABdhPJybp2k+BYGwk3hoadcZotDg0bccX+mZOYTZdEOKiuC6mz/d1aDLcwfDGdDWCJ1he1lkB8yNGA==
X-Received: by 2002:a63:e017:: with SMTP id e23mr20944311pgh.125.1595299052135;
        Mon, 20 Jul 2020 19:37:32 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id z6sm17888266pfn.173.2020.07.20.19.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:37:31 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_h5: Set HCI_UART_RESET_ON_INIT to correct flags
Date:   Tue, 21 Jul 2020 10:37:15 +0800
Message-Id: <20200721103652.1.Idbc7eddf1f24f750a8bbcbc8e06743736ae3be31@changeid>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HCI_UART_RESET_ON_INIT belongs in hdev_flags, not flags.

Fixes: ce945552fde4a09 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

 drivers/bluetooth/hci_h5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index e60b2e0773db110..e41854e0d79aae2 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -793,7 +793,7 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (!h5)
 		return -ENOMEM;
 
-	set_bit(HCI_UART_RESET_ON_INIT, &h5->serdev_hu.flags);
+	set_bit(HCI_UART_RESET_ON_INIT, &h5->serdev_hu.hdev_flags);
 
 	h5->hu = &h5->serdev_hu;
 	h5->serdev_hu.serdev = serdev;
-- 
2.28.0.rc0.105.gf9edc3c819-goog

