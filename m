Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F42C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44B8208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgH1F6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:58:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38888 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgH1F6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:58:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bd86f0bqHz9v46X;
        Fri, 28 Aug 2020 07:58:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id BtiWnx0qMdGG; Fri, 28 Aug 2020 07:58:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bd86d6nStz9v46V;
        Fri, 28 Aug 2020 07:58:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1A908B783;
        Fri, 28 Aug 2020 07:58:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EODWWxGjNj7H; Fri, 28 Aug 2020 07:58:50 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B35668B769;
        Fri, 28 Aug 2020 07:58:50 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AD45265D47; Fri, 28 Aug 2020 05:58:50 +0000 (UTC)
Message-Id: <b91f507cfc591929ac0c34a85eec7061bc1b1203.1598594308.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0f65bb24a2519e5e6c33089016cb249a7c1b1e35.1598594308.git.christophe.leroy@csgroup.eu>
References: <0f65bb24a2519e5e6c33089016cb249a7c1b1e35.1598594308.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/5] powerpc/vdso: Declare vdso_patches[] as __initdata
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Aug 2020 05:58:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdso_patches[] table is used only at init time.

Mark it __initdata.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4ad042995ccc..dfa08a7b4e7c 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -76,7 +76,7 @@ struct vdso_patch_def
  * Currently, we only change sync_dicache to do nothing on processors
  * with a coherent icache
  */
-static struct vdso_patch_def vdso_patches[] = {
+static struct vdso_patch_def vdso_patches[] __initdata = {
 	{
 		CPU_FTR_COHERENT_ICACHE, CPU_FTR_COHERENT_ICACHE,
 		"__kernel_sync_dicache", "__kernel_sync_dicache_p5"
-- 
2.25.0

