Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A116C4363F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1A92173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892554;
	bh=ZrVLOezcbDKD29gv/0DCCDT9ox76t+tAnftaI1z9/ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kj1DjmHdiLX5vuEPR+a5S+ugG+/k7gSxQzhQY3o6IVRNV0zzVjWBDjthBGMsku74T
	 XpXtjcoWsg1iTAgpHDDRWiSa+21IH5t49zVAoKRMuOOiSuNFa8sCTc2URyOY1YSfA1
	 yYIIQWkOzC9AsK7Eqx4AtmsTHovuxt/8pJVCCBRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgG0X3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgG0XYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDCF22B48;
        Mon, 27 Jul 2020 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892256;
        bh=ZrVLOezcbDKD29gv/0DCCDT9ox76t+tAnftaI1z9/ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hh8GQYV9zezldtcQaplZYydGEKFNnpGb5Zk2JwRBxEI52bvquXKnhdN+9SZAPbT46
         9X4frwl4eUEzTYjX1Sy8wj7wx1YonnHT4eRGOu7X7FU6OBpKL5eBybVPfud5Hq7b84
         UJQpdTEnwPiUiWlTfDtt/0/ETQLFJoNXNZAZZDlk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 23/25] RISC-V: Set maximum number of mapped pages correctly
Date:   Mon, 27 Jul 2020 19:23:43 -0400
Message-Id: <20200727232345.717432-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232345.717432-1-sashal@kernel.org>
References: <20200727232345.717432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

[ Upstream commit d0d8aae64566b753c4330fbd5944b88af035f299 ]

Currently, maximum number of mapper pages are set to the pfn calculated
from the memblock size of the memblock containing kernel. This will work
until that memblock spans the entire memory. However, it will be set to
a wrong value if there are multiple memblocks defined in kernel
(e.g. with efi runtime services).

Set the the maximum value to the pfn calculated from dram size.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fdc772f57edc3..753f2cdbeab8f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -149,9 +149,9 @@ void __init setup_bootmem(void)
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	set_max_mapnr(PFN_DOWN(mem_size));
 	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_low_pfn = max_pfn;
+	set_max_mapnr(max_low_pfn);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
-- 
2.25.1

