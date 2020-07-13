Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8878BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B88E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594642138;
	bh=1qbvfcMKN5hP6zOyDUgdL4znQEsqmFuoCgnlTBk45c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xu1eNMqhxxEp058uhKLtTn18tNQ3kiJQjX6fSRLTUrL/zinBRTB/y1uK/iN2tjthe
	 NhxXuOnWqoiUFCM+37L32HTyGSbVnkDaCCmh3I3gLnnnFULWGhWClpfmSQiAiNzUs3
	 zarZUEsxGpoatOyWqOWQLoFHmwoK+uwxmMirymRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgGMMI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgGMMI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:08:57 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C956206F0;
        Mon, 13 Jul 2020 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594642136;
        bh=1qbvfcMKN5hP6zOyDUgdL4znQEsqmFuoCgnlTBk45c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARRPO0hM3y8uwt5JcDs+5sqPXZ3hHBPVOJ46tDyorL8sz4Bs1R8hgfjZDOYNei8fo
         gwttVzG88WukbjWmZ4IKta16HDiOLLztQ1vR8jhKYYeJxvfs8DfuXWLCTVj2MBDGXu
         UVgp5HqYslkA2AB+3T+V0xfVLYIDsnoW/qcY3JXE=
Date:   Mon, 13 Jul 2020 15:08:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        foersleo@amazon.de, irogers@google.com, jolsa@redhat.com,
        kirill@shutemov.name, mark.rutland@arm.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, sblbir@amazon.com,
        shakeelb@google.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        yang.shi@linux.alibaba.com, ying.huang@intel.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 01/14] mm/page_ext: Export lookup_page_ext() to GPL
 modules
Message-ID: <20200713120842.GA707159@kernel.org>
References: <20200713084144.4430-1-sjpark@amazon.com>
 <20200713084144.4430-2-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713084144.4430-2-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 13, 2020 at 10:41:31AM +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit exports 'lookup_page_ext()' to GPL modules.  It will be used
> by DAMON in following commit for the implementation of the region based
> sampling.

Maybe I'm missing something, but why is DAMON a module?

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Varad Gautam <vrd@amazon.de>
> ---
>  mm/page_ext.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index a3616f7a0e9e..9d802d01fcb5 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
>  					MAX_ORDER_NR_PAGES);
>  	return get_entry(base, index);
>  }
> +EXPORT_SYMBOL_GPL(lookup_page_ext);
>  
>  static int __init alloc_node_page_ext(int nid)
>  {
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
