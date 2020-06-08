Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20F1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAF8206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH9R6PgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgFHJlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgFHJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:41:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE1C08C5C3;
        Mon,  8 Jun 2020 02:41:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so16564053wrm.13;
        Mon, 08 Jun 2020 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iutKVuNQT00nZYTrm/7dqkO57UE+CiDX2Zw0XM5T/bs=;
        b=FH9R6PgLpY/xfk9Y1umYU9fO4KCushpyvjjDhM6GJ3nbePEUfx9CV9RGHkeRSKEsHj
         zCXHp+4Ck8VAOggyeM3SPuTEOA6yYqQlAiHqlJeK+Tw08h17No6y1uCKK92+EdzuRSD9
         iYmyshNqAE33+CC7ezVX90kkXloMBdNxYKKkXuvntSmd4Vfv9P53HbLszP3pvtFAQ4u+
         WY/fTwy4fFDibyaS6xNI8Dh5SvXgvY6twrbNPfSRkwQk/SmbbnRdzcxIy5mfqVenF3jH
         ioqEmx/A1cA7WMxoRwDOzRHXszwdyy3dYKEVTAZDtqV0lOVXw93sqf2pulgQUzOnACOx
         1j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iutKVuNQT00nZYTrm/7dqkO57UE+CiDX2Zw0XM5T/bs=;
        b=WVCFs6AIrCDoO0flfJrf+ZMgXrUEEvIHP4UKrNwIXr2cR6CgU2h0YlknJYlq8DpsW8
         Om50o2EpikJpoyWAHbNDqCh7FuaVmx2LnX9ih4Wt81aAABgehRXW9G+4oapLHBEOcdSR
         h9RYFvNyHbol6X7kq5IeShpbxbzi0/g1weWKZtDjctCNGCqptwG9aDrCcNp2GnQdTy6T
         WwZBNG2WTBjaMwbTC0armR3Uj+4exSc4y5VY23ZKjF0Fx4M1AewHtpzL5Yon+BAR6YCp
         /cTetWQ/bKz+rApDzHp7bQ0I0vCpZZqyky5IMFUPoCXfSZQkvuHRhmzTNHa0VyRtD9Dl
         LUwg==
X-Gm-Message-State: AOAM533WHvLLGarpoABpbAwwlQnRfVwlW6hAlVn+rYaa3VjLxrwZ1XMN
        fpQ5SFBHi9Vhp576ofKtPww=
X-Google-Smtp-Source: ABdhPJxGkVz4sfW8YmjuDWuFHym9WXb7hrNJ4E1wx771qRgJ70vSanVuzdsFBsv1+hLGrALaJ6L1Rw==
X-Received: by 2002:adf:a283:: with SMTP id s3mr21368789wra.147.1591609258686;
        Mon, 08 Jun 2020 02:40:58 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id a3sm22096479wrp.91.2020.06.08.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:40:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, jonas.gorski@gmail.com,
        linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] mtd: parsers: bcm63xx: simplify CFE detection
Date:   Mon,  8 Jun 2020 11:40:53 +0200
Message-Id: <20200608094053.3381512-3-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608094053.3381512-1-noltari@gmail.com>
References: <20200608094053.3381512-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to parse CFE version string, which is customized by some
vendors, let's just check that "CFE1" was passed on argument 3.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/parsers/bcm63xxpart.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/parsers/bcm63xxpart.c b/drivers/mtd/parsers/bcm63xxpart.c
index 78f90c6c18fd..06b69e905a42 100644
--- a/drivers/mtd/parsers/bcm63xxpart.c
+++ b/drivers/mtd/parsers/bcm63xxpart.c
@@ -22,6 +22,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
 
+#include <asm/mach-bcm63xx/bcm63xx_board.h>
+
 #define BCM963XX_CFE_BLOCK_SIZE		SZ_64K	/* always at least 64KiB */
 
 #define BCM963XX_CFE_MAGIC_OFFSET	0x4e0
@@ -32,30 +34,6 @@
 #define STR_NULL_TERMINATE(x) \
 	do { char *_str = (x); _str[sizeof(x) - 1] = 0; } while (0)
 
-static int bcm63xx_detect_cfe(struct mtd_info *master)
-{
-	char buf[9];
-	int ret;
-	size_t retlen;
-
-	ret = mtd_read(master, BCM963XX_CFE_VERSION_OFFSET, 5, &retlen,
-		       (void *)buf);
-	buf[retlen] = 0;
-
-	if (ret)
-		return ret;
-
-	if (strncmp("cfe-v", buf, 5) == 0)
-		return 0;
-
-	/* very old CFE's do not have the cfe-v string, so check for magic */
-	ret = mtd_read(master, BCM963XX_CFE_MAGIC_OFFSET, 8, &retlen,
-		       (void *)buf);
-	buf[retlen] = 0;
-
-	return strncmp("CFE1CFE1", buf, 8);
-}
-
 static int bcm63xx_read_nvram(struct mtd_info *master,
 	struct bcm963xx_nvram *nvram)
 {
@@ -138,7 +116,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	struct bcm963xx_nvram *nvram = NULL;
 	int ret;
 
-	if (bcm63xx_detect_cfe(master))
+	if (!bcm63xx_is_cfe_present())
 		return -EINVAL;
 
 	nvram = vzalloc(sizeof(*nvram));
-- 
2.26.2

