Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EECC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3466B21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/EBBAtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgBFOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:24:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46536 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:24:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so3187706pfp.13;
        Thu, 06 Feb 2020 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2k1+BmAg/PACALQSiYk+3lsPVNBiCnjdKk4ZEAWEMAo=;
        b=D/EBBAtUCOsUg+i5bc2KUgV/GljhCwwCEpfUQIBNM6QpF/qcvleiiWUPzWuhRHg8vI
         mDk35foTgP7jqdshD7/iiIlVKlV2x7GldZeLGYzETC2/QlYsZUOna04O9EwJaZrng0M9
         hC2lth/uBHlK0Kg47gN2csh+tnTUb3bYoIJm2kriip+fzAyCn2vigf4DFqe9hV1sRi9e
         Od17WHXkwoXftisbxh/kTJRQLidKXb/tewXkYnYDAdzzPLBJFMOKDFNkWbPuIE0LlILx
         dbnOF4b2+CIsfQhgW8mhX1W+t4KNDy9nv+BTOkn953zm+roBm1fpl17o2yF+riu8Yl1c
         oyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2k1+BmAg/PACALQSiYk+3lsPVNBiCnjdKk4ZEAWEMAo=;
        b=p5O+fNg03PN0Nt2Lj7H0TWPTeQJYB7znoLt/qupMhuNnZOTVBq2n83Ykjy/tZ3MUtO
         cVHrLdTUZzbONcmjaQbaLU2nur5iX3egYfCZDNDrGVU5nWrZCGyPWnhepqVfwEyu9zi1
         vwECq4igpMhvNgMlSWU1XtkxElk4AQLRF186zyj/X6g2bjfbHBeEb+EGHJXvSPqWTDw9
         ctgvrYMl5bgnLxy2zouHh1EwMzCSgJaXDUbXzYouVVj/JJqUccEShRr0JKUsDdSwhboZ
         7bvL4E/U+xS1S+jYMkb5/uZfYENujLeCc4eSXA6Jg25++PMxuND9QIIltRRAWuv/PTPu
         zRlw==
X-Gm-Message-State: APjAAAXnbS7GUk4jA0/gCGSlp6C+/hOPWMZy0Kv+wV1QTCRmQun+UXDf
        wWEkZdnC3V+pqeHccd8I4A4=
X-Google-Smtp-Source: APXvYqy6t80R5aju+KrOh4xsVYVlB/QZyNhzW81TIqyD1gUzeCv+aNGJ92Oc695aN7ezOXOQMcC/BA==
X-Received: by 2002:a63:ba19:: with SMTP id k25mr4089647pgf.333.1580999072575;
        Thu, 06 Feb 2020 06:24:32 -0800 (PST)
Received: from localhost (104.128.80.227.16clouds.com. [104.128.80.227])
        by smtp.gmail.com with ESMTPSA id q12sm3595749pfh.158.2020.02.06.06.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 06:24:31 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH 1/2] net: stmmac: use readl_poll_timeout() function in init_systime()
Date:   Thu,  6 Feb 2020 22:24:03 +0800
Message-Id: <20200206142404.24980-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206142404.24980-1-zhengdejin5@gmail.com>
References: <20200206142404.24980-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init_systime() function use an open coded of readl_poll_timeout().
Replace the open coded handling with the proper function.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 020159622559..2a24e2a7db3b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -10,6 +10,7 @@
 *******************************************************************************/
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include "common.h"
 #include "stmmac_ptp.h"
@@ -53,8 +54,8 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 
 static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 {
-	int limit;
 	u32 value;
+	int err;
 
 	writel(sec, ioaddr + PTP_STSUR);
 	writel(nsec, ioaddr + PTP_STNSUR);
@@ -64,13 +65,10 @@ static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 	writel(value, ioaddr + PTP_TCR);
 
 	/* wait for present system time initialize to complete */
-	limit = 10;
-	while (limit--) {
-		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSINIT))
-			break;
-		mdelay(10);
-	}
-	if (limit < 0)
+	err = readl_poll_timeout(ioaddr + PTP_TCR, value,
+				 !(value & PTP_TCR_TSINIT),
+				 10000, 100000);
+	if (err)
 		return -EBUSY;
 
 	return 0;
-- 
2.25.0

