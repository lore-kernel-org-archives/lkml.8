Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FBC2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5B4206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKf24TUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgC3WJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:09:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55312 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgC3WJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:09:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so466864wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ik/3e0uSzSzcYKdS0/OeT2EBEqYErrSILcGFWXs+2RM=;
        b=UKf24TULpgTKJkpnnCkZEN2gEFN63tvYWD6w41Q4gya0Vq0f09iToO7bl/oB1ZNu1I
         +0yED3dPm+FJXmb22sY74RrD/wLrvk+TzOh++9pEq937ku5LKzlLKLbIC1/cLmRF9JGh
         LGS1Q7OfD8Ne+svufwH86ipe5b3qGXcIjpyKxe+GsXMLC/l9e5NpHtvCVj2HEwh1AjEo
         JAG0gCIGwsXq0TB69oyMticmrZiArh9E+JW7jV3U38k6sZSiwUyQi6xL6HuUspFxjE1o
         wB+Tl/94HobSZdFyXYLMNZLq5Tr+4Z+GIfvh8MhzsAx7n8rQ6loCcmHgebUg1ZoBGPCo
         PUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ik/3e0uSzSzcYKdS0/OeT2EBEqYErrSILcGFWXs+2RM=;
        b=fxWZUZ2ugIyJsXaNLeZUnbOdhlhQ8y0FXG/trpYALo5hSHFNcP9D5iDRzNJVKLLQJc
         eh33cp4iFPejeiqBLlSmbMTnOOmPviD3bizAFAaCLu5vxOjA++468Cp8qt0JPFgvO/xn
         YLvSuLULA3/OK18z4MO4EjAnrlIHc11yLCNpWQk81ZYLOv4Uz3w/0F71VTx3P9RAWkaE
         mKJm63B3Iw/a5eqT+gML9ndJMyCIAYIAi+ZVQIeoxaemHrfdVTjjYDLWT1sz7baqE5AY
         xTAU6r8sdnRbTelY/QHzCw3eBIHUInTQRYXBkKe80CXclwm2VmwhjjFm65C722zr/RgG
         KHKg==
X-Gm-Message-State: ANhLgQ2liy7Hh3GPjHOmyP1i39BH0t3pxaJ5k3GvB+rXoi7gwCkhoZye
        sTQzXfW/a+F9Q7tc3AZavGo=
X-Google-Smtp-Source: ADFU+vuuC/kM6I+Yns0EcU4d71N+MU8c4b3Y0qKLRXiZ5TPZCVcveYtXDSjtrUkUuS2HMFVUkbqj4w==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr251708wmj.40.1585606149273;
        Mon, 30 Mar 2020 15:09:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i8sm25093845wrb.41.2020.03.30.15.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 15:09:08 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com, jhubbard@nvidia.com, bhe@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v4] mm/page_alloc.c: use NODE_MASK_NONE in build_zonelists()
Date:   Mon, 30 Mar 2020 22:08:40 +0000
Message-Id: <20200330220840.21228-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly simplify the code by initializing user_mask with NODE_MASK_NONE,
instead of later calling nodes_clear(). This saves a line of code.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v4: adjust subject/description as suggested by John Hubbard
v3: adjust the commit log a little
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

