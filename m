Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA97C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A2D20644
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgDVTNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgDVTNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:13:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293BC03C1A9;
        Wed, 22 Apr 2020 12:13:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRKoK-00073V-6C; Wed, 22 Apr 2020 21:13:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 87BF11C02FC;
        Wed, 22 Apr 2020 21:13:27 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:13:27 -0000
From:   "tip-bot2 for Jimmy Assarsson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] mm: Remove MPX leftovers
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402172507.2786-1-jimmyassarsson@gmail.com>
References: <20200402172507.2786-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Message-ID: <158758280709.28353.11814672256767435249.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     66648766ef38d8d6c48ded2f59cf98420aec2cdb
Gitweb:        https://git.kernel.org/tip/66648766ef38d8d6c48ded2f59cf98420aec2cdb
Author:        Jimmy Assarsson <jimmyassarsson@gmail.com>
AuthorDate:    Thu, 02 Apr 2020 19:25:07 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Apr 2020 21:02:35 +02:00

mm: Remove MPX leftovers

Remove MPX leftovers in generic code.

Fixes: 45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")
Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200402172507.2786-1-jimmyassarsson@gmail.com
---
 fs/proc/task_mmu.c | 3 ---
 include/linux/mm.h | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8d382d4..e12ad2e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -622,9 +622,6 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
 		[ilog2(VM_DENYWRITE)]	= "dw",
-#ifdef CONFIG_X86_INTEL_MPX
-		[ilog2(VM_MPX)]		= "mp",
-#endif
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a32342..e1882ee 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -329,13 +329,6 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
 
-#if defined(CONFIG_X86_INTEL_MPX)
-/* MPX specific bounds table or bounds directory */
-# define VM_MPX		VM_HIGH_ARCH_4
-#else
-# define VM_MPX		VM_NONE
-#endif
-
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
