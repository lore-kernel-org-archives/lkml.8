Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23C9C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762AB20659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RZdGphhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDERok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:44:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25337 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgDERok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:44:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wLdv1JL1z9ty3L;
        Sun,  5 Apr 2020 19:44:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RZdGphhf; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sO0UJIhGt_9C; Sun,  5 Apr 2020 19:44:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wLdv0F8Sz9ty2y;
        Sun,  5 Apr 2020 19:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586108675; bh=/9XgCX7ZNJJPrUF+WQ+S9CCuMlj+u/mt4LD/Anh8LO4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=RZdGphhfQJpXMML9EYAYJZKjGygcznlJM5NS1qXq0U26m2MV5F2PBBzVk/Ykhyf0i
         gSDRERCbfJGTwyIMtfRwZYs+5Qw8eBWmJCS8xIo26aF9TYjvknQbmzDqZk7RoCSiMB
         jVNfmn6vFwthQtZ34yLx2fTZ7i1GCeHPV+hSmXZs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F2ED8B783;
        Sun,  5 Apr 2020 19:44:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Vh44H95c2jsb; Sun,  5 Apr 2020 19:44:38 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B06A8B774;
        Sun,  5 Apr 2020 19:44:38 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 40BF86571C; Sun,  5 Apr 2020 17:44:38 +0000 (UTC)
Message-Id: <daf7bf5dadb9d7412e63010f60112a32c1f01b98.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 03/13] powerpc/8xx: Create C version of kuap_restore()
 and kuap_check()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  5 Apr 2020 17:44:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting PPC32 to C syscall entry/exit,
create C version of kuap_restore() and kuap_check() on 8xx

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 85ed2390fb99..1918d2e55da3 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -34,6 +34,19 @@
 
 #include <asm/reg.h>
 
+static inline void kuap_restore(struct pt_regs *regs)
+{
+	mtspr(SPRN_MD_AP, regs->kuap);
+}
+
+static inline void kuap_check(void)
+{
+	if (!IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
+		return;
+
+	WARN_ON_ONCE((mfspr(SPRN_MD_AP) & 0xffff0000) != (MD_APG_KUAP & 0xffff0000));
+}
+
 static inline void allow_user_access(void __user *to, const void __user *from,
 				     unsigned long size, unsigned long dir)
 {
-- 
2.25.0

