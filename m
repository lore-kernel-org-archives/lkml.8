Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A972C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AAF208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgH1F6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:58:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36032 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1F6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:58:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bd86d154nz9v46W;
        Fri, 28 Aug 2020 07:58:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TBiVncvcZNgb; Fri, 28 Aug 2020 07:58:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bd86d0KYgz9v46V;
        Fri, 28 Aug 2020 07:58:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD0BC8B783;
        Fri, 28 Aug 2020 07:58:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IfOHtGjhp0zm; Fri, 28 Aug 2020 07:58:49 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC8A48B769;
        Fri, 28 Aug 2020 07:58:49 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A6A8C65D47; Fri, 28 Aug 2020 05:58:49 +0000 (UTC)
Message-Id: <42bc1c04b574f4b7dff3bddc228eff704de72420.1598594308.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0f65bb24a2519e5e6c33089016cb249a7c1b1e35.1598594308.git.christophe.leroy@csgroup.eu>
References: <0f65bb24a2519e5e6c33089016cb249a7c1b1e35.1598594308.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/5] powerpc/vdso: Declare constant vars as __ro_after_init
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Aug 2020 05:58:49 +0000 (UTC)
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
index fb393266b9cb..4ad042995ccc 100644
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

