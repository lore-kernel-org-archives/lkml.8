Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3E7C38A2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1EB20768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586900447;
	bh=OfJu1/oupH8M6xcgfPxtGU4BaAPtFLjk7IzN5xySeSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7WQIpBWWzh72sRc6wtVFGYgZ2s8XFSLFUNFLbRr53o/LZ+RsfGtbab+/x3dOuDam
	 6wLJz3rneh2L9FW2ZWieJTEO3CM5sQa6S3dHrZ4az7QudxP+yaF++KZILeJ4unUYtR
	 oDO9ec33RjzLY2qdPFTzlrtJ2+YpPFac1S4Hsmd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633989AbgDNVkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbgDNVkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:40:22 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9392076B;
        Tue, 14 Apr 2020 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586900422;
        bh=OfJu1/oupH8M6xcgfPxtGU4BaAPtFLjk7IzN5xySeSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aoMwkqgR4XKfLJnPFAuGZ8WduuZekzhADcKXqhg2LWjY+JzXsd9ffmeEYQDxdotXO
         t5gJeJxSTQ3I0/OlwJSuQl1VJLyg5OGZCap8KimzYtyL7L4Zs+87x03vcq5TISby9J
         9ks0ai51hG1UEqZa041Ywl7zSTGAIN/4g13IlG9k=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        sparclinux@vger.kernel.org, kernel-team@android.com
Subject: [RESEND PATCH 1/4] sparc32: mm: Fix argument checking in __srmmu_get_nocache()
Date:   Tue, 14 Apr 2020 22:40:08 +0100
Message-Id: <20200414214011.2699-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414214011.2699-1-will@kernel.org>
References: <20200414214011.2699-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'size' argument to __srmmu_get_nocache() is a number of bytes not
a shift value, so fix up the sanity checking to treat it properly.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/mm/srmmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b7c94de70cca..cb9ded8a68b7 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -175,18 +175,18 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
  */
 static void *__srmmu_get_nocache(int size, int align)
 {
-	int offset;
+	int offset, minsz = 1 << SRMMU_NOCACHE_BITMAP_SHIFT;
 	unsigned long addr;
 
-	if (size < SRMMU_NOCACHE_BITMAP_SHIFT) {
+	if (size < minsz) {
 		printk(KERN_ERR "Size 0x%x too small for nocache request\n",
 		       size);
-		size = SRMMU_NOCACHE_BITMAP_SHIFT;
+		size = minsz;
 	}
-	if (size & (SRMMU_NOCACHE_BITMAP_SHIFT - 1)) {
-		printk(KERN_ERR "Size 0x%x unaligned int nocache request\n",
+	if (size & (minsz - 1)) {
+		printk(KERN_ERR "Size 0x%x unaligned in nocache request\n",
 		       size);
-		size += SRMMU_NOCACHE_BITMAP_SHIFT - 1;
+		size += minsz - 1;
 	}
 	BUG_ON(align > SRMMU_NOCACHE_ALIGN_MAX);
 
-- 
2.26.0.110.g2183baf09c-goog

