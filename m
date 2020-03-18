Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ED8C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5781B206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNnUA5nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCRDdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:33:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38857 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:33:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so13120647pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b6do2FdM++ZNF8atrZaZPrVTraaxJfH9p4SJ3Cchx9M=;
        b=bNnUA5njuPgjKCIrC9rnivOwgdkNOnKofd4X93noFXuJftyr3thd65QJ+M83ojvcvY
         t7m4G3TkleHv5rQNJ6cDoA5Uc+2T64eOYiKfF4XtUOd0Goj9OjsVCh1ZH0zzqB2c6bPr
         raDe4tTZnDh3mIr/cLWvmIo0JLYVEK5uhZqg60MnYwxZH4H2cWC2eRTFXLVkdvxBwlC8
         m2WT2v99W1/ovHvxDEHNG20Qz3NdO0Ki0aJ9v0pWoQxd+ZnUFmyaCXQD2gXRjYcft8b/
         /uVcQC96CLnaHEbKx+pCd0S7XuvBhCweZP53nF0Shubh5LS8BfSZtBOY/gCL9fvuRCdo
         wnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b6do2FdM++ZNF8atrZaZPrVTraaxJfH9p4SJ3Cchx9M=;
        b=K+V5tSFmR2NiBPcUvqNsFppZcuGJZ0hq/UmWprZgDUSbekCoB/8eTS2Ek8nsolAxnx
         D0eLjMDTbB5En3nS/eYg1gltERCf2teIHXXR4JwkzX21Mq6RWg0FCw5aBXyffsnHdZwk
         sTWzJNjKmOt5jrwt2DrF73dg4LK+PScVk1TziFmL5r/nLX/AsQ5LgXSoecoItViB99JG
         XV8qbf09eMGwyMgpEL6RM+39Iin3DO8JQ3ju+XBAXkaEZXE++CnafvORTDV52q1ZInsV
         HiJQLnlTo1i6yS4OGN+b9TsRUQQbyCgvtpPxvE7FtWtUDLGFDfrG7w7PCuoh0CrK0oeT
         MZAg==
X-Gm-Message-State: ANhLgQ2FhcWbkArHNXfg68ciBbhJMJ7S3Ij0M4litCI5jzt15MUjQqRE
        OXBTiTxw0y07734eTLsoTXo=
X-Google-Smtp-Source: ADFU+vuL6p2rHDxY5MYsnLQ86cOcIrYEZTOXts4UYoOuDn4X/PzTNNgN74Q97cwZhMcURv/IrNTyQg==
X-Received: by 2002:a62:2684:: with SMTP id m126mr2019555pfm.153.1584502409939;
        Tue, 17 Mar 2020 20:33:29 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id ep7sm679641pjb.24.2020.03.17.20.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 20:33:29 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 1/2] mm/page_alloc: use ac->high_zoneidx for classzone_idx
Date:   Wed, 18 Mar 2020 12:32:57 +0900
Message-Id: <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Currently, we use the zone index of preferred_zone which represents
the best matching zone for allocation, as classzone_idx. It has a problem
on NUMA system with ZONE_MOVABLE.

In NUMA system, it can be possible that each node has different populated
zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone and
node 1 could have only NORMAL zone. In this setup, allocation request
initiated on node 0 and the one on node 1 would have different
classzone_idx, 3 and 2, respectively, since their preferred_zones are
different. If they are handled by only their own node, there is no problem.
However, if they are somtimes handled by the remote node due to memory
shortage, the problem would happen.

In the following setup, allocation initiated on node 1 will have some
precedence than allocation initiated on node 0 when former allocation is
processed on node 0 due to not enough memory on node 1. They will have
different lowmem reserve due to their different classzone_idx thus
an watermark bars are also different.

root@ubuntu:/sys/devices/system/memory# cat /proc/zoneinfo
Node 0, zone      DMA
  per-node stats
...
  pages free     3965
        min      5
        low      8
        high     11
        spanned  4095
        present  3998
        managed  3977
        protection: (0, 2961, 4928, 5440)
...
Node 0, zone    DMA32
  pages free     757955
        min      1129
        low      1887
        high     2645
        spanned  1044480
        present  782303
        managed  758116
        protection: (0, 0, 1967, 2479)
...
Node 0, zone   Normal
  pages free     459806
        min      750
        low      1253
        high     1756
        spanned  524288
        present  524288
        managed  503620
        protection: (0, 0, 0, 4096)
...
Node 0, zone  Movable
  pages free     130759
        min      195
        low      326
        high     457
        spanned  1966079
        present  131072
        managed  131072
        protection: (0, 0, 0, 0)
...
Node 1, zone      DMA
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 1006, 1006)
Node 1, zone    DMA32
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 1006, 1006)
Node 1, zone   Normal
  per-node stats
...
  pages free     233277
        min      383
        low      640
        high     897
        spanned  262144
        present  262144
        managed  257744
        protection: (0, 0, 0, 0)
...
Node 1, zone  Movable
  pages free     0
        min      0
        low      0
        high     0
        spanned  262144
        present  0
        managed  0
        protection: (0, 0, 0, 0)

min watermark for NORMAL zone on node 0
allocation initiated on node 0: 750 + 4096 = 4846
allocation initiated on node 1: 750 + 0 = 750

This watermark difference could cause too many numa_miss allocation
in some situation and then performance could be downgraded.

Recently, there was a regression report about this problem on CMA patches
since CMA memory are placed in ZONE_MOVABLE by those patches. I checked
that problem is disappeared with this fix that uses high_zoneidx
for classzone_idx.

http://lkml.kernel.org/r/20180102063528.GG30397@yexl-desktop

Using high_zoneidx for classzone_idx is more consistent way than previous
approach because system's memory layout doesn't affect anything to it.
With this patch, both classzone_idx on above example will be 3 so will
have the same min watermark.

allocation initiated on node 0: 750 + 4096 = 4846
allocation initiated on node 1: 750 + 4096 = 4846

One could wonder if there is a side effect that allocation initiated on
node 1 will use higher bar when allocation is handled on node 1 since
classzone_idx could be higher than before. It will not happen because
the zone without managed page doesn't contributes lowmem_reserve at all.

Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
Tested-by: Ye Xiaolong <xiaolong.ye@intel.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index c39c895..aebaa33 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -119,7 +119,7 @@ struct alloc_context {
 	bool spread_dirty_pages;
 };
 
-#define ac_classzone_idx(ac) zonelist_zone_idx(ac->preferred_zoneref)
+#define ac_classzone_idx(ac) (ac->high_zoneidx)
 
 /*
  * Locate the struct page for both the matching buddy in our
-- 
2.7.4

