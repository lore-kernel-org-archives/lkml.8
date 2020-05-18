Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEB8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDD220671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgERSJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733125AbgERSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09211C061A0C;
        Mon, 18 May 2020 11:06:13 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jak9O-00008n-KX; Mon, 18 May 2020 20:06:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2A2751C009C;
        Mon, 18 May 2020 20:06:06 +0200 (CEST)
Date:   Mon, 18 May 2020 18:06:06 -0000
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use RDRAND and RDSEED mnemonics in archrandom.h
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200508105817.207887-1-ubizjak@gmail.com>
References: <20200508105817.207887-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <158982516602.17951.15035547991791218308.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3d81b3d1e55a518837c3d1f722c6d93abe34aa85
Gitweb:        https://git.kernel.org/tip/3d81b3d1e55a518837c3d1f722c6d93abe34aa85
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 08 May 2020 12:58:17 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 18 May 2020 19:50:47 +02:00

x86/cpu: Use RDRAND and RDSEED mnemonics in archrandom.h

Current minimum required version of binutils is 2.23,
which supports RDRAND and RDSEED instruction mnemonics.

Replace the byte-wise specification of RDRAND and
RDSEED with these proper mnemonics.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200508105817.207887-1-ubizjak@gmail.com
---
 arch/x86/include/asm/archrandom.h | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 7a4bb1b..ebc248e 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -15,16 +15,6 @@
 
 #define RDRAND_RETRY_LOOPS	10
 
-#define RDRAND_INT	".byte 0x0f,0xc7,0xf0"
-#define RDSEED_INT	".byte 0x0f,0xc7,0xf8"
-#ifdef CONFIG_X86_64
-# define RDRAND_LONG	".byte 0x48,0x0f,0xc7,0xf0"
-# define RDSEED_LONG	".byte 0x48,0x0f,0xc7,0xf8"
-#else
-# define RDRAND_LONG	RDRAND_INT
-# define RDSEED_LONG	RDSEED_INT
-#endif
-
 /* Unconditional execution of RDRAND and RDSEED */
 
 static inline bool __must_check rdrand_long(unsigned long *v)
@@ -32,9 +22,9 @@ static inline bool __must_check rdrand_long(unsigned long *v)
 	bool ok;
 	unsigned int retry = RDRAND_RETRY_LOOPS;
 	do {
-		asm volatile(RDRAND_LONG
+		asm volatile("rdrand %[out]"
 			     CC_SET(c)
-			     : CC_OUT(c) (ok), "=a" (*v));
+			     : CC_OUT(c) (ok), [out] "=r" (*v));
 		if (ok)
 			return true;
 	} while (--retry);
@@ -46,9 +36,9 @@ static inline bool __must_check rdrand_int(unsigned int *v)
 	bool ok;
 	unsigned int retry = RDRAND_RETRY_LOOPS;
 	do {
-		asm volatile(RDRAND_INT
+		asm volatile("rdrand %[out]"
 			     CC_SET(c)
-			     : CC_OUT(c) (ok), "=a" (*v));
+			     : CC_OUT(c) (ok), [out] "=r" (*v));
 		if (ok)
 			return true;
 	} while (--retry);
@@ -58,18 +48,18 @@ static inline bool __must_check rdrand_int(unsigned int *v)
 static inline bool __must_check rdseed_long(unsigned long *v)
 {
 	bool ok;
-	asm volatile(RDSEED_LONG
+	asm volatile("rdseed %[out]"
 		     CC_SET(c)
-		     : CC_OUT(c) (ok), "=a" (*v));
+		     : CC_OUT(c) (ok), [out] "=r" (*v));
 	return ok;
 }
 
 static inline bool __must_check rdseed_int(unsigned int *v)
 {
 	bool ok;
-	asm volatile(RDSEED_INT
+	asm volatile("rdseed %[out]"
 		     CC_SET(c)
-		     : CC_OUT(c) (ok), "=a" (*v));
+		     : CC_OUT(c) (ok), [out] "=r" (*v));
 	return ok;
 }
 
