Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A0FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2499620772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fk0aZIGL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vxlSTCU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHSH72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:59:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHSH71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:59:27 -0400
Date:   Wed, 19 Aug 2020 07:59:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597823965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKEhZzqvCjaxP53qCi9LN8ncL61Gxe6m154eAmy3DYY=;
        b=fk0aZIGLa7WjINO9I3jQ+ZZ18V7po+8M6u1rI0hUcPrEoaY24HtjH9XbIfHYzN+NQSsC6o
        foXC7oQZ+3DX++q9pWWjjD6mFhm60jhdU12Cqncz40NvDlqZ5hHhX4zNp0r+NrKetjyLoT
        iimIHZTQcgOA035gtCcIDjlxTUIDStlTkfH6c2hN1MBH3j9MPTO4c1yUZ8/ix2nDqvyXCU
        2kIrW2cZwfI/eP/6cOvY07ntO8eXsNZHo92IMhu2s4TuoqzTQmsGTUGRN3Npu0c5yYNSJR
        E+H2lPjxGXkjJj55rUBUQM9oPqqERuIoO5Ots/ITz7E/V9hmFMdhS7+xI2jC2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597823965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKEhZzqvCjaxP53qCi9LN8ncL61Gxe6m154eAmy3DYY=;
        b=vxlSTCU6b+/wUhE1xDqgG0EpT1hVE9sQfIDqi5iroOL5ztey2idhtYzP6bBIvKx/UnfCVv
        lO5CNiHiRFoMh7BA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Fix typos and improve the comments in sync_core()
Cc:     Ingo Molnar <mingo@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818053130.GA3161093@gmail.com>
References: <20200818053130.GA3161093@gmail.com>
MIME-Version: 1.0
Message-ID: <159782396422.3192.14342418739600805042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     40eb0cb4939e462acfedea8c8064571e886b9773
Gitweb:        https://git.kernel.org/tip/40eb0cb4939e462acfedea8c8064571e886b9773
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 18 Aug 2020 07:31:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 09:56:36 +02:00

x86/cpu: Fix typos and improve the comments in sync_core()

- Fix typos.

- Move the compiler barrier comment to the top, because it's valid for the
  whole function, not just the legacy branch.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200818053130.GA3161093@gmail.com
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/sync_core.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 4631c0f..0fd4a9d 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -47,16 +47,19 @@ static inline void iret_to_self(void)
  *
  *  b) Text was modified on a different CPU, may subsequently be
  *     executed on this CPU, and you want to make sure the new version
- *     gets executed.  This generally means you're calling this in a IPI.
+ *     gets executed.  This generally means you're calling this in an IPI.
  *
  * If you're calling this for a different reason, you're probably doing
  * it wrong.
+ *
+ * Like all of Linux's memory ordering operations, this is a
+ * compiler barrier as well.
  */
 static inline void sync_core(void)
 {
 	/*
 	 * The SERIALIZE instruction is the most straightforward way to
-	 * do this but it not universally available.
+	 * do this, but it is not universally available.
 	 */
 	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
 		serialize();
@@ -67,10 +70,10 @@ static inline void sync_core(void)
 	 * For all other processors, there are quite a few ways to do this.
 	 * IRET-to-self is nice because it works on every CPU, at any CPL
 	 * (so it's compatible with paravirtualization), and it never exits
-	 * to a hypervisor. The only down sides are that it's a bit slow
+	 * to a hypervisor.  The only downsides are that it's a bit slow
 	 * (it seems to be a bit more than 2x slower than the fastest
-	 * options) and that it unmasks NMIs.  The "push %cs" is needed
-	 * because, in paravirtual environments, __KERNEL_CS may not be a
+	 * options) and that it unmasks NMIs.  The "push %cs" is needed,
+	 * because in paravirtual environments __KERNEL_CS may not be a
 	 * valid CS value when we do IRET directly.
 	 *
 	 * In case NMI unmasking or performance ever becomes a problem,
@@ -81,9 +84,6 @@ static inline void sync_core(void)
 	 * CPUID is the conventional way, but it's nasty: it doesn't
 	 * exist on some 486-like CPUs, and it usually exits to a
 	 * hypervisor.
-	 *
-	 * Like all of Linux's memory ordering operations, this is a
-	 * compiler barrier as well.
 	 */
 	iret_to_self();
 }
