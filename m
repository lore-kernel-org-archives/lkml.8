Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68703C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4624672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="E4ojI6nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgANL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:57:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51300 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:57:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so13427746wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugt9NhT5qx5K1mB/UaPbfN62J2sX7cG2UI+XKtUYHbQ=;
        b=E4ojI6nqpqGBKa0JWoFd9+T55lzmEJtZI3EeBZ4lhHsSafV3nI3ZKSq1rki6IwQ/kU
         Mpfk9ZpLGC33xu6W1jLe18qGzzfkRmNRo8KtFVP7AXp0i9MSJ6B1aBqZZg1NqiC5b92+
         csy9I3NXNS5nadeR1QQtK6tEDsMJxpp7mJHS9y+0d9eJXmQ7XeujL3MU8hN34i1d/1N0
         EL47fnswzL3Q/jRvnKd+dDMcDtRXvYtuH5y32QuR8i6DI6tbiXZUoL+nFDlvW/3Hu0eF
         P7InSsGmVkZzxwrxekQv96iLwCF0GbyaJUpAnKNMyehiW95eo1hFFcFYYVE4PxkrfANH
         uynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ugt9NhT5qx5K1mB/UaPbfN62J2sX7cG2UI+XKtUYHbQ=;
        b=ovMWiaCL/SHrYRqQJR31gAaipAbx0URvuFknv9cmiVjQV2r5YOIN8MJeYLUBUhWFp1
         e4/4bycz7aXx7GG7IiFTlR/Tr0qfSKXkgar6cqzTeBzT/agRcGxKft90vb7c/ShdLNmm
         WgKNBnZDgi1nJfFGAggH2pUlrxtXx1W2XCqloqBW3jTpci8wdiaLQlk6lNTAVsgCB+MY
         VdQbO51zpLjPTV7nsJi1QNZoeIg2KlYWYTCx094jBps6RfN0wJ9SlQYMncGKcxD58Thm
         +YAPnaG9sqROprZrRA6XLwSHZ3MVjzQbcHmf98zZN0pTsrEDWr6IqFdaLkyeslK9cx8Y
         RJ5Q==
X-Gm-Message-State: APjAAAW3o86vHV5q02YEWvta2Xr5btsJXYmy/OGV3kn7BVjN33jJ7aN3
        M/MBk0N7txZzoZ+9EOa4sfpNJmBVhbShoQ==
X-Google-Smtp-Source: APXvYqxSzaYGycnDOh4TJANEo6odka5SoVQ7IwDpTqoGjq8hO5jsm1+0JncLYRz8Ou2BackUVhXSIw==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr27336242wmc.9.1579003050044;
        Tue, 14 Jan 2020 03:57:30 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v17sm19279679wrt.91.2020.01.14.03.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 03:57:29 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] microblaze: Wire CMA allocator
Date:   Tue, 14 Jan 2020 12:57:28 +0100
Message-Id: <1a1a4c1e0f930e4fc0dfc785dbce57c07303f1a6.1579003045.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on commit 04e3543e228f ("microblaze: use the generic dma coherent remap allocator")
CMA can be easily enabled by calling dma_contiguous_reserve() at the end of
mmu_init(). High limit is end of lowmem space which is completely unused at
this point of time.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Christoph: Can you please review this patch?
I have used this cma allocator
https://lwn.net/Articles/485193/
also together with allocating and freeing via debugfs interface.

If there is any other good way how to test cma please let me know.

---
 arch/microblaze/Kconfig               | 1 +
 arch/microblaze/configs/mmu_defconfig | 2 ++
 arch/microblaze/include/asm/Kbuild    | 1 +
 arch/microblaze/mm/init.c             | 4 ++++
 4 files changed, 8 insertions(+)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 5f46ebe7bfe3..e6289294e7fc 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -27,6 +27,7 @@ config MICROBLAZE
 	select HAVE_ARCH_HASH
 	select HAVE_ARCH_KGDB
 	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index dd63766c2d19..9b8a50f30662 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -26,6 +26,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_EFI_PARTITION is not set
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -82,6 +83,7 @@ CONFIG_NFS_FS=y
 CONFIG_CIFS=y
 CONFIG_CIFS_STATS2=y
 CONFIG_ENCRYPTED_KEYS=y
+CONFIG_DMA_CMA=y
 CONFIG_DEBUG_INFO=y
 CONFIG_KGDB=y
 CONFIG_KGDB_TESTS=y
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index e5c9170a07fc..acb2d246002f 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += bugs.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 050fc621c920..1056f1674065 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -7,6 +7,7 @@
  * for more details.
  */
 
+#include <linux/dma-contiguous.h>
 #include <linux/memblock.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -345,6 +346,9 @@ asmlinkage void __init mmu_init(void)
 	/* This will also cause that unflatten device tree will be allocated
 	 * inside 768MB limit */
 	memblock_set_current_limit(memory_start + lowmem_size - 1);
+
+	/* CMA initialization */
+	dma_contiguous_reserve(memory_start + lowmem_size - 1);
 }
 
 /* This is only called until mem_init is done. */
-- 
2.24.0

