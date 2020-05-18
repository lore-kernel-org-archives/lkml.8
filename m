Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB362C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F520758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SaXIVd6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERURn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgERURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:17:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B1C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tmfw6jv5c7I6nXp+B8iQMsgCtcPbXu8jo3om/FY1qFw=; b=SaXIVd6VivCdptFJVGlmWC8fzO
        Jx5YkkPhHKxbCKDyIvWNZndS6WIHBY41YhddYvOORXpZjVNSB9fZ4k0cO4itdlqeetvBqSwQTDqWA
        VGr3iSBcmHogXbbEh94LhIxMxonmwgetSILAc8bqM0WdlaOAl3S6OtrZyzAgzOaQGoZuR94WCmiCt
        PA+2xjYxgxbZyZd8d9HUY2eptNIceu74Y7YcM+KILfayp/FCkxSE0Rt9rb4wqMQUzah7umJqXwadI
        YA0vRnQcws0drKfTegKLFC9sc6aAKLbxa7CVJ42s/dha303uuMCvnIJOc2WZvN9YlYSpQ26Ur6G2Z
        fpW7w//w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jamCf-000670-KU; Mon, 18 May 2020 20:17:37 +0000
Date:   Mon, 18 May 2020 13:17:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/gup.c: Use gup_flags as parameter instead of passing
 write flag
Message-ID: <20200518201737.GV16070@bombadil.infradead.org>
References: <1589831903-27800-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589831903-27800-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 01:28:23AM +0530, Souptick Joarder wrote:
> The idea is to get rid of write parameter. Instead caller will pass
> FOLL_WRITE to __get_user_pages_fast(). This will not change any
> functionality of the API. Once it is upstream all the callers will
> be changed to pass FOLL_WRITE.

Uhh ... until you change all the callers, haven't you just broken all
the callers?

> -int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> -			  struct page **pages)
> +int __get_user_pages_fast(unsigned long start, int nr_pages,
> +			unsigned int gup_flags, struct page **pages)
>  {
>  	unsigned long len, end;
>  	unsigned long flags;
> @@ -2685,10 +2692,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
>  	 * because gup fast is always a "pin with a +1 page refcount" request.
>  	 */
> -	unsigned int gup_flags = FOLL_GET;
> -
> -	if (write)
> -		gup_flags |= FOLL_WRITE;
> +	gup_flags |= FOLL_GET;
