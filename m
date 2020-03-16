Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF05CC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88DD206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326437;
	bh=C2+1CgEyCzXyL6jcSaddsVFkd/pDIlYfQqXchjpjooI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQmqVvfBS7k9sCLL4ieyL6ojwbyMJroig/Wfb0pq4zsayJPrPO2R4SWVdc92aKbVv
	 xKmgH6so6+CNy/D4CuwV66n3A0cXlEfw1e2CWxhkyVfY23Y+ZA11OskXL1lUeVutn7
	 andzsDG21xyv4LId+xEG7ypm4Hf9B23iTknUaB6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgCPCeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgCPCd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EABB206E9;
        Mon, 16 Mar 2020 02:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326038;
        bh=C2+1CgEyCzXyL6jcSaddsVFkd/pDIlYfQqXchjpjooI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eU+t03gkoeJhoXLg3o01vQ12Xm23rSwMJEaToLssXLnirrp26t6Qo++oo8gobnn/o
         K6Y5hsJf3Sf+b8Bv5mSWO3Af6BhAyLwO+ly48P7qTd0UmMaM8zTJ7ySqRab8pKVmxr
         0zJPtQR5hWZbTEiIFv9W3+3X5Yn7pnRBrfhZJ81I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 32/41] riscv: Fix range looking for kernel image memblock
Date:   Sun, 15 Mar 2020 22:33:10 -0400
Message-Id: <20200316023319.749-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <alex@ghiti.fr>

[ Upstream commit a160eed4b783d7b250a32f7e5787c9867abc5686 ]

When looking for the memblock where the kernel lives, we should check
that the memory range associated to the memblock entirely comprises the
kernel image and not only intersects with it.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 965a8cf4829ca..fab855963c730 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -131,7 +131,7 @@ void __init setup_bootmem(void)
 	for_each_memblock(memory, reg) {
 		phys_addr_t end = reg->base + reg->size;
 
-		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
+		if (reg->base <= vmlinux_start && vmlinux_end <= end) {
 			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
 
 			/*
-- 
2.20.1

