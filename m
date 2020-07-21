Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B0AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56102068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWWJmHwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgGUVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:00:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DTQIuZB8c1fyynJQcCCnAFbsCacNAxGER4BIRMaS+h0=; b=fWWJmHwWmhSH2hLIxtmaDjNQbg
        asRhE2+kU+rJXOdR9dWrt6LuCIHcKT/Mq6Nv2JoZzWeRxx5N1zgowcXzcm8BJKmZTe4bhU7KTJHYm
        hTVGFd/FntBw3QslC2mfBrB6VNT3vXgTrsow12zzQ0Kk8WxF1xO4QBez7Xb4SEz8XNXwvsZ7dcVOn
        b7YT5lExhKhnc8USSxICn8u+kBNrvbB6bJvSRCVSaNFu8fCW6Qd4LSKomm9Yum8wl9HMRIzb6Hc2c
        YO/HIx/Uo/SgSw1UJ6lj2Ofi70ur1Faq2veJhhhMi8cRc/mExfu6xLOEGU4PQDVGLTqjTuTaF0EGB
        fVpW85jg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxzMq-0000Y2-7G; Tue, 21 Jul 2020 21:00:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH] ARC: pgalloc.h: delete a duplicated word + other fixes
Date:   Tue, 21 Jul 2020 13:59:58 -0700
Message-Id: <20200721205958.15229-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "to".
Change "Thay" to "That".
Add a closing right parenthesis.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/pgalloc.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200720.orig/arch/arc/include/asm/pgalloc.h
+++ linux-next-20200720/arch/arc/include/asm/pgalloc.h
@@ -18,10 +18,10 @@
  * vineetg: April 2010
  *  -Switched pgtable_t from being struct page * to unsigned long
  *      =Needed so that Page Table allocator (pte_alloc_one) is not forced to
- *       to deal with struct page. Thay way in future we can make it allocate
+ *       deal with struct page. That way in future we can make it allocate
  *       multiple PG Tbls in one Page Frame
  *      =sweet side effect is avoiding calls to ugly page_address( ) from the
- *       pg-tlb allocator sub-sys (pte_alloc_one, ptr_free, pmd_populate
+ *       pg-tlb allocator sub-sys (pte_alloc_one, ptr_free, pmd_populate)
  *
  *  Amit Bhor, Sameer Dhavale: Codito Technologies 2004
  */
