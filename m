Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641DFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3237720639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262989;
	bh=ASNGJWgtwtS9VpHWrz2J5lsF5hX9JWswGiuJzWsIJqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CESIMk5AGfHo8f5Yz6dmBvMX+IayI5NqwAKq4/s5SgMQyOZ8PE8yayXRlikK3mPi6
	 AwjIeLOSkHQCTbsC6UQht8uy9xemzBgsM+vHbjhJn5KBgYvdJUkcnux2nl2ZPBU/ZX
	 BjSweysHPPdgLscjgnNtvx4E0LTssUei5+dJq/gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHXIfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgHXIff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:35:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3FA204FD;
        Mon, 24 Aug 2020 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258134;
        bh=ASNGJWgtwtS9VpHWrz2J5lsF5hX9JWswGiuJzWsIJqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahtxM8xrC1qqws7h5aaMtBa1RvKQxs3l76Fi1x0osmAj6IlWfkBb/IPeJpUW+Bx47
         mC7/3Xz5jgiD0UyQ79ADEwWxWHhwR37SyAOxBpg3RXJh1p0zT3RXxtKV9zDaTzUxyd
         l6SVyJKgeZTU4f8Ie9wS/p3byhx9QXgCzUh/vzT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Laurent Morichetti <laurent.morichetti@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 058/148] drm/ttm: fix offset in VMAs with a pg_offs in ttm_bo_vm_access
Date:   Mon, 24 Aug 2020 10:29:16 +0200
Message-Id: <20200824082416.848529113@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
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
index fa03fab02076d..33526c5df0e8c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -505,8 +505,10 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
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



