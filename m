Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FD02087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgH0Ptf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:49:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18100 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgH0Pta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:49:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BcnGY6QxJz9v4bT;
        Thu, 27 Aug 2020 17:49:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 04lsUqrsDZaj; Thu, 27 Aug 2020 17:49:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BcnGY5bXSz9v2FV;
        Thu, 27 Aug 2020 17:49:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 601FE8B8A3;
        Thu, 27 Aug 2020 17:49:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5n3OaebEi7eJ; Thu, 27 Aug 2020 17:49:27 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 22EC18B8A2;
        Thu, 27 Aug 2020 17:49:26 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 894EE65D45; Thu, 27 Aug 2020 15:49:26 +0000 (UTC)
Message-Id: <c4bb4789ee2b0e4eeff9589722920c58ce05242a.1598543237.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e8d735102627299303acd8fbec8c7a706b1e7882.1598543237.git.christophe.leroy@csgroup.eu>
References: <e8d735102627299303acd8fbec8c7a706b1e7882.1598543237.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/6] powerpc/vdso: Don't rely on vdso_pages being 0 for
 failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Aug 2020 15:49:26 +0000 (UTC)
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
index 465150253c31..c173c70ca7d2 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -178,11 +178,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	current->mm->context.vdso_base = 0;
 
-	/* vDSO has a problem and was disabled, just don't "enable" it for the
-	 * process
-	 */
-	if (vdso_pages == 0)
-		return 0;
 	/* Add a page to the vdso size for the data page */
 	vdso_pages ++;
 
@@ -712,14 +707,16 @@ static int __init vdso_init(void)
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
 
@@ -732,7 +729,7 @@ static int __init vdso_init(void)
 	if (IS_ENABLED(CONFIG_PPC64)) {
 		pagelist = kcalloc(vdso64_pages + 1, sizeof(struct page *), GFP_KERNEL);
 		if (!pagelist)
-			goto alloc_failed;
+			return 0;
 
 		pagelist[0] = virt_to_page(vdso_data);
 
@@ -745,14 +742,6 @@ static int __init vdso_init(void)
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

