Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66149C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410E6207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661346;
	bh=Z5EKxfv+Va+d0E6RTU9IoyZ/sjv+aNvaJmc9GxB6eh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQy3NGKswtusPp8tp7rFLAtOt+4mpZH8dd7pZiLjjUpbi/dW5LoLU9S+ED887IqO6
	 6odl4dSHeHStAkBjug8qMQq6UVgWdZ/nQezEkQ2NqBydlhIVCnwYwW8sEQNtoBfYYl
	 bVdJNYWnLy7tPqF7k4GtgB8srotL6Ki5j6NmTZHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbgFIAJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730944AbgFHXUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E659208C7;
        Mon,  8 Jun 2020 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658431;
        bh=Z5EKxfv+Va+d0E6RTU9IoyZ/sjv+aNvaJmc9GxB6eh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mD/LQK4Iu2MPtiC1JLzCUImvqa+qyhexvLj7gM2A2IHr5zr5iqjb5lo7lUmRAdkJv
         Y1ldgT1GAOjQo8gYuOromEZIGYBJdGppQn70bW0SRt7i9eLWgMx4JF7fTiHbTZS2lX
         BZ/9c1qkbEYOPS58sy8aNEAkDAd1XGOWP4T1x9Ps=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 076/175] MIPS: Make sparse_init() using top-down allocation
Date:   Mon,  8 Jun 2020 19:17:09 -0400
Message-Id: <20200608231848.3366970-76-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
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
index 5eec13b8d222..7b06e6ee6817 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -653,7 +653,17 @@ static void __init arch_mem_init(char **cmdline_p)
 				 crashk_res.end - crashk_res.start + 1);
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
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
-- 
2.25.1

