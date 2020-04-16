Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0594C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BDF206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404839AbgDPAok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:44:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:6004 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404680AbgDPAoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:44:34 -0400
IronPort-SDR: 5OWOdHQTfBj8JBjKbRtro52wXfjxIhjQ+gY/OR7nbZtlSycagzTRZ8NtBC3QL036Ujx03TUdfr
 AMWeCBIFeszQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 17:44:31 -0700
IronPort-SDR: LP1ZX19PIRLq3IQP8QvX+QBzgBj0twgbyBMruwkfFconOhZcQs0SRky7gY3uTsjQUgnVwPt8ky
 2pLK6B6D2yuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="427636809"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2020 17:44:29 -0700
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
        <87imi1yz07.fsf@yhuang-dev.intel.com> <20200415091948.GH810380@xps-13>
Date:   Thu, 16 Apr 2020 08:44:28 +0800
In-Reply-To: <20200415091948.GH810380@xps-13> (Andrea Righi's message of "Wed,
        15 Apr 2020 11:19:48 +0200")
Message-ID: <87wo6gxnrn.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> On Wed, Apr 15, 2020 at 03:44:08PM +0800, Huang, Ying wrote:
>> Andrea Righi <andrea.righi@canonical.com> writes:
>> 
>> >  mm/swapfile.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > index 9fd47e6f7a86..cb9eb517178d 100644
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -1944,7 +1944,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>> >  		vmf.pmd = pmd;
>> >  		last_ra = atomic_read(&last_readahead_pages);
>> >  		atomic_set(&swapin_readahead_hits, last_ra);
>> 
>> You need to remove the above 2 lines firstly.
>
> Meh... too much enthusiasm, and I definitely need more coffee this
> morning. Here's the right patch applied:
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5871a2aa86a5..8b38441b66fa 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1940,7 +1940,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  		vmf.vma = vma;
>  		vmf.address = addr;
>  		vmf.pmd = pmd;
> -		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
> +		page = lookup_swap_cache(entry, vma, addr);
> +		if (!page)
> +			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);

The vmf assignment can be moved inside "if" block.  Otherwise the patch
looks good to me.

>  		if (!page) {
>  			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
>  				goto try_next;
>
> And following the right results:
>
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> 	COUNT      EVENT
> 	1618       $retval = 1
> 	4960       $retval = 2
> 	41315      $retval = 4
> 	103521     $retval = 8
>
> swapoff time: 12.19s
>
> So, not as good as the fixed-size readahead, but it's definitely an
> improvement, considering that the swapoff time is ~22s without this
> patch applied.
>
> I think this change can be a simple and reasonable compromise.

Yes.  I think so too.

Best Regards,
Huang, Ying

> Thanks again and sorry for the noise,
> -Andrea
