Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9E220773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4JJonJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgIBO2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgIBOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:20:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1757C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:20:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so2913296lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yUbI/u12I3tbrNl3oQN+SypMuNDwaTlt1Yp8aBZBte8=;
        b=a4JJonJJylVDs925j3r5bbBuwcU2/E2sdH5NBrHvuifqsqucpztGLMigUBDtpOg/Rt
         8GbJs+e5lRFP8EE2YR1T3nNNLWV2BGDt3ENAhbP3FKGHaSwcd7dFPdl6osHpnc0egw79
         mAAbpLjGiaMA+CiV4Y1p77DFr69oYiNXMBw1C53F17856BuytAh5IqwIDP7UET6Mqage
         7eDqOBR1RnGoXxRryVAVJH32Fdf5kw/WEnQT1tRgOOut3k6TCuKvq2HPV7zqa2hDuD7O
         e4uGYxs5JXvuThAHHKzrdkaORjdvcs0ibI00RE3fypzVD3W3w8Tukka5wp4mw23qEjVi
         DCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yUbI/u12I3tbrNl3oQN+SypMuNDwaTlt1Yp8aBZBte8=;
        b=dBJBmWmbTLKTg2rd16F263urMBiYdFXfcCvgARNqbY33Wmk1wdpJIQqEa8RgH9f6aV
         zVbnMqXb3WSNMKE70XSfsLUtoYeiVX3phLLJZrryAu74zxkrXHRZMX+ElqLEm9So+Wml
         9wj/qLMFPVJh8vU/Az+JpW2pL7lIjFIof8qbhCTmhTjPTM7Q+BW2ZXNfcF9q5dEHAHV8
         bq5W6hB9JJ4Fh705ymZEYBVWgsxJfvPstC/lPjDAzTqDM7XIqA5wCxmGGWTCl4yuCBm6
         BQgLhqDmdKrHEvMDCWvsrkiuW8vdr7JDD0PpeMFlBw2YjTz+EbR2SxRErf5ymOEJwCNi
         SKEA==
X-Gm-Message-State: AOAM532/mqT08Dq+Z5EM2zBtiNkS9RboJ763K+/iVtrgp1KvD5lqQtfM
        J8/mBzdW8c5aqEBstEcy/rc+kepFkkQ=
X-Google-Smtp-Source: ABdhPJzTYFTzYrEpF8uhZXXshQhbaVi6zGNK2v7VJfB4LZKKr0RD1f6fBz9kgbhhnH4IdXKhvUa6wA==
X-Received: by 2002:a05:6512:358c:: with SMTP id m12mr3470907lfr.18.1599056451225;
        Wed, 02 Sep 2020 07:20:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id n20sm610548lfh.1.2020.09.02.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:20:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] regmap: Add can_sleep configuration option
Date:   Wed,  2 Sep 2020 17:18:43 +0300
Message-Id: <20200902141843.6591-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regmap can't sleep if spinlock is used for the locking protection.
This patch fixes regression caused by a previous commit that switched
regmap to use fsleep() and this broke Amlogic S922X platform.

This patch adds new configuration option for regmap users, allowing to
specify whether regmap operations can sleep and assuming that sleep is
allowed if mutex is used for the regmap locking protection.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 2b32d2f7ce0a ("regmap: Use flexible sleep")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/regmap/internal.h |  3 +++
 drivers/base/regmap/regmap.c   | 19 +++++++++++++++----
 include/linux/regmap.h         |  3 +++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 3d80c4b43f72..8a59359e145f 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -161,6 +161,9 @@ struct regmap {
 	void *selector_work_buf;	/* Scratch buffer used for selector */
 
 	struct hwspinlock *hwlock;
+
+	/* if set, the regmap core can sleep */
+	bool can_sleep;
 };
 
 struct regcache_ops {
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index a417cb1a11dc..2807e544658e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -697,11 +697,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 	if (config->disable_locking) {
 		map->lock = map->unlock = regmap_lock_unlock_none;
+		map->can_sleep = config->can_sleep;
 		regmap_debugfs_disable(map);
 	} else if (config->lock && config->unlock) {
 		map->lock = config->lock;
 		map->unlock = config->unlock;
 		map->lock_arg = config->lock_arg;
+		map->can_sleep = config->can_sleep;
 	} else if (config->use_hwlock) {
 		map->hwlock = hwspin_lock_request_specific(config->hwlock_id);
 		if (!map->hwlock) {
@@ -737,6 +739,7 @@ struct regmap *__regmap_init(struct device *dev,
 			mutex_init(&map->mutex);
 			map->lock = regmap_lock_mutex;
 			map->unlock = regmap_unlock_mutex;
+			map->can_sleep = true;
 			lockdep_set_class_and_name(&map->mutex,
 						   lock_key, lock_name);
 		}
@@ -2230,8 +2233,12 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
 				if (ret != 0)
 					return ret;
 
-				if (regs[i].delay_us)
-					fsleep(regs[i].delay_us);
+				if (regs[i].delay_us) {
+					if (map->can_sleep)
+						fsleep(regs[i].delay_us);
+					else
+						udelay(regs[i].delay_us);
+				}
 
 				base += n;
 				n = 0;
@@ -2267,8 +2274,12 @@ static int _regmap_multi_reg_write(struct regmap *map,
 			if (ret != 0)
 				return ret;
 
-			if (regs[i].delay_us)
-				fsleep(regs[i].delay_us);
+			if (regs[i].delay_us) {
+				if (map->can_sleep)
+					fsleep(regs[i].delay_us);
+				else
+					udelay(regs[i].delay_us);
+			}
 		}
 		return 0;
 	}
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index d865d8fea535..0c49d59168b5 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -342,6 +342,7 @@ typedef void (*regmap_unlock)(void *);
  * @hwlock_id: Specify the hardware spinlock id.
  * @hwlock_mode: The hardware spinlock mode, should be HWLOCK_IRQSTATE,
  *		 HWLOCK_IRQ or 0.
+ * @can_sleep: Optional, specifies whether regmap operations can sleep.
  */
 struct regmap_config {
 	const char *name;
@@ -398,6 +399,8 @@ struct regmap_config {
 	bool use_hwlock;
 	unsigned int hwlock_id;
 	unsigned int hwlock_mode;
+
+	bool can_sleep;
 };
 
 /**
-- 
2.27.0

