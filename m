Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22916C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE43121741
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hSRMu9wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgBDHiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:38:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35179 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgBDHh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:37:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Bc432sGMz9vC1g;
        Tue,  4 Feb 2020 08:37:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hSRMu9wz; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IWa7axmcAhxe; Tue,  4 Feb 2020 08:37:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Bc431n5hz9vC1c;
        Tue,  4 Feb 2020 08:37:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580801875; bh=IXjiKlijLtzQuR/CNi0kS3j7+7PM/7fqUO8AWUmnzeg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=hSRMu9wznvfD+qbck0wOIk87YeVy3P7ZkgPtDiAnur09tpGBUEosTAAmr8VsL7vyr
         x/zwOKFKm6fKOd2TnHGotd6uDnkaDr+NqKtNlK8FQDDE5NIg8tCFrZwJXzp0hl8qxi
         V0MdkHXXn+CXa8fUDjK9UzDcdYrupgzkjLxCktt4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B7018B7B6;
        Tue,  4 Feb 2020 08:37:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RM1G0Aq0u8hX; Tue,  4 Feb 2020 08:37:56 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1AEC8B755;
        Tue,  4 Feb 2020 08:37:55 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9C3F0652B3; Tue,  4 Feb 2020 07:37:55 +0000 (UTC)
Message-Id: <a4453f734d9d7f0c6625b7bf306ec2d28631f56c.1580801787.git.christophe.leroy@c-s.fr>
In-Reply-To: <f96ed94dc57ea810b738c4e02263e08c2c8781b6.1580801787.git.christophe.leroy@c-s.fr>
References: <f96ed94dc57ea810b738c4e02263e08c2c8781b6.1580801787.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/4] powerpc/uaccess: Implement user_read_access_begin and
 user_write_access_begin
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  4 Feb 2020 07:37:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for selective read or write user access with
user_read_access_begin/end and user_write_access_begin/end.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h |  4 ++--
 arch/powerpc/include/asm/kup.h           | 14 +++++++++++++-
 arch/powerpc/include/asm/uaccess.h       | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 3c0ba22dc360..1617e73bee30 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -108,7 +108,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 	u32 addr, end;
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
-	BUILD_BUG_ON(dir == KUAP_CURRENT);
+	BUILD_BUG_ON(dir & ~KUAP_READ_WRITE);
 
 	if (!(dir & KUAP_WRITE))
 		return;
@@ -131,7 +131,7 @@ static __always_inline void prevent_user_access(void __user *to, const void __us
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
 
-	if (dir == KUAP_CURRENT) {
+	if (dir & KUAP_CURRENT_WRITE) {
 		u32 kuap = current->thread.kuap;
 
 		if (unlikely(!kuap))
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 92bcd1a26d73..c745ee41ad66 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -10,7 +10,9 @@
  * Use the current saved situation instead of the to/from/size params.
  * Used on book3s/32
  */
-#define KUAP_CURRENT	4
+#define KUAP_CURRENT_READ	4
+#define KUAP_CURRENT_WRITE	8
+#define KUAP_CURRENT		(KUAP_CURRENT_READ | KUAP_CURRENT_WRITE)
 
 #ifdef CONFIG_PPC64
 #include <asm/book3s/64/kup-radix.h>
@@ -101,6 +103,16 @@ static inline void prevent_current_access_user(void)
 	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT);
 }
 
+static inline void prevent_current_read_from_user(void)
+{
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
+}
+
+static inline void prevent_current_write_to_user(void)
+{
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_KUAP_H_ */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 2f500debae21..4427d419eb1d 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -468,6 +468,28 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
 #define user_access_save	prevent_user_access_return
 #define user_access_restore	restore_user_access
 
+static __must_check inline bool
+user_read_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return false;
+	allow_read_from_user(ptr, len);
+	return true;
+}
+#define user_read_access_begin	user_read_access_begin
+#define user_read_access_end		prevent_current_read_from_user
+
+static __must_check inline bool
+user_write_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return false;
+	allow_write_to_user((void __user *)ptr, len);
+	return true;
+}
+#define user_write_access_begin	user_write_access_begin
+#define user_write_access_end		prevent_current_write_to_user
+
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
 #define unsafe_put_user(x, p, e) unsafe_op_wrap(__put_user_allowed(x, p), e)
-- 
2.25.0

