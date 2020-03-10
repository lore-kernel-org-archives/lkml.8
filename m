Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29437C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0025C24694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844611;
	bh=wy9W+fQwofwFUAdAK7CWRsY2cm5mGzcAMji3HmIrySs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rb+Q+6fFuSeHDmzeTt472ariP3NzM7z/hTrYiEjCQWQQqdnLDE72Lw+1CrS5hJtDt
	 BM2fTzxokNjcIdapc4DKNcaSK/wRpv67F8risKO4v7V3a6ReUYUZV7GjAuKDqDZZxp
	 +B+h1LK2AEtK32xBr+4gRe4wdpWaBZ9aFD2qZ9T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgCJMuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgCJMt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:49:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D670C20674;
        Tue, 10 Mar 2020 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844599;
        bh=wy9W+fQwofwFUAdAK7CWRsY2cm5mGzcAMji3HmIrySs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZBh/2aiXyn9L2eeprPMD3T1C5urf0F7P73wCF1IHxVCpHa90grm3YYWtt2cM6VGj
         vShNqeI1r5Zh2Th+OoLpMwP56PvYUHr1D3MWB4mUMUi1C0gneIQbWBPNR158vrQLAX
         WD9AvnUcbfQJvX4IZMSePLmiTMYqblTnxykSaP70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Mo Qihui <qihui.mo@verisilicon.com>,
        Zhange Jian <zhang_jian5@dahuatech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/168] csky/mm: Fixup export invalid_pte_table symbol
Date:   Tue, 10 Mar 2020 13:38:16 +0100
Message-Id: <20200310123640.430251045@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
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



