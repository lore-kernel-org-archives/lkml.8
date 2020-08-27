Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B08C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC272087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgH0Ptj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:49:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16639 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgH0Ptd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:49:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BcnGc6Xvcz9v4bX;
        Thu, 27 Aug 2020 17:49:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KsJ0H92DvpU9; Thu, 27 Aug 2020 17:49:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BcnGc5Z0nz9v4bK;
        Thu, 27 Aug 2020 17:49:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D0B7E8B880;
        Thu, 27 Aug 2020 17:49:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0IlVTSKdZz_x; Thu, 27 Aug 2020 17:49:29 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EFA308B886;
        Thu, 27 Aug 2020 17:49:28 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id A8F8D65D45; Thu, 27 Aug 2020 15:49:28 +0000 (UTC)
Message-Id: <098cc5a46f989adaa850b3b2ef62ead02919ec81.1598543237.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e8d735102627299303acd8fbec8c7a706b1e7882.1598543237.git.christophe.leroy@csgroup.eu>
References: <e8d735102627299303acd8fbec8c7a706b1e7882.1598543237.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 5/6] powerpc/vdso: Declare constant vars as __ro_after_init
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Aug 2020 15:49:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid any risk of modification of vital VDSO variables,
declare them __ro_after_init.

vdso32_kbase and vdso64_kbase could be made 'const', but it would
have high impact on all functions using them as the compiler doesn't
expect const property to be discarded.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 6390a37dacea..600df1164a0b 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -38,19 +38,19 @@
 #define VDSO_ALIGNMENT	(1 << 16)
 
 extern char vdso32_start, vdso32_end;
-static unsigned int vdso32_pages;
-static void *vdso32_kbase = &vdso32_start;
-unsigned long vdso32_sigtramp;
-unsigned long vdso32_rt_sigtramp;
+static unsigned int vdso32_pages __ro_after_init;
+static void *vdso32_kbase __ro_after_init = &vdso32_start;
+unsigned long vdso32_sigtramp __ro_after_init;
+unsigned long vdso32_rt_sigtramp __ro_after_init;
 
 extern char vdso64_start, vdso64_end;
-static void *vdso64_kbase = &vdso64_start;
-static unsigned int vdso64_pages;
+static void *vdso64_kbase __ro_after_init = &vdso64_start;
+static unsigned int vdso64_pages __ro_after_init;
 #ifdef CONFIG_PPC64
-unsigned long vdso64_rt_sigtramp;
+unsigned long vdso64_rt_sigtramp __ro_after_init;
 #endif /* CONFIG_PPC64 */
 
-static int vdso_ready;
+static int vdso_ready __ro_after_init;
 
 /*
  * The vdso data page (aka. systemcfg for old ppc64 fans) is here.
-- 
2.25.0

