Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D07C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250862078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="fW03118K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgIJIqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgIJInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:43:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06924C061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:15 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so4196291pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DydHZR1p/a4YgWod1jge5YOze1r87n8O9ViW1sroOHE=;
        b=fW03118K7OqoKHn0n/T5KvrtUYFGItUGF5N6guUzhftq5pe6S/cCuNZOc7HvKn8Eey
         IDNdM9hwsCF4NZkTkAwKmCSYy5a2dFlOA9lp46ncqkgd1q3DoUJBFxmUZUZt6kufBXDw
         pYTgoq8v1ApLaGpSc4X6a84Kaosdt95njNvvWGVCbOHsa7bfTKEnm+5pbShj746vZxEM
         b+3wSM92YFInqZYqb9WhPEDbL8IxDn5xD9kvQ3mFFAd9hJY0Ini76LCw7FtbXR+ymhl4
         VUof+fRcGtKEQQO3SOy6ZDwd0/xU/N2QLdSZhnFwnfuFkKPNnJZKNuYqkAsm/aEf/aXB
         rmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DydHZR1p/a4YgWod1jge5YOze1r87n8O9ViW1sroOHE=;
        b=tlNTbDDqscXpqWMlI9nNso1efUJF4K+rkjqmfapmJ13ZkJnMp2UJJtmXjkCOxJLA43
         i7nm0MLdaWgy1oMBzLpIC4NRLeq9vJVOnyvaZZTn/8224T6cuOwGXlhhbwd9IEN/aK2z
         36tcPTa7qjwdLm4clGfVR9pjl2qrtZLC1u6va9Byq5GR8tbw/kcZA66hSitmFIS6wDeM
         tsxVxB56j482ubrcK3dXCjIejZEwyTWCbTHhJ7SvaKJLzEk3JHGIsxJqgplJA3tLyG0c
         yz6vEjBRip8Euk0OhIpPaU3qdL515qMOK5ZOuRNL0lL/jvwbEph4bBGER9VACr0NDk7d
         HMmQ==
X-Gm-Message-State: AOAM533fLy35UQulEXsGNttVQ4SaGmfu95OEKFpH1r14oZMdcNRPcdFn
        CnI2W6wtctfjzQNGPDvb9dV6gg==
X-Google-Smtp-Source: ABdhPJw1G2Xl2QigaSTG41KX4+ivGSijQkSvMrzle/xljTr3qEDQNI3MjDlu9qARs4whVg2vcMPJEw==
X-Received: by 2002:a63:f53:: with SMTP id 19mr3741250pgp.26.1599727395106;
        Thu, 10 Sep 2020 01:43:15 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id n21sm4447567pgl.7.2020.09.10.01.43.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 01:43:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: Add the missing numa stat of anon and file for cgroup v2
Date:   Thu, 10 Sep 2020 16:42:58 +0800
Message-Id: <20200910084258.22293-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cgroup v1, we have a numa_stat interface. This is useful for
providing visibility into the numa locality information within an
memcg since the pages are allowed to be allocated from any physical
node. One of the use cases is evaluating application performance by
combining this information with the application's CPU allocation.
But the cgroup v2 does not. So this patch adds the missing information.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75cd1a1e66c8..c779673f29b2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1492,10 +1492,34 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 	return false;
 }
 
+#ifdef CONFIG_NUMA
+static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
+					   unsigned int nid,
+					   enum node_stat_item idx)
+{
+	long x;
+	struct mem_cgroup_per_node *pn;
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+
+	VM_BUG_ON(nid >= nr_node_ids);
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	x = atomic_long_read(&pn->lruvec_stat[idx]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+#endif
+
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
 	int i;
+#ifdef CONFIG_NUMA
+	int nid;
+#endif
 
 	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
 	if (!s.buffer)
@@ -1512,12 +1536,30 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	 * Current memory state:
 	 */
 
-	seq_buf_printf(&s, "anon %llu\n",
+	seq_buf_printf(&s, "anon %llu",
 		       (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
 		       PAGE_SIZE);
-	seq_buf_printf(&s, "file %llu\n",
+#ifdef CONFIG_NUMA
+	for_each_node_state(nid, N_MEMORY)
+		seq_buf_printf(&s, " N%d=%llu", nid,
+			       (u64)memcg_node_page_state(memcg, nid,
+							  NR_ANON_MAPPED) *
+			       PAGE_SIZE);
+#endif
+	seq_buf_putc(&s, '\n');
+
+	seq_buf_printf(&s, "file %llu",
 		       (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
 		       PAGE_SIZE);
+#ifdef CONFIG_NUMA
+	for_each_node_state(nid, N_MEMORY)
+		seq_buf_printf(&s, " N%d=%llu", nid,
+			       (u64)memcg_node_page_state(memcg, nid,
+							  NR_FILE_PAGES) *
+			       PAGE_SIZE);
+#endif
+	seq_buf_putc(&s, '\n');
+
 	seq_buf_printf(&s, "kernel_stack %llu\n",
 		       (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
 		       1024);
-- 
2.20.1

