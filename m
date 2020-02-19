Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA936C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B592465A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBSAUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:20:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:62347 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgBSAUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:20:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 16:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="258738236"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 18 Feb 2020 16:20:05 -0800
Date:   Tue, 18 Feb 2020 16:20:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page-writeback.c: write_cache_pages(): deduplicate
 identical checks
Message-ID: <20200219002004.GC14509@iweiny-DESK2.sc.intel.com>
References: <20200218221716.1648-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218221716.1648-1-mfo@canonical.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:17:16PM -0300, Mauricio Faria de Oliveira wrote:
> There used to be a 'retry' label in between the two (identical) checks
> when first introduced in commit f446daaea9d4 ("mm: implement writeback
> livelock avoidance using page tagging"), and later modified/updated in
> commit 6e6938b6d313 ("writeback: introduce .tagged_writepages for the
> WB_SYNC_NONE sync stage").
> 
> The label has been removed in commit 64081362e8ff ("mm/page-writeback.c:
> fix range_cyclic writeback vs writepages deadlock"), and the (identical)
> checks are now present / performed immediately one after another.
> 
> So, remove/deduplicate the latter check, moving tag_pages_for_writeback()
> into the former check before the 'tag' variable assignment, so it's clear
> that it's not used in this (similarly-named) function call but only later
> in pagevec_lookup_range_tag().
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
>  v2: add the missing braces to the conditional statement
>      with more than a single statement.. doh; and to the
>      else branch (w/a single statement, per coding style.)
> 
>  mm/page-writeback.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 2caf780a42e7..ab5a3cee8ad3 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2182,12 +2182,12 @@ int write_cache_pages(struct address_space *mapping,
>  		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>  			range_whole = 1;
>  	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
> +		tag_pages_for_writeback(mapping, index, end);
>  		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> +	} else {
>  		tag = PAGECACHE_TAG_DIRTY;
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag_pages_for_writeback(mapping, index, end);
> +	}
>  	done_index = index;
>  	while (!done && (index <= end)) {
>  		int i;
> -- 
> 2.20.1
> 
