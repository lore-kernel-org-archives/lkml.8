Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089EDC35280
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 05:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C29208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 05:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZQroANp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEJFQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 01:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgEJFQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 01:16:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38947C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 22:16:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b188so6323389qkd.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZQOBtTOiht/0OTixgCTPb48WYjmKFlAenmS+UqHqNA=;
        b=ZQroANp8fgUbLE8O4nFaXlsn7+z6JZjkWLsveqku+AYSLiUyGrfjpC2D7qEkXrb0nV
         T1EgclBvDaia3VA+43Ew95hkDX2T6KgjVwcCfslouE+D1RS7CLU7qWtdj1yOiqASSZVW
         m477xibSv/upulyLQtawU1erZ0Ths74iNxOsBZhfdKWwn2g7EioloXZwbH61oI2q3B1x
         wwCYrnVj3QN+D2gJYSRxT8ofiSkYD8J/qMwawq6ciCszISikJhlxzwAFnmr6D+Z3IB2F
         MOrLayOAYJzfUxBysfxc/aLCiXqc/jRBWiyvWvURGPYrPv36G+atA+WWIhcGhKSFKUq9
         fniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZQOBtTOiht/0OTixgCTPb48WYjmKFlAenmS+UqHqNA=;
        b=KI06KBQzdoYCHK36lqtSijgycWqp+FNDR54YFB0MUythbz7Otm5V+3Z1MAm7b7ckL8
         HBgy9hcoHY72XdGkiQMVK91q1yqDxyS1P72lzZ2XKmEz90hhnnmsTwFHzJCxOXIOwojX
         cBsKHQb81VVSit85rRm7KvJBzuOk1CKGUP3Bp8eHvVg8H9XFhzn+TQYvU8P2WBwWNVU5
         4dImqnepkKIspZm/gZmdDw4LQMvdabqUCap+0EXpNCtgZfSigg9JON5BZ42nK9cc064x
         zcqCMpCt4rRBG9hXB7b+cadv1a6naEl4bm/M8xMPlwlJeZbLuhguMlJIwokykY/xPOvD
         ptAA==
X-Gm-Message-State: AGi0PuaWqvZur7LePpld1P/ynkDNNcMp+fU5tlnA8/pGhv27N91mdihK
        AA8zSNpRHj9aVdRzpBrRLFUyuQ==
X-Google-Smtp-Source: APiQypKtHcNmHWehOq6GSOMUk4uYVa07dxCSGKOqz6ZDcs8RxJ31wkL9eoYr3glZoE0oMzDU3ZNJug==
X-Received: by 2002:a37:4b02:: with SMTP id y2mr8924162qka.178.1589087769424;
        Sat, 09 May 2020 22:16:09 -0700 (PDT)
Received: from ovpn-112-80.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 127sm5215177qkj.59.2020.05.09.22.16.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 May 2020 22:16:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, aik@ozlabs.ru,
        paulmck@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/mm/book3s64/iommu: fix some RCU-list locks
Date:   Sun, 10 May 2020 01:15:59 -0400
Message-Id: <20200510051559.1959-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is safe to traverse mm->context.iommu_group_mem_list with either
mem_list_mutex or the RCU read lock held. Silence a few RCU-list false
positive warnings and fix a few missing RCU read locks.

 arch/powerpc/mm/book3s64/iommu_api.c:330 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by qemu-kvm/4305:
  #0: c000000bc3fe4d68 (&container->lock){+.+.}-{3:3}, at: tce_iommu_ioctl.part.9+0xc7c/0x1870 [vfio_iommu_spapr_tce]
  #1: c000000001501910 (mem_list_mutex){+.+.}-{3:3}, at: mm_iommu_get+0x50/0x190

 ====
 arch/powerpc/mm/book3s64/iommu_api.c:132 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by qemu-kvm/4305:
  #0: c000000bc3fe4d68 (&container->lock){+.+.}-{3:3}, at: tce_iommu_ioctl.part.9+0xc7c/0x1870 [vfio_iommu_spapr_tce]
  #1: c000000001501910 (mem_list_mutex){+.+.}-{3:3}, at: mm_iommu_do_alloc+0x120/0x5f0

 ====
 arch/powerpc/mm/book3s64/iommu_api.c:292 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by qemu-kvm/4312:
  #0: c000000ecafe23c8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0xdc/0x950 [kvm]
  #1: c000000045e6c468 (&kvm->srcu){....}-{0:0}, at: kvmppc_h_put_tce+0x88/0x340 [kvm]

 ====
 arch/powerpc/mm/book3s64/iommu_api.c:424 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by qemu-kvm/4312:
  #0: c000000ecafe23c8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0xdc/0x950 [kvm]
  #1: c000000045e6c468 (&kvm->srcu){....}-{0:0}, at: kvmppc_h_put_tce+0x88/0x340 [kvm]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/mm/book3s64/iommu_api.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index fa05bbd1f682..bf0108b6f445 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -129,7 +129,8 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 
 	mutex_lock(&mem_list_mutex);
 
-	list_for_each_entry_rcu(mem2, &mm->context.iommu_group_mem_list, next) {
+	list_for_each_entry_rcu(mem2, &mm->context.iommu_group_mem_list, next,
+				lockdep_is_held(&mem_list_mutex)) {
 		/* Overlap? */
 		if ((mem2->ua < (ua + (entries << PAGE_SHIFT))) &&
 				(ua < (mem2->ua +
@@ -289,6 +290,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
 		if ((mem->ua <= ua) &&
 				(ua + size <= mem->ua +
@@ -297,6 +299,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 			break;
 		}
 	}
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -327,7 +330,8 @@ struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
 
 	mutex_lock(&mem_list_mutex);
 
-	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
+	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next,
+				lockdep_is_held(&mem_list_mutex)) {
 		if ((mem->ua == ua) && (mem->entries == entries)) {
 			ret = mem;
 			++mem->used;
@@ -421,6 +425,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 	struct mm_iommu_table_group_mem_t *mem;
 	unsigned long end;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
 		if (mem->dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
 			continue;
@@ -437,6 +442,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 			return true;
 		}
 	}
+	rcu_read_unlock();
 
 	return false;
 }
-- 
2.21.0 (Apple Git-122.2)

