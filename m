Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9ABC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E239D2070E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oag5TOk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGZAcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:32:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E9C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oii4LBL1NkYW6Lvx3U7a5RL6ppKxaExqdGAXmKNK+jk=; b=Oag5TOk3soHACnJ/wlMmJ9ha04
        A6+G71xfZgvOjfmstcsRVm0OAW6DgeYHDxg+HZ5ttw63h5ykWUGR+GJePahISp77G1RcUJ0jEvxok
        ytdcafYXnl+Bski4pZ33RFQJeXE22EuVTdH1wY+5uNIO7oVDJQRio+2QgV6DTaiHo1oVgFWy/9WJV
        pRkLVvHrI6fyGVBrnUJi7AYkeQW8cSO9ShzIbdMpdiA+GYctdL6VxkYSonJS+Ju4SmUmXkRhTqtlP
        vshWaHNTBmWbOeiPJAiQiUYs55VbhrNtXzOOEM4lPxxPEGNPm5lnLTa+K9tMTWeeTJkh9/8Cqou+n
        ZnlUZPsQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUaK-0002x2-6l; Sun, 26 Jul 2020 00:32:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm64: pgtable-hwdef.h: delete duplicated words
Date:   Sat, 25 Jul 2020 17:32:05 -0700
Message-Id: <20200726003207.20253-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003207.20253-1-rdunlap@infradead.org>
References: <20200726003207.20253-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words "at" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgtable-hwdef.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200720.orig/arch/arm64/include/asm/pgtable-hwdef.h
+++ linux-next-20200720/arch/arm64/include/asm/pgtable-hwdef.h
@@ -29,7 +29,7 @@
  * Size mapped by an entry at level n ( 0 <= n <= 3)
  * We map (PAGE_SHIFT - 3) at all translation levels and PAGE_SHIFT bits
  * in the final page. The maximum number of translation levels supported by
- * the architecture is 4. Hence, starting at at level n, we have further
+ * the architecture is 4. Hence, starting at level n, we have further
  * ((4 - n) - 1) levels of translation excluding the offset within the page.
  * So, the total number of bits mapped by an entry at level n is :
  *
@@ -98,7 +98,7 @@
 #define CONT_PMDS		(1 << (CONT_PMD_SHIFT - PMD_SHIFT))
 #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
 #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
-/* the the numerical offset of the PTE within a range of CONT_PTES */
+/* the numerical offset of the PTE within a range of CONT_PTES */
 #define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_PTES-1))
 
 /*
