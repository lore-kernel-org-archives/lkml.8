Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE8C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A291A206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635265AbgDOHoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:44:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:35275 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635245AbgDOHoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:44:12 -0400
IronPort-SDR: 4Aht1Cit3gqBivU5pF6Jr3CMKVSvsv2blI2vMI4xYfedGOcdRp3FU7PNJLihdDXQTvImQS4Hca
 KDVM6hxMviEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 00:44:11 -0700
IronPort-SDR: xG888X2yA7QrY0sNtoht0u4esMcn2G+GOhx/16MnoB2aXnYmjAV3LwZ4oJU9DfgrThk0bRYSas
 Q1macOKatCgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="253447153"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 00:44:09 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
References: <20200413111810.GA801367@xps-13>
        <87a73f7d71.fsf@yhuang-dev.intel.com> <20200413133150.GA810380@xps-13>
        <87wo6i6efn.fsf@yhuang-dev.intel.com> <20200414130520.GF810380@xps-13>
        <87v9m1zd83.fsf@yhuang-dev.intel.com> <20200415073239.GG810380@xps-13>
Date:   Wed, 15 Apr 2020 15:44:08 +0800
In-Reply-To: <20200415073239.GG810380@xps-13> (Andrea Righi's message of "Wed,
        15 Apr 2020 09:32:39 +0200")
Message-ID: <87imi1yz07.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

>  mm/swapfile.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9fd47e6f7a86..cb9eb517178d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1944,7 +1944,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  		vmf.pmd = pmd;
>  		last_ra = atomic_read(&last_readahead_pages);
>  		atomic_set(&swapin_readahead_hits, last_ra);

You need to remove the above 2 lines firstly.

Best Regards,
Huang, Ying

> -		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
> +		page = lookup_swap_cache(entry, vma, addr);
> +		if (!page)
> +			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
>  		if (!page) {
>  			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
>  				goto try_next;
>
> Thanks!
> -Andrea
