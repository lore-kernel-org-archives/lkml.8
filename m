Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B44C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BBC22522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAWHFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 02:05:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgAWHFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:05:11 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4FCF3AEBE20CF7D75747;
        Thu, 23 Jan 2020 15:05:10 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 23 Jan 2020
 15:05:01 +0800
From:   Xuefeng Wang <wxf.wang@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <chenzhou10@huawei.com>,
        Xuefeng Wang <wxf.wang@hisilicon.com>
Subject: [PATCH 0/2] mm/thp: rework the pmd protect changing flow
Date:   Thu, 23 Jan 2020 15:55:11 +0800
Message-ID: <20200123075514.15142-1-wxf.wang@hisilicon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On KunPeng920 board. When changing permission of a large range region,
pmdp_invalidate() takes about 65% in profile (with hugepages) in JIT tool.
Kernel will flush tlb twice: first flush happens in pmdp_invalidate, second
flush happens at the end of change_protect_range(). The first pmdp_invalidate
is not necessary if the hardware support atomic pmdp changing. The atomic
changing pimd to zero can prevent the hardware from update asynchronous.
So reconstruct it and remove the first pmdp_invalidate. And the second tlb
flush can make sure the new tlb entry valid.

This patch series add a pmdp_modify_prot transaction abstraction firstly.
Then add pmdp_modify_prot_start() in arm64, which uses pmdp_huge_get_and_clear()
to atomically fetch the pmd and zero the entry.

After rework, the mprotect can get 3~13 times performace gain in range
64M to 512M on KunPeng920:

4K granule/THP on
memory size(M)	64	128	256	320	448	512
pre-patch	0.77	1.40	2.64	3.23	4.49	5.10
post-patch	0.20	0.23	0.28	0.31	0.37	0.39

Changes:
v2:
 - fix set_pmd_at compile problems

Xuefeng Wang (2):
  mm: add helpers pmdp_modify_prot_start/commit
  arm64: mm: rework the pmd protect changing flow

 arch/arm64/include/asm/pgtable.h | 14 +++++++++++++
 include/asm-generic/pgtable.h    | 35 ++++++++++++++++++++++++++++++++
 mm/huge_memory.c                 | 19 ++++++++---------
 3 files changed, 57 insertions(+), 11 deletions(-)

--
2.17.1
