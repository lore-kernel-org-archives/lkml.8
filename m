Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9D32075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ2wAWd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgGMGmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3865C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so5747030pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=noldTA6TKGUO86OIVB7oA9T0/eymsgYb8B93ohzbuus=;
        b=fJ2wAWd8sVBowfNQlIYjTQgKE97koI1YqDvDAfd6uHrehSwNDh+QUIAWbXchLGE53T
         FO7SDKQBdY7BFhSnrxslfGgCGXHhSNRO0N6yZZ2HmUj1F5m/19tehni4HYoQY3gcT/8z
         Ds0wQ2ds0+bpJlNXyTCEj1dUR5G/rrimdM7a2VkzBXedNUK42Au4AeBre8ww++9pcMcQ
         vGOoXH6aGvhfQ75S4tnMBS2sH7e/NAhaysv1I2AMuqrflUr7w8HAMzzLGABi/jGfRU6j
         lLXyRu70tyicI0MyGZpyK6umgi4AQMlbIqZMWyRF7Ab5kyxDzagzK4LUm8DLiaoiQnbo
         q91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=noldTA6TKGUO86OIVB7oA9T0/eymsgYb8B93ohzbuus=;
        b=p7g5ci66HApCnJzrBuFNkQHcvlLHzeKPNo9d0vzBOHBst4ObFr1WGnXwjQ9fbxs1wN
         vKmrc7mZgjYA1ISzUFgBYNnUCGgqA23A7ayjw+cHznoSvDdsGeGICjLl4AhhNljb+Tdk
         wg61fTStd+CUvfNZaxQMf37jceEXSttJxuDPXOLigkRzDCYC2NDNcdWU2B5RcuHVWvqz
         la+Y8u8ZwbFfW0TkoXok9qCpeh9emvh9mt2wT60O0GZjN2V4YPar1k1es+Xory6MMRde
         CL/PmV0e7Fm3FIDpY/ocXB/iUjNWD6Q2r3y7B/UEaeMuHfqDBtrWLAcduUrFlqi7VfZx
         zebw==
X-Gm-Message-State: AOAM532NbyH3Qw+/laGUGnVoisQjPIbSqUT99hZY94GT6QX9aMFfM9Mx
        xIepHAE1lTbOdjTA1zRAaSA=
X-Google-Smtp-Source: ABdhPJwn+AcUDIjoxlY5QSg2l4apojuP3f6MX5U97ovJuEBrhG6ucQ8EykH/oSODENjgFRQvokIW6A==
X-Received: by 2002:a17:90b:488:: with SMTP id bh8mr19357095pjb.49.1594622539325;
        Sun, 12 Jul 2020 23:42:19 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:18 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 1/9] mm/page_isolation: prefer the node of the source page
Date:   Mon, 13 Jul 2020 15:41:49 +0900
Message-Id: <1594622517-20681-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

For locality, it's better to migrate the page to the same node rather than
the node of the current caller's cpu.

Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_isolation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f6d07c5..aec26d9 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -309,5 +309,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private)
 {
-	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
+	int nid = page_to_nid(page);
+
+	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
 }
-- 
2.7.4

