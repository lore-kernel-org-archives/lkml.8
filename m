Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C0AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208302084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gno6XA1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGCI6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgGCI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:58:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF75C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:58:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u9so8805617pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BGY31r3gXsVvMQOHoM8a6MHD33MAStOOtvTSyarMfM=;
        b=gno6XA1RsGOX7Anfh8skZ16jnJ2eYyVSDqsmWAMcOR3jmCUaEM/znLHHGUE/j/y37e
         QY2nm6fQisDvNQPsOKd0SDhrWXRNvMvbW39HIq2GP2d7NzRij8XZJvxafI2rihmF97YU
         aMeHttXeBsNVEQ2P1GcXzTN4vrfHr8+If4xYUwSDsMZI/ZyxdBe0/0sRTrvVosGZw22m
         UNIGY7Mdq/GW5yNrBZV5wMVQYClpfnTPRilt9Cv52+eJTMBEGO9F1EfZiY+ULmp44Skg
         MHWkcT8LL4G2OfZzAjcLUeRvqWE2g4+spkulMnBEljaArz1Z+FkP1FRUNLQmLpzWhgdX
         affg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BGY31r3gXsVvMQOHoM8a6MHD33MAStOOtvTSyarMfM=;
        b=nVCn8NWrXWMSOZd1KWFVNSsVk6H5I/bDIPCYlGm7YpOddRgCsYNdNcO95Vi/E3i+0A
         5ZN3TVA31lVXSeXFcLl1/x4AWKXJ+nlqG/dq6+Fdiieeqg1L79hdOopmoRh6w2wiZQ/P
         NjRqtAD0i9IpjIMrjreHzJ85/RxhW5qo5mZhXwjBVtQc0Ft44+JP5xlPfUpUnu+vtTUR
         +DlqK2b5xTKwfUa07ciMOimMNzV7dFQliqWPsqs3DMWcLuJHoEmWNF26fglb9S/HjWv8
         siuXHAVAwj6A4WJnyiAZTuwbRIeDb4Qa0lGQEQLbgqmSXjbYDTLH01SOgHVX99r75jQu
         u0Rw==
X-Gm-Message-State: AOAM532ZmXjzI+zzUDxnTXySfFJWgfmR0RR8OPrCdsV32e4YL5NbeKrR
        M7Jane/I5k8KBtd9izzQkj6mFFzZMF8=
X-Google-Smtp-Source: ABdhPJynSZW9qH2tq+gpwdtLXh45KB+tBR8yBMrcqSwKxOpT+68saLPhHGU1Sla5UeGcRJbdhsGE5g==
X-Received: by 2002:a17:90a:de94:: with SMTP id n20mr27314929pjv.125.1593766681242;
        Fri, 03 Jul 2020 01:58:01 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id l23sm2126287pjy.45.2020.07.03.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:58:00 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/3] riscv: Set more data to cacheinfo
Date:   Fri,  3 Jul 2020 16:57:53 +0800
Message-Id: <3ca47cfde607516e51f78f1645357ca739e775d0.1593766028.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593766028.git.zong.li@sifive.com>
References: <cover.1593766028.git.zong.li@sifive.com>
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
index 4c90c07d8c39..cdd35e53fd98 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -8,12 +8,46 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
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
+	if (!of_property_read_u32(node, "cache-size", &size)) {
+		of_property_read_u32(node, "cache-block-size", &line_size);
+		of_property_read_u32(node, "cache-sets", &sets);
+		ci_leaf_init((*this_leaf)++, CACHE_TYPE_UNIFIED, level, size, sets, line_size);
+	}
+
+	if (!of_property_read_u32(node, "i-cache-size", &size)) {
+		of_property_read_u32(node, "i-cache-sets", &sets);
+		of_property_read_u32(node, "i-cache-block-size", &line_size);
+		ci_leaf_init((*this_leaf)++, CACHE_TYPE_INST, level, size, sets, line_size);
+	}
+
+	if (!of_property_read_u32(node, "d-cache-size", &size)) {
+		of_property_read_u32(node, "d-cache-sets", &sets);
+		of_property_read_u32(node, "d-cache-block-size", &line_size);
+		ci_leaf_init((*this_leaf)++, CACHE_TYPE_DATA, level, size, sets, line_size);
+	}
 }
 
 static int __init_cache_level(unsigned int cpu)
@@ -66,29 +100,24 @@ static int __populate_cache_leaves(unsigned int cpu)
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
2.27.0

