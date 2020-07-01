Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17706C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A0D20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGAIix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgGAIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:38:44 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9759C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:38:43 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 68D2636B; Wed,  1 Jul 2020 10:38:41 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 3/3] x86/mm/64: Make sync_global_pgds() static
Date:   Wed,  1 Jul 2020 10:38:38 +0200
Message-Id: <20200701083839.19193-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701083839.19193-1-joro@8bytes.org>
References: <20200701083839.19193-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function is only called from within init_64.c by now and can be
static. Also remove it from pgtable_64.h.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_64.h | 2 --
 arch/x86/mm/init_64.c             | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 1b68d24dc6a0..95ac911b1a30 100644
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
index e0cd2dfd333d..e65b96f381a7 100644
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
-- 
2.17.1

