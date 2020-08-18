Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78409C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6056F20658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgHRRUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:20:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48596 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgHRRTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhg3Tvnz9vCy0;
        Tue, 18 Aug 2020 19:19:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8pkMd_j9NkKu; Tue, 18 Aug 2020 19:19:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhg2lZJz9vCxg;
        Tue, 18 Aug 2020 19:19:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A9098B7EC;
        Tue, 18 Aug 2020 19:19:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Zzzz-Z2qN1Ye; Tue, 18 Aug 2020 19:19:33 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E96978B7D7;
        Tue, 18 Aug 2020 19:19:32 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C8C0565CF4; Tue, 18 Aug 2020 17:19:32 +0000 (UTC)
Message-Id: <537c7082ee309a0bb9c67a50c5d9dd929aedb82d.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 20/25] signal: Add unsafe_put_compat_sigset()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement 'unsafe' version of put_compat_sigset()

For the bigendian, use unsafe_put_user() directly
to avoid intermediate copy through the stack.

For the littleendian, use a straight unsafe_copy_to_user().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/compat.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index d38c4d7e83bd..7ec6e44b093b 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -442,6 +442,38 @@ put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
 #endif
 }
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define unsafe_put_compat_sigset(compat, set, label) do {		\
+	compat_sigset_t __user *__c = compat;				\
+	const sigset_t *__s = set;					\
+									\
+	switch (_NSIG_WORDS) {						\
+	case 4:								\
+		unsafe_put_user(__s->sig[3] >> 32, &__c->sig[7], label);	\
+		unsafe_put_user(__s->sig[3], &__c->sig[6], label);	\
+		fallthrough;						\
+	case 3:								\
+		unsafe_put_user(__s->sig[2] >> 32, &__c->sig[5], label);	\
+		unsafe_put_user(__s->sig[2], &__c->sig[4], label);	\
+		fallthrough;						\
+	case 2:								\
+		unsafe_put_user(__s->sig[1] >> 32, &__c->sig[3], label);	\
+		unsafe_put_user(__s->sig[1], &__c->sig[2], label);	\
+		fallthrough;						\
+	case 1:								\
+		unsafe_put_user(__s->sig[0] >> 32, &__c->sig[1], label);	\
+		unsafe_put_user(__s->sig[0], &__c->sig[0], label);	\
+	}								\
+} while (0)
+#else
+#define unsafe_put_compat_sigset(compat, set, label) do {		\
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

