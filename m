Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07785C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25782074B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HB/On//S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgFFM0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 08:26:36 -0400
Received: from mout02.posteo.de ([185.67.36.66]:40471 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgFFM0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 08:26:36 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5C33F2400FF
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 14:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1591446393; bh=epeJiDa1gJiuVNMTII1fQFigLnJl1skHt7r0UvbAQ2w=;
        h=From:To:Cc:Subject:Date:From;
        b=HB/On//SfGLVG9Awz2iNs8FoSBZR+hBG9UceI1vTthis1m4pStTTh7e8ohuNdOutr
         VE65n0Qjt7l0YExLaMYwAaWTgIIIvxqzwcuI9td/0/VdG0Kn2iq3Rhxhs3J6efsTOu
         gIcGKJXy9PytHDWI8sWUGtk3Htz5uKQTAQr08OzOrqGHiYwqiOU9u3wmlP++Ph87Wm
         EpjkjUnW/vkNOVcGCy7RKiTZHJpFUTges9hyHo8n45ht4KOBxUdjbeI0ziIBZxkzJK
         iP/yggZHxAy2VSRQE2o8i19ye6QZWYqCOr03uzbi5ppsyQQjIuFSwyvVUifOq6fZrm
         62zclJzw33jgw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 49fJfJ6qxGz6tmN;
        Sat,  6 Jun 2020 14:26:32 +0200 (CEST)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     x86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/mm: Fix -Wmissing-prototypes warning in init.c
Date:   Sat,  6 Jun 2020 14:26:29 +0200
Message-Id: <20200606122629.2720-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Wmissing-prototypes warning by including the respective header containing prototypes:

  arch/x86/mm/init.c:81:6:
  warning: no previous prototype for ‘x86_has_pat_wp’ [-Wmissing-prototypes]
  bool x86_has_pat_wp(void)

  arch/x86/mm/init.c:86:22:
  warning: no previous prototype for ‘pgprot2cachemode’ [-Wmissing-prototypes]
  enum page_cache_mode pgprot2cachemode(pgprot_t pgprot)

Fix:

  arch/x86/mm/init.c:893:13:
  warning: no previous prototype for ‘mem_encrypt_free_decrypted_mem’ [-Wmissing-prototypes]
  void __weak mem_encrypt_free_decrypted_mem(void) { }

by making it static inline for the !CONFIG_AMD_MEM_ENCRYPT case.
This warning happens when CONFIG_AMD_MEM_ENCRYPT is not enabled (defconfig for example):

  ./arch/x86/include/asm/mem_encrypt.h:80:27:
  warning: inline function ‘mem_encrypt_free_decrypted_mem’ declared weak [-Wattributes]
  static inline void __weak mem_encrypt_free_decrypted_mem(void) { }
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It's ok to convert to static inline because the function is only use in x86.
Is not shared with other architectures so that it is not necessary to be __weak.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/include/asm/mem_encrypt.h | 2 ++
 arch/x86/mm/init.c                 | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 848ce43b9040..8e8140cfded9 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -77,6 +77,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+static inline  void mem_encrypt_free_decrypted_mem(void) { }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 112d3b98a3b6..a751b15f89c0 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <asm/pti.h>
 #include <asm/text-patching.h>
+#include <asm/memtype.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -890,8 +891,6 @@ void free_kernel_image_pages(const char *what, void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
-void __weak mem_encrypt_free_decrypted_mem(void) { }
-
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
-- 
2.20.1

