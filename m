Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B467C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C742054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458590;
	bh=n1FukGZuQXyu2MVVpZOdKAmj1C0W92scKOGnuT4UQO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QC2KDbXOzBfX3l1ZF9jDvuAqJtb0gP1c+QLLx9vH6pmX+c8SWA/vmkSjgwYdYyIhW
	 aG+y3k6WzRKJs1ipLBg/M7hGKQfJnqXKdzC4N39EUmqS/Ubkl2SLamfmtsVr691WHj
	 AEsBsdQIkaIvUmZxMhP5gIoEmKgKeAJQl06iZbpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgHCMnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgHCMaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:30:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91FB2177B;
        Mon,  3 Aug 2020 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457815;
        bh=n1FukGZuQXyu2MVVpZOdKAmj1C0W92scKOGnuT4UQO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRQSs2VkiOx/k6uqe5VoD4WWWwU5528l51f/w2U15RKAEo4QKdamhBiobjzKMGjEa
         XAMvAACq54+PfrDi41+PEh+MKGOkF4NcpYcZNC9NSrW7ueHSYWt2lrGraLowlTvE3R
         4YCqyu9Pu11o8JHntK8uANnuEvi3yaf2dfndQJGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 83/90] RISC-V: Set maximum number of mapped pages correctly
Date:   Mon,  3 Aug 2020 14:19:45 +0200
Message-Id: <20200803121901.620814302@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 3198129230126..b1eb6a0411183 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -115,9 +115,9 @@ void __init setup_bootmem(void)
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



