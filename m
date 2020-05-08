Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776FBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567DA24953
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgEHXOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 19:14:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEHXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:14:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jXCCd-00064O-A7; Fri, 08 May 2020 23:14:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] net: tg3: tidy up loop, remove need to compute off with a multiply
Date:   Sat,  9 May 2020 00:14:47 +0100
Message-Id: <20200508231447.485241-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the value for 'off' is computed using a multiplication and
a couple of statements later off is being incremented by len and
this value is never read.  Clean up the code by removing the
multiplication and just increment off by len on each iteration.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Use reverse Christmas tree variable declaration style

---
 drivers/net/ethernet/broadcom/tg3.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ff98a82b7bc4..7a3b22b35238 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -10797,17 +10797,15 @@ static int tg3_init_hw(struct tg3 *tp, bool reset_phy)
 #ifdef CONFIG_TIGON3_HWMON
 static void tg3_sd_scan_scratchpad(struct tg3 *tp, struct tg3_ocir *ocir)
 {
+	u32 off, len = TG3_OCIR_LEN;
 	int i;
 
-	for (i = 0; i < TG3_SD_NUM_RECS; i++, ocir++) {
-		u32 off = i * TG3_OCIR_LEN, len = TG3_OCIR_LEN;
-
+	for (i = 0, off = 0; i < TG3_SD_NUM_RECS; i++, ocir++, off += len) {
 		tg3_ape_scratchpad_read(tp, (u32 *) ocir, off, len);
-		off += len;
 
 		if (ocir->signature != TG3_OCIR_SIG_MAGIC ||
 		    !(ocir->version_flags & TG3_OCIR_FLAG_ACTIVE))
-			memset(ocir, 0, TG3_OCIR_LEN);
+			memset(ocir, 0, len);
 	}
 }
 
-- 
2.25.1

