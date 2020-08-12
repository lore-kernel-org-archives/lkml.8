Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658A32080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgHLMG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:06:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14758 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgHLMGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1r0XlgzB09Zs;
        Wed, 12 Aug 2020 14:06:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EYIVEdrFQatj; Wed, 12 Aug 2020 14:06:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1q6tkvzB09Zf;
        Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 691C98B828;
        Wed, 12 Aug 2020 14:06:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XALPXVlmoRZG; Wed, 12 Aug 2020 14:06:09 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 213CB8B7FC;
        Wed, 12 Aug 2020 14:06:09 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 03AD265C34; Wed, 12 Aug 2020 12:06:09 +0000 (UTC)
Message-Id: <5fe96b182b49c03dd51659079ac0486436d696c4.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 17/19] signal: Add unsafe_put_compat_sigset()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:06:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement 'unsafe' version of put_compat_sigset()

For the bigendian, use unsafe_put_user() directly
to avoid intermediate copy through the stack.

For the littleendian, use a straight unsafe_copy_to_user().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/compat.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index c4255d8a4a8a..bbe5f9658ed1 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -442,6 +442,38 @@ put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
 #endif
 }
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define unsafe_put_compat_sigset(compat, set, label) do { 		\
+	compat_sigset_t __user *__c = compat;				\
+	const sigset_t *__s = set;					\
+									\
+	switch (_NSIG_WORDS) {						\
+	case 4:								\
+		unsafe_put_user(__s->sig[3] >> 32, __c->sig[7], label);	\
+		unsafe_put_user(__s->sig[3], __c->sig[6], label);	\
+		fallthrough;						\
+	case 3:								\
+		unsafe_put_user(__s->sig[2] >> 32, __c->sig[5], label);	\
+		unsafe_put_user(__s->sig[2], __c->sig[4], label);	\
+		fallthrough;						\
+	case 2:								\
+		unsafe_put_user(__s->sig[1] >> 32, __c->sig[3], label);	\
+		unsafe_put_user(__s->sig[1], __c->sig[2], label);	\
+		fallthrough;						\
+	case 1:								\
+		unsafe_put_user(__s->sig[0] >> 32, __c->sig[1], label);	\
+		unsafe_put_user(__s->sig[0], __c->sig[0], label);	\
+	}								\
+} while (0)
+#else
+#define unsafe_put_compat_sigset(compat, set, label) do { 		\
+	compat_sigset_t __user *__c = compat;				\
+	const sigset_t *__s = set;					\
+									\
+	unsafe_copy_to_user(__c, __s, sizeof(*__c), label);		\
+} while (0)
+#endif
+
 extern int compat_ptrace_request(struct task_struct *child,
 				 compat_long_t request,
 				 compat_ulong_t addr, compat_ulong_t data);
-- 
2.25.0

