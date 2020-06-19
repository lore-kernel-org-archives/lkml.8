Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD74C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA93921BE5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbgFSPHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:07:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51985 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391481AbgFSPG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:06:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49pMbK6BKzz9v09p;
        Fri, 19 Jun 2020 17:06:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qPXkSaXizYlF; Fri, 19 Jun 2020 17:06:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49pMbK5Lb9z9v09j;
        Fri, 19 Jun 2020 17:06:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C72038B879;
        Fri, 19 Jun 2020 17:06:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PzOvOBPHVrpg; Fri, 19 Jun 2020 17:06:55 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EBCF8B868;
        Fri, 19 Jun 2020 17:06:55 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3733065AF4; Fri, 19 Jun 2020 15:06:55 +0000 (UTC)
Message-Id: <fb7bc12e8fcef77386ed0960e20e7474e4cd3173.1592578278.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1592578278.git.christophe.leroy@csgroup.eu>
References: <cover.1592578278.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/8] powerpc/lib: Prepare code-patching for modules
 allocated outside vmalloc space
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Jun 2020 15:06:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_vmalloc_or_module_addr() instead of is_vmalloc_addr()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 0a051dfeb177..8c3934ea6220 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -93,7 +93,7 @@ static int map_patch_area(void *addr, unsigned long text_poke_addr)
 	unsigned long pfn;
 	int err;
 
-	if (is_vmalloc_addr(addr))
+	if (is_vmalloc_or_module_addr(addr))
 		pfn = vmalloc_to_pfn(addr);
 	else
 		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
-- 
2.25.0

