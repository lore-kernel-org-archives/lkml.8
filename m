Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782DC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE3520786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4FstDpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCXL04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:26:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgCXL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:26:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so8892584pgn.1;
        Tue, 24 Mar 2020 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FrbvE2+XGpAbkhd83eQ/l+A4H9hHet3Hf7AqA26edfw=;
        b=G4FstDptw0ertkuwcrfdpUKzgqLUAfdH03n/zKcG4Ozvq8Dl8sViuWhFe+jF8bY3p4
         C5IhT4IM8x+w0OrS5smYwsOmHL0U4MGo/7gU+JHPzCsLqAyICNBFJfsyP8dIXToM2yWI
         8H3WXTsB42phpRuA8wknt/1fCK0elvX5CNYHcB46tfU3R+ZohLAbKEnYR+t1RgqPoHWB
         XU2iR+BexF3hBrzKIieVTkwozV21Ow7j7vyWZbr/JNMtrnENEeUeKFpuK0UOWUAX8a+T
         pKTdPeArgQOfS6YxM+Shx85MJL4fWCl5ho/hAn3hRhKfsMhFvhy++WXVhdbctj3aTgVS
         tKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FrbvE2+XGpAbkhd83eQ/l+A4H9hHet3Hf7AqA26edfw=;
        b=rNkrxtgGh8UfZOPEZcjAiO8SZb0/XLPtNnZGpsyKrVpmBX32paNyn0lgecJj/H4dox
         s+0CsJIp8yH+JSH8G7pfwcDaUGxT/u1pXkYJXiCa4QlUxiyXBUhAhlyYUTf8i6Ks3X8X
         RAq2sHNC6NLHavwDSnpD85ReZ9hYpEYBSBnk///lg3KoaCGCyMpnU8NvBQOEVy2xcBVW
         0fM3nfCpiixHFX5DC3v7zzh/jMqrrzF+Yb2tavus8Znuo5TmakvzEepVHTrnNHhzEKB4
         mARWYcWhInfxy2/zwytlb5rUCQaLQ/7svavelo41XGNQABs8UG/ORRNF78g1iIXwnoRz
         w84A==
X-Gm-Message-State: ANhLgQ2Mh40vZM14wMsvS0PuWgGtAOSdOFVDwHdtgioFjZrhr+0K9gRD
        V3JLjlBQKDL9x0ECOUxx4k0=
X-Google-Smtp-Source: ADFU+vt1jg56FUPmc2UWey6QkZhMBdlnJxDKePswGVYyeaouJxVkEEvb+rFCGkFiDg5fOd6lYt/O3g==
X-Received: by 2002:a62:170f:: with SMTP id 15mr28277644pfx.12.1585049215248;
        Tue, 24 Mar 2020 04:26:55 -0700 (PDT)
Received: from localhost ([144.34.194.51])
        by smtp.gmail.com with ESMTPSA id n30sm8070278pgc.36.2020.03.24.04.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 04:26:54 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next] net: phy: mdio-mux-bcm-iproc: use readl_poll_timeout() to simplify code
Date:   Tue, 24 Mar 2020 19:26:47 +0800
Message-Id: <20200324112647.27237-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use readl_poll_timeout() to replace the poll codes for simplify
iproc_mdio_wait_for_idle() function

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index aad6809ebe39..42fb5f166136 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -10,6 +10,7 @@
 #include <linux/phy.h>
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 
 #define MDIO_RATE_ADJ_EXT_OFFSET	0x000
 #define MDIO_RATE_ADJ_INT_OFFSET	0x004
@@ -78,18 +79,11 @@ static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
 
 static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
 {
-	unsigned int timeout = 1000; /* loop for 1s */
 	u32 val;
 
-	do {
-		val = readl(base + MDIO_STAT_OFFSET);
-		if ((val & MDIO_STAT_DONE) == result)
-			return 0;
-
-		usleep_range(1000, 2000);
-	} while (timeout--);
-
-	return -ETIMEDOUT;
+	return readl_poll_timeout(base + MDIO_STAT_OFFSET, val,
+				  (val & MDIO_STAT_DONE) == result,
+				  2000, 1000000);
 }
 
 /* start_miim_ops- Program and start MDIO transaction over mdio bus.
-- 
2.25.0

