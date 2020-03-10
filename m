Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49048C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FE924697
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845076;
	bh=wy9W+fQwofwFUAdAK7CWRsY2cm5mGzcAMji3HmIrySs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ms3ifxk3lmkCPHxuKXWw63z7wBYCCD+RV97f7B4VboFpXBydPKkvGfpCSOaKmMbWi
	 PWTe7csN4ZeBEBu/+OeOdP7x8kO7NMj0/D1yD+RaZzZvWr6IyEv7+RGn0up4l+jAJG
	 McvUb7870xCZXiZbDp699oPpuK/UnFWxrvBB+W9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgCJM5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbgCJM5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:57:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DA32467D;
        Tue, 10 Mar 2020 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845068;
        bh=wy9W+fQwofwFUAdAK7CWRsY2cm5mGzcAMji3HmIrySs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjxmSC31qpOC0vCQUFyYFCzLXW/2U04tK4DqIB9oIxSnOnwI1Qr8CK8NS7uaJCUAH
         JCPGKy0IR4V+uxyhpHvdKKrbWdeHsHQFmdBv/rib5Vw4r5fQapVMwVobq/mV4qLtpJ
         aUL/aFDfVxC+PiFbwlW4yBz9gG/1dKJ34P5AYV4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Mo Qihui <qihui.mo@verisilicon.com>,
        Zhange Jian <zhang_jian5@dahuatech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 051/189] csky/mm: Fixup export invalid_pte_table symbol
Date:   Tue, 10 Mar 2020 13:38:08 +0100
Message-Id: <20200310123644.664820070@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit 7f4a567332f035ab16b29010fbd04a0f10183c77 ]

There is no present bit in csky pmd hardware, so we need to prepare invalid_pte_table
for empty pmd entry and the functions (pmd_none & pmd_present) in pgtable.h need
invalid_pte_talbe to get result. If a module use these functions, we need export the
symbol for it.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Mo Qihui <qihui.mo@verisilicon.com>
Cc: Zhange Jian <zhang_jian5@dahuatech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index d4c2292ea46bc..00e96278b3776 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -31,6 +31,7 @@
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
+EXPORT_SYMBOL(invalid_pte_table);
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
-- 
2.20.1



