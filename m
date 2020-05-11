Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613A3C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4215520722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgEKCXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:23:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729328AbgEKCXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:23:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1B4298DAEC3A82EFFADF;
        Mon, 11 May 2020 10:17:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 10:17:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 07/10] riscv: Make SYS_SUPPORTS_HUGETLBFS depends on MMU
Date:   Mon, 11 May 2020 10:19:58 +0800
Message-ID: <20200511022001.179767-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
References: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HUGETLBFS only used when MMU enabled, add the dependence.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 494e670520ae..d0010ed8e0f4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -138,6 +138,7 @@ config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
 config SYS_SUPPORTS_HUGETLBFS
+	depends on MMU
 	def_bool y
 
 config STACKTRACE_SUPPORT
-- 
2.26.2

