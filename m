Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B15BC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 04:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90F20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 04:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WQslhNWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDHEaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:30:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgDHEaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 00:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BEquI+4lstFA/zdETWPYXXXk59o52DQLY6S3OE0zmY0=; b=WQslhNWq6Kp4oZKzq9nvfn7v1C
        6VSTHsiDuNwUunUYqQAlLLdglxkLC9Wn9mj6Nd29e8AeERWeJWK0SNVpcLadAe9ML1YmBo62x6UDk
        T82yasJVNBJkI7NavPpjNLqBOMPCJjK9QkCtyiPQJEPgt3xwveYiXKjzFShX+sB6ae3CXzqbGP0D0
        kZk6mpHrO3/6WoYuissRx5dPvUDJOEn/Sc8aEAOomOk+OShvLpoSK/FF6meTN5Z+M35PgsUW0msHk
        RDa6Bt+hSbwl5CEZt26xHHjc8/8rTaNSJ8iwRg0nJsUNvk2hv/LWfY6PtePfGCB+NmYZOHVxjLpwy
        yRtWj9wg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM2Lg-00087s-W0; Wed, 08 Apr 2020 04:30:01 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] mm: page_alloc: fix kernel-doc warning
Message-ID: <02998bd4-0b82-2f15-2570-f86130304d1e@infradead.org>
Date:   Tue, 7 Apr 2020 21:29:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add description of function parameter 'mt' to fix kernel-doc warning:

../mm/page_alloc.c:3246: warning: Function parameter or member 'mt' not described in '__putback_isolated_page'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 mm/page_alloc.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200407.orig/mm/page_alloc.c
+++ linux-next-20200407/mm/page_alloc.c
@@ -3238,6 +3238,7 @@ int __isolate_free_page(struct page *pag
  * __putback_isolated_page - Return a now-isolated page back where we got it
  * @page: Page that was isolated
  * @order: Order of the isolated page
+ * @mt: The page's pageblock's migratetype
  *
  * This function is meant to return a page pulled from the free lists via
  * __isolate_free_page back to the free lists they were pulled from.

