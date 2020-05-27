Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C932C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEB52078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CheiPRCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgE0Gpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Gpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:45:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so11343087pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uy1aITqPYjQyDConSDxS/vAmxEPZtfezVYXKIghEL6E=;
        b=CheiPRClNQtcEvaOFuaPZj6s17m24bqQKV7N6nV3kZS9Dx0DA/Wuua6TZ9vVwtxoHp
         /X4lk38zc0BorHBt1q5UBpXMhfwRevjYCAXJt8koPi31G/sNhk/nJh8c/J3V98PFrIX6
         jp0Y1rp4ARZJCP7xDp9JpPbf/6Ev3cTK8k56oDIfBVg/0pqUFGA+v4T9LZTz4rpb11Cf
         nD7ZIy45HQ916c0C7IxLs9LE6ck4xw8NhrT0Pn4Km/i5mdIugENsUofGa4IX60wjYlhl
         vnbCxasvW/5WP/fYvOetmEWlTUjh/TGaZbG1KJXqTZv2xvGXEQj1M95pvU1eZ1fntljN
         0Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uy1aITqPYjQyDConSDxS/vAmxEPZtfezVYXKIghEL6E=;
        b=pXwAOM3FDVJggt7Fph1eo3ja+dv54ONN3w75EVEAKFBRi+MEhg/PwBzCou0U0Yjim2
         DwMLeQqGv85qHqb9whajLMycLfcsSOE9gBBbiyCknKg+UpSK/K10vHXZvdEKabbxKI8H
         edbPUPOdpu480IIi1mmWbKyf40Jh/PosrIYObxd91YT80KSRy9lnOCpT2sjy/9FoOs+c
         ELc+LfAWn/wTAEdu/SDlZON2s2TDFASk5DjsA6YaQLMVuG4JWRGvJVSsBxrAnv9N1vkM
         1mFx2ca/foHb7QmnHOnXapygam8xNXl1eYgQNy3rsaMJ2fUI5WRvgubuCahP1cU54wrs
         xrMA==
X-Gm-Message-State: AOAM530R/PoeKCbW6fG8KcY7g9quAQEVbPncSx4vcVB/7b2nkdq7ylkM
        lvRxmQIg594UcN0STk57gXA=
X-Google-Smtp-Source: ABdhPJzBioCuxa1MlThxgTpc7I9sNDJk/3/RYFCqWUnSeJkGm66wFjQ4Rkki6BVwGiaOzM3NUdhVVg==
X-Received: by 2002:a63:f856:: with SMTP id v22mr2672557pgj.64.1590561946463;
        Tue, 26 May 2020 23:45:46 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:45:46 -0700 (PDT)
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
Subject: [PATCH v2 01/12] mm/page_isolation: prefer the node of the source page
Date:   Wed, 27 May 2020 15:44:52 +0900
Message-Id: <1590561903-13186-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

For locality, it's better to migrate the page to the same node
rather than the node of the current caller's cpu.

Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_isolation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 2c11a38..7df89bd 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -300,5 +300,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private)
 {
-	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
+	int nid = page_to_nid(page);
+
+	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
 }
-- 
2.7.4

