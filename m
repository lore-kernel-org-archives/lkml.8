Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAACC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493992077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTMMyrGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCZWYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:24:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32791 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZWYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:24:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id w25so5845606wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FAoCzyrdY1LBflFj0Bs5Q8Nrdecy48mQMVZ+2E8qNH8=;
        b=JTMMyrGuyHsBCTErKJAGpX8ivePahwROd1sXO3axLXyvZ1H/EicEtW8tGyy6iEccrT
         xVHFhx2L738y23EtcpvAwXwcxoYCGbsFPGCAwqsqcHaEYyX43djUDNyrOSMf0TXuBqj9
         3+TDxxOQjrNCUrH7nRTTq3+SgsvI1pErv2nFd1z4lz69U27kiOKUsTpGq4varX++wjLl
         mfV+plZAc3strnoQy3zPzdtW7HcqrhX24rUDnvr2UV2r97tB7iWtbPPMfrLLs7o02lq9
         BqWuP9cIuCELntO8AV2KfsDsaL07eOudrJP9WEJOmDLRg0j5AFE4QBuUkptVOZgpxrNt
         13mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FAoCzyrdY1LBflFj0Bs5Q8Nrdecy48mQMVZ+2E8qNH8=;
        b=mLPsBmUpJ+rIL6q7r4PaNCBR4gmxj6o5fCNdCzaYZDnIIfC+t649FOL1xVTVeUMZ54
         3QwgTyjNNYs1V1uKNrMYEI+YxOjS+aNY5Ooj+vuQ2FvidaCXUYPm5SXTEnPm4LhOZY6P
         +q53y37XDqc610ikHoQUO7C9dWjjxcw3lryCqqL9Y8EzLHeekhB0RWFJlM6czhP4xWf9
         SEP3AUVnWq7CB5X/hxGQdIVm6Nu/8q+unFFSr7oYIsHj16tVlmMLYYrNSHfMBjJcIMfc
         /CvZ2YJFJckMKuyWT/GGIPsUcQHWkBNh7G3bKg5cx8JhoGx1tE0naUSNvp7C+0bZ2k63
         eEyA==
X-Gm-Message-State: ANhLgQ2jB5zIXIG4n+WROho0ZTP3tP9HaNRz7MSSLnBC8A3Wt+zR48M8
        DS3YtcqH8vvJOqPEZKW0L3A=
X-Google-Smtp-Source: ADFU+vvMyEi9mdN1lTnZ9Kt/xM9PP20O2+s0UWDof1+uc8SqBbmOdoNH86tbnHs9mktJhDxjnt+Qrg==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr2063353wmb.127.1585261488638;
        Thu, 26 Mar 2020 15:24:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s15sm5506680wrt.16.2020.03.26.15.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 15:24:48 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] mm/page_alloc.c: leverage compiler to zero out used_mask
Date:   Thu, 26 Mar 2020 22:24:44 +0000
Message-Id: <20200326222445.18781-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we always clear used_mask before getting node order, we can
leverage compiler to do this instead of at run time.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e823bca3f2f..2144b6ceb119 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
 {
 	static int node_order[MAX_NUMNODES];
 	int node, load, nr_nodes = 0;
-	nodemask_t used_mask;
+	nodemask_t used_mask = {.bits = {0}};
 	int local_node, prev_node;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
 	load = nr_online_nodes;
 	prev_node = local_node;
-	nodes_clear(used_mask);
 
 	memset(node_order, 0, sizeof(node_order));
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
-- 
2.23.0

