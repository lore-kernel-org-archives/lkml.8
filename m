Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA17C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A814C20725
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqGx9xHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgEINTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEINTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:19:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D07C061A0C;
        Sat,  9 May 2020 06:19:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y4so4574296ljn.7;
        Sat, 09 May 2020 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fZJtWkOkMNUl6XTsiHiADWF9Kc6RxsIGqhrfQi5dRk=;
        b=eqGx9xHMrXUUYA8PoEaJxXK+ild5Er04ALdMkmF2GBS6bgUG6+auJPq/dgqYbPzrHr
         ugSMviR2iyfGXcP45VXnRxRVAFfnp9bZC/EcgnDeEZjmUFhyTba9Ve3aO2Hx2zBU2BME
         Llqf318kX2bEeDl/ILaapokcZsY5ObVpOFoIw4rUBAo9ezPzrbQNZXzJFdGJIaw7Lrmi
         zU/NtJmCfEPK+BtZ1Bp2jm9s1QV5ElRk0GFkGGFQNCSOHfYcgGRwUX88vgn9mMhnxwnz
         tyYBsOI2o68CUm9/LkkUN+w0d3O/Xi9TmAh7IXlgSmACEHL31xXCDB2EGmGZaY+/sVXd
         J9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fZJtWkOkMNUl6XTsiHiADWF9Kc6RxsIGqhrfQi5dRk=;
        b=S12NPtng5JIJwidUDZb/ncS8fr7E/o6oZqf1H11W/z/MAfY+mdUTFrwf544fsrfWe1
         i7iZFHDvQ2MRzeclix1Y0h8Tb9tTdeFDitkzozgI2OLoRe5yeSJ9V8x3RsNO5sLJxCfU
         u7/CO1BPpBMRFZkjVxOgaRhqHM970rVMnMa0l+nBTAs6TEAsD9DIp3L7YKoaBQ7y1ArF
         SaI0iwgj2cY8HdRL7MDhi9yA7jodoeE05JWuyEiZDYIPE7gLKeed7wsWK2j29QvSnAGl
         dBc6fuudxFr4HXXjcr6YgjEM/4Bb/mydF2HNvDkI+KYcOSUC5F5QxdMgHnWCxwyq5MX+
         yQCw==
X-Gm-Message-State: AOAM530QRBB43W3G/DzQHrDpGwhhnuTWUDlQq3vV1Nd5uEt27v3/bKrQ
        aRhCf+TVvHjZ/CXsih5eV12MJRUryO4=
X-Google-Smtp-Source: ABdhPJxmYVz6a9UOmFgdn5YnqxO0IIk8isZ6TsCVXS9pSZ1zCIee0z33rBdcNfsvJ4yydD4ptNcimw==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr4799815lji.225.1589030339581;
        Sat, 09 May 2020 06:18:59 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id e25sm4075185lfb.89.2020.05.09.06.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 06:18:58 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] Bluetooth: serdev: Constify serdev_device_ops
Date:   Sat,  9 May 2020 15:17:19 +0200
Message-Id: <20200509131719.5681-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serdev_device_ops is not modified and can be const. Also, remove the
unneeded declaration of it.

Output from the file command before and after:

Before:
   text    data     bss     dec     hex filename
   7192    2408     192    9792    2640 drivers/bluetooth/hci_serdev.o

After:
   text    data     bss     dec     hex filename
   7256    2344     192    9792    2640 drivers/bluetooth/hci_serdev.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 4652896d4990..599855e4c57c 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -21,8 +21,6 @@
 
 #include "hci_uart.h"
 
-static struct serdev_device_ops hci_serdev_client_ops;
-
 static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_type)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -260,7 +258,7 @@ static int hci_uart_receive_buf(struct serdev_device *serdev, const u8 *data,
 	return count;
 }
 
-static struct serdev_device_ops hci_serdev_client_ops = {
+static const struct serdev_device_ops hci_serdev_client_ops = {
 	.receive_buf = hci_uart_receive_buf,
 	.write_wakeup = hci_uart_write_wakeup,
 };
-- 
2.26.2

