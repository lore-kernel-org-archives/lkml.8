Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86951C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EFB20753
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056770;
	bh=7oo6LZ5BRUCyl3femyA+j4OKOF1/fABSYqHgCYpP7nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KSWsjOIhx/3YOlqF/YLGYIK1cJR8x/1lOQv0QWNY78vZJc5s6RHP4BiVkFDetK2n
	 RE4qbc+OQTAqn6WEk3aHMyWNkFlNh2LHbokeRKmJb29LAIRdnQ1KtsO9rDIzhacwWq
	 VXMoe+3FliQ3jvPtRvk56duqRetjMN6ZUIXwZRqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCXNQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgCXNQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:16:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F6E208CA;
        Tue, 24 Mar 2020 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055777;
        bh=7oo6LZ5BRUCyl3femyA+j4OKOF1/fABSYqHgCYpP7nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pe54daeZkaeyBsEOQTmpuMuUL+FVOQKf+QTz4owR0tskaVVpQUNDQukiLzxfzhNl0
         +svykbJjkiBIasyBriMUxUUo8DHRZC2u4AWQj31iiuqeX9WNOh4XKyZKHL1WHfGkrf
         0zvzNGUn5DObKbgeFA8NHTGC1Ok3fwZFOArsqbM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 026/102] riscv: Force flat memory model with no-mmu
Date:   Tue, 24 Mar 2020 14:10:18 +0100
Message-Id: <20200324130809.146548861@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@wdc.com>

[ Upstream commit aa2734202acc506d09c8e641db4da161f902df27 ]

Compilation errors trigger if ARCH_SPARSEMEM_ENABLE is enabled for
a nommu kernel. Since the sparsemem model does not make sense anyway
for the nommu case, do not allow selecting this option to always use
the flatmem model.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ade9699aa0dd6..a0fa4be94a68e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -101,6 +101,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
+	depends on MMU
 	select SPARSEMEM_VMEMMAP_ENABLE
 
 config ARCH_SELECT_MEMORY_MODEL
-- 
2.20.1



