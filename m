Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FBAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0823208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHXT1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:27:14 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:54330 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725976AbgHXT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:27:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4539D837F24F;
        Mon, 24 Aug 2020 19:27:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lunch29_4b01b2827055
X-Filterd-Recvd-Size: 2829
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Aug 2020 19:27:12 +0000 (UTC)
Message-ID: <37bbda0e0d94d3324210fa807f4061a9e9bd66bc.camel@perches.com>
Subject: Re: [PATCH] mm/mempool: Add 'else' to split mutually exclusive case
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 12:27:10 -0700
In-Reply-To: <20200824121840.4cd7eb3dce03e8e1473221b3@linux-foundation.org>
References: <20200824115354.7879-1-linmiaohe@huawei.com>
         <20200824121840.4cd7eb3dce03e8e1473221b3@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 12:18 -0700, Andrew Morton wrote:
> On Mon, 24 Aug 2020 07:53:54 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> > Add else to split mutually exclusive case and avoid some unnecessary check.
> > 
> > --- a/mm/mempool.c
> > +++ b/mm/mempool.c
> > @@ -60,9 +60,8 @@ static void check_element(mempool_t *pool, void *element)
> >  	/* Mempools backed by slab allocator */
> >  	if (pool->free == mempool_free_slab || pool->free == mempool_kfree)
> >  		__check_element(pool, element, ksize(element));
> > -
> >  	/* Mempools backed by page allocator */
> > -	if (pool->free == mempool_free_pages) {
> > +	else if (pool->free == mempool_free_pages) {
> >  		int order = (int)(long)pool->pool_data;
> >  		void *addr = kmap_atomic((struct page *)element);
> >  
> 
> It doesn't seem to change code generation (compiler is smart), but I
> think it helps readability.

style: braces should be added to the first test.

Perhaps better as:
---
 mm/mempool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 79bff63ecf27..d0206eab86a4 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -57,12 +57,12 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
 
 static void check_element(mempool_t *pool, void *element)
 {
-	/* Mempools backed by slab allocator */
-	if (pool->free == mempool_free_slab || pool->free == mempool_kfree)
+	if (pool->free == mempool_free_slab ||
+	    pool->free == mempool_kfree) {
+		/* Mempools backed by slab allocator */
 		__check_element(pool, element, ksize(element));
-
-	/* Mempools backed by page allocator */
-	if (pool->free == mempool_free_pages) {
+	} else if (pool->free == mempool_free_pages) {
+		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
 		void *addr = kmap_atomic((struct page *)element);
 


