Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B6C52D6E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1FD248D7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY3Pf14f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIDRKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgIDRKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:10:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F5C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 10:10:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so6748633wmm.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WxJFiAHqmCNHBnOnEhnoypPyWw0qL1gXmCoUBa+7iVU=;
        b=DY3Pf14fjD+wnOiE1RQcasnd9yVDlAO+srkP/gYoJGx8nnNC2pNplWL93ni4oVDZQP
         pwoksoK6V/aAidA1XQk+KMJtCCOdU8kU/zBM/m+IB+Ep/ew+5d36Aeo2R77JKjSjiHIg
         TidAMRoQ7Nt6LuOtROz7e1ISTp9Usmyqge2ESLDhejTesVklkFiv3EowcJwvXurGHmUf
         wDQhu3YQ21akPFgqmKbCo0dtj7TsSvC1UiStmwvp5Tcv3eZFtxZIBkLqGGbg+CaCcFdi
         AX3d4IhvQb8jmj//MZ83KwmEhSvfCa9Ee52T4jwyC+YFSmgcBCubqZQsU7JxEI+CzkbZ
         Wf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WxJFiAHqmCNHBnOnEhnoypPyWw0qL1gXmCoUBa+7iVU=;
        b=ta0MePx8nyA3gm0aenEso4lT1FY0Yc5MTQvMx8ItklQfXsi/hwJBMrKk4tBwjcjrpG
         3PMeKtT/8tB0M9TfEZd3EklMyUdquKSYtxKa4CPcXJyNhAViEjWL3IJxLy/GfBr2FndR
         gRVPqErIokBWSpqAPPsrCtFFXhz3T5Y86aFKY7nOBbyvSA07qAou05bioic6STEr5vy4
         jvPHtzISFXHhlsM2/jtHQFSpnxxZsR5a8Ie7RDmW/YebCl/bq1GQbBfGQhFC0IPHRJSs
         M/coBmpcXhRfZ+5qvuLb6tp2gPumxhr1U46QxfroKtwun4x4yVjNTejyJtb4oBlDAh+j
         jSnw==
X-Gm-Message-State: AOAM531JTNUpuknbRqsX1v6uStvqaSekTtuCGYFxv0Q5+pPIDQYt0Iov
        jHSKlTd7YIiLCnVE0jYNwBs=
X-Google-Smtp-Source: ABdhPJwaFucIUGW3WR849mU+T6OEQNYynmsCPe1Je8+q99d8YZxVoWvc1alr7AzFrGfI2WJSqvEgoQ==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr8482034wmz.119.1599239416140;
        Fri, 04 Sep 2020 10:10:16 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id n16sm13368215wrj.25.2020.09.04.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:10:15 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: onenand: omap2: Allow for compile-testing on !ARM
Date:   Fri,  4 Sep 2020 18:09:55 +0100
Message-Id: <20200904170954.18321-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems no particular reason for building on ARM only, so remove the
restriction to increase test coverage.

Build-tested on x86 with allyesconfig.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/mtd/nand/onenand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
index 1a0e65bc246e..e2272f07d500 100644
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@ -24,7 +24,7 @@ config MTD_ONENAND_GENERIC
 
 config MTD_ONENAND_OMAP2
 	tristate "OneNAND on OMAP2/OMAP3 support"
-	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
+	depends on ARCH_OMAP2 || ARCH_OMAP3 || COMPILE_TEST
 	depends on OF || COMPILE_TEST
 	help
 	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
-- 
2.28.0

