Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC97DC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEB92220A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X097XksK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgD1TpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728703AbgD1TpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:45:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B720AC03C1AB;
        Tue, 28 Apr 2020 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ozJ4/VCCoOCPsRdSc3NikpEPmevttfRVGSWHfGtgyPo=; b=X097XksKF4UJYy1M1UQSEzc/TX
        wSx6mHzP0Pg7Lyy3l4oJPeFr3jUWzn18Hmdo73qxJ84N80PzFceLS+XkuPpVpIyrEczeLGCljKXCA
        LstVM5ix6YN91UPAre63NSEEuYBVMgjie7FrTjktpVI1GLc3HIEbGm4sDrFKtT0/OtRqaOd9Ycyx2
        ZBWbA9d/XkyEioVunlmS82vG+CkUMbDhPi3Tedd2bqVzuc+GclRHpMZxRPwM8w2mZv2BIRUK/XCXd
        Jmj70qYwEAKbJajKBWiqFVA6zP3P6fux5euO+6RsMsEurvYdTCB3wYrmb6wKKcvG8lbjB+uo/95EP
        /2EgeWCg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTW9y-0005uQ-TN; Tue, 28 Apr 2020 19:44:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 1/7] mm: Document x86 uses a linked list of pgds
Date:   Tue, 28 Apr 2020 12:44:43 -0700
Message-Id: <20200428194449.22615-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428194449.22615-1-willy@infradead.org>
References: <20200428194449.22615-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

x86 uses page->lru of the pages used for pgds, but that's not immediately
obvious to anyone looking to make changes.  Add a struct list_head to
the union so it's clearly in use for pgds.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba8..9bb34e2cd5a5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -142,8 +142,13 @@ struct page {
 			struct list_head deferred_list;
 		};
 		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
+			union {
+				struct list_head pgd_list;	/* x86 */
+				struct {
+					unsigned long _pt_pad_1;
+					pgtable_t pmd_huge_pte;
+				};
+			};
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
-- 
2.26.2

