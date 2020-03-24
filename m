Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF32C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA25206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055785;
	bh=+Wrdt2IjNJU/+2f1OXPiWEBQi2rieRBad78UzbSNW1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kco/dEiPJHW+vqg271hOKkJO/fsw1F7bp27rHhb3b26ShdNJKMNDDP60HHtPeRs3P
	 xCF/NL1uOHaulPfwVkmxkusdTUPKOosADQN4FBagg5QeKkgUMc7raw5ZDvZUa3l9qf
	 FrCfX9dpshuVNib5/3BtUM7+g3j5Mzv5GxAnFmNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCXNQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgCXNQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:16:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 840BA206F6;
        Tue, 24 Mar 2020 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055782;
        bh=+Wrdt2IjNJU/+2f1OXPiWEBQi2rieRBad78UzbSNW1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wYUNO1a3YTlVCcmwFvIDNMQr1QBLTqeGx6cS6uYQfdefQGA+YFBgUUBhmjO/gHBK
         JVX0BjZCVn2AVeTjVB0obLw+BNz0+TRiWGQs3RVX3Xoj/Yl5gWckZeyNjahf6dlbko
         VlGHlAf/9fo9cJrotjlDtYi7liFT6s3n//ueCdRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 027/102] riscv: Fix range looking for kernel image memblock
Date:   Tue, 24 Mar 2020 14:10:19 +0100
Message-Id: <20200324130809.238000730@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 573463d1c799a..f5d813c1304da 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -98,7 +98,7 @@ void __init setup_bootmem(void)
 	for_each_memblock(memory, reg) {
 		phys_addr_t end = reg->base + reg->size;
 
-		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
+		if (reg->base <= vmlinux_start && vmlinux_end <= end) {
 			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
 
 			/*
-- 
2.20.1



