Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C7A20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy30OPps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgG3JX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG3JX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:23:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836CC061794;
        Thu, 30 Jul 2020 02:23:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so2879319pls.2;
        Thu, 30 Jul 2020 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEcfQyKopahyJ7cyN5C7qc3ogAAlzbIDe3eGdCZLDlg=;
        b=Dy30OPpsunVqPQHRc8zKA0CNz1xj5tnGaAKB3bfCSkaCdEh/XzdiXvfg7q1kwQqaKr
         P5DnoB9OnJyOILV4j6GHpZRuvoIFchtzfcoGRMr/jOiumprmJXYO4xk/lF0Yvl5xqx0Z
         58tErr5r92NrX4WtqTq4Z9e3KLBFKI0hoQ0vD2chzDheOcO7rgq9vCKUORpnaNgVawo/
         iPDCZ++2p+jbM58i54zHtdoaLT5oybQwz4LUwN5NpcrlHEzn9/1YG4sOHDukYbJ/opOY
         xjphFAJlRere1Rj2hX3B7WfDcga/TZnmt40SBEeIbtVcEzqeVYdPXSRdsJT7d6V081pr
         u7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEcfQyKopahyJ7cyN5C7qc3ogAAlzbIDe3eGdCZLDlg=;
        b=AoCamPqn6KUGQ5cNUJMMsy4wKkSBSWoYV9JQr3vgv80lDeag/zYejAlT2BE2+nPyEm
         dkuepQvbi+Sss6FvIeFoQSX8lkOMywz59p4Hh6eEc5F6Ri+B/csUyrDWVvElWa/oicNq
         4tQ4jYQUh4131JqR7+rPAAKW0oya6NmH5VUrt7YzQ2M0BltKCtezJ/6jxP9/tAA6txz8
         mfZY/vJYbIAJnFf6Qtl84W+cj5k6Ua5Samxl+3O8W62pbzUbAe5NOV6UOl4EBbNn/J1y
         LWbD+Zllt3In/+D6K/XqCXBR95pDeahHA68O9bUmeSWe8bu2JW/QTZjSDP55jk5cK+OZ
         srlQ==
X-Gm-Message-State: AOAM5314BZGvy7V1Ez2adOcdeWrRAYt8ERVyBsxt6qy8Xg7wXqFaWxAF
        fxYTKAla5RsCDt3MGQUU7gk=
X-Google-Smtp-Source: ABdhPJx3WDwF3oqL6peA+8A4RFcrk+CQEEDrK8qZi7yLmtrQIv/rqJP1yDMF6/GNeb65q3Z8TOFNzw==
X-Received: by 2002:a17:90a:1d46:: with SMTP id u6mr2182031pju.220.1596101036913;
        Thu, 30 Jul 2020 02:23:56 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id s8sm5183803pfc.122.2020.07.30.02.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 02:23:56 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] of: reserved-memory: remove duplicated call to of_get_flat_dt_prop() for no-map node
Date:   Thu, 30 Jul 2020 17:23:53 +0800
Message-Id: <20200730092353.15644-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Just use nomap instead of the second call to of_get_flat_dt_prop(). And
change nomap as a bool type due to != NULL operator. Also, correct comment
about node of 'align' -> 'alignment'.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/of/of_reserved_mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6877080..c255c7e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -69,7 +69,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 
 /**
  * __reserved_mem_alloc_size() - allocate reserved memory described by
- *	'size', 'align'  and 'alloc-ranges' properties.
+ *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
 static int __init __reserved_mem_alloc_size(unsigned long node,
 	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
@@ -79,7 +79,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 	phys_addr_t base = 0, align = 0, size;
 	int len;
 	const __be32 *prop;
-	int nomap;
+	bool nomap;
 	int ret;
 
 	prop = of_get_flat_dt_prop(node, "size", &len);
@@ -92,8 +92,6 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 	}
 	size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-
 	prop = of_get_flat_dt_prop(node, "alignment", &len);
 	if (prop) {
 		if (len != dt_root_addr_cells * sizeof(__be32)) {
@@ -104,11 +102,13 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
 	}
 
+	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+
 	/* Need adjust the alignment to satisfy the CMA requirement */
 	if (IS_ENABLED(CONFIG_CMA)
 	    && of_flat_dt_is_compatible(node, "shared-dma-pool")
 	    && of_get_flat_dt_prop(node, "reusable", NULL)
-	    && !of_get_flat_dt_prop(node, "no-map", NULL)) {
+	    && !nomap) {
 		unsigned long order =
 			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
 
@@ -247,7 +247,7 @@ void __init fdt_init_reserved_mem(void)
 		int len;
 		const __be32 *prop;
 		int err = 0;
-		int nomap;
+		bool nomap;
 
 		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 		prop = of_get_flat_dt_prop(node, "phandle", &len);
-- 
1.9.1

