Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF387C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4E72187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581648915;
	bh=lQDKYAfbCVYkA0WiWbRnkihwJDNeJ9WI1ZHWRFRZfp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jpaJSIiiL4E5ip2TVPG5RGRWCfN86xZT+wFwjUKA62GdssH8epQmSgqhn2/LGhJpx
	 JBAXEr+fsrziayfeieNYJ8T5jsR1vZ2wshZdhQz2B2Cchswtf4Rg+vSGHdhEjyPE9R
	 XchjSwoK2ce0JmZLc1JVcpWfzAstOjDoA7tMInZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgBNCzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNCzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:55:14 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718BB2168B;
        Fri, 14 Feb 2020 02:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581648912;
        bh=lQDKYAfbCVYkA0WiWbRnkihwJDNeJ9WI1ZHWRFRZfp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V26bRk+BUYMdbQqNQyDqSi8eyS8yH4pDIs4smYhZ2SbGazHJkvd++D105I185t9G8
         WPwtRBVxjpFV7sXn55HriYsdol54A6FxY9NVI5h5DEjOzaTPFk/o1w1gUiLCBE4m7D
         Or7O57tp9EiQk8Bgv0HtYmDVDG42qJo707k+2UdQ=
Date:   Thu, 13 Feb 2020 18:55:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     willy@infradead.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate.c: migrate PG_readahead flag
Message-Id: <20200213185511.4660aca17553562d764dc7ea@linux-foundation.org>
In-Reply-To: <1581640185-95731-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1581640185-95731-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 08:29:45 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Currently migration code doesn't migrate PG_readahead flag.
> Theoretically this would incur slight performance loss as the
> application might have to ramp its readahead back up again.  Even though
> such problem happens, it might be hidden by something else since
> migration is typically triggered by compaction and NUMA balancing, any
> of which should be more noticeable.
> 
> Migrate the flag after end_page_writeback() since it may clear
> PG_reclaim flag, which is the same bit as PG_readahead, for the new
> page.
> 
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -647,6 +647,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
>  	if (PageWriteback(newpage))
>  		end_page_writeback(newpage);
>  
> +	/*
> +	 * PG_readahead share the same bit with PG_reclaim, the above
> +	 * end_page_writeback() may clear PG_readahead mistakenly, so set
> +	 * the bit after that.
> +	 */
> +	if (PageReadahead(page))
> +		SetPageReadahead(newpage);
> +
>  	copy_page_owner(page, newpage);
>  

Why not

  	if (PageWriteback(newpage)) {
  		end_page_writeback(newpage);
		/*
		 * PG_readahead share the same bit with PG_reclaim, the above
		 * end_page_writeback() may clear PG_readahead mistakenly, so
		 * set the bit after that.
		 */
		if (PageReadahead(page))
			SetPageReadahead(newpage);
	}

?
