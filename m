Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA581C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AE82083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860791;
	bh=d3nacwIRosEwNcWx/cyzqOzY7YFSMWWWUSOC4AvfB2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7wojktk2yUTWiqQAjbfY4fmSV5uwkTGM79p+CK85jd8w6IQqjItz5DRRwbzzF0TM
	 4yT28Cfr9aXl/Z5X+Mc86ZovyktFKaFNu2prU5jbh9xs2GVaISsOseOSsbSNg9HjE9
	 l4kUYJRjVTH54hQJ8q95Hxiv7xF5m+jprXkeuoQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbgG0Oju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgG0OJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:09:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F252173E;
        Mon, 27 Jul 2020 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858974;
        bh=d3nacwIRosEwNcWx/cyzqOzY7YFSMWWWUSOC4AvfB2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPfMJr6gUOHVfkckdYnZn+FZ4bWRcaZsKPk2ckoC5qQ0HHiyHZRGVDvW/kvCp+Rf8
         Stcn9YjRgNGt/O7ff+3vqbEaW3opTbGet6Ld5LCrtXAttblY/tAmCZMalaruLBq2qk
         CaofBztzreRlKh6i7CqS5zFM/Jg800weBT/dc++A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 4.19 18/86] IB/umem: fix reference count leak in ib_umem_odp_get()
Date:   Mon, 27 Jul 2020 16:03:52 +0200
Message-Id: <20200727134915.278101253@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

Add missing mmput() on error path to avoid ref-count leak.

This problem is introduced by 79bb5b7ee177 ("RDMA/umem: Fix missing mmap_sem in get umem ODP call")
and resolved by f27a0d50a4bc ("RDMA/umem: Use umem->owning_mm inside ODP").
So, it's only needed in stable-4.14 and stable-4.19.

Fixes: 79bb5b7ee177 ("RDMA/umem: Fix missing mmap_sem in get umem ODP call")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem_odp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -356,7 +356,8 @@ int ib_umem_odp_get(struct ib_ucontext *
 		vma = find_vma(mm, ib_umem_start(umem));
 		if (!vma || !is_vm_hugetlb_page(vma)) {
 			up_read(&mm->mmap_sem);
-			return -EINVAL;
+			ret_val = -EINVAL;
+			goto out_mm;
 		}
 		h = hstate_vma(vma);
 		umem->page_shift = huge_page_shift(h);


