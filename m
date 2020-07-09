Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E891C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C73206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594269572;
	bh=EzEck5pK05sjzHneaktRgOUwg6NdvPNK4uNthDpoQk0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j014aSCf9HszCQQww8npOZLhYzWRWDGykhikcIXUGVkKR2iA9HuIT7LgJ68IAq3vc
	 oRs4LQFmF/C4u6yOwaYwXBLSX0YUrLuSm8cfwCugPb+DLSByejO183Uck0fRmBYxSr
	 5uCpoxViLWVJoxBuIROerHQAoEOXI9vwnYKawqNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGIEja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgGIEja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:39:30 -0400
Received: from localhost.localdomain (unknown [42.120.72.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2196D20674;
        Thu,  9 Jul 2020 04:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594269569;
        bh=EzEck5pK05sjzHneaktRgOUwg6NdvPNK4uNthDpoQk0=;
        h=From:To:Cc:Subject:Date:From;
        b=d8hxSgcPxbbd08TV7oJ+807uJ7gS/2ZfhyWs5TQWkLCFurJsAjhQnErf8p/c+BAB9
         l7DJP93A6bvQWdYn9Z8p9ArLTP+BDu3z1K5ZQbRjcHB5Yb1z/aag2vWoxXOffgVblQ
         rHRj6EoSocX1nEDAGlV7FSo9+1v2YBoxx6m8c38k=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, bjorn.topel@gmail.com, atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Greentime Hu <green.hu@gmail.com>
Subject: [PATCH] riscv: Enable ELF-ASLR for riscv
Date:   Thu,  9 Jul 2020 04:38:30 +0000
Message-Id: <1594269511-13340-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Let riscv enable randomizes the stack, heap and binary images of
ELF binaries. Seems it's ok at all after qemu & chip test and
there is no founded side effect.

So just simply select ARCH_HAS_ELF_RANDOMIZE :)

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Zong Li <zong.li@sifive.com>
Cc: Greentime Hu <green.hu@gmail.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 91bfc6c..eed6647 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -20,6 +20,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
-- 
2.7.4

