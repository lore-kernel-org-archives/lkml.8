Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198DB20738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PgK3vno4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHaHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgHaHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:33:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE24C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so2603383plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8nXsELlGPOePYVbXqOXdNoTjjuLOTGOh+u2B39XJu8=;
        b=PgK3vno4y4uwW0Yi58wlX6/1YevWE+eaNCNklNzhaveHpwsIaI1MOoSH3cPpLFUUq8
         Daf9oeWZJge40WMlzQBLFJQJKeCb+bgKr9G4rja5pujve83hHa8vhB6QAX5nwGGxDGub
         SLidwctwFMKDMb1q6daswpBm9XAYxPD9Gdz4rwQa8NTs71hTlTb53lJYgQI983OD9hqb
         1Fv/iK3Rd7OyRSPQWASC8XjqbN/Xvv63t8YtjVNaYepP4Onp7W79GMFT2pevIYsOKgt1
         kjVapBj+6KPTM3zgGOGjeOGqfdM0tRkidE3wpB0nWtuZcO5NeChEuDItjsr7WI8AZvy/
         8nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8nXsELlGPOePYVbXqOXdNoTjjuLOTGOh+u2B39XJu8=;
        b=BA9OaEkIzVzT2XQEUmKIco+O3ApU8Eodlgw0UTA/si+nq/Qq3BePr3vNdFmvKjfSMX
         SbZuw11bxMweCcwJ2kSCTWoQm4oTKast2IUM/zIzrF+dS/wkEe5E7/DkzOBmiw61J6kR
         BpaAyAn4LlKnx+SYyIBbPtZfcthPuNqMZFgjvyszt361Mt8XGkpQh+oNrMh91XfJWpSn
         j7FPlP6uoWwQsVfVizPhBOq5DjfScr30xGm0MGv+SGPGmRGZvTwIoaNFJJzTjpMMuPa5
         KPjVeXW38TxdRGlH7uZEeLEDg33JrT0oLLzlV2Z3lvV02sXW9+1tL8pDQJaqOwQrm1La
         bt5w==
X-Gm-Message-State: AOAM531JPyWLG8XYed3QW/eUhCLar7aFadi2TiA80dr93QDJHBD7y7ol
        E3wKpk3zvgO2aBE0qIOeWqnymA==
X-Google-Smtp-Source: ABdhPJzs9X5O5kyMY3Nd2SdofibbT/u9RBqwKl1r3PYPjMBunDZIw25L3ceWDYs9AEQE5xZYYOFRyQ==
X-Received: by 2002:a17:90a:4214:: with SMTP id o20mr229469pjg.232.1598859235279;
        Mon, 31 Aug 2020 00:33:55 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id m3sm6065979pjn.28.2020.08.31.00.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 00:33:54 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 1/3] riscv: Set more data to cacheinfo
Date:   Mon, 31 Aug 2020 15:33:48 +0800
Message-Id: <77ead0a4d6f48966429dbb1ea48d901d589217af.1598859038.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598859038.git.zong.li@sifive.com>
References: <cover.1598859038.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set cacheinfo.{size,sets,line_size} for each cache node, then we can
get these information from userland through auxiliary vector.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/cacheinfo.c | 66 +++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index bd0f122965c3..291d7d8f748b 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -25,12 +25,53 @@ cache_get_priv_group(struct cacheinfo *this_leaf)
 	return NULL;
 }
 
-static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 struct device_node *node,
-			 enum cache_type type, unsigned int level)
+static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
+			 unsigned int level, unsigned int size,
+			 unsigned int sets, unsigned int line_size)
 {
 	this_leaf->level = level;
 	this_leaf->type = type;
+	this_leaf->size = size;
+	this_leaf->number_of_sets = sets;
+	this_leaf->coherency_line_size = line_size;
+
+	/*
+	 * If the cache is fully associative, there is no need to
+	 * check the other properties.
+	 */
+	if (sets == 1)
+		return;
+
+	/*
+	 * Set the ways number for n-ways associative, make sure
+	 * all properties are big than zero.
+	 */
+	if (sets > 0 && size > 0 && line_size > 0)
+		this_leaf->ways_of_associativity = (size / sets) / line_size;
+}
+
+static void fill_cacheinfo(struct cacheinfo **this_leaf,
+			   struct device_node *node, unsigned int level)
+{
+	unsigned int size, sets, line_size;
+
+	if (!of_property_read_u32(node, "cache-size", &size) &&
+	    !of_property_read_u32(node, "cache-block-size", &line_size) &&
+	    !of_property_read_u32(node, "cache-sets", &sets)) {
+		ci_leaf_init((*this_leaf)++, CACHE_TYPE_UNIFIED, level, size, sets, line_size);
+	}
+
+	if (!of_property_read_u32(node, "i-cache-size", &size) &&
+	    !of_property_read_u32(node, "i-cache-sets", &sets) &&
+	    !of_property_read_u32(node, "i-cache-block-size", &line_size)) {
+		ci_leaf_init((*this_leaf)++, CACHE_TYPE_INST, level, size, sets, line_size);
+	}
+
+	if (!of_property_read_u32(node, "d-cache-size", &size) &&
+	    !of_property_read_u32(node, "d-cache-sets", &sets) &&
+	    !of_property_read_u32(node, "d-cache-block-size", &line_size)) {
+		ci_leaf_init((*this_leaf)++, CACHE_TYPE_DATA, level, size, sets, line_size);
+	}
 }
 
 static int __init_cache_level(unsigned int cpu)
@@ -83,29 +124,24 @@ static int __populate_cache_leaves(unsigned int cpu)
 	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
-	if (of_property_read_bool(np, "cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
-	if (of_property_read_bool(np, "i-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
-	if (of_property_read_bool(np, "d-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+	/* Level 1 caches in cpu node */
+	fill_cacheinfo(&this_leaf, np, level);
 
+	/* Next level caches in cache nodes */
 	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
 		of_node_put(prev);
 		prev = np;
+
 		if (!of_device_is_compatible(np, "cache"))
 			break;
 		if (of_property_read_u32(np, "cache-level", &level))
 			break;
 		if (level <= levels)
 			break;
-		if (of_property_read_bool(np, "cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
-		if (of_property_read_bool(np, "i-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
-		if (of_property_read_bool(np, "d-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+
+		fill_cacheinfo(&this_leaf, np, level);
+
 		levels = level;
 	}
 	of_node_put(np);
-- 
2.28.0

