Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3267C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB3324658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Dj6RekFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOAaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:30:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38555 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgAOAaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:30:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so7479454pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2uhXxJrpNwhDXk9w5jQc+1ryIzo08zTX5UifvdF/pDY=;
        b=Dj6RekFYo2OwXbRK+O1AQ0vjKi6Ro2yluA2wQT5Y1favqbhm1f08DgK2+5jazZksuW
         C+9ia4nJupQ9Ju3guCueIoC1e7hFXG/erqMN1McuCn7ERQ4GlWapSijCdp+w0jD451/v
         uH3duKtwf8E5Z55j2l20CFyLzF+vs6tF4M7a8oyGJGWCHKUqBgbdbghaMUSlFErWscE2
         iUkBulr6BTQV6vvdeiXDaj7PXI8wzD7vVDFtmDKKfUoyiOmseWA2on6pGoWmbGe+W/QK
         QiG6pzkTQK5irGjCSY2Z5VDx5YEfW5nefjEsKf9L/nATDCFk3DemGxidF/PHS+RLx6LZ
         MyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2uhXxJrpNwhDXk9w5jQc+1ryIzo08zTX5UifvdF/pDY=;
        b=VUU1Cw1mz6tEXYxZdTtP1djDJouh9SVVR73d819AsT7p9qCpppWcRnyCYXsGmeBAj3
         H+58ZWIlzijj+NvfO3kWN+hSo5tVFFoF5gAVjHvIhgvTGz5DflL0+YSJnE2AWL7f+qvy
         VpDUlWT4FkgNVQv8PbwhL93qdaleHc+lTXWOFF22xZguaYFQ8WUMPEyMsgfxt9QdU4gK
         SQKmfU8W+8Vcd7Q2ZDs0Wpxhbtxri7CV3p05RBd78Z6U61pOcmFWZCCmDhr7lzW/QVGv
         msDFB2yYRDhnm9my9kAEUqZpxBYbVQ6vVDwTek8Mk4GLoyexrJNpxSpWtZ02LKiKtemX
         nkcw==
X-Gm-Message-State: APjAAAWAYTHSwlQ83+a6RvqiuoZSztwgw9zyB8KbwpwWjlTNcIWhmhY3
        HTWFU8UloSmy7QU8woNviMzDLg==
X-Google-Smtp-Source: APXvYqzwpNDwOwqUi+FNMt9PWk5H7yfUQKRU9edFhU6evZLIfwvYFB4NOBn3ZXTiJZ8v/Zv1mLCXiQ==
X-Received: by 2002:a63:b141:: with SMTP id g1mr31273224pgp.168.1579048220401;
        Tue, 14 Jan 2020 16:30:20 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id h3sm14684706pjs.0.2020.01.14.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:30:19 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mpq7920: Fix incorrect defines
Date:   Wed, 15 Jan 2020 08:29:53 +0800
Message-Id: <20200115002953.14731-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix defines for MPQ7920_MASK_BUCK_ILIM and MPQ7920_DISCHARGE_ON
Remove unused MPQ7920_REG_REGULATOR_EN1.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mpq7920.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mpq7920.h b/drivers/regulator/mpq7920.h
index 1498a1e3f4f5..489924655a96 100644
--- a/drivers/regulator/mpq7920.h
+++ b/drivers/regulator/mpq7920.h
@@ -43,11 +43,10 @@
 #define MPQ7920_LDO5_REG_B		0x1e
 #define MPQ7920_LDO5_REG_C		0x1f
 #define MPQ7920_REG_MODE		0x20
-#define MPQ7920_REG_REGULATOR_EN1	0x22
 #define MPQ7920_REG_REGULATOR_EN	0x22
 
 #define MPQ7920_MASK_VREF		0x7f
-#define MPQ7920_MASK_BUCK_ILIM		0xd0
+#define MPQ7920_MASK_BUCK_ILIM		0xc0
 #define MPQ7920_MASK_LDO_ILIM		BIT(6)
 #define MPQ7920_MASK_DISCHARGE		BIT(5)
 #define MPQ7920_MASK_MODE		0xc0
@@ -57,7 +56,7 @@
 #define MPQ7920_MASK_DVS_SLEWRATE	0xc0
 #define MPQ7920_MASK_OVP		0x40
 #define MPQ7920_OVP_DISABLE		~(0x40)
-#define MPQ7920_DISCHARGE_ON		0x1
+#define MPQ7920_DISCHARGE_ON		BIT(5)
 
 #define MPQ7920_REGULATOR_EN_OFFSET	7
 
-- 
2.20.1

