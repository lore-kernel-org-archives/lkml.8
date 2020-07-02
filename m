Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C28C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937652089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mz6WZPSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGBGYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGBGYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:24:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EBC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:24:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r17so28623816ybj.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iZR7HnIiawJ7wzfiy0Ut0vXr2/SqR6IE5pS9JE3U7po=;
        b=mz6WZPStsuXLTdPf74q+rl3ncwIazZ/1XrQgZjRHiIn7CeFK4q/A6u4oPfPFkTNEPb
         0OSlqwLJc7Dckc9FQxELz7ifXB9BgaW9Az79IViIduvG9yZ1zQ3yPSeAHrc42NqruYr6
         Oi7ZWgYQQXiRTwNo7Vgz2xCtT7wxKB4rAgEZa17+KHit5M0YLuZHyYGA1YikZ9t/tfDB
         ruJtSB5blSCSpYWtoUo/X/RHUcgOltK3YdY1/Y9sLGTUcU0wXJ/VVmiTgXo0Lb8tCgsc
         AYLhjEKqRumQq7RVRZn0Qg/5udS5A3yJ5K4VaDPKoK0vBys78t39hetucFKI1pBRFSdX
         5HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iZR7HnIiawJ7wzfiy0Ut0vXr2/SqR6IE5pS9JE3U7po=;
        b=V8Xq/xgyAfohjZ3pmosg2piJaCWTFhZKTYRwa9JQzbCE1K0WUOOI6Nj4ST32UhGSa+
         QGklWuFkMQdH/ocsvO1e30N5UdPIDrMC+DtwqoVYSWF6ZJky0KDdIs9uFHncRfbq2cNQ
         SElknLEs93x4UdKnlBLR+YuBZ9p2/3G7R1j6Qq+IJDjJxXH37ndIStiKOqLgRsZ+AgWc
         c86ydJY2VOtfnKsHeMKLh1HsJmUKBvN4tDg2H6UplYLedZIzQCsqmK8jxv2rroCsad/D
         iOsH3sblXaX5Pl/xWE1PMCbhsBswKJoKZjfIDkcoh1zNFpkQbct9HMC1yaovz+fJPse/
         tvnA==
X-Gm-Message-State: AOAM53187BbDpRfy5eq1RZIzw1yBYsBenOZ5B/CS5Xu334sXiIuVKihz
        pDtA5yqy4c3aibnH1GJ1VzZxAZr5PC9e
X-Google-Smtp-Source: ABdhPJyjdnT5MaK/T6agjEBgLQNZJMX/mX1BLU3IAGS5LPHQXU6PipfcCyLI5smcJiTvvuUnWd4MWUfOx3Zi
X-Received: by 2002:a25:1941:: with SMTP id 62mr53184112ybz.16.1593671040774;
 Wed, 01 Jul 2020 23:24:00 -0700 (PDT)
Date:   Thu,  2 Jul 2020 16:23:19 +1000
In-Reply-To: <20200702062320.2903147-1-amistry@google.com>
Message-Id: <20200702162231.v2.3.I7acfb591bfacf3b1b04a3d388385098bfcc9fecd@changeid>
Mime-Version: 1.0
References: <20200702062320.2903147-1-amistry@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 3/4] regulator: mt6397: Implement of_map_mode
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsin-hsiung.wang@mediatek.com, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementing of_map_mode is necessary to be able to specify operating
modes in the devicetree using 'regulator-allowed-modes', and to change
regulator modes.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

Changes in v2: None

 drivers/regulator/mt6397-regulator.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index d51e98ce1138..0a30df5e414f 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -53,6 +53,7 @@ struct mt6397_regulator_info {
 		.vsel_mask = vosel_mask,				\
 		.enable_reg = enreg,					\
 		.enable_mask = BIT(0),					\
+		.of_map_mode = mt6397_map_mode,				\
 	},								\
 	.qi = BIT(13),							\
 	.vselon_reg = voselon,						\
@@ -144,6 +145,18 @@ static const unsigned int ldo_volt_table7[] = {
 	1300000, 1500000, 1800000, 2000000, 2500000, 2800000, 3000000, 3300000,
 };
 
+static unsigned int mt6397_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case MT6397_BUCK_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	case MT6397_BUCK_MODE_FORCE_PWM:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
 static int mt6397_regulator_set_mode(struct regulator_dev *rdev,
 				     unsigned int mode)
 {
-- 
2.27.0.212.ge8ba1cc988-goog

