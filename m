Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B3BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E64207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659576;
	bh=vupYtHh+zi9vBtEtZ9bTOPCO4HoBCBq9wOTHXWHbTOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TmoUkMHilNhICHxuu1Bl7OSf5YIrLErHzrjvNIx0mvCvHplHccQlZzQP7+K1djgAI
	 Sa/L6r6Pj/ET+klhd5SMd/QY4gVKFRFUcceSJ0cj/ProarDR8CowAGaaQMz3ZKflyK
	 6JogGepGdkghu8ixWptB0CzR4a8G8s/x5UiQ/zmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbgFHXjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387718AbgFHX2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:28:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFACB20775;
        Mon,  8 Jun 2020 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658893;
        bh=vupYtHh+zi9vBtEtZ9bTOPCO4HoBCBq9wOTHXWHbTOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0B0TTQ22PNEPzJvwRsalZVo2PFlBmvj127yRwtQ5pwqz4+cM0pRQfTGMTrRr1A0ds
         4JIbPoMPonQ35IZNHGZ1whRFWrQMeI0qs92JJqdPBCw2P36R8hVLUrziKLvA5G8lZT
         tbXeHxy90hL1M8fXBoug8khGe75WXbWQniIX0HIc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 16/37] MIPS: Make sparse_init() using top-down allocation
Date:   Mon,  8 Jun 2020 19:27:28 -0400
Message-Id: <20200608232750.3370747-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232750.3370747-1-sashal@kernel.org>
References: <20200608232750.3370747-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 269b3a9ac538c4ae87f84be640b9fa89914a2489 ]

In the current code, if CONFIG_SWIOTLB is set, when failed to get IO TLB
memory from the low pages by plat_swiotlb_setup(), it may lead to the boot
process failed with kernel panic.

(1) On the Loongson and SiByte platform
arch/mips/loongson64/dma.c
arch/mips/sibyte/common/dma.c
void __init plat_swiotlb_setup(void)
{
	swiotlb_init(1);
}

kernel/dma/swiotlb.c
void  __init
swiotlb_init(int verbose)
{
...
	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
		return;
...
	pr_warn("Cannot allocate buffer");
	no_iotlb_memory = true;
}

phys_addr_t swiotlb_tbl_map_single()
{
...
	if (no_iotlb_memory)
		panic("Can not allocate SWIOTLB buffer earlier ...");
...
}

(2) On the Cavium OCTEON platform
arch/mips/cavium-octeon/dma-octeon.c
void __init plat_swiotlb_setup(void)
{
...
	octeon_swiotlb = memblock_alloc_low(swiotlbsize, PAGE_SIZE);
	if (!octeon_swiotlb)
		panic("%s: Failed to allocate %zu bytes align=%lx\n",
		      __func__, swiotlbsize, PAGE_SIZE);
...
}

Because IO_TLB_DEFAULT_SIZE is 64M, if the rest size of low memory is less
than 64M when call plat_swiotlb_setup(), we can easily reproduce the panic
case.

In order to reduce the possibility of kernel panic when failed to get IO
TLB memory under CONFIG_SWIOTLB, it is better to allocate low memory as
small as possible before plat_swiotlb_setup(), so make sparse_init() using
top-down allocation.

Reported-by: Juxin Gao <gaojuxin@loongson.cn>
Co-developed-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8fa30516f39d..33f5aeaf0024 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -769,7 +769,17 @@ static void __init arch_mem_init(char **cmdline_p)
 				BOOTMEM_DEFAULT);
 #endif
 	device_tree_init();
+
+	/*
+	 * In order to reduce the possibility of kernel panic when failed to
+	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
+	 * low memory as small as possible before plat_swiotlb_setup(), so
+	 * make sparse_init() using top-down allocation.
+	 */
+	memblock_set_bottom_up(false);
 	sparse_init();
+	memblock_set_bottom_up(true);
+
 	plat_swiotlb_setup();
 	paging_init();
 
-- 
2.25.1

