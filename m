Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED842C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC2A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LW5PQXRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgDQRI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:08:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42698 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgDQRIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:08:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 493jH7702vz9tyxB;
        Fri, 17 Apr 2020 19:08:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LW5PQXRB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r1kkrlHPH2ff; Fri, 17 Apr 2020 19:08:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 493jH75Q3zz9tyx8;
        Fri, 17 Apr 2020 19:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587143331; bh=8PZ7zqrNdw1HVCHe6hX++DbwkBGST2rBcWVwmI2RJcA=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LW5PQXRBPzqoM8diZt6CgiztQP08BFWR5fPJEifl4RhnzOIbhs9cPi+HlBDZEFfYT
         2xgLHJ0VCUd9H4D6AfeQLE3FYNrqhthBqHsZH19F9+cOrc+dLS3Yeuu16uxGkNr3Mt
         Su4wldA3uOkR/rPEWqw0YMngR/+hna3SiWY6Zjeg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 98D978BB98;
        Fri, 17 Apr 2020 19:08:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sa6pRHBqzzbM; Fri, 17 Apr 2020 19:08:53 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CC7F8B75E;
        Fri, 17 Apr 2020 19:08:53 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F200C657A3; Fri, 17 Apr 2020 17:08:52 +0000 (UTC)
Message-Id: <fe952112c29bf6a0a2778c9e6bbb4f4afd2c4258.1587143308.git.christophe.leroy@c-s.fr>
In-Reply-To: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 2/2] powerpc/uaccess: Implement unsafe_copy_to_user() as a
 simple loop
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 17 Apr 2020 17:08:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, unsafe_copy_to_user() is based on
raw_copy_to_user() which calls __copy_tofrom_user().

__copy_tofrom_user() is a big optimised function to copy big amount
of data. It aligns destinations to cache line in order to use
dcbz instruction.

Today unsafe_copy_to_user() is called only from filldir().
It is used to mainly copy small amount of data like filenames,
so __copy_tofrom_user() is not fit.

Also, unsafe_copy_to_user() is used within user_access_begin/end
sections. In those section, it is preferable to not call functions.

Rewrite unsafe_copy_to_user() as a macro that uses __put_user_goto().
We first perform a loop of long, then we finish with necessary
complements.

unsafe_copy_to_user() might be used in the near future to copy
fixed-size data, like pt_regs structs during signal processing.
Having it as a macro allows GCC to optimise it for instead when
it knows the size in advance, it can unloop loops, drop complements
when the size is a multiple of longs, etc ...

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v4: new
---
 arch/powerpc/include/asm/uaccess.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 9365b59495a2..b24fbe75f9ce 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -514,7 +514,26 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
 #define unsafe_put_user(x, p, e) __put_user_goto(x, p, e)
+
 #define unsafe_copy_to_user(d, s, l, e) \
-	unsafe_op_wrap(raw_copy_to_user_allowed(d, s, l), e)
+do {									\
+	u8 __user *_dst = (u8 __user *)(d);				\
+	const u8 *_src = (const u8 *)(s);				\
+	size_t _len = (l);						\
+	int _i;								\
+									\
+	for (_i = 0; _i < (_len & ~(sizeof(long) - 1)); _i += sizeof(long))		\
+		__put_user_goto(*(long*)(_src + _i), (long __user *)(_dst + _i), e);\
+	if (IS_ENABLED(CONFIG_PPC64) && (_len & 4)) {			\
+		__put_user_goto(*(u32*)(_src + _i), (u32 __user *)(_dst + _i), e);	\
+		_i += 4;						\
+	}								\
+	if (_len & 2) {							\
+		__put_user_goto(*(u16*)(_src + _i), (u16 __user *)(_dst + _i), e);	\
+		_i += 2;						\
+	}								\
+	if (_len & 1) \
+		__put_user_goto(*(u8*)(_src + _i), (u8 __user *)(_dst + _i), e);\
+} while (0)
 
 #endif	/* _ARCH_POWERPC_UACCESS_H */
-- 
2.25.0

