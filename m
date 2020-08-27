Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4198DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2025120738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MbQSDBWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgH0IWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgH0IWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:22:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7080AC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p11so2918068pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKMjaK4PJ2ikiw6P6/95F1RDaOcuUp3p/mM1whWPxCo=;
        b=MbQSDBWvoPjLTkfpJ6W9TcjJq9/+n/NQo+AJobLzZ7Is1ydeKYFI48f1r/AN91sTxm
         DHQkeVarpRgucSMz0YC7L1zAQEhKH7795QJAyG/zEF6h4JD3NpYKgwEEm7Xb/yJzacsh
         6LblF7uD2w1wZdCtimTpg+Uy+uoPA1wbB3+8rR9KLpYEjv7EK1YrIonjbtQQck1h9EuS
         2I+hwbt9esWN2x77H8qOxf8mNQkgwUf3rx8gWwg2xkmyfeFwQODfHceImpF9lfNTdskN
         vMygPBxPxi8VvFkIrEbr6Dt1NHjqE/xkmb6UHIp8elkzd+6VqpdPA1KhwXVqtRu124hF
         bSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKMjaK4PJ2ikiw6P6/95F1RDaOcuUp3p/mM1whWPxCo=;
        b=a2LewQr6MAuApizvPmvLsqMyxfz/mr/3mEuInBVQ/8XQUqt5COC7I/Q+VWFCcRR55G
         pQmiO7v/ayvC3a5bbQO7djBWxUsfa/bM/GO+oe/rEtEu+c8gm0x1u+RdoUK/YjW+Qvju
         gwl1gz0GOVIY9ID/bL3UnmNzdk/F5idhDGw772E/Wl1bfUDjW6vavj8iY3zKH0zMlikP
         /F/QoeS6ePyHX7aX4uiU481eDDJi2fgZEcr/lLS0166ap69p51YuxPezt8EbDOo24YIh
         eyPjmTfEcMbl2vFbpwyPL26byinYyjHmX4JMLiJDsoI45sMBKgvGFuKQ3xQCZKfaBXxH
         XDwA==
X-Gm-Message-State: AOAM532hY/uSSc+bxP/w2ddE+3+GWyjOrT2jOhV8YkuoVut3A0ROyvD3
        8qNg7P/e8P/VAMzpdzohtJS34Vj6nT5YzA==
X-Google-Smtp-Source: ABdhPJw5+r9975c88bMGRSVhrhMXZSwgIayivj2J2g9JqLxJnjwcO22WhqzHH0zBazX1WESqCzXWkg==
X-Received: by 2002:a63:224e:: with SMTP id t14mr12839351pgm.129.1598516554899;
        Thu, 27 Aug 2020 01:22:34 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 124sm1828351pfb.19.2020.08.27.01.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:22:34 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/3] riscv: Set more data to cacheinfo
Date:   Thu, 27 Aug 2020 16:22:26 +0800
Message-Id: <3f1f693147f0b62f19f4a44b8e8ef3d5bde23352.1598515355.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598515355.git.zong.li@sifive.com>
References: <cover.1598515355.git.zong.li@sifive.com>
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
 arch/riscv/kernel/cacheinfo.c | 59 ++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index bd0f122965c3..8b85abfbd77a 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -25,12 +25,46 @@ cache_get_priv_group(struct cacheinfo *this_leaf)
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
+	if (!(sets == 1) && (sets > 0 && size > 0 && line_size > 0))
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
@@ -83,29 +117,24 @@ static int __populate_cache_leaves(unsigned int cpu)
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

