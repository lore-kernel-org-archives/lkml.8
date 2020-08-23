Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCCDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC2920723
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jKqRfFAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHWEFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 00:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:05:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5A0C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kIwBa05m/iJNR/Pys23UU7wGtxarpEXkcKhDd8QDpP4=; b=jKqRfFABiSQ8rD3e6i5uxdtEGr
        elKO12fEj3h6zQZs0VO9HX1DOoZWunDR01GtYBxS1LHSJ3KrWV62wzJy6AqfxPlMtYeQBcE3ifpMJ
        HJckULwjfAXTR4I1sUVvaSPZfA+CuGBKwudwqdQJ1jdtU1ndRRgefZiHTEhHl4jXwbfjaNjPyfnDe
        xF95w3QOYSSN2D/lQhQLgJlSvGdGxQS5LvocD9rOClTxYR9mv+qmXiNp8qU9+HLRBxsiTkQmojn+F
        lOyNezmQsl5WPWeBiiymC7PIyZNhFSWvkFZmxvZG9UwHr4AZOn3c3xd1T+xv6YiYSyjC1dowQ+dhi
        yRRVzIcA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFb-0004qh-QM; Sun, 23 Aug 2020 04:05:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH] lib: earlycpio: delete duplicated words
Date:   Sat, 22 Aug 2020 21:04:55 -0700
Message-Id: <20200823040455.25995-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: H. Peter Anvin <hpa@linux.intel.com>
---
 lib/earlycpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/earlycpio.c
+++ linux-next-20200730/lib/earlycpio.c
@@ -42,7 +42,7 @@ enum cpio_fields {
 /**
  * cpio_data find_cpio_data - Search for files in an uncompressed cpio
  * @path:       The directory to search for, including a slash at the end
- * @data:       Pointer to the the cpio archive or a header inside
+ * @data:       Pointer to the cpio archive or a header inside
  * @len:        Remaining length of the cpio based on data pointer
  * @nextoff:    When a matching file is found, this is the offset from the
  *              beginning of the cpio to the beginning of the next file, not the
