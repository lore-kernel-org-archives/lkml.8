Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D93C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557AD2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/TUZja2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgC0WBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:01:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34242 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0WBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:01:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so13430431wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eTSWsRe+abYo5Q3Wjbmc6XN3lWlOvN/WxCYogj6bEeQ=;
        b=O/TUZja2YQbTR2MQe2O/+i3o5XBdDGDXbI04IBdld8DfWXT1YHRrtg9UYtv2RMMS+b
         LkUKoIZKnFAki+Tc7YHvgzbUTsQtS+nOs28cuEQce6lbkM8ZUxvluTbI/aAPT8+cniu1
         z3MkANBXfoTmrvW4aExbl9KJsWhbM/Z1xS7QlnpciMxcwQZuJzEeCe5gyq2JjNcQmBMu
         lxNW7JIry0nzsweknTVGNENhJNpoehU3pz0MYt1oA98+BxoYAQ0Akwgvg36g231GiveM
         i9zchGjEkFunSx7vO5s8DqEaFVyotANoAXVHB3TP08nhtlBgj/7ZF7m7wWEwse1hq4EG
         ruRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eTSWsRe+abYo5Q3Wjbmc6XN3lWlOvN/WxCYogj6bEeQ=;
        b=s8eYzgihL/cJ8GEsNlFFjjLi7tRH25+8fniTTm7Xl48O3SB8cZ1lXcmVXHyw7NFVhF
         SqnMB/Ti/wnZDcDpCkKmJdNO6LAjTZMTyddxcdwfZsqGy1Bty5WXizuG9vQ9FbvsxteE
         EmDfXCb4v/OkM4phYg6Bg9nphsu1tJvJyMMi6nMLRYo40/kiCb6wb6V/0Dimnvp+84C6
         Hez5ET9JTTexo0KAxMDLIGz/KteEKyOuGwdMAlYt13qvF3FEzz2yOuwwutwKMqRNFMMD
         OhF3hneE6dZ3zHhapevrQ4E5XvNIWVHu1IYkkgkabJ/MsFbXK2hEwOoLLfp8DF86fX2I
         EnGA==
X-Gm-Message-State: ANhLgQ0pRLPb1OcNHgJ3cH6qXs2W10uWTfiu0+8kWyuwiQwIT3lgq3Mx
        /ez4zfIJMdxgxBlQ8hs89zR5ly7z
X-Google-Smtp-Source: ADFU+vuKMRzAFYnr9n+j4lDMfaJF3f9pk6VBECs97XO6gsauwAapLshjF4PrYgtS+w6KzVFWDCZAqQ==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr1667954wrh.1.1585346502328;
        Fri, 27 Mar 2020 15:01:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l83sm9670639wmf.43.2020.03.27.15.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 15:01:41 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com, Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 1/2] mm/page_alloc.c: use NODE_MASK_NONE define used_mask
Date:   Fri, 27 Mar 2020 22:01:20 +0000
Message-Id: <20200327220121.27823-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all 0 nodemask_t, we have already define macro NODE_MASK_NONE.
Leverage this instead of clear it at run time.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: use NODE_MASK_NONE as suggested by David Hildenbrand
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef790dfad6aa..dfcf2682ed40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
 {
 	static int node_order[MAX_NUMNODES];
 	int node, load, nr_nodes = 0;
-	nodemask_t used_mask;
+	nodemask_t used_mask = NODE_MASK_NONE;
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

