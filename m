Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD5C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D571A20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MLKCqRTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBFDt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:49:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42771 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBFDt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:49:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so4210201qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 19:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxANxXZU2Rk08XG2GluKfdDTwnG/dy9QREjJ+P1sSFM=;
        b=MLKCqRTIDJqkhl7bnIkVnVSnJFpwKsqgEiDQwlNrFCQVi5/4n8Qxyk9uCiV+BL7lvm
         GrJojoMdU/xDt+4HbWyb3xfWCz3ssFMhOMWLJV2yL6WiMUpfdbbGkOXvQklllnl0mfND
         DqhPzDIeVzszTkvquwmJfmcs4hilCFBaVzcU290i8Zfsyf+D7saadnUkDOwXZio+y8ik
         +d6N2a2XpmVwP/qN2gyVaLF8WlaSGWDayMvsCvAnO554cPyrGo9wBQeE0gYtyuWhpxF2
         TgVi4G1D/l6fv7/2d4ENp1YAmAl0tHCXJBdP84QD7Un0/bVKY4m7IM5/VRduP+vfrVde
         /KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxANxXZU2Rk08XG2GluKfdDTwnG/dy9QREjJ+P1sSFM=;
        b=UHS8ezI6V09/aY+yyXHwA1wfIiZ6H8iRBqQE2tvrpvmDBxqmmi545vCdIdR3nIT+pL
         IqDA2QAloBaLGD8a3bTzNRpOy3VlWPVjxre6GB/Tm57TWdCGoQhVoC0aukadP9pjV80s
         KruKzxKKLDcJzbUbYzPhxMEsI3h7/jajQpHrT7Nb2ka06LZ0FrMCazubmQtU2zTC9o0l
         IH+dWDQ0+xbKXte5ws+XZce3VipCR+c9t45LAA/SBheYgBw1qjctXLFtQih2isifFsyE
         Mg/7jy0bo4SZksSHU9I91UhSupO+Wg7MMIE3fgezNsC9oEyLfZCsuDcyX2joSU2hwLV9
         +RxQ==
X-Gm-Message-State: APjAAAWoxqeXaVZ5lSq7YW+KcLFv/jyTuxb0JMgS3G6ZPDXEV7oDcg8O
        8TW6EEl9W9RlV/GDKjLJWRVaBA==
X-Google-Smtp-Source: APXvYqymOeTH53oOrgC3D/ksozhvjOxvOHWHxZkJqVLIUdwJiCdAeHCXvM6a0syHyqAcF4IUEyfPsg==
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr816980qke.297.1580960994405;
        Wed, 05 Feb 2020 19:49:54 -0800 (PST)
Received: from ovpn-120-236.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x16sm811123qki.110.2020.02.05.19.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 19:49:53 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/memcontrol: fix a data race in scan count
Date:   Wed,  5 Feb 2020 22:49:45 -0500
Message-Id: <20200206034945.2481-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mem_cgroup_per_node mz.lru_zone_size[zone_idx][lru] could be
accessed concurrently as noticed by KCSAN,

 BUG: KCSAN: data-race in lruvec_lru_size / mem_cgroup_update_lru_size

 write to 0xffff9c804ca285f8 of 8 bytes by task 50951 on cpu 12:
  mem_cgroup_update_lru_size+0x11c/0x1d0
  mem_cgroup_update_lru_size at mm/memcontrol.c:1266
  isolate_lru_pages+0x6a9/0xf30
  shrink_active_list+0x123/0xcc0
  shrink_lruvec+0x8fd/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x170/0x700
  __handle_mm_fault+0xc9f/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffff9c804ca285f8 of 8 bytes by task 50964 on cpu 95:
  lruvec_lru_size+0xbb/0x270
  mem_cgroup_get_zone_lru_size at include/linux/memcontrol.h:536
  (inlined by) lruvec_lru_size at mm/vmscan.c:326
  shrink_lruvec+0x1d0/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_current+0xa6/0x120
  alloc_slab_page+0x3b1/0x540
  allocate_slab+0x70/0x660
  new_slab+0x46/0x70
  ___slab_alloc+0x4ad/0x7d0
  __slab_alloc+0x43/0x70
  kmem_cache_alloc+0x2c3/0x420
  getname_flags+0x4c/0x230
  getname+0x22/0x30
  do_sys_openat2+0x205/0x3b0
  do_sys_open+0x9a/0xf0
  __x64_sys_openat+0x62/0x80
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 95 PID: 50964 Comm: cc1 Tainted: G        W  O L    5.5.0-next-20200204+ #6
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

The write is under lru_lock, but the read is done as lockless. The scan
count is used to determine how aggressively the anon and file LRU lists
should be scanned. Load tearing could generate an inefficient heuristic,
so fix it by adding READ_ONCE() for the read.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..e8734dabbc61 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -533,7 +533,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	struct mem_cgroup_per_node *mz;
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	return mz->lru_zone_size[zone_idx][lru];
+	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
 }
 
 void mem_cgroup_handle_over_high(void);
-- 
2.21.0 (Apple Git-122.2)

