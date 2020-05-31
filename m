Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C82074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgEaKtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 06:49:09 -0400
Received: from outpost17.zedat.fu-berlin.de ([130.133.4.110]:47409 "EHLO
        outpost17.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbgEaKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 06:49:09 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1jfLWZ-00304k-Jg; Sun, 31 May 2020 12:49:03 +0200
Received: from z6.physik.fu-berlin.de ([160.45.32.137] helo=z6)
          by relay1.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1jfLWZ-001ryz-H6; Sun, 31 May 2020 12:49:03 +0200
Received: from glaubitz by z6 with local (Exim 4.93)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1jfLWR-00AXem-Pj; Sun, 31 May 2020 12:48:55 +0200
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     linux-sh@vger.kernel.org
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v2] sh: Implement __get_user_u64() required for 64-bit get_user()
Date:   Sun, 31 May 2020 12:47:16 +0200
Message-Id: <20200531104715.2512247-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 160.45.32.137
X-ZEDAT-Hint: RV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to build the kernel with CONFIG_INFINIBAND_USER_ACCESS enabled fails

     ERROR: "__get_user_unknown" [drivers/infiniband/core/ib_uverbs.ko] undefined!

with on SH since the kernel misses a 64-bit implementation of get_user().

Implement the missing 64-bit get_user() as __get_user_u64(), matching the
already existing __put_user_u64() which implements the 64-bit put_user().

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/include/asm/uaccess_32.h | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

 Changes since v1:
 - Replace single mov instruction for exception handling
   in case of invalid load

diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 624cf55acc27..35f6c1e40ec3 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -26,6 +26,9 @@ do {								\
 	case 4:							\
 		__get_user_asm(x, ptr, retval, "l");		\
 		break;						\
+	case 8:							\
+		__get_user_u64(x, ptr, retval);			\
+		break;						\
 	default:						\
 		__get_user_unknown();				\
 		break;						\
@@ -66,6 +69,54 @@ do {							\
 
 extern void __get_user_unknown(void);
 
+#if defined(CONFIG_CPU_LITTLE_ENDIAN)
+#define __get_user_u64(x, addr, err) \
+({ \
+__asm__ __volatile__( \
+	"1:\n\t" \
+	"mov.l	%2,%R1\n\t" \
+	"mov.l	%T2,%S1\n\t" \
+	"2:\n" \
+	".section	.fixup,\"ax\"\n" \
+	"3:\n\t" \
+	"mov  #0,%R1\n\t"   \
+	"mov  #0,%S1\n\t"   \
+	"mov.l	4f, %0\n\t" \
+	"jmp	@%0\n\t" \
+	" mov	%3, %0\n\t" \
+	".balign	4\n" \
+	"4:	.long	2b\n\t" \
+	".previous\n" \
+	".section	__ex_table,\"a\"\n\t" \
+	".long	1b, 3b\n\t" \
+	".previous" \
+	:"=&r" (err), "=&r" (x) \
+	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+#else
+#define __get_user_u64(x, addr, err) \
+({ \
+__asm__ __volatile__( \
+	"1:\n\t" \
+	"mov.l	%2,%S1\n\t" \
+	"mov.l	%T2,%R1\n\t" \
+	"2:\n" \
+	".section	.fixup,\"ax\"\n" \
+	"3:\n\t" \
+	"mov  #0,%S1\n\t"   \
+	"mov  #0,%R1\n\t"   \
+	"mov.l	4f, %0\n\t" \
+	"jmp	@%0\n\t" \
+	" mov	%3, %0\n\t" \
+	".balign	4\n" \
+	"4:	.long	2b\n\t" \
+	".previous\n" \
+	".section	__ex_table,\"a\"\n\t" \
+	".long	1b, 3b\n\t" \
+	".previous" \
+	:"=&r" (err), "=&r" (x) \
+	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+#endif
+
 #define __put_user_size(x,ptr,size,retval)		\
 do {							\
 	retval = 0;					\
-- 
2.27.0.rc2

