Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F287C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0667D207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgHLMGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:06:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62924 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbgHLMGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1s1nSGzB09Zt;
        Wed, 12 Aug 2020 14:06:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QCWa6f7c4hKp; Wed, 12 Aug 2020 14:06:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1s0p0czB09Zf;
        Wed, 12 Aug 2020 14:06:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D7F58B826;
        Wed, 12 Aug 2020 14:06:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pwBk8hGIuTTj; Wed, 12 Aug 2020 14:06:10 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2849C8B7FC;
        Wed, 12 Aug 2020 14:06:10 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0B57265C34; Wed, 12 Aug 2020 12:06:10 +0000 (UTC)
Message-Id: <4ea86b6d9f4e3ba0126f9961b98407549d7f0294.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 18/19] powerpc/signal32: Add and use
 unsafe_put_sigset_t()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:06:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_sigset_t() calls copy_to_user() for copying two words.

Because INLINE_COPY_TO_USER is not defined on powerpc,
copy_to_user() doesn't get optimised and falls back to
copy_tofrom_user() with the relevant glue. This is terribly
inefficient for copying two words.

By switching to unsafe_put_user(), we end up with something as
simple as:

 3cc:   81 3d 00 00     lwz     r9,0(r29)
 3d0:   91 26 00 b4     stw     r9,180(r6)
 3d4:   81 3d 00 04     lwz     r9,4(r29)
 3d8:   91 26 00 b8     stw     r9,184(r6)

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d03ba3d8eb68..6cbff0293ff4 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -87,6 +87,8 @@ static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
 	return put_compat_sigset(uset, set, sizeof(*uset));
 }
 
+#define unsafe_put_sigset_t	unsafe_put_compat_sigset
+
 static inline int get_sigset_t(sigset_t *set,
 			       const compat_sigset_t __user *uset)
 {
@@ -143,6 +145,13 @@ static inline int put_sigset_t(sigset_t __user *uset, sigset_t *set)
 	return copy_to_user(uset, set, sizeof(*uset));
 }
 
+#define unsafe_put_sigset_t(uset, set, label) do { 			\
+	sigset_t __user *__us = uset	;				\
+	const sigset_t *__s = set;					\
+									\
+	unsafe_copy_to_user(__us, __s, sizeof(*__us), label);		\
+} while (0)
+
 static inline int get_sigset_t(sigset_t *set, const sigset_t __user *uset)
 {
 	return copy_from_user(set, uset, sizeof(*uset));
@@ -820,10 +829,11 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	{
 		unsafe_put_user(0, &rt_sf->uc.uc_link, failed);
 	}
+
+	unsafe_put_sigset_t(&rt_sf->uc.uc_sigmask, oldset, failed);
+
 	user_write_access_end();
 
-	if (put_sigset_t(&rt_sf->uc.uc_sigmask, oldset))
-		goto badframe;
 	if (copy_siginfo_to_user(&rt_sf->info, &ksig->info))
 		goto badframe;
 
-- 
2.25.0

