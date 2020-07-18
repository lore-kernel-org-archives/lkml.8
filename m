Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3365AC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1376D2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1zLd/On4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgGRCwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:52:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE52C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PmdHF489a27cE71jPgnHs7xUnlxXtCgBoKeQmnNIHB4=; b=1zLd/On4dUJk8xhA1C6EYdonKx
        j0lUxQI0A56F+wiYkKqOoc+T2NIGTPhzDPHgZzSOwHylPY4oZwP7RCutwF3s6gEUUEm4ILoPdTssc
        NClXZybIaHYelPMLzyXJn3dObcRvkSzsfKY+TNQmSgzc/aywz43cWwDZBCHj850WFZ2ybnBt1pGeW
        xGvWzY5HlMSq2Oaxx9q6AtEzbX7pNo7OCXmcDekBpTMHhSaWYChUqFyGTY4LizqylxYVvpMPE6/k4
        PUXAev9uUDm4z8SRNeRF3XSH5B0VLlcjGGBq+M3IQg39xjjXv4a7R1ccU9jGnG9eVNk15Eun9os6I
        IQ7UFsKg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwcxO-0006hT-GB; Sat, 18 Jul 2020 02:52:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] highmem: linux/highmem.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Message-ID: <57b70139-4f2d-c520-0882-f310c2b64b65@infradead.org>
Date:   Fri, 17 Jul 2020 19:52:07 -0700
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

Drop the doubled word "is" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/highmem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/highmem.h
+++ linux-next-20200714/include/linux/highmem.h
@@ -73,7 +73,7 @@ static inline void kunmap(struct page *p
  * no global lock is needed and because the kmap code must perform a global TLB
  * invalidation when the kmap pool wraps.
  *
- * However when holding an atomic kmap is is not legal to sleep, so atomic
+ * However when holding an atomic kmap is not legal to sleep, so atomic
  * kmaps are appropriate for short, tight code paths only.
  *
  * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap

