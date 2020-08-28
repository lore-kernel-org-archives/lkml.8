Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3EFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D99208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgH1F6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:58:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59115 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1F6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:58:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bd86Z5msmz9v46K;
        Fri, 28 Aug 2020 07:58:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id i93GAfYmaVGr; Fri, 28 Aug 2020 07:58:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bd86Z4wB0z9v1yg;
        Fri, 28 Aug 2020 07:58:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 946898B783;
        Fri, 28 Aug 2020 07:58:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id e6zdPpxc_7u0; Fri, 28 Aug 2020 07:58:47 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 71BB38B769;
        Fri, 28 Aug 2020 07:58:47 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6BBFD65D47; Fri, 28 Aug 2020 05:58:47 +0000 (UTC)
Message-Id: <1a065ae3042e3b47cc9418162cd8003dff35b5f7.1598594308.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0f65bb24a2519e5e6c33089016cb249a7c1b1e35.1598594308.git.christophe.leroy@csgroup.eu>
References: <0f65bb24a2519e5e6c33089016cb249a7c1b1e35.1598594308.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/5] powerpc/vdso: Don't rely on vdso_pages being 0 for
 failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Aug 2020 05:58:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vdso initialisation failed, vdso_ready is not set.
Otherwise, vdso_pages is only 0 when it is a 32 bits task
and CONFIG_VDSO32 is not selected.

As arch_setup_additional_pages() now bails out directly in
that case, we don't need to set vdso_pages to 0.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 3ef3fc546ac8..8f245e988a8a 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -176,11 +176,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	current->mm->context.vdso_base = 0;
 
-	/* vDSO has a problem and was disabled, just don't "enable" it for the
-	 * process
-	 */
-	if (vdso_pages == 0)
-		return 0;
 	/* Add a page to the vdso size for the data page */
 	vdso_pages ++;
 
@@ -710,14 +705,16 @@ static int __init vdso_init(void)
 	 * Initialize the vDSO images in memory, that is do necessary
 	 * fixups of vDSO symbols, locate trampolines, etc...
 	 */
-	if (vdso_setup())
-		goto setup_failed;
+	if (vdso_setup()) {
+		pr_err("vDSO setup failure, not enabled !\n");
+		return 0;
+	}
 
 	if (IS_ENABLED(CONFIG_VDSO32)) {
 		/* Make sure pages are in the correct state */
 		pagelist = kcalloc(vdso32_pages + 1, sizeof(struct page *), GFP_KERNEL);
 		if (!pagelist)
-			goto alloc_failed;
+			return 0;
 
 		pagelist[0] = virt_to_page(vdso_data);
 
@@ -730,7 +727,7 @@ static int __init vdso_init(void)
 	if (IS_ENABLED(CONFIG_PPC64)) {
 		pagelist = kcalloc(vdso64_pages + 1, sizeof(struct page *), GFP_KERNEL);
 		if (!pagelist)
-			goto alloc_failed;
+			return 0;
 
 		pagelist[0] = virt_to_page(vdso_data);
 
@@ -743,14 +740,6 @@ static int __init vdso_init(void)
 	smp_wmb();
 	vdso_ready = 1;
 
-	return 0;
-
-setup_failed:
-	pr_err("vDSO setup failure, not enabled !\n");
-alloc_failed:
-	vdso32_pages = 0;
-	vdso64_pages = 0;
-
 	return 0;
 }
 arch_initcall(vdso_init);
-- 
2.25.0

