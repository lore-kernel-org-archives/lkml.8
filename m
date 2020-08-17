Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B381DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897502072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaoLxBWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHQXlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHQXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:41:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77FC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:13 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so13827844qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XknbIlnHZrFH1cHJvFSECrSwbxvSnf/0N8RfyO8KRs=;
        b=vaoLxBWiRU+5xIDIFyWITLohlTqhH1HK12fd4foHfW0R0A2F1x9MUJiMAOe+I2072w
         NFIinxYaay6/Lt///o0+Z7IlWSHgX2sqi4pZdFPnv9ooU+5Qo/nf2tL7tPvJujqafjYO
         SPkgj5IIt+W3BpHBIQaDmyA5VklmPYK0rzj/M5fdO35wT5bydG2T0ebUWlKuQQu1c070
         uTcvk3IEYu9e1JAi+G9C+7RHGYzBegWTylY3pA5EZNxPKXq0KirUjq4LQKhO29X/ilDj
         8jVr6ZEDASC4or+gD0OQwmw7N1cjuSX5Y7WVe1v5ZQrrXV7F37s7E9iCAfVkOYFie6MZ
         DfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XknbIlnHZrFH1cHJvFSECrSwbxvSnf/0N8RfyO8KRs=;
        b=qmwZACPp/fKK+hcVYFhaLDMMJHeQR/BgNnEsk74ldV9KuZ+8TX4ABO6YCCCaPnlNhY
         /TfeyJvmT3JDbk/lo7Gta3osbdsck15W1zsja4BEQvZoD0Let5O9KibTUXpUSILKMZ4z
         FFO7P5t/C2JkAfJHQflasYpw+lZs7I/wu/lWQhjKYBKqcoqN+vNut1GriG8TGLDMaeaf
         vZLZIJT6bUdasSyk0oqsJni1IuQrQBdLBruxaLuUPzQYNelYIlKevufHkJX7YDJ+e8Fv
         qKjPhEbHxbasNYT3V3GlDvSJgTk+EkUgJ3ycmRdaGu7Szs36/PEWM0OGFu89ZX6T52C7
         Sbew==
X-Gm-Message-State: AOAM530LcesN6NWeRBwoUgYTwCmhuupoDHYz5O0P5H7T0DZNS9qn35YC
        8Db5iIcTGHfn4VeCZqWPnWo=
X-Google-Smtp-Source: ABdhPJy4nBQGtI9lW7HTYYHGQwVb1/Vq3MOjJhto9jz+uRKvO0Omupjbqy2NNQT+LkFwWrPfjw9/9w==
X-Received: by 2002:ac8:104:: with SMTP id e4mr15875453qtg.47.1597707672302;
        Mon, 17 Aug 2020 16:41:12 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id w58sm22342868qth.95.2020.08.17.16.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:41:11 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/10] powerpc/pseries/iommu: Add iommu_pseries_alloc_table() helper
Date:   Mon, 17 Aug 2020 20:40:28 -0300
Message-Id: <20200817234033.442511-6-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817234033.442511-1-leobras.c@gmail.com>
References: <20200817234033.442511-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates a helper to allow allocating a new iommu_table without the need
to reallocate the iommu_group.

This will be helpful for replacing the iommu_table for the new DMA window,
after we remove the old one with iommu_tce_table_put().

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 8fe23b7dff3a..39617ce0ec83 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -53,28 +53,31 @@ enum {
 	DDW_EXT_QUERY_OUT_SIZE = 2
 };
 
-static struct iommu_table_group *iommu_pseries_alloc_group(int node)
+static struct iommu_table *iommu_pseries_alloc_table(int node)
 {
-	struct iommu_table_group *table_group;
 	struct iommu_table *tbl;
 
-	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
-			   node);
-	if (!table_group)
-		return NULL;
-
 	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
 	if (!tbl)
-		goto free_group;
+		return NULL;
 
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
 	kref_init(&tbl->it_kref);
+	return tbl;
+}
 
-	table_group->tables[0] = tbl;
+static struct iommu_table_group *iommu_pseries_alloc_group(int node)
+{
+	struct iommu_table_group *table_group;
+
+	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
+	if (!table_group)
+		return NULL;
 
-	return table_group;
+	table_group->tables[0] = iommu_pseries_alloc_table(node);
+	if (table_group->tables[0])
+		return table_group;
 
-free_group:
 	kfree(table_group);
 	return NULL;
 }
-- 
2.25.4

