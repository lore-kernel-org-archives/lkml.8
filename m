Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E2FC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF6D20732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJJO4KUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgC2KGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:06:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35138 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2KGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:06:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id f74so6850878wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDlXgGi+Z3+Qe0YXBUomDwVMmX3I0aaEPSRRpRISjUw=;
        b=FJJO4KUejCReB6AwWaE87oh2ahe07+JIy9/igzeJULLN+J9lHc7q/kBD0Tns2R99mM
         UZRsMMx/Ag4SmuDYjLhIKbO14CXAdYvllxG2wtudlCKC4nWW8mjYrPvlOUZeN7a3ANOw
         vVQavMl1L6EDDd/tiUicd5WFy4QkFz4GRitGOXnQx5+Nl3MKN6hC8RXdTezuW00OxtZY
         HvEqcKkWyKHHbe6tJoJmAjte9jGqyiUyawuz/eiYDWQXCZgLU6cdvQoDNR+IX6897cPu
         xg5bHdN5VWn/T3WdqauB0ONkejLvDd8L/S/I32ATN4r+NkQmcevoB3hMyx2MoxKtAXYl
         8xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDlXgGi+Z3+Qe0YXBUomDwVMmX3I0aaEPSRRpRISjUw=;
        b=HptDxsctSxhj4BcJY+H4+JokZJBJiGzIiqnAC+n8d4pFeN1OL7Bw9dn2uTzHIBOsQB
         LilvDaJL7GDV2uBCt3lVoL5Xb5YzJNG95g17DNn4JXgexQlug0wx5bOPzuLS0jsgOwVh
         wo6jR3pvN16q7KUXvenE/rlVC7dhYh5l+7dL1bkHs9a4Tgd8zD6ZGzwYN134OXIH5EN/
         Bv2mGHu+qbmNAmgw6BM9Y9KT961wP3SRaXcKFI5xumIyKdUJwRxT28IN9lClQ8QFijdf
         30qdiXwL9XfbuuJZSXup284SrkJs2Ar5nze0jUrbRhkAVyB+IvCPjNWj7BvFHNLLmzLB
         BPCQ==
X-Gm-Message-State: ANhLgQ3HtT0f44Oh4wkQnjwvRZvJag36BKDz+z97uxcxsxeVhEQdRe+I
        4TR/3Hs1DTMEJRppFYDINGo=
X-Google-Smtp-Source: ADFU+vst8vc18G3cSMmIxN49Q+LrGT+rT0taHECMwGJg7eBcezImS7osmI2krGCMP84PX3y1ZYXDag==
X-Received: by 2002:a1c:197:: with SMTP id 145mr7597511wmb.42.1585476382803;
        Sun, 29 Mar 2020 03:06:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-227.178.006.pools.vodafone-ip.de. [178.6.252.227])
        by smtp.gmail.com with ESMTPSA id o14sm15725578wmh.22.2020.03.29.03.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 03:06:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: refactor Efuse_GetCurrentSize()
Date:   Sun, 29 Mar 2020 12:04:50 +0200
Message-Id: <20200329100450.10126-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor while loop in Efuse_GetCurrentSize() to reduce indentation
level and clear line over 80 characters checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 33 +++++++++++-----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index c525682d0edf..9bb3ec0cd62f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -370,28 +370,27 @@ static u16 Efuse_GetCurrentSize(struct adapter *pAdapter)
 
 	while (efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data) &&
 	       AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-		if (efuse_data != 0xFF) {
-			if ((efuse_data & 0x1F) == 0x0F) {		/* extended header */
-				hoffset = efuse_data;
+		if (efuse_data == 0xFF)
+			break;
+		if ((efuse_data & 0x1F) == 0x0F) { /* extended header */
+			hoffset = efuse_data;
+			efuse_addr++;
+			efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data);
+			if ((efuse_data & 0x0F) == 0x0F) {
 				efuse_addr++;
-				efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data);
-				if ((efuse_data & 0x0F) == 0x0F) {
-					efuse_addr++;
-					continue;
-				} else {
-					hoffset = ((hoffset & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
-					hworden = efuse_data & 0x0F;
-				}
+				continue;
 			} else {
-				hoffset = (efuse_data >> 4) & 0x0F;
-				hworden =  efuse_data & 0x0F;
+				hoffset = ((hoffset & 0xE0) >> 5) |
+					  ((efuse_data & 0xF0) >> 1);
+				hworden = efuse_data & 0x0F;
 			}
-			word_cnts = Efuse_CalculateWordCnts(hworden);
-			/* read next header */
-			efuse_addr = efuse_addr + (word_cnts * 2) + 1;
 		} else {
-			break;
+			hoffset = (efuse_data >> 4) & 0x0F;
+			hworden =  efuse_data & 0x0F;
 		}
+		word_cnts = Efuse_CalculateWordCnts(hworden);
+		/* read next header */
+		efuse_addr = efuse_addr + (word_cnts * 2) + 1;
 	}
 
 	rtw_hal_set_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
-- 
2.26.0

