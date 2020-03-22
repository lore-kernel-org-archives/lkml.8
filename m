Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F1C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2132072D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 02:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJF4wN28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgCVCtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 22:49:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44710 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgCVCtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 22:49:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so5574573pfb.11;
        Sat, 21 Mar 2020 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i03boqnLAKIXm7IsxoZ9x9d/wqr8Z5h4zwehOBg1CH8=;
        b=JJF4wN28ZoiIMynq1XCF6HGHjQ0iAFU6VkAZA0q9p7t5k8SA9vnknlnM2gYaSd/M6Q
         PMgLTv/Agdb3WWTqpGWx1L/8FaDkcUftRIV4dEo4gB8WU8asnqEBkeissdWSAAA7NNIF
         X4TC14jcv0OgntonX/0FSFw80yXeLVO3wfNlfm4oQEjvdl7EVQDSnUDJZVvhT7MHDj7L
         4jzdVK4vWufh2fOqHE85V5xTh4tY1DhOwyammziLPZt2rZ78rePwlbD54zLxhcC5h6Qo
         f8Z0MkFxJBQ4dONz56wIgyondFqKQuYjTOLvoxJ4FKZ0RKXsAFQN7YqfOX2nMfkEX1yh
         BTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i03boqnLAKIXm7IsxoZ9x9d/wqr8Z5h4zwehOBg1CH8=;
        b=VZnpaauyJulsMArkXHIcK507Qb4txTp0j4H0sK6dJGOviSyDrA4Kl/RV0hApQgOHIz
         eY1m+4R8IxminmxG0qykefxv0OS774N6clQ52bBlDhmYpOtfIMhUNwc4MM3dcPjghvJl
         WpeC68pE2i5PZmiI5t4PFyiPdQWrmzDx76W9U/3aufHwx7TEcTyQ8IGYW/2t3OyKweUs
         WOSJxkRBD2KxyjpWYvFd0AFw2IVQ5l9ox5KJnC7L+BfdQeESDTLwVsfASz61sCqzUbxf
         Ow32MA5pnHNQb1kXOqYSZsxFRJWwrIV+xjSTbYREeyVxgP13KEY/Rz470PJu+lUGRAXR
         tOwQ==
X-Gm-Message-State: ANhLgQ3qVr246KllT56/xxTrkGMwVnQwki9YsEFdGlNNUvQ4sb3/6k39
        xPnsROvf5NXqr0elWwRV56c=
X-Google-Smtp-Source: ADFU+vtwSMlJtBOGVhF988SWJXiCWsqrt0bMXyGvr4xywpaJZciHg5h2Hc60NPIOays5UYmjedHBag==
X-Received: by 2002:a63:334a:: with SMTP id z71mr16454335pgz.305.1584845380977;
        Sat, 21 Mar 2020 19:49:40 -0700 (PDT)
Received: from localhost ([216.24.188.11])
        by smtp.gmail.com with ESMTPSA id p4sm9502186pfg.163.2020.03.21.19.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Mar 2020 19:49:40 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, allison@lohutok.net,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v3 5/7] net: phy: aquantia: use phy_read_mmd_poll_timeout() to simplify the code
Date:   Sun, 22 Mar 2020 10:48:32 +0800
Message-Id: <20200322024834.31402-6-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200322024834.31402-1-zhengdejin5@gmail.com>
References: <20200322024834.31402-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use phy_read_mmd_poll_timeout() to replace the poll codes for
simplify the code in aqr107_wait_reset_complete() function.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- adapt to it after modifying the parameter order of the
	  newly added function
v1 -> v2:
	- remove the handle of phy_read_mmd's return error.

 drivers/net/phy/aquantia_main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 31927b2c7d5a..db3e20938729 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -451,16 +451,11 @@ static int aqr107_set_tunable(struct phy_device *phydev,
  */
 static int aqr107_wait_reset_complete(struct phy_device *phydev)
 {
-	int val, retries = 100;
-
-	do {
-		val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
-		if (val < 0)
-			return val;
-		msleep(20);
-	} while (!val && --retries);
+	int val;
 
-	return val ? 0 : -ETIMEDOUT;
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					 VEND1_GLOBAL_FW_ID, val,
+					 val != 0, 20000, 2000000);
 }
 
 static void aqr107_chip_info(struct phy_device *phydev)
-- 
2.25.0

