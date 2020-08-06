Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D086C47435
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAA123142
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgHFIXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:23:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18272 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgHFIXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:23:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMhMH72hCz9v0TH;
        Thu,  6 Aug 2020 10:23:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IHruyvwNIS1G; Thu,  6 Aug 2020 10:23:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMhMH65Wxz9v0St;
        Thu,  6 Aug 2020 10:23:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 415D38B7F9;
        Thu,  6 Aug 2020 10:23:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XCcAL8QChux9; Thu,  6 Aug 2020 10:23:09 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 08EBC8B75E;
        Thu,  6 Aug 2020 10:23:09 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B0CBA65BC9; Thu,  6 Aug 2020 08:23:08 +0000 (UTC)
Message-Id: <a6e62627d25fb7ae9b91d8bf553e707689e37498.1596702117.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 1/3] syscalls: use uaccess_kernel in addr_limit_user_check
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Aug 2020 08:23:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Patch series "clean up address limit helpers", v2.

In preparation for eventually phasing out direct use of set_fs(), this
series removes the segment_eq() arch helper that is only used to implement
or duplicate the uaccess_kernel() API, and then adds descriptive helpers
to force the kernel address limit.

This patch (of 6):

Use the uaccess_kernel helper instead of duplicating it.

Link: http://lkml.kernel.org/r/20200714105505.935079-1-hch@lst.de
Link: http://lkml.kernel.org/r/20200710135706.537715-1-hch@lst.de
Link: http://lkml.kernel.org/r/20200710135706.537715-2-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da987..e933a43d4a69 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -263,7 +263,7 @@ static inline void addr_limit_user_check(void)
 		return;
 #endif
 
-	if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
+	if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
 				  "Invalid address limit on user-mode return"))
 		force_sig(SIGKILL);
 
-- 
2.25.0

