Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047CAC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E03206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgELOKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgELOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:10:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC448C061A0C;
        Tue, 12 May 2020 07:10:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYVcH-0005CN-HL; Tue, 12 May 2020 16:10:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1EE261C02FC;
        Tue, 12 May 2020 16:10:41 +0200 (CEST)
Date:   Tue, 12 May 2020 14:10:41 -0000
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use INVPCID mnemonic in invpcid.h
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200508092247.132147-1-ubizjak@gmail.com>
References: <20200508092247.132147-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <158929264101.390.18239205970315804831.tip-bot2@tip-bot2>
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

Commit-ID:     7e32a9dac9926241d56851e1517c9391d39fb48e
Gitweb:        https://git.kernel.org/tip/7e32a9dac9926241d56851e1517c9391d39fb48e
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 08 May 2020 11:22:47 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 May 2020 16:05:30 +02:00

x86/cpu: Use INVPCID mnemonic in invpcid.h

The current minimum required version of binutils is 2.23, which supports
the INVPCID instruction mnemonic. Replace the byte-wise specification of
INVPCID with the proper mnemonic.

 [ bp: Add symbolic operand names for increased readability and flip
   their order like the insn expects them for the AT&T syntax. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200508092247.132147-1-ubizjak@gmail.com

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/invpcid.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/invpcid.h b/arch/x86/include/asm/invpcid.h
index 989cfa8..734482a 100644
--- a/arch/x86/include/asm/invpcid.h
+++ b/arch/x86/include/asm/invpcid.h
@@ -12,12 +12,9 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 	 * stale TLB entries and, especially if we're flushing global
 	 * mappings, we don't want the compiler to reorder any subsequent
 	 * memory accesses before the TLB flush.
-	 *
-	 * The hex opcode is invpcid (%ecx), %eax in 32-bit mode and
-	 * invpcid (%rcx), %rax in long mode.
 	 */
-	asm volatile (".byte 0x66, 0x0f, 0x38, 0x82, 0x01"
-		      : : "m" (desc), "a" (type), "c" (&desc) : "memory");
+	asm volatile("invpcid %[desc], %[type]"
+		     :: [desc] "m" (desc), [type] "r" (type) : "memory");
 }
 
 #define INVPCID_TYPE_INDIV_ADDR		0
