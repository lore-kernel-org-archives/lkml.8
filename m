Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05370C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48F8206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgEKCXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:23:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729102AbgEKCXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:23:38 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 19131B6D5A615D7DDB22;
        Mon, 11 May 2020 10:17:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 10:17:08 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 10/10] riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id'
Date:   Mon, 11 May 2020 10:20:01 +0800
Message-ID: <20200511022001.179767-11-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
References: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from ./../include/linux/compiler_types.h:68,
                 from <command-line>:
../include/asm-generic/mmiowb.h: In function ‘mmiowb_set_pending’:
../include/asm-generic/percpu.h:34:38: error: implicit declaration of function ‘smp_processor_id’; did you mean ‘raw_smp_processor_id’? [-Werror=implicit-function-declaration]
 #define my_cpu_offset per_cpu_offset(smp_processor_id())
                                      ^~~~~~~~~~~~~~~~
../include/linux/compiler-gcc.h:58:26: note: in definition of macro ‘RELOC_HIDE’
  (typeof(ptr)) (__ptr + (off));     \
                          ^~~
../include/linux/percpu-defs.h:249:2: note: in expansion of macro ‘SHIFT_PERCPU_PTR’
  SHIFT_PERCPU_PTR(ptr, my_cpu_offset);    \
  ^~~~~~~~~~~~~~~~
../include/asm-generic/percpu.h:34:23: note: in expansion of macro ‘per_cpu_offset’
 #define my_cpu_offset per_cpu_offset(smp_processor_id())
                       ^~~~~~~~~~~~~~
../include/linux/percpu-defs.h:249:24: note: in expansion of macro ‘my_cpu_offset’
  SHIFT_PERCPU_PTR(ptr, my_cpu_offset);    \
                        ^~~~~~~~~~~~~
../include/asm-generic/mmiowb.h:30:26: note: in expansion of macro ‘this_cpu_ptr’
 #define __mmiowb_state() this_cpu_ptr(&__mmiowb_state)
                          ^~~~~~~~~~~~
../include/asm-generic/mmiowb.h:37:28: note: in expansion of macro ‘__mmiowb_state’
  struct mmiowb_state *ms = __mmiowb_state();
                            ^~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/include/asm/mmiowb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
index bb4091ff4a21..0b2333e71fdc 100644
--- a/arch/riscv/include/asm/mmiowb.h
+++ b/arch/riscv/include/asm/mmiowb.h
@@ -9,6 +9,7 @@
  */
 #define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
 
+#include <linux/smp.h>
 #include <asm-generic/mmiowb.h>
 
 #endif	/* _ASM_RISCV_MMIOWB_H */
-- 
2.26.2

