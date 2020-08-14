Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E8D20885
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHNPUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgHNPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:20:07 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BD2C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 08:20:06 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 7BDA74D6;
        Fri, 14 Aug 2020 17:20:02 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, hpa@zytor.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason@zx2c4.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 2/2] x86/mm/64: Update comment in preallocate_vmalloc_pages()
Date:   Fri, 14 Aug 2020 17:19:47 +0200
Message-Id: <20200814151947.26229-3-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200814151947.26229-1-joro@8bytes.org>
References: <20200814151947.26229-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The comment explaining why 4-level systems only need to allocate on
the P4D level caused some confustion. Update it to better explain why
on 4-level systems the allocation on PUD level is necessary.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 777d83546764..124e63795ac9 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1252,14 +1252,19 @@ static void __init preallocate_vmalloc_pages(void)
 		if (!p4d)
 			goto failed;
 
-		/*
-		 * With 5-level paging the P4D level is not folded. So the PGDs
-		 * are now populated and there is no need to walk down to the
-		 * PUD level.
-		 */
 		if (pgtable_l5_enabled())
 			continue;
 
+		/*
+		 * The goal here is to allocate all possibly required
+		 * hardware page tables pointed to by the top hardware
+		 * level.
+		 *
+		 * On 4-level systems, the p4d layer is folded away and
+		 * the above code does no preallocation.  Below, go down
+		 * to the pud _software_ level to ensure the second
+		 * hardware level is allocated on 4-level systems too.
+		 */
 		lvl = "pud";
 		pud = pud_alloc(&init_mm, p4d, addr);
 		if (!pud)
-- 
2.28.0

