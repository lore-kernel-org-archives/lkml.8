Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BB5C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642822078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xFfNNCpl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IPvMxZKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgG0MqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgG0MqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:46:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AA4C0619D5;
        Mon, 27 Jul 2020 05:46:21 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:46:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595853980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8mhpwniynq9Al2KGCYBwvFuQ7zWUXZaUO3a2zhmi2s=;
        b=xFfNNCpl3n5qNHpsh2Wz2f6wleEcAmsnXtUQ223FVVLBZ/H6lWotPR/ROkfSXn63Qy3ARV
        U2vrwQCN1WNoav/k6BFSeiJejlXHox92vdIbcTVV8CENtlzxe8dEwMuAwv31skUB2KDpv6
        AgLJz/ZK/Hu2CXNntwxK+aLILymnf1busUBEcjf6aUVGD9EnZjytR3GP529/nyDmxBrEeL
        ML6YYShw8r4HMfBais1DbadsGPyNv8hwnGtmHq9I4kG7C4j+qQ4HUuxST7v05mwZFqlAv3
        kUHh2MD546J0SkhTnSxGLf3P86e1s6GycwaeILpsnPklktW5x7HldPSQsWUyyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595853980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8mhpwniynq9Al2KGCYBwvFuQ7zWUXZaUO3a2zhmi2s=;
        b=IPvMxZKyU6yy/VZmGPWtFd2GxuekaAO9hfL/EzMczlJRWWO9a32DLBAei6G2GOBh8W7Lt3
        +nwtIEKcBgYdDiCA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/64: Make sync_global_pgds() static
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200721095953.6218-4-joro@8bytes.org>
References: <20200721095953.6218-4-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159585397939.4006.11580788411199403044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     2b32ab031e82a109e2c5b0d30ce563db0fe286b4
Gitweb:        https://git.kernel.org/tip/2b32ab031e82a109e2c5b0d30ce563db0fe286b4
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 21 Jul 2020 11:59:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 12:32:29 +02:00

x86/mm/64: Make sync_global_pgds() static

The function is only called from within init_64.c and can be static.
Also remove it from pgtable_64.h.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lore.kernel.org/r/20200721095953.6218-4-joro@8bytes.org
---
 arch/x86/include/asm/pgtable_64.h | 2 --
 arch/x86/mm/init_64.c             | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 1b68d24..95ac911 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -168,8 +168,6 @@ static inline void native_pgd_clear(pgd_t *pgd)
 	native_set_pgd(pgd, native_make_pgd(0));
 }
 
-extern void sync_global_pgds(unsigned long start, unsigned long end);
-
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e0cd2df..e65b96f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -209,7 +209,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
  * When memory was added make sure all the processes MM have
  * suitable PGD entries in the local PGD level page.
  */
-void sync_global_pgds(unsigned long start, unsigned long end)
+static void sync_global_pgds(unsigned long start, unsigned long end)
 {
 	if (pgtable_l5_enabled())
 		sync_global_pgds_l5(start, end);
