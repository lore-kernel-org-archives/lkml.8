Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962CEC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF00208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgDWF5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:57:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:15586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWF5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:57:41 -0400
IronPort-SDR: Xmj4ccdnJ+aC3spofX+ICKWUACpKa4aph2Dmw14QYPca7dCcerk0vlHQk/E/1k6reQSGO9S4oC
 wqPNPsTNBdNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 22:57:41 -0700
IronPort-SDR: ejDVh1zgi7oy/DpflGw3T9rYQg4ba8uEkByvioeoGK7V4VDJqnLN1m14ZQi7+kcx49k+a7vYcp
 UAC8mZg8SZPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="456786339"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2020 22:57:39 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in scan_swap_map_slots()
In-Reply-To: <20200422214111.19370-1-richard.weiyang@gmail.com> (Wei Yang's
        message of "Wed, 22 Apr 2020 21:41:11 +0000")
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 23 Apr 2020 13:57:34 +0800
Message-ID: <87d07y2181.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> After commit c60aa176c6de8 ("swapfile: swap allocation cycle if
> nonrot"), swap allocation is cyclic. Current approach is done with two
> separate loop on the upper and lower half. This looks a little
> redundant.

I can understand that the redundant code doesn't smell good.  But I
don't think the new code is easier to be understood than the original
one.

> From another point of view, the loop iterates [lowest_bit, highest_bit]
> range starting with (offset + 1) but except scan_base. So we can
> simplify the loop with condition (next_offset() != scan_base) by
> introducing next_offset() which makes sure offset fit in that range
> with correct order.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Hugh Dickins <hughd@google.com>
> CC: "Huang, Ying" <ying.huang@intel.com>
>
> ---
> v2:
>   * return scan_base if the lower part is eaten
>   * only start over when iterating on the upper part
> ---
>  mm/swapfile.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f903e5a165d5..0005a4a1c1b4 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -729,6 +729,19 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  	}
>  }
>  
> +static unsigned long next_offset(struct swap_info_struct *si,
> +				unsigned long *offset, unsigned long scan_base)
> +{
> +	/* only start over when iterating on the upper part */
> +	if (++(*offset) > si->highest_bit && *offset > scan_base) {
> +		*offset = si->lowest_bit;
> +		/* someone has eaten the lower part */
> +		if (si->lowest_bit >= scan_base)
> +			return scan_base;
> +	}

if "offset > si->highest_bit" is true and "offset < scan_base" is true,
scan_base need to be returned.

Again, the new code doesn't make it easier to find this kind of issues.

Best Regards,
Huang, Ying
