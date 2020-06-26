Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA44206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EULyogCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFZUPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZUPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:15:47 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01335C03E97B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lzG6AjqURuPpzOdjQIJr5ziJhpZEP90OSuws6+uc9do=; b=EULyogCZ+vLnQ4vDdeO645I49c
        JCAzn9PSGanMWl3T93Kz8kXyJ7uKVwdhM4UZsYD5GHb1UXcPqsPXegzFnQvYxhiERvpQtQjv6tPxc
        a2HA6+xE/ZKKyk3hX3tA/rJ/zhCxMjNTEyMahbn6cmJhk2nMEBYBNnXZoCHpBf+DyVkuMizbm1k7M
        XdBNDQjUHhWYTns2tUByMF/Sjt/X2UZra229XVHSrXmFaszMcIvGK4cId92eLFduTgxzal7ZhLpoE
        1JWXw9/jquv7jykijTV1/gl2o+a0BW3BKjA3m4lyTZ3nTReMy72U7zaoi9TdeC0MgdshRslLbGiz8
        FoB3Xbmw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joukt-0000NC-S3; Fri, 26 Jun 2020 20:15:25 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -mmotm] mm: memory-failure: add stub for page_handle_poison()
Message-ID: <5bc95fd0-4c21-59c3-4629-7b6848b6a399@infradead.org>
Date:   Fri, 26 Jun 2020 13:15:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a build error when no HWPOISON kconfig symbols are set/enabled
by providing a stub function for 'page_handle_poison()'.

../mm/memory-failure.c: In function ‘__soft_offline_page’:
../mm/memory-failure.c:1827:3: error: implicit declaration of function ‘page_handle_poison’; did you mean ‘page_init_poison’? [-Werror=implicit-function-declaration]
   page_handle_poison(page, false, true);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c |    5 +++++
 1 file changed, 5 insertions(+)

--- mmotm-2020-0625-2036.orig/mm/memory-failure.c
+++ mmotm-2020-0625-2036/mm/memory-failure.c
@@ -200,6 +200,11 @@ int hwpoison_filter(struct page *p)
 {
 	return 0;
 }
+
+static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
+{
+	return true;
+}
 #endif
 
 EXPORT_SYMBOL_GPL(hwpoison_filter);

