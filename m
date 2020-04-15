Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5418C2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895592AbgDOJcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895564AbgDOJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:32:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9BC061A0C;
        Wed, 15 Apr 2020 02:32:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOePB-0005Xm-66; Wed, 15 Apr 2020 11:32:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B31131C0081;
        Wed, 15 Apr 2020 11:32:24 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:32:24 -0000
From:   "tip-bot2 for Kairui Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] crash_dump: Remove no longer used saved_max_pfn
Cc:     Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200330181544.1595733-1-kasong@redhat.com>
References: <20200330181544.1595733-1-kasong@redhat.com>
MIME-Version: 1.0
Message-ID: <158694314428.28353.3558515515241070907.tip-bot2@tip-bot2>
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

Commit-ID:     4c5b566c2193e2af82c891daa5303c8899e61044
Gitweb:        https://git.kernel.org/tip/4c5b566c2193e2af82c891daa5303c8899e61044
Author:        Kairui Song <kasong@redhat.com>
AuthorDate:    Tue, 31 Mar 2020 02:15:44 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 15 Apr 2020 11:21:54 +02:00

crash_dump: Remove no longer used saved_max_pfn

saved_max_pfn was originally introduced in commit

  92aa63a5a1bf ("[PATCH] kdump: Retrieve saved max pfn")

It used to make sure that the user does not try to read the physical memory
beyond saved_max_pfn. But since commit

  921d58c0e699 ("vmcore: remove saved_max_pfn check")

it's no longer used for the check. This variable doesn't have any users
anymore so just remove it.

 [ bp: Drop the Calgary IOMMU reference from the commit message. ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lkml.kernel.org/r/20200330181544.1595733-1-kasong@redhat.com
---
 arch/x86/kernel/e820.c     | 8 --------
 include/linux/crash_dump.h | 2 --
 kernel/crash_dump.c        | 6 ------
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c5399e8..4d13c57 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -910,14 +910,6 @@ static int __init parse_memmap_one(char *p)
 		return -EINVAL;
 
 	if (!strncmp(p, "exactmap", 8)) {
-#ifdef CONFIG_CRASH_DUMP
-		/*
-		 * If we are doing a crash dump, we still need to know
-		 * the real memory size before the original memory map is
-		 * reset.
-		 */
-		saved_max_pfn = e820__end_of_ram_pfn();
-#endif
 		e820_table->nr_entries = 0;
 		userdef = 1;
 		return 0;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 4664fc1..bc15628 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -97,8 +97,6 @@ extern void unregister_oldmem_pfn_is_ram(void);
 static inline bool is_kdump_kernel(void) { return 0; }
 #endif /* CONFIG_CRASH_DUMP */
 
-extern unsigned long saved_max_pfn;
-
 /* Device Dump information to be filled by drivers */
 struct vmcoredd_data {
 	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 9c23ae0..92da322 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -6,12 +6,6 @@
 #include <linux/export.h>
 
 /*
- * If we have booted due to a crash, max_pfn will be a very low value. We need
- * to know the amount of memory that the previous kernel used.
- */
-unsigned long saved_max_pfn;
-
-/*
  * stores the physical address of elf header of crash image
  *
  * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by
