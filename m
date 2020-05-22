Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88203C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D881205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159427;
	bh=MWITYB0vR5lA3KxxO0iN6yDsjvP8KH/f4rd52IxEzSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17GHrv254YiKv+QnyjycQFHlMak22LezlLg6HkE/XlcGw5n3KWM4tKMVOTiRtI5/b
	 1zatL9NgpFgY9p/xLRwchGtV8JmnXcTq8gBacQw4jv8NCrNDdGdDyp0Wm2lC2KbAo/
	 tzVRrP21pJXmrpZW1Y6QRzMQLYRHVwqdRp3ZCocI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgEVOuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730767AbgEVOuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58EAD22249;
        Fri, 22 May 2020 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159040;
        bh=MWITYB0vR5lA3KxxO0iN6yDsjvP8KH/f4rd52IxEzSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gz74speDsIrhfbnw3pb9c4TKj7Gn5xuMeAp0gC/0Tzv+qQq7YSqSv0LcOeopOa21c
         CdqZjSaLudvGxGWLxrQLt/gbeHOOPAZtHgm2eNsuqFmambRk/eraqMxiFrA7j/KbLA
         /j2GdykSxa1IGli5U+VFntLA1lk8fYLpI4fwcrfE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 37/41] riscv: pgtable: Fix __kernel_map_pages build error if NOMMU
Date:   Fri, 22 May 2020 10:49:54 -0400
Message-Id: <20200522144959.434379-37-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 9a6630aef93394ac54494c7e273e9bc026509375 ]

riscv64-none-linux-gnu-ld: mm/page_alloc.o: in function `.L0 ':
page_alloc.c:(.text+0xd34): undefined reference to `__kernel_map_pages'
riscv64-none-linux-gnu-ld: page_alloc.c:(.text+0x104a): undefined reference to `__kernel_map_pages'
riscv64-none-linux-gnu-ld: mm/page_alloc.o: in function `__pageblock_pfn_to_page':
page_alloc.c:(.text+0x145e): undefined reference to `__kernel_map_pages'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 05b92987f500..31d912944d8d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -467,6 +467,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 
 #define TASK_SIZE 0xffffffffUL
 
+static inline void __kernel_map_pages(struct page *page, int numpages, int enable) {}
+
 #endif /* !CONFIG_MMU */
 
 #define kern_addr_valid(addr)   (1) /* FIXME */
-- 
2.25.1

