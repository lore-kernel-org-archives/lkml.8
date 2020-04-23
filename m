Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE27C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11542098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDWM0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726789AbgDWM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:26:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA68C08E934;
        Thu, 23 Apr 2020 05:26:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRawC-0005GC-Ry; Thu, 23 Apr 2020 14:26:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5966D1C0244;
        Thu, 23 Apr 2020 14:26:40 +0200 (CEST)
Date:   Thu, 23 Apr 2020 12:26:39 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Use pgprotval_t in protval_4k_2_large() and
 protval_large_2_4k()
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200422170116.GA28345@lst.de>
References: <20200422170116.GA28345@lst.de>
MIME-Version: 1.0
Message-ID: <158764479990.28353.14903341506618201022.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     325518e9b743686f471e7a4ef617b57c91386795
Gitweb:        https://git.kernel.org/tip/325518e9b743686f471e7a4ef617b57c91386795
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 22 Apr 2020 18:53:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Apr 2020 11:38:42 +02:00

x86/mm: Use pgprotval_t in protval_4k_2_large() and protval_large_2_4k()

Use the proper type for "raw" page table values.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200422170116.GA28345@lst.de
---
 arch/x86/include/asm/pgtable_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 567abdb..7b6ddcf 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -478,7 +478,7 @@ static inline pteval_t pte_flags(pte_t pte)
 
 unsigned long cachemode2protval(enum page_cache_mode pcm);
 
-static inline unsigned long protval_4k_2_large(unsigned long val)
+static inline pgprotval_t protval_4k_2_large(pgprotval_t val)
 {
 	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
 		((val & _PAGE_PAT) << (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
@@ -487,7 +487,7 @@ static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
 {
 	return __pgprot(protval_4k_2_large(pgprot_val(pgprot)));
 }
-static inline unsigned long protval_large_2_4k(unsigned long val)
+static inline pgprotval_t protval_large_2_4k(pgprotval_t val)
 {
 	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
 		((val & _PAGE_PAT_LARGE) >>
