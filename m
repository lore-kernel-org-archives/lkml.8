Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B08C2BB55
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:01:34 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD9E20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJaWdMZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD9E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgDMDBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 23:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgDMDBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:01:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4118C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:01:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j4so8189711qkc.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mQX+KyXjCVkEwrSR2o41b1Ot5pYdAT4bZiqTAuIYN0=;
        b=aJaWdMZkG1cE5j/Wm8VZt8qgiOX8psJyOjp/o9CICZev/QYcRMFKDimRoNo5hH/Qu1
         Y3jGDooRVtdbrsIBFLqBpqbsXFa85w5osXid8My4Dw8C0CbQzez1XWzW2S19AW2NqqB1
         NlbnPlc9kqy1J5+sgGlAf24hUhfrqY7WRoq3qUHVVPzBAuBNQaCgra39URVcSZRtt0z3
         nXLOWaDQQohYJjJZFgaDLSAg2O7r5Hsaw56MrUh501zlYBna/YdLHxz+1e8zZFEHHlvr
         72obBKgvXHrvsYRPjFP0hHTq+EGeTFMQ2AvAwJRJazasdALpPX3XKONIb1IlKN04tn18
         TyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mQX+KyXjCVkEwrSR2o41b1Ot5pYdAT4bZiqTAuIYN0=;
        b=nrFbSze9XGnFV+1Aze60NGTb0E5jSN7wx1mvYfi6M02rBub1zGc3bK3Wgb6Dfio07X
         9BMlF4sIhpIKjEFpI4G5FFJ8P4NAnvHssBQMRRRQF7+hR9PDRhkHNjH5wdVeNn3hsOXc
         LNf0jxqssfU/9tMCAStvXHU+M6O9I1kH0sjfml9DNFcmckgCjqkkjFjH5RnMF3DLtUD0
         pnR2bAQOtsd5bAGgcD3JwBF0G2Gr1KTbDSKvnJuADp/5P23elCDPEmQ0NfKd6Di2oUK6
         kUZbo1/aoV8DRh83VwLPUQ6lKKIzB6w2j7OikrYTG/Y+9mEMQZOSBMfvubEmRLIgf+Y0
         8CSQ==
X-Gm-Message-State: AGi0Pub9afyzAyu8PWpC2BLotghNloY0VGcQCA6GZ9liNwCUvjCfXB+7
        0oLBy3ntOCBPbKZWpd3TZBE=
X-Google-Smtp-Source: APiQypJZp9gK8i5BNduuh+7QfE4lAzdYgPYn7wCiXiZdGKkngk+UH8/k/2jGb1lsTCCHQFbF3an3BQ==
X-Received: by 2002:a37:e10c:: with SMTP id c12mr5385520qkm.483.1586746891631;
        Sun, 12 Apr 2020 20:01:31 -0700 (PDT)
Received: from localhost.localdomain ([189.78.178.135])
        by smtp.gmail.com with ESMTPSA id i20sm7208754qkl.135.2020.04.12.20.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 20:01:30 -0700 (PDT)
From:   Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
To:     gregkh@linuxfoundation.org, navid.emamdoost@gmail.com,
        sylphrenadin@gmail.com, nishkadg.linux@gmail.com,
        stephen@brennan.io, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
Date:   Mon, 13 Apr 2020 03:01:28 +0000
Message-Id: <20200413030129.861-1-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes of the local variable value and
modification in the seletive repetition structure.

Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 52 ++++++++++++--------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 9b8d85a4855d..87c02aee3854 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4880,7 +4880,7 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
 void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
 	    u8 *macaddr, u8 defaultkey, u32 *keycontent)
 {
-	u32 target_command = 0;
+	u32 target_command = CAM_CONTENT_COUNT * entryno |  BIT(31) | BIT(16);
 	u32 target_content = 0;
 	u16 us_config = 0;
 	u8 i;
@@ -4890,39 +4890,35 @@ void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
 
 	RT_TRACE(COMP_SEC,
 		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
-        	 __func__, dev, entryno, keyindex, keytype, macaddr);
+		 __func__, dev, entryno, keyindex, keytype, macaddr);
 
 	if (defaultkey)
 		us_config |= BIT(15) | (keytype << 2);
 	else
 		us_config |= BIT(15) | (keytype << 2) | keyindex;
 
-	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
-		target_command  = i + CAM_CONTENT_COUNT * entryno;
-		target_command |= BIT(31) | BIT(16);
-
-		if (i == 0) { /* MAC|Config */
-			target_content = (u32)(*(macaddr + 0)) << 16 |
-					(u32)(*(macaddr + 1)) << 24 |
-					(u32)us_config;
-
-			write_nic_dword(dev, WCAMI, target_content);
-			write_nic_dword(dev, RWCAM, target_command);
-		} else if (i == 1) { /* MAC */
-			target_content = (u32)(*(macaddr + 2))	 |
-					(u32)(*(macaddr + 3)) <<  8 |
-					(u32)(*(macaddr + 4)) << 16 |
-					(u32)(*(macaddr + 5)) << 24;
-			write_nic_dword(dev, WCAMI, target_content);
-			write_nic_dword(dev, RWCAM, target_command);
-		} else {
-			/* Key Material */
-			if (keycontent) {
-				write_nic_dword(dev, WCAMI,
-						*(keycontent + i - 2));
-				write_nic_dword(dev, RWCAM, target_command);
-                	}
-		}
+	target_content = macaddr[0] << 16 |
+			 macaddr[0] << 24 |
+			(u32)us_config;
+
+	write_nic_dword(dev, WCAMI, target_content);
+	write_nic_dword(dev, RWCAM, target_command++);
+
+	/* MAC */
+	target_content = macaddr[2]	  |
+			 macaddr[3] <<  8 |
+			 macaddr[4] << 16 |
+			 macaddr[5] << 24;
+	write_nic_dword(dev, WCAMI, target_content);
+	write_nic_dword(dev, RWCAM, target_command++);
+
+	/* Key Material */
+	if (!keycontent)
+		return;
+
+	for (i = 2; i < CAM_CONTENT_COUNT; i++) {
+		write_nic_dword(dev, WCAMI, *keycontent++);
+		write_nic_dword(dev, RWCAM, target_command++);
 	}
 }
 
-- 
2.20.1

