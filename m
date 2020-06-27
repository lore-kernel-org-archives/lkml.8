Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91452C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E42720E65
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsThSYYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgF0EzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgF0EzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:55:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B18C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:55:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f6so1769552pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+gA6TTWkMdHm5W4oJu5q0X2lUIi1w6v+kFfwKgYQFdw=;
        b=gsThSYYldvqlflGoCnyy6zhApgX1N1u4QndX5Ni5Ms9mflGFUYO7UxSjcngrtpUogE
         J0AOVFtzY1BYqTfXflC1HZBj2Gins8ECuvRTjVm3TcTy0KiiJnSliEF6E5bPN/WxTFTO
         icLy4DOWwVq8Dz6CJCYJum7AbZUs25BigtbQKmwIm+F7lEhWl3liPLkv4pR1w8mmlBQ8
         NcPiRSr3Wot1j4JQ2BWXYRLtEurhVrSz6w5SYxdnS0EHf7lW7gSqCI0aLGlgT8TfFbcz
         GBMm44neagmza+5UMkSC+kE0szE5T6SZsV8f82olXxckz04SFelkGHnkDT3790KSlk14
         J+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+gA6TTWkMdHm5W4oJu5q0X2lUIi1w6v+kFfwKgYQFdw=;
        b=TVhhjqS2KVcMxNTWPvIVNGXWeSd/FlVp1Pc4Y1FB8wCOgmnTvZFiddi7rrkiveEKnp
         +sGx2pt8b28S1pnxk8G26fZWJsASTqDIHnnfYx/C+Lw/Q/ewwfwnxPm1KsrtQsEEdtDi
         MTHNWvy70VzWRjkn25krmuZBa5cHSdl+7DeQtkM1wCQn4i8z7cBkpegGE6KNlJ+zIudp
         T0plvqz/1+7IegLZ3rcbHdRHb5qx1JGO18MTHdJhPhDXMaO73hO0MJZaujuVh97Ojofx
         wSlZWhRrGpg5lCjJuhoixGYenjaA7i8FpCh8ebEP87dXHxfMhtXFaRWSggPRO3XxIegr
         jTGg==
X-Gm-Message-State: AOAM532g1wO9gAZ8yUzZrlSYD5lwMKbotjMZ2hnUPCwr3mWmdpIsLxcw
        H5GWXjDd4smt2EJ2WELDieI=
X-Google-Smtp-Source: ABdhPJx3mWKJGR86Eb7qOI9bQqp5l2FYg+gm5648darG2hlNHr2XfBF/bQlTYhbohm1zrtiHXTBoXA==
X-Received: by 2002:a17:902:9a89:: with SMTP id w9mr5518433plp.30.1593233716796;
        Fri, 26 Jun 2020 21:55:16 -0700 (PDT)
Received: from localhost ([144.34.187.180])
        by smtp.gmail.com with ESMTPSA id u8sm26859976pfh.215.2020.06.26.21.55.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 21:55:16 -0700 (PDT)
Date:   Sat, 27 Jun 2020 04:55:07 +0000
From:   Long Li <lonuxli.64@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm:free unused pages in kmalloc_order
Message-ID: <20200627045507.GA57675@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Environment using the slub allocator, 1G memory in my ARM32.
kmalloc(1024, GFP_HIGHUSER) can allocate memory normally,
kmalloc(64*1024, GFP_HIGHUSER) will cause a memory leak, because
alloc_pages returns highmem physical pages, but it cannot be directly
converted into a virtual address and return NULL, the pages has not
been released. Usually driver developers will not use the
GFP_HIGHUSER flag to allocate memory in kmalloc, but I think this
memory leak is not perfect, it is best to be fixed. This is the
first time I have posted a patch, there may be something wrong.

Signed-off-by: Long Li <lonuxli.64@gmail.com>
---
 mm/slab_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a143a8c8f874..d2c53b980ab3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -819,8 +819,12 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	page = alloc_pages(flags, order);
 	if (likely(page)) {
 		ret = page_address(page);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
-				    PAGE_SIZE << order);
+		if (ret)
+			mod_node_page_state(page_pgdat(page),
+					NR_SLAB_UNRECLAIMABLE_B,
+					PAGE_SIZE << order);
+		else
+			__free_pages(page, order);
 	}
 	ret = kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
-- 
2.17.1

