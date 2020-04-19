Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11C0C38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 23:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963462073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 23:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDSXzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 19:55:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:11903 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgDSXzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 19:55:19 -0400
IronPort-SDR: niSQLpUn1pK78QqGfheO+K3BM+ebwyV4YclY94gFwYa0v/Qa189HVKDvNCQlD/7mlJrDF6Q/iI
 0kx1lLyNAUxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 16:55:18 -0700
IronPort-SDR: sZ1G3kofgHfIoBQELUN/HRqZRv78d/mbOfOSsLspYbAWiigElMDYY7acOlYIDPk08UoO8NJpZc
 OnFXbs9/UkUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,404,1580803200"; 
   d="scan'208";a="254776055"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2020 16:55:16 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm: swap: properly update readahead statistics in unuse_pte_range()
References: <20200418084705.GA147642@xps-13>
Date:   Mon, 20 Apr 2020 07:55:16 +0800
In-Reply-To: <20200418084705.GA147642@xps-13> (Andrea Righi's message of "Sat,
        18 Apr 2020 10:47:05 +0200")
Message-ID: <87o8rnt4ij.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> In unuse_pte_range() we blindly swap-in pages without checking if the
> swap entry is already present in the swap cache.
>
> By doing this, the hit/miss ratio used by the swap readahead heuristic
> is not properly updated and this leads to non-optimal performance during
> swapoff.
>
> Tracing the distribution of the readahead size returned by the swap
> readahead heuristic during swapoff shows that a small readahead size is
> used most of the time as if we had only misses (this happens both with
> cluster and vma readahead), for example:
>
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
>         COUNT      EVENT
>         36948      $retval = 8
>         44151      $retval = 4
>         49290      $retval = 1
>         527771     $retval = 2
>
> Checking if the swap entry is present in the swap cache, instead, allows
> to properly update the readahead statistics and the heuristic behaves in
> a better way during swapoff, selecting a bigger readahead size:
>
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
>         COUNT      EVENT
>         1618       $retval = 1
>         4960       $retval = 2
>         41315      $retval = 4
>         103521     $retval = 8
>
> In terms of swapoff performance the result is the following:
>
> Testing environment
> ===================
>
>  - Host:
>    CPU: 1.8GHz Intel Core i7-8565U (quad-core, 8MB cache)
>    HDD: PC401 NVMe SK hynix 512GB
>    MEM: 16GB
>
>  - Guest (kvm):
>    8GB of RAM
>    virtio block driver
>    16GB swap file on ext4 (/swapfile)
>
> Test case
> =========
>  - allocate 85% of memory
>  - `systemctl hibernate` to force all the pages to be swapped-out to the
>    swap file
>  - resume the system
>  - measure the time that swapoff takes to complete:
>    # /usr/bin/time swapoff /swapfile
>
> Result (swapoff time)
> ======
>                   5.6 vanilla   5.6 w/ this patch
>                   -----------   -----------------
> cluster-readahead      22.09s              12.19s
>     vma-readahead      18.20s              15.33s
>
> Conclusion
> ==========
>
> The specific use case this patch is addressing is to improve swapoff
> performance in cloud environments when a VM has been hibernated, resumed
> and all the memory needs to be forced back to RAM by disabling swap.
>
> This change allows to better exploits the advantages of the readahead
> heuristic during swapoff and this improvement allows to to speed up the
> resume process of such VMs.
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Looks good to me, Thanks!

Best Regards,
Huang, Ying

> ---
> Changes in v4:
>  - added a "conclusion" section in the patch description to better
>    explain the importance of this change (no functional changes)
>
>  mm/swapfile.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5871a2aa86a5..f8bf926c9c8f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1937,10 +1937,14 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  
>  		pte_unmap(pte);
>  		swap_map = &si->swap_map[offset];
> -		vmf.vma = vma;
> -		vmf.address = addr;
> -		vmf.pmd = pmd;
> -		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
> +		page = lookup_swap_cache(entry, vma, addr);
> +		if (!page) {
> +			vmf.vma = vma;
> +			vmf.address = addr;
> +			vmf.pmd = pmd;
> +			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> +						&vmf);
> +		}
>  		if (!page) {
>  			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
>  				goto try_next;
