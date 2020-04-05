Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24ACC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784E420659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="QLJ3b7CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgDERoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:44:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27481 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgDERoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:44:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wLdt1zXhz9ty3K;
        Sun,  5 Apr 2020 19:44:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QLJ3b7CJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id R4RvUfwHAYZs; Sun,  5 Apr 2020 19:44:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wLdt0tkLz9ty2y;
        Sun,  5 Apr 2020 19:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586108674; bh=+Vq2DhCbptHoTJrgP33JgNBllJVdhbPixQ4rKRn8KTc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=QLJ3b7CJ8Gq87V16BA8wfYh4F4xMypFjjrSVEBa0uF4KuV4nFXoW9J2UCbOXC0o0H
         AG9edKIqLvjHjmcQ45BHg94qU07TJWIR1/GM5KDGX7vPXfHWHVqVOgBvmmUJ8BFBKj
         roh4Q99JevJ1MTcJ/Gf1PKHKy1TqBrus6a5RUJyc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C9148B783;
        Sun,  5 Apr 2020 19:44:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id b8YXuLWyKOtd; Sun,  5 Apr 2020 19:44:37 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 659138B774;
        Sun,  5 Apr 2020 19:44:37 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3A98E6571C; Sun,  5 Apr 2020 17:44:37 +0000 (UTC)
Message-Id: <6e7e16e234125dfa11a8004e1e1d0fe47fd1adf5.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 02/13] powerpc/32s: Create C version of kuap_restore()
 and kuap_check()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  5 Apr 2020 17:44:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting PPC32 to C syscall entry/exit,
create C version of kuap_restore() and kuap_check() on book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 3c0ba22dc360..c85bc5b56366 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -102,6 +102,27 @@ static inline void kuap_update_sr(u32 sr, u32 addr, u32 end)
 	isync();	/* Context sync required after mtsrin() */
 }
 
+static inline void kuap_restore(struct pt_regs *regs)
+{
+	u32 kuap = current->thread.kuap;
+	u32 addr = kuap & 0xf0000000;
+	u32 end = kuap << 28;
+
+	if (unlikely(!kuap))
+		return;
+
+	current->thread.kuap = 0;
+	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
+}
+
+static inline void kuap_check(void)
+{
+	if (!IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
+		return;
+
+	WARN_ON_ONCE(current->thread.kuap != 0);
+}
+
 static __always_inline void allow_user_access(void __user *to, const void __user *from,
 					      u32 size, unsigned long dir)
 {
-- 
2.25.0

