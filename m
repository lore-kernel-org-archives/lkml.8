Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF98C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D377206E6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp+IfQa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC2Cmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 22:42:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34997 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgC2Cmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:42:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so16821385wrn.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m3v4eUN1Q8sQ8xavWGBmWHQ29/mKNFiqKaIswR2Yr2k=;
        b=Wp+IfQa1bYEpqrV6Mbx4pfI10yrDhmVCxHQvAGH4iHMos+E6LOCSjJxtPxMZx4WSHK
         /InfH8Ekfl1xp4NqzOVpRsz9Pi+bf1Uukp1Gwa3ih1PB1g8Kc7sFHuom/blQX/m8Qqf7
         dYP012oQADT7bZgf3H5FflM7AWDutupoDDHwIDQe/MQb/GriG2v9S9jXvfiPXJZrNOWD
         59GeUJsZQBnRBnF8txlGxAHIWw3mj30JidpLzV3ZBtWUwWVQ8BDFQbiacTUosyzXfVz7
         bXZ8iIBvkfDOmkHN5jh5Sz22zkirrUPn075hUdQkTcKB9dVop1LjHkKtY5sIYVpaHIJh
         ktbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m3v4eUN1Q8sQ8xavWGBmWHQ29/mKNFiqKaIswR2Yr2k=;
        b=k01CWtRAkwpEOakfUvB39L9ue0igJHmO7Rlc8iQTGFQ3MOfLlYQjd35Oolk4k6u8tK
         ZpBurDpMd4QbHzk5HDRT0KI0aSnFbcbm797Ei+6ar1tGS3IIFkRUF0Fk5V10bKAHmo1A
         md7W118eKHPf6X/1QoGiVD4VQGe9jpuwLdASlQb+hGq0q8Q75nKwI9BROgDQ81AYa/lm
         6tapQpaHxIV1HKTKcFpB1xF7WUj4vYV3LtZNDmniOx55iu2LL/hdTx3W0/reINYIOGfn
         DpDr3BV/pwuNOv2vxXddf5SLcvvkkwh79uR78NJ8UCEanegH+hAE/gmr2ZXvaDYBWBsx
         6zng==
X-Gm-Message-State: ANhLgQ34w6+1KH3Am69k3s75xPMjimEbTsgu2TAGHiIfP9vfgISQsRrM
        VtuoLuN38CWDGoThiPPouMw=
X-Google-Smtp-Source: ADFU+vvDMaN/xFKcdo5GXeR+Nf9wdCY1mQqmhctgMpGp5GkhHcHVIdNK4pqxB3hqLdMZlMiOcEzXKw==
X-Received: by 2002:adf:b1d8:: with SMTP id r24mr7701334wra.266.1585449753286;
        Sat, 28 Mar 2020 19:42:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t10sm15424374wrx.38.2020.03.28.19.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 19:42:32 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com, jhubbard@nvidia.com, bhe@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3] mm/page_alloc.c: use NODE_MASK_NONE define used_mask
Date:   Sun, 29 Mar 2020 02:42:17 +0000
Message-Id: <20200329024217.5199-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all 0 nodemask_t, we have already define macro NODE_MASK_NONE.
Leverage this to define an all clear nodemask.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
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

