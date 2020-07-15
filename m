Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFD9C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE0F20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TsPBifbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGOXaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:30:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49850 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgGOXae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594855834; x=1626391834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1WUJsuuWe1ZBua62bFIdOijTgWGShB9OAlNDVmWfFmY=;
  b=TsPBifboiuVFCCuQ4BhaQF8e9Y9VJxJX1Yem1CL9I6hQt5Mbya3yK4Al
   eXgL9xTA0mqltFMzsyZaY7jLCqg3kOZT69qTWGo7GcLO4q5/LPTr3iHZC
   JWIUIyFuRlIr5UQvJp+Lw3EAnHmFDJAF7JD+kJ4ROS5Eg3ZkDFe9RWVwU
   aNg3CtgIULZCV/aZ369FzYo68OQLUsxUmCu+GCYxyj9brzJ/pbU1nmM4A
   me+2JyD+JANzpWCkDIShmwlbkH31VRT+umPWsqTP2KUG/iT1q8x5F4Obg
   0HgHKnf7/x1cLvEqdR1ScMACS1SNyUabYBpmfNCq6vH1xgNmLft9pYFt9
   w==;
IronPort-SDR: VRG942NGLmNjMASHaJzkBluPVMBpTqhtym6MtWUapENhFBtqCh+SZU378lH49vFH/Y6XXU1iMV
 af27qBOz7aHpnfvqPVs/7O8MTCVxemGSmJMx3DeP2/sm9Rq6zq9G3jlJwZhnpLmliRbKfGxCoG
 TwbCX0p90u0aLJOIVvdmLTRJNnkF+fLccf6VP0tZghpOBjhKGvu4FKYq0vw/r//eKDW/tb4GYv
 gf6CRKrIdZpVLsqy+XGOZnapxw7UO/AcPqZMlPxCgHlVgGkwlqed7s6KB0bbjGu2CgkTqwBxZA
 7Ow=
X-IronPort-AV: E=Sophos;i="5.75,357,1589212800"; 
   d="scan'208";a="146868544"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 07:30:23 +0800
IronPort-SDR: 23mcAq4JMdd+m6NbmF+zNTphh6dgWPkayNMYKsaVJZQmfp0VecHPvIMRxPoWnWL2KcWH5zFsO6
 x4yMDcC9NlHxpxJW3S45q/fJkxqKvbRMk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 16:18:48 -0700
IronPort-SDR: jolcTqH56Kqn7iIi8sFylTtgUKK7/Idjrhr2qok3aASAzRD1+74v7auysvNA/+tadSVs44nyYc
 W3zYMoqRAm7g==
WDCIronportException: Internal
Received: from cnf009656.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.5])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 16:30:21 -0700
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
Subject: [PATCH 4/4] riscv: Parse all memory blocks to remove unusable memory
Date:   Wed, 15 Jul 2020 16:30:09 -0700
Message-Id: <20200715233009.27183-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200715233009.27183-1-atish.patra@wdc.com>
References: <20200715233009.27183-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, maximum physical memory allowed is equal to -PAGE_OFFSET.
That's why we remove any memory blocks spanning beyond that size. However,
it is done only for memblock containing linux kernel which will not work
if there are multiple memblocks.

Process all memory blocks to figure out how much memory needs to be removed
and remove at the end instead of updating the memblock list in place.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f818a47a72d1..79e9d55bdf1a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -147,26 +147,29 @@ void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
 	phys_addr_t mem_size = 0;
+	phys_addr_t total_mem = 0;
+	phys_addr_t mem_start, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
-		phys_addr_t end = reg->base + reg->size;
-
-		if (reg->base <= vmlinux_start && vmlinux_end <= end) {
-			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
-
-			/*
-			 * Remove memblock from the end of usable area to the
-			 * end of region
-			 */
-			if (reg->base + mem_size < end)
-				memblock_remove(reg->base + mem_size,
-						end - reg->base - mem_size);
-		}
+		end = reg->base + reg->size;
+		if (!total_mem)
+			mem_start = reg->base;
+		if (reg->base <= vmlinux_start && vmlinux_end <= end)
+			BUG_ON(reg->size == 0);
+		total_mem = total_mem + reg->size;
 	}
-	BUG_ON(mem_size == 0);
+
+	/*
+	 * Remove memblock from the end of usable area to the
+	 * end of region
+	 */
+	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
+	if (mem_start + mem_size < end)
+		memblock_remove(mem_start + mem_size,
+				end - mem_start - mem_size);
 
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
-- 
2.24.0

