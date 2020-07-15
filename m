Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A95C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243E120658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c7wiGpPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGOXaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:30:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49850 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGOXad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594855833; x=1626391833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=twVd2hS4vHLegZi/5Yb2c/TlDfLbVg6CqN55yP8mnGU=;
  b=c7wiGpPd5vG+XAhlxAfN58Bp/rFpGteIOuX0mn4yveDIrhEJOLHV3I9J
   O5X+faZ4abY9ZU2gRIMsSJfPO5hqZV2kqP8CvtmUPfyHniEYBVYfUBefh
   KvD7T66bMcKyAvFfo34/rTIVe1tw9TZQaehjE2gGbESy/dMzoD6YeEcxg
   YKeC0ayKdflHkcixunLeKRBUzt04XhUJqVPV7k5HaYPkQtEo6MMOvlQX2
   xK/OLGiqxwaZyJqwN9lR5baAYgOCb4N/gbzA2dlPJ7/lmHBP7bS2lSbvA
   KPkA5bppXTNFQLN5PKY8nQUQK3o+oMMUdFtRu5djJxrA6oTkLNCdE0NnT
   Q==;
IronPort-SDR: Rb+DsUqcUZ9nwSP3RejjCH9c3MCbmDPAYURwtjLwtQhdVSyjVYXsy41UZyPmMFzouunNZev90s
 f+52Na4CQ22YmD9hrX1dFsZwpytWbo/cM7/M1mN1w+ZJBVK0TJsHN8uqP+uUvpGOmuwxKA+Bxu
 178u2pV7+sq5BmAg46Yd6NtP1k3v/tU5pPg+Pu/ZixloIeNj8fGqYD191cKv8CeXygls/gY3jw
 SmV6nbyZATuFtcur7QfCQy2p56z1+BkfgkRplW89i0srJzFKMXz4sPGIoKCtefrUjnMQ9vr1MU
 rBo=
X-IronPort-AV: E=Sophos;i="5.75,357,1589212800"; 
   d="scan'208";a="146868543"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 07:30:22 +0800
IronPort-SDR: zqI6kO07mt3FYEmD3bLvf7icG/mnsRnqVwwNUt/G99ex+Y2oh57F+Ve+RyhyRvUsSzvGZwQO69
 ME1mKWW5YXe/msKVkEYbZ16tpfO7m1QlI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 16:18:46 -0700
IronPort-SDR: 1TTYe0RSrUU0ahO9ycR7q0BEobnWgWFg1uIOeSBYtrEvYohsOdcY2b28Lv3l2aiAAIgzG22WQB
 HIGAlkAB8iAA==
WDCIronportException: Internal
Received: from cnf009656.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.5])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 16:30:19 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 3/4] RISC-V: Do not rely on initrd_start/end computed during early dt parsing
Date:   Wed, 15 Jul 2020 16:30:08 -0700
Message-Id: <20200715233009.27183-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200715233009.27183-1-atish.patra@wdc.com>
References: <20200715233009.27183-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, initrd_start/end are computed during early_init_dt_scan
but used during arch_setup. We will get the following panic if initrd is used
and CONFIG_DEBUG_VIRTUAL is turned on.

[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/riscv/mm/physaddr.c:33!
[    0.000000] Kernel BUG [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc4-00015-ged0b226fed02 #886
[    0.000000] epc: ffffffe0002058d2 ra : ffffffe0000053f0 sp : ffffffe001001f40
[    0.000000]  gp : ffffffe00106e250 tp : ffffffe001009d40 t0 : ffffffe00107ee28
[    0.000000]  t1 : 0000000000000000 t2 : ffffffe000a2e880 s0 : ffffffe001001f50
[    0.000000]  s1 : ffffffe0001383e8 a0 : ffffffe00c087e00 a1 : 0000000080200000
[    0.000000]  a2 : 00000000010bf000 a3 : ffffffe00106f3c8 a4 : ffffffe0010bf000
[    0.000000]  a5 : ffffffe000000000 a6 : 0000000000000006 a7 : 0000000000000001
[    0.000000]  s2 : ffffffe00106f068 s3 : ffffffe00106f070 s4 : 0000000080200000
[    0.000000]  s5 : 0000000082200000 s6 : 0000000000000000 s7 : 0000000000000000
[    0.000000]  s8 : 0000000080011010 s9 : 0000000080012700 s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : 000000000001fe30 t4 : 000000000001fe30
[    0.000000]  t5 : 0000000000000000 t6 : ffffffe00107c471
[    0.000000] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x22/0x46 with crng_init=0

To avoid the error, initrd_start/end can be computed from phys_initrd_start/size
in setup itself. It also improves the initrd placement by aligning the start
and size with the page size.

Fixes: 6435f773d81f (riscv: mm: add support for CONFIG_DEBUG_VIRTUAL)
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8d22973bde40..f818a47a72d1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -95,19 +95,40 @@ void __init mem_init(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
+	phys_addr_t start;
 	unsigned long size;
 
-	if (initrd_start >= initrd_end) {
-		pr_info("initrd not found or empty");
+	/* Ignore the virtul address computed during device tree parsing */
+	initrd_start = initrd_end = 0;
+
+	if (!phys_initrd_size)
+		return;
+	/*
+	 * Round the memory region to page boundaries as per free_initrd_mem()
+	 * This allows us to detect whether the pages overlapping the initrd
+	 * are in use, but more importantly, reserves the entire set of pages
+	 * as we don't want these pages allocated for other purposes.
+	 */
+	start = round_down(phys_initrd_start, PAGE_SIZE);
+	size = phys_initrd_size + (phys_initrd_start - start);
+	size = round_up(size, PAGE_SIZE);
+
+	if (!memblock_is_region_memory(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
+		       (u64)start, size);
 		goto disable;
 	}
-	if (__pa_symbol(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		pr_err("initrd extends beyond end of memory");
+
+	if (memblock_is_region_reserved(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
+		       (u64)start, size);
 		goto disable;
 	}
 
-	size = initrd_end - initrd_start;
-	memblock_reserve(__pa_symbol(initrd_start), size);
+	memblock_reserve(start, size);
+	/* Now convert initrd to virtual addresses */
+	initrd_start = (unsigned long)__va(phys_initrd_start);
+	initrd_end = initrd_start + phys_initrd_size;
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
-- 
2.24.0

