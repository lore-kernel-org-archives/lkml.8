Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E09C3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AA024670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbgBNPeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:34:04 -0500
Received: from david.siemens.de ([192.35.17.14]:45136 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgBNPeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:34:03 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 01EFXoue022931
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 16:33:50 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 01EFXnI9026125;
        Fri, 14 Feb 2020 16:33:49 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] riscv: Add support for mem=
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <899dc26e-aca5-0a81-ccb5-c0fda59503f0@siemens.com>
Date:   Fri, 14 Feb 2020 16:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This sets a memory limit provided via mem= on the command line,
analogously to many other architectures.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/riscv/mm/init.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 965a8cf4829c..09948e43741b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -488,8 +488,26 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
+static phys_addr_t memory_limit = PHYS_ADDR_MAX;
+
+/*
+ * Limit the memory size that was specified via FDT.
+ */
+static int __init early_mem(char *p)
+{
+	if (!p)
+		return 1;
+
+	memory_limit = memparse(p, &p) & PAGE_MASK;
+	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
+
+	return 0;
+}
+early_param("mem", early_mem);
+
 void __init paging_init(void)
 {
+	memblock_enforce_memory_limit(memory_limit);
 	setup_vm_final();
 	memblocks_present();
 	sparse_init();
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
