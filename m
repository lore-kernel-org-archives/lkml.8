Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBAC2D0ED
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F5216FD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNtVMhtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCZWYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:24:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZWYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:24:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so9176153wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ypZyzlrBAG+cLsLy+PU3T0dnOH3TPzYnikBxeCUs2mM=;
        b=PNtVMhtUOqP8DzyueMCTTgYYrWGu+yFrrmFpnA19hy4ZMZ/s62bZxKhvArlVVOSFQS
         hrCxqLZJs8FIZZHi6/FbeFe+4566AOXU+65eUYtYGJGRrSP1fRzcxHoR2PuIW8ZWk15+
         3nELe9YQ8rGDue7kr13V4iMg+Ui/yGYCbsCA1yyNj+Fgg0CcobDMvk8HBSA1ojYn1qk9
         nXU7EpZVZ/Dtuj9KfD719HX6/KCYayR1l7W5TND7xGjPrECXkIWQ22orEKqqaoU9EkM+
         j4dKvLVmaJMqt+dlcdlKdoyBRbRRBzlXVcHIfVX8sK8EkZ/hkwE0zCM+AZkwO+XQo4P9
         zD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ypZyzlrBAG+cLsLy+PU3T0dnOH3TPzYnikBxeCUs2mM=;
        b=XxVeuKsS5DYNtWoz2wtD4YpTTW9+YYwi0Ykhfy0oTBWXG9Xau8/uVatuS9uvrP0CS1
         3pMcQ3mGm9WbWPW3KNkHGbf37YrDE9HFgTYJi7MeC9wfp93M0eyaRuYQQiegAy2ShRD4
         jXSR0h57uOq9mwb6Oq3xiE4GHU84JIkn4F005PYHJ/dUY1zg6CjIjrknVcXuYRYu8ABg
         pP4UY9JKyejtpk93D0ZT4f5QLHZ4agu/NNnq5WA9VhOSjoIiqzMsbMRmgfrE2ekzKz4e
         ja/gXOTZOF5LyzN56DaiRtpaJxP75HDrCYO8nNndKnv4+UIQGi+35wvxFRa8DSw50M0g
         47WQ==
X-Gm-Message-State: ANhLgQ1NZsTIbR3OdbMkKuOA3oP60m7fxdiqd3vroGtiK6QB1AvVOQ4n
        GDKN1bjhcKwZ7j0KJaShz/Yuzp8Q
X-Google-Smtp-Source: ADFU+vsHPQH1+HrBFDUdDLpJjUvvAhy2zrl3d4FreyJZGAjpLSFjTA1BKwyta+vrf+MCVIx4unC3qg==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr9582651wrp.130.1585261489629;
        Thu, 26 Mar 2020 15:24:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a64sm5312899wmh.39.2020.03.26.15.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 15:24:49 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] mm/page_alloc.c: define node_order with all zero
Date:   Thu, 26 Mar 2020 22:24:45 +0000
Message-Id: <20200326222445.18781-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200326222445.18781-1-richard.weiyang@gmail.com>
References: <20200326222445.18781-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we always clear node_order before getting it, we can leverage
compiler to do this instead of at run time.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2144b6ceb119..7a6435cffdb7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	static int node_order[MAX_NUMNODES];
+	static int node_order[MAX_NUMNODES] = {0};
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask = {.bits = {0}};
 	int local_node, prev_node;
@@ -5595,7 +5595,6 @@ static void build_zonelists(pg_data_t *pgdat)
 	load = nr_online_nodes;
 	prev_node = local_node;
 
-	memset(node_order, 0, sizeof(node_order));
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.
-- 
2.23.0

