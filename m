Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E715BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA0F2070C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZCA3cyUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGZAcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:32:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A61C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rD4MBwzb8VJHKl1gycQF4Ap/2qNTaWEJ+pUmhGZKJmg=; b=ZCA3cyUs6mYJ61gy4gvWyH1uPl
        Qgo8ANIdxdNHBceyAV8dG81e3mKGMCpo0bMZJ25djMw2cinvY2WkzVaSfC5dQVqkqDwnNrQkOVLm6
        isyyuphzOUeRlfBR5ZgkbWok0TDHKO+4swDoD51ZBYMtEojfileDXp8OtYrssyRm2/ZuUeeYWNuVm
        koaXNms1jTfA1Qo6/A+gCzMcqO4iSqrv5uw/kivY2/D0QfT0vQ1BzZN4SPQ95LrzWKswdeioaTduU
        STpMeuU2Zr+FM4Co4X66jH8lnvCvTG6Gsb/YLW2iBNOzZPKpfLyBHaqf1po/q59twToep5TJK68Te
        2KCG3ocQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUaN-0002x2-Qd; Sun, 26 Jul 2020 00:32:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: sigcontext.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:32:07 -0700
Message-Id: <20200726003207.20253-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003207.20253-1-rdunlap@infradead.org>
References: <20200726003207.20253-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/uapi/asm/sigcontext.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/arm64/include/uapi/asm/sigcontext.h
+++ linux-next-20200720/arch/arm64/include/uapi/asm/sigcontext.h
@@ -179,7 +179,7 @@ struct sve_context {
  * The same convention applies when returning from a signal: a caller
  * will need to remove or resize the sve_context block if it wants to
  * make the SVE registers live when they were previously non-live or
- * vice-versa.  This may require the the caller to allocate fresh
+ * vice-versa.  This may require the caller to allocate fresh
  * memory and/or move other context blocks in the signal frame.
  *
  * Changing the vector length during signal return is not permitted:
