Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE85C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831E8206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056136;
	bh=C2+1CgEyCzXyL6jcSaddsVFkd/pDIlYfQqXchjpjooI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M6knmlmZzFFm7BO985KZfI6JAp5+/CwcQ566kodfNzN0JnNjxK6q2eYYjOFHlg1+1
	 +8SGHEnIVApXrqO7vjNswTIIMoIJ3HIE2WB71FPoSqHuuHkHx4eCAlH3wqZailg0eK
	 cX2+WfaE1+6sNApntnrpuaiBpDMtfXuGn9q5fHf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgCXNWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgCXNWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:22:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98BA206F6;
        Tue, 24 Mar 2020 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056133;
        bh=C2+1CgEyCzXyL6jcSaddsVFkd/pDIlYfQqXchjpjooI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/62lGEuUrablPjwlO5rpR5f44pDQ6exuVio6F5845HxIgACtpa/CVz64Gl3wkXJ8
         hoMAyNhl64UPgGF8k1c1r/YNx7LYB6wpC5BA2hyn4hXB/Crl5v9fJE03UCdJH51Ynu
         llYw7uuj9JC3WyaX09Vb2ZKEb/ap8oo1BG+wGgPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 031/119] riscv: Fix range looking for kernel image memblock
Date:   Tue, 24 Mar 2020 14:10:16 +0100
Message-Id: <20200324130811.499306700@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
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



