Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A919DC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E2320658
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2IegzK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgHaUpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaUpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:45:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CDAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:45:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so8331176ljn.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGWdJHmBhcLApK6Gyv517DwGmOfnqNlWSzfh48hd76s=;
        b=K2IegzK5CK6Mh9MAZiFX4jlpCbYSevDk7G7G+EFxKxNWhQNFfCbnLCNBYThEA6Hu2T
         34G1oxE2mI+ONN2OawuQifOoQCa9m9FlG+Qfso6bKQpgMRVhP9QuLMFnrMRJx9YP7E70
         YI0exNrE+yBFAK+67c0Gtg87axRfNFhEQAWQE+dozqF3CD5ydTFYZ5oGgHbUezAOI/8O
         98i2hZ4chKJH0UdfkQjFLx10LIbekG0tsVcdN0ArgGHA34qgdxi8RC1hiowbHiGNX6VB
         I3+GEJzu6+Oik8Mjh8kVeG+NfqUBB5X9aUstLcNUd9mlemW6rLXXp4Uf2I40gMWnxy9I
         ZrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGWdJHmBhcLApK6Gyv517DwGmOfnqNlWSzfh48hd76s=;
        b=Dg+x8Yk6vDTfDnjRnIATpJLb7DED5z1q+AyuAipT8MAH4eo845vcx9IPCkslX3CvL2
         Dlu7T+rwYjkwAMHqNJBeD3Q2OXyo8nCeTbsOLntl5fAsWhs5fwAGOn/Bkuhi7mKSmUVQ
         j9UlpHbA6ARv/zwoPf7HDNOxyKkmflYBNey4Rlw8SNz9AOFQNi9x/pS0BXQsOKFnBIcB
         GEZNfT5jUeHWFfKlBA38El0xjAepPzLt07Ley8wpl9PZwjuLtvhQI5bIDzCkjg4ZxjCp
         qk50sKxkQyHCQBazOlCQtLNHBHj8+iME4EwrWAuTOixkg3nvhwGHEpK8I4HLLKTlJR7K
         K56g==
X-Gm-Message-State: AOAM530RLH5yco5SOXxmVVoRbg9+5UyIzZAReLu0V3Am/PJzAHclufMr
        7bl6L9EgyMA01mCpeukLsCc=
X-Google-Smtp-Source: ABdhPJy3b6Yp+XqVRrS7Ps07T/jjRNKZUYZVR6rKgNSKlZZBF3T6A5Z+baQxTesbc4Z8RiZvopSzlA==
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr1382705ljk.204.1598906701765;
        Mon, 31 Aug 2020 13:45:01 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id k13sm2061703lfg.10.2020.08.31.13.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:45:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] regulator: core: Fix slab-out-of-bounds in regulator_unlock_recursive()
Date:   Mon, 31 Aug 2020 23:43:35 +0300
Message-Id: <20200831204335.19489-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit 7d8196641ee1 ("regulator: Remove pointer table
overallocation") changed the size of coupled_rdevs and now KASAN is able
to detect slab-out-of-bounds problem in regulator_unlock_recursive(),
which is a legit problem caused by a typo in the code. The recursive
unlock function uses n_coupled value of a parent regulator for unlocking
supply regulator, while supply's n_coupled should be used. In practice
problem may only affect platforms that use coupled regulators.

Cc: stable@vger.kernel.org # 5.0+
Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5eda1927a4aa..8796c9a24b28 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -236,8 +236,8 @@ static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 static void regulator_unlock_recursive(struct regulator_dev *rdev,
 				       unsigned int n_coupled)
 {
-	struct regulator_dev *c_rdev;
-	int i;
+	struct regulator_dev *c_rdev, *supply_rdev;
+	int i, supply_n_coupled;
 
 	for (i = n_coupled; i > 0; i--) {
 		c_rdev = rdev->coupling_desc.coupled_rdevs[i - 1];
@@ -245,10 +245,13 @@ static void regulator_unlock_recursive(struct regulator_dev *rdev,
 		if (!c_rdev)
 			continue;
 
-		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev))
-			regulator_unlock_recursive(
-					c_rdev->supply->rdev,
-					c_rdev->coupling_desc.n_coupled);
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev)) {
+			supply_rdev = c_rdev->supply->rdev;
+			supply_n_coupled = supply_rdev->coupling_desc.n_coupled;
+
+			regulator_unlock_recursive(supply_rdev,
+						   supply_n_coupled);
+		}
 
 		regulator_unlock(c_rdev);
 	}
-- 
2.27.0

