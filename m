Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EBDC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5092082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="FD/FwlRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgAQIDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:03:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51853 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgAQIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:03:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so6447391wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=No5zItI5V7Iuzrldv9moLweC7sKUvSUh3z+nAwFGCCQ=;
        b=FD/FwlRZZtTtvWo3RODi0eiN+0CH5m4vUovqnnNNvplZoiiAPZ4tnHSqRC0Emr3NG4
         fBJ4L4KHFdeoe1SMXEdZWPmw+GfPlz1VLmsQ+iyvB4S63WeLJ0DlD33o0JdHBKXegkX2
         IA7RC0pO9cdMatwKg+YpZkY4J80IX7wp1il/BfOpDnDa2ZvBB1FLpR5ieCWl8g9Q0HjV
         Uo31EuCT8dZnhfwCSbz381yCN6a0Pszg5dRbmtdT7asi5YQSGTrztQu7/l+oxXSCfPpU
         KjanhJ6njv9V0KnbmK/rwZd0Pys2ATuK6JnTny0kZAtO2dIWLIy139cu20qDAA8w2qTk
         +vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=No5zItI5V7Iuzrldv9moLweC7sKUvSUh3z+nAwFGCCQ=;
        b=LAC8nXir1OpniH8vp2/LgDHt/KMVb/0dnVJB865yf1gf0OokRM++XfzLhy9dElh0xq
         XDvIb6HL0+yLfdfa4ibHKM5BjrYDVrMbROBK5ose88lD91VR7XvKBEkZ9F9U81y9By+T
         wLtWmVIg0T5GsywdJgxXb+bYa2yE1oNLC4S/m08xMk1Ft3fp0rpoanEQ1LaSmh83F6Co
         yM8sqQHcsdBuJ41/m+wYS8ZOjXczqwGW8ej9ARiTN185TeB4FPbGgm+Ovha/9n57/XKI
         Fpfo7BHftes4Kwms0YG2B3vAwJyEDN/pf1BAZieEbeR3KwKPkEe9xLw1EjI6ZCg3S33T
         onMw==
X-Gm-Message-State: APjAAAWNz4n+Do4a6hc5N+1AZw2RT4zwfm33sLS4pFWipqxBggilGmHp
        IVP+rwlI46ZLX0OtHNiecKUmbqryKJ7zbID+
X-Google-Smtp-Source: APXvYqw5uxhOlORUCFP3RCaXlRdhguD/d/JJFoMZuwvJJZAI1kCDZ+KbCikba+gPCrldELqgy3jRGg==
X-Received: by 2002:a1c:bbc3:: with SMTP id l186mr3214021wmf.101.1579248218710;
        Fri, 17 Jan 2020 00:03:38 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t125sm8721624wmf.17.2020.01.17.00.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 00:03:38 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>
Cc:     Manish Narani <manish.narani@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] microblaze: Wire CMA allocator
Date:   Fri, 17 Jan 2020 09:03:32 +0100
Message-Id: <b2e5d3c9c94aa09b5897f60ec86d858041ee62df.1579248206.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1579248206.git.michal.simek@xilinx.com>
References: <cover.1579248206.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on commit 04e3543e228f ("microblaze: use the generic dma coherent
remap allocator")
CMA can be easily enabled by calling dma_contiguous_reserve() at the end of
mmu_init(). High limit is end of lowmem space which is completely unused at
this point of time.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Align commit message
- Remove adding dma-contigous.h via Kbuild because it is done by previous
  patch

Christoph: Can you please review this patch?
I have used this cma allocator
https://lwn.net/Articles/485193/
also together with allocating and freeing via debugfs interface.

If there is any other good way how to test cma please let me know.

---
 arch/microblaze/Kconfig               | 1 +
 arch/microblaze/configs/mmu_defconfig | 2 ++
 arch/microblaze/mm/init.c             | 4 ++++
 3 files changed, 7 insertions(+)

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
2.25.0

