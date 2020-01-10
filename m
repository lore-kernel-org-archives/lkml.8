Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A257C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABD52082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnZcmzME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgAJJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:32:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42285 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgAJJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:32:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so1086714wro.9;
        Fri, 10 Jan 2020 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/eHOMT158nZ3peFbo4qmkM+fTWEBBXxh1kcQu4MDcJc=;
        b=KnZcmzMEmGfAMH7grsvVsqcBdGL6MhwPQWUGn4JZaqe0gTZnKDKrrmL7Lp59/TNZSk
         ZYvD7tYTRXnYP37mhOk3B1ii+Lwn8cqKN9M125Qogr2eDs8FbVrbI7I+luMhKGzErdxx
         d5/6vz+HUpD3fcImxQesPG4RAqc+7ogRd8LaMJmht4Jz1xH0oWpFDwswKh0oEi6ssfOg
         LHQWpOptVeLC5DuAlwBA32rfWFgV7cEfhM+gIuz/jeGuUiyktzRs3EpTaQ4d0ljMAPhX
         tUtzrw2mSZBOK4AdGUvatGszwXQBUSxjy4Pv3cgeO7/2x0JeYQyj+32fICPcWT8um/ht
         tY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/eHOMT158nZ3peFbo4qmkM+fTWEBBXxh1kcQu4MDcJc=;
        b=EoHRNDjqRAwlUVCB0OaRoQzFbED6nraJOa5l5r0SHsV4LWLJ9Y4W70I03HxLKFcSAZ
         Amgoyi51lyQ/uNePjlK4IepBD9Wx2RJ/EK1yMTWG8c5a+GZYu44qEV34DJIECyI4Rygf
         QVvlxE7BZm8b0wotlRwloWyhS6rbCcGV/yRAtibPzsbbYotTbXJmcAqtMeHE8FEJY9K9
         A4EqzD1EXSbistukaj08gz2eC5Q/65pHqbzih6b8leqiQ2w8eFsvY5y5KTZjQ5ofLEUz
         oFwefJ69pcmn+sVV0+n2/lS0yk3ZDuMborGTvG8xsoEDnrglKfzyrvToglabwZfG6ejy
         LKXA==
X-Gm-Message-State: APjAAAV1t1gttgtPanF98Pw8IU1kWGXEXzVvAtkZG9+tDdAO3mNuIbSX
        U6HS0B0jIRC2+dY+WN9nkkSDQiPTIhe9Lw==
X-Google-Smtp-Source: APXvYqzhUK46UM0hHL0B059hi9oo0YikxkTn2vNa6AzVI9NaDlYQirdb/QPiPBnLiyOL/UyR6jiCdg==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr2518223wrq.314.1578648718675;
        Fri, 10 Jan 2020 01:31:58 -0800 (PST)
Received: from localhost.localdomain (p5B3F6BF6.dip0.t-ipconnect.de. [91.63.107.246])
        by smtp.gmail.com with ESMTPSA id q3sm1473054wmj.38.2020.01.10.01.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 01:31:57 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: mpq7920: Fix Woverflow warning on conversion
Date:   Fri, 10 Jan 2020 10:31:48 +0100
Message-Id: <20200110093148.6718-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning Woverflow warning on type conversion reported on X86.

Fixes: 6501c1f54a17 (regulator: mpq7920: add mpq7920 regulator driver)
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/regulator/mpq7920.c | 2 +-
 drivers/regulator/mpq7920.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index c603d60fb87b..ab1b847c57e5 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -221,7 +221,7 @@ static int mpq7920_parse_cb(struct device_node *np,
 	if (of_property_read_bool(np, "mps,buck-ovp-disable")) {
 		regmap_update_bits(config->regmap,
 				MPQ7920_BUCK1_REG_B + (rdesc->id * 4),
-				BIT(6), ~BIT(6));
+				MPQ7920_MASK_OVP, MPQ7920_OVP_DISABLE);
 	}
 
 	ret = of_property_read_u8(np, "mps,buck-phase-delay", &val);
diff --git a/drivers/regulator/mpq7920.h b/drivers/regulator/mpq7920.h
index 6a93bfbc750c..1498a1e3f4f5 100644
--- a/drivers/regulator/mpq7920.h
+++ b/drivers/regulator/mpq7920.h
@@ -55,6 +55,8 @@
 #define MPQ7920_MASK_SWITCH_FREQ	0x30
 #define MPQ7920_MASK_BUCK_PHASE_DEALY	0x30
 #define MPQ7920_MASK_DVS_SLEWRATE	0xc0
+#define MPQ7920_MASK_OVP		0x40
+#define MPQ7920_OVP_DISABLE		~(0x40)
 #define MPQ7920_DISCHARGE_ON		0x1
 
 #define MPQ7920_REGULATOR_EN_OFFSET	7
-- 
2.17.1

