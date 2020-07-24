Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97189C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD3A20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="va7aB1yx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ozkt+gD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGXH45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:56:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGXH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:56:56 -0400
Date:   Fri, 24 Jul 2020 07:56:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595577414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SIg3/SYrGlu5FpEqesZYPYgojA1f2D2OGjki95TLKw=;
        b=va7aB1yxMW15tsDKQFVecBf70B/wUHAsP+1T0NCD1gggE9heF10Jz0DdrWFYoCGsggfMiP
        CWKyP5bi6QM9UC4KGjZBCjYZkHIJkyp10TRfaaxqM0IiTIQmJZhEaavNpov95fugt7nj9o
        zOZX3i7ujeiLuEU2RDrsxtXgpW/+AaX7xuktED1mMESE81/DYJVl4oAw30+0Na8fwt3EUy
        YW7tVTmpt2to3deF9qT/wcNgCcatqO0059/esUV5L0O1dYDqDumcaNHIg5mOnM6wII7Zwm
        t6wMYtfU37D1lvfN8B1P3bNXA/tE106jBcT4RY6sn9sKi36oUzRe7RgfmEautQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595577414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SIg3/SYrGlu5FpEqesZYPYgojA1f2D2OGjki95TLKw=;
        b=Ozkt+gD15AL70cyR2PLbBgSKsCV8kROc+oaslZGEg5eDL7GgMahfq50nrwtyUlLUOxapla
        cbxC35rvKHLzJ6AQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Drop unused MAX_PHYSADDR_BITS
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723231544.17274-2-nivedita@alum.mit.edu>
References: <20200723231544.17274-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159557741311.4006.10642517822235710788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0a787b28b7a375ad9d5c77bc3922ae1a8305239e
Gitweb:        https://git.kernel.org/tip/0a787b28b7a375ad9d5c77bc3922ae1a8305239e
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 23 Jul 2020 19:15:42 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 09:53:06 +02:00

x86/mm: Drop unused MAX_PHYSADDR_BITS

The macro is not used anywhere, and has an incorrect value (going by the
comment) on x86_64 since commit c898faf91b3e ("x86: 46 bit physical address
support on 64 bits")

To avoid confusion, just remove the definition.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200723231544.17274-2-nivedita@alum.mit.edu

---
 arch/x86/include/asm/sparsemem.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1992187..6bfc878 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -10,24 +10,20 @@
  *    field of the struct page
  *
  * SECTION_SIZE_BITS		2^n: size of each section
- * MAX_PHYSADDR_BITS		2^n: max size of physical address space
- * MAX_PHYSMEM_BITS		2^n: how much memory we can have in that space
+ * MAX_PHYSMEM_BITS		2^n: max size of physical address space
  *
  */
 
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_X86_PAE
 #  define SECTION_SIZE_BITS	29
-#  define MAX_PHYSADDR_BITS	36
 #  define MAX_PHYSMEM_BITS	36
 # else
 #  define SECTION_SIZE_BITS	26
-#  define MAX_PHYSADDR_BITS	32
 #  define MAX_PHYSMEM_BITS	32
 # endif
 #else /* CONFIG_X86_32 */
 # define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
-# define MAX_PHYSADDR_BITS	(pgtable_l5_enabled() ? 52 : 44)
 # define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
 #endif
 
