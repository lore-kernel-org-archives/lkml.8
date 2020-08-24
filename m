Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AF1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FB12071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261975;
	bh=2piNqjgMF8RHhqlBhK0HIYSunlesgNni0vdGlmvyMoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTQPr2XVZJCZ3pSuFoCOijj0Xdh7Ig7GgmPN319n0HzCkqtMjDYBuWD7MqlvGoQJ2
	 Ck1PWi3tgwSsTWo9Uf4dKHYuyC7bSOossrEgoTdQUw7QkTR4GzbxLtOgDtrZT/wQ3P
	 +npnzfttwZseyCpmR+daZ/xy+qR5OVk3i/o4k838=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgHXJj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbgHXIqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:46:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736FA206F0;
        Mon, 24 Aug 2020 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258804;
        bh=2piNqjgMF8RHhqlBhK0HIYSunlesgNni0vdGlmvyMoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgZNh1XbIyz0rI/LLjH+8GIRBspnLDg09Tl30s7p86envT9d024Yse04nfPNKhpnt
         hnSKIgaU9bUDaV9Of4h5K51kxSecY6rH/pCuofpEISU4zGGKaoj8k1YY8TU+23+Kl6
         1kw7mCa/YPa56RYLN+a96S8xfzgsQCmykW2GIf1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Laurent Morichetti <laurent.morichetti@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/107] drm/ttm: fix offset in VMAs with a pg_offs in ttm_bo_vm_access
Date:   Mon, 24 Aug 2020 10:30:17 +0200
Message-Id: <20200824082407.663650123@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit c0001213d195d1bac83e0744c06ff06dd5a8ba53 ]

VMAs with a pg_offs that's offset from the start of the vma_node need
to adjust the offset within the BO accordingly. This matches the
offset calculation in ttm_bo_vm_fault_reserved.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Laurent Morichetti <laurent.morichetti@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/381169/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 46dc3de7e81bf..f2bad14ac04ab 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -358,8 +358,10 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 static int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
 			    void *buf, int len, int write)
 {
-	unsigned long offset = (addr) - vma->vm_start;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
+	unsigned long offset = (addr) - vma->vm_start +
+		((vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node))
+		 << PAGE_SHIFT);
 	int ret;
 
 	if (len < 1 || (offset + len) >> PAGE_SHIFT > bo->num_pages)
-- 
2.25.1



