Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C7C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6484A2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgCaJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:49:59 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:14591 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730409AbgCaJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:49:57 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 02V9XJDk065695
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 17:33:19 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 02V9WLWb065506;
        Tue, 31 Mar 2020 17:32:21 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 31 Mar 2020
 17:33:15 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-riscv@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <green.hu@gmail.com>, <Anup.Patel@wdc.com>,
        <akpm@linux-foundation.org>, <logang@deltatee.com>,
        <david.abdurachmanov@gmail.com>, <atish.patra@wdc.com>,
        <tglx@linutronix.de>, <bp@suse.de>, <yash.shah@sifive.com>,
        <alex@ghiti.fr>, <zong.li@sifive.com>, <gary@garyguo.net>,
        <rppt@linux.ibm.com>, <steven.price@arm.com>,
        Eric Lin <tesheng@andestech.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH 3/3] riscv/mm: Add pkmap in print_vm_layout()
Date:   Tue, 31 Mar 2020 17:32:41 +0800
Message-ID: <20200331093241.3728-4-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200331093241.3728-1-tesheng@andestech.com>
References: <20200331093241.3728-1-tesheng@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 02V9WLWb065506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling CONFIG_HIGHMEM, lowmem will before pkmap
region and the memory layout will be like as below:

Virtual kernel memory layout:
      lowmem : 0xc0000000 - 0xf5400000   ( 852 MB)
       pkmap : 0xf5600000 - 0xf5800000   (   2 MB)
      fixmap : 0xf5800000 - 0xf5c00000   (4096 kB)
      pci io : 0xf5c00000 - 0xf6c00000   (  16 MB)
     vmemmap : 0xf6c00000 - 0xf7bfffff   (  15 MB)
     vmalloc : 0xf7c00000 - 0xffc00000   ( 128 MB)

Signed-off-by: Eric Lin <tesheng@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/mm/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 59afb479176a..b32d558e3f99 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -80,6 +80,12 @@ static inline void print_mlm(char *name, unsigned long b, unsigned long t)
 static void print_vm_layout(void)
 {
 	pr_notice("Virtual kernel memory layout:\n");
+#ifdef CONFIG_HIGHMEM
+	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
+		  (unsigned long)high_memory);
+	print_mlm("pkmap", (unsigned long)PKMAP_BASE,
+		  (unsigned long)FIXADDR_START);
+#endif
 	print_mlk("fixmap", (unsigned long)FIXADDR_START,
 		  (unsigned long)FIXADDR_TOP);
 	print_mlm("pci io", (unsigned long)PCI_IO_START,
@@ -88,8 +94,10 @@ static void print_vm_layout(void)
 		  (unsigned long)VMEMMAP_END);
 	print_mlm("vmalloc", (unsigned long)VMALLOC_START,
 		  (unsigned long)VMALLOC_END);
+#ifndef CONFIG_HIGHMEM
 	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
 		  (unsigned long)high_memory);
+#endif
 }
 #else
 static void print_vm_layout(void) { }
-- 
2.17.0

