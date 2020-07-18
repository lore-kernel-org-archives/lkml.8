Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2CBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 03:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849BB2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 03:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BILag9yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgGRDEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 23:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRDEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 23:04:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD175C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 20:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7RUTSYbxVy6xT6xvpnV+itvZ5yKCz5OATkrmrwQ0Q8M=; b=BILag9ywRcnycQlUa9wZ+kBpv3
        nrm6vDjOdI71kAqgp4sGvi98p/tTueXBaf2xxjCy1zoW7cR3jhG4x+ngNwqCE/7GetjKGXPftYU/H
        vVnmDbKXga0SliMkib9wyWY5/66rO82AXKjOkirz3P+O0ensca0fvRigmHuJl9KRUnz3QsnvletBp
        j74tx2Y/MrAeAABIZZTXni9IgmPztidqyGucU1y9oAd8f6BSsb2XyH7f5Raj6cZiU88T5X/tod3ZG
        G+1bABvp8+bM8ypeN7Voe8qsW9bR4F7ohVr5XIILhppLyeLQ8cHKcmUbyMOIATAl6Eh2QRb/gjHAX
        jkWoIqzw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwd8v-0007bb-Ms; Sat, 18 Jul 2020 03:04:06 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] highmem: linux/highmem.h: fix duplicated words in a
 comment
Message-ID: <ad605959-0083-4794-8d31-6b073300dd6f@infradead.org>
Date:   Fri, 17 Jul 2020 20:04:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Change the doubled word "is" in a comment to "it is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
v2: instead of dropping one "is", change to "it is" [thanks Willy]

 include/linux/highmem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/highmem.h
+++ linux-next-20200714/include/linux/highmem.h
@@ -73,7 +73,7 @@ static inline void kunmap(struct page *p
  * no global lock is needed and because the kmap code must perform a global TLB
  * invalidation when the kmap pool wraps.
  *
- * However when holding an atomic kmap is is not legal to sleep, so atomic
+ * However when holding an atomic kmap it is not legal to sleep, so atomic
  * kmaps are appropriate for short, tight code paths only.
  *
  * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap

