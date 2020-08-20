Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B2A2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597941993;
	bh=1N4N7lW5MVeLs+DqxzXoSXZiWCLJTm8mjKFiKJLpIcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UbjuzP+Awepcn3jqmzdS6WyU/qL4F9k8yoOIhuAgRnXpb69h8McKpcmEXbcO5XKgO
	 Uc6m2g8vsGfSZNp5TxnsAyfjF8gA1KSwEAPNE7R6B8gNKaEGwpXvpChILlLlBDS5F1
	 73lriE5vEacsCAKPLgoA06UpfXzhjgCW+8maMWy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgHTQqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbgHTQpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:45:52 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8772072D;
        Thu, 20 Aug 2020 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597941952;
        bh=1N4N7lW5MVeLs+DqxzXoSXZiWCLJTm8mjKFiKJLpIcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YI1lMpQ4VlBBR7pv5QltUyex6A4bRfzFzEpfHU+BoCNdlVbw1FrRqUoIFWm3K3AmE
         FY/VxPwbBqLbp0Xf8kJ+AsgEqs2HjLtpGdq5ycv4mNAox16v3jUFjumWQ1TzGQQsey
         8wENiwNf7L49yqW0jN24Ri+ezJhG/nUAMRAeawso=
Date:   Thu, 20 Aug 2020 19:45:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm: Rewrite shmem_seek_hole_data
Message-ID: <20200820164546.GD752365@kernel.org>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819150555.31669-3-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 04:05:50PM +0100, Matthew Wilcox (Oracle) wrote:
> use the XArray directly instead of using the pagevec abstraction.
> The code is simpler and more efficient.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/shmem.c | 61 +++++++++++++++++++++---------------------------------
>  1 file changed, 24 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a7bbc4ed9677..0f9f149f4b5e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2659,53 +2659,40 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  }
>  
>  /*
> - * llseek SEEK_DATA or SEEK_HOLE through the page cache.
> + * llseek SEEK_DATA or SEEK_HOLE through the page cache.  We don't need
> + * to get a reference on the page because this interface is racy anyway.
> + * The page we find will have had the state at some point.

For my non-native ear "will have had" is too complex ;-)

>   */
>  static pgoff_t shmem_seek_hole_data(struct address_space *mapping,
>  				    pgoff_t index, pgoff_t end, int whence)
>  {
> +	XA_STATE(xas, &mapping->i_pages, index);
>  	struct page *page;
> -	struct pagevec pvec;
> -	pgoff_t indices[PAGEVEC_SIZE];
> -	bool done = false;
> -	int i;
>  
> -	pagevec_init(&pvec);
> -	pvec.nr = 1;		/* start small: we may be there already */
> -	while (!done) {
> -		pvec.nr = find_get_entries(mapping, index,
> -					pvec.nr, pvec.pages, indices);
> -		if (!pvec.nr) {
> -			if (whence == SEEK_DATA)
> -				index = end;
> -			break;
> +	rcu_read_lock();
> +	if (whence == SEEK_DATA) {
> +		for (;;) {
> +			page = xas_find(&xas, end);
> +			if (xas_retry(&xas, page))
> +				continue;
> +			if (!page || xa_is_value(page) || PageUptodate(page))
> +				break;
>  		}
> -		for (i = 0; i < pvec.nr; i++, index++) {
> -			if (index < indices[i]) {
> -				if (whence == SEEK_HOLE) {
> -					done = true;
> -					break;
> -				}
> -				index = indices[i];
> -			}
> -			page = pvec.pages[i];
> -			if (page && !xa_is_value(page)) {
> -				if (!PageUptodate(page))
> -					page = NULL;
> -			}
> -			if (index >= end ||
> -			    (page && whence == SEEK_DATA) ||
> -			    (!page && whence == SEEK_HOLE)) {
> -				done = true;
> +	} else /* SEEK_HOLE */ {
> +		for (;;) {
> +			page = xas_next(&xas);
> +			if (xas_retry(&xas, page))
> +				continue;
> +			if (!xa_is_value(page) &&
> +					(!page || !PageUptodate(page)))
> +				break;
> +			if (xas.xa_index >= end)
>  				break;
> -			}
>  		}
> -		pagevec_remove_exceptionals(&pvec);
> -		pagevec_release(&pvec);
> -		pvec.nr = PAGEVEC_SIZE;
> -		cond_resched();
>  	}
> -	return index;
> +	rcu_read_unlock();
> +
> +	return xas.xa_index;
>  }
>  
>  static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
> -- 
> 2.28.0
> 
> 

-- 
Sincerely yours,
Mike.
