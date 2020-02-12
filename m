Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AB22073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fXJEbKcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgBLPCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:02:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38437 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:02:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6so1062684plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR6J0RTBbPdiqIfgczIlNViu+Jfpdo5P+6apUdMx6rM=;
        b=fXJEbKcPz4oZt4vjeQJC2jNIOrpZ1m2hZnnwZkP5rU7AE2QIVND8VnVMxzeeqSSoOE
         aaGtrB9l3mGgYnaDu6hBgE8HqEV/vlrEpzSTLPJMZtzBdy0U7sA++/WL2Tasz6q1t2DL
         TJA5cIkn3M9qod38ONclfYM57sLuwI2y41BcyXlLoNeNJCFTZle9xCkJGpI0ShEPH/TZ
         Ef8lVuQKM5KuYVuBrg5lMfWivUlln/vjvsZicO5bgPPUB3JFRztvcgEHmKxRO1w3PA2B
         XoEKYiqP5t2BHeGzn0QEEwhurrfy+LJht3miMz511brInMhXFsN4R8i0LAaJ8+tD6Wrw
         nBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR6J0RTBbPdiqIfgczIlNViu+Jfpdo5P+6apUdMx6rM=;
        b=T+fRnea6NE1JfrPU4TMot6WsoLLVppjU4ohxijJiiZ4Yw5LTap691qg7kcMD90HB0h
         f6RMuN/70M0MYFY0Ed3yJqaLMJr2SCGXDTU9+qTP1NvhOG9vmIkghBxHx/ju1IBWIR0u
         CQDmn206/P4AtAFKtyX5395GtiGjq9hT10LmUrlAd651YlwINLWUkvJwcjaDOsrB6YjC
         KvnRdOvldXm2CdkIysk2j0VE4kXyFzFy4GQTvrL5UB/in6fYs+j+u+0m9ewugQyWXLsb
         BY0ghydwm0VDZzFrnOfi/SgINOmEunSjBW+H3Gs6No77TpDjCASUwW1KKZRCiR7HbvRf
         VIuw==
X-Gm-Message-State: APjAAAWLgUW6AOFR9/bOCIII/xrHx5m1wv0zPDYgEMzWSEsMRbJBT7Lr
        NdCemogkcWuwyQpZt2A40nTJLQ==
X-Google-Smtp-Source: APXvYqx6grvy4ycKCwhlUc6ND3/5PFcUMpv8fDnyny3EdLaNp4drcF3H+3/1rlIxxUXFqoQfmv7M6Q==
X-Received: by 2002:a17:90a:e996:: with SMTP id v22mr10613007pjy.53.1581519752767;
        Wed, 12 Feb 2020 07:02:32 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id d73sm1312155pfd.109.2020.02.12.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 07:02:31 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: mp5416: Fix output discharge enable bit for LDOs
Date:   Wed, 12 Feb 2020 23:02:23 +0800
Message-Id: <20200212150223.20042-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .active_discharge_on/.active_discharge_mask settings does not match
the datasheet, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Saravanan,
I don't have the h/w to test, please help review and test this patch.

Thanks,
Axel

 drivers/regulator/mp5416.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 7954ad17249b..67ce1b52a1a1 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -73,7 +73,7 @@
 		.owner			= THIS_MODULE,			\
 	}
 
-#define MP5416LDO(_name, _id)						\
+#define MP5416LDO(_name, _id, _dval)					\
 	[MP5416_LDO ## _id] = {						\
 		.id = MP5416_LDO ## _id,				\
 		.name = _name,						\
@@ -87,9 +87,9 @@
 		.vsel_mask = MP5416_MASK_VSET,				\
 		.enable_reg = MP5416_REG_LDO ##_id,			\
 		.enable_mask = MP5416_REGULATOR_EN,			\
-		.active_discharge_on	= BIT(_id),			\
+		.active_discharge_on	= _dval,			\
 		.active_discharge_reg	= MP5416_REG_CTL2,		\
-		.active_discharge_mask	= BIT(_id),			\
+		.active_discharge_mask	= _dval,			\
 		.owner			= THIS_MODULE,			\
 	}
 
@@ -155,10 +155,10 @@ static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
 	MP5416BUCK("buck2", 2, mp5416_I_limits2, MP5416_REG_CTL1, BIT(1), 2),
 	MP5416BUCK("buck3", 3, mp5416_I_limits1, MP5416_REG_CTL1, BIT(2), 1),
 	MP5416BUCK("buck4", 4, mp5416_I_limits2, MP5416_REG_CTL2, BIT(5), 2),
-	MP5416LDO("ldo1", 1),
-	MP5416LDO("ldo2", 2),
-	MP5416LDO("ldo3", 3),
-	MP5416LDO("ldo4", 4),
+	MP5416LDO("ldo1", 1, BIT(4)),
+	MP5416LDO("ldo2", 2, BIT(3)),
+	MP5416LDO("ldo3", 3, BIT(2)),
+	MP5416LDO("ldo4", 4, BIT(1)),
 };
 
 /*
-- 
2.20.1

