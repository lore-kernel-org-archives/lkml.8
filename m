Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09890C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0CB206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Chky+ntO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAJE5s8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgHOV7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgHOVvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C589C09B050;
        Sat, 15 Aug 2020 08:47:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597506409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48x4OrRtq4LeuwE5ksVTTMPn0fnAIYckmFCTxbX0hm0=;
        b=Chky+ntOBR8DjsTzO6oxz9pH6rCJvs016SP4EC+i5J3CJLkhD6O5Nm8w/q8pywNyYaabzI
        +myMiADzBQI/V39DQ3oUdr6xSl01lFqIhOtbsQVdHcLmTtbn1z11supr2l42UO7wByvPWo
        T0SnHrn8U1FJmB/GDELaOdjE1AIYLXaiOwntba/Qke0Y4TzPITbNBbxvn3o0EMoWGmqaAh
        myOFOpNlxyZ/+hly81cuoKdeyUcDQTXp6DI1kT331CmJK58zBs+yhnj1ThA5RLpL5Ot7zL
        4p4xgBnbk8miooZs81a7BRj1pswJAqwuZSV6YA9PWIdLco279PiJngX5EJmuQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597506409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48x4OrRtq4LeuwE5ksVTTMPn0fnAIYckmFCTxbX0hm0=;
        b=RAJE5s8yZhJhJ3zMNoio+lgbaPuiCxpp+mRCCPRYCJpgySynlKZEZfN8T6f/Gl6/fc0T01
        M3d5wmwUoF06dfAQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/64: Do not sync vmalloc/ioremap mappings
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200814151947.26229-2-joro@8bytes.org>
References: <20200814151947.26229-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159750640896.3192.12080661084400860264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     58a18fe95e83b8396605154db04d73b08063f31b
Gitweb:        https://git.kernel.org/tip/58a18fe95e83b8396605154db04d73b08063f31b
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 14 Aug 2020 17:19:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Aug 2020 13:56:16 +02:00

x86/mm/64: Do not sync vmalloc/ioremap mappings

Remove the code to sync the vmalloc and ioremap ranges for x86-64. The
page-table pages are all pre-allocated so that synchronization is
no longer necessary.

This is a patch that already went into the kernel as:

	commit 8bb9bf242d1f ("x86/mm/64: Do not sync vmalloc/ioremap mappings")

But it had to be reverted later because it unveiled a bug from:

	commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for vmalloc area")

The bug in that commit causes the P4D/PUD pages not to be correctly
allocated, making the synchronization still necessary. That issue got
fixed meanwhile upstream:

	commit 995909a4e22b ("x86/mm/64: Do not dereference non-present PGD entries")

With that fix it is safe again to remove the page-table synchronization
for vmalloc/ioremap ranges on x86-64.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200814151947.26229-2-joro@8bytes.org
---
 arch/x86/include/asm/pgtable_64_types.h | 2 --
 arch/x86/mm/init_64.c                   | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 8f63efb..52e5f5f 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -159,6 +159,4 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
-#define ARCH_PAGE_TABLE_SYNC_MASK	(pgtable_l5_enabled() ?	PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
-
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a4ac13c..777d835 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -217,11 +217,6 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
-{
-	sync_global_pgds(start, end);
-}
-
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
