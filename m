Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A8C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D035A207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDTXvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:51:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:4341 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTXvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:51:07 -0400
IronPort-SDR: bUMclkSmag1JzDUo+nf7oltyKpxylWDEfbwJDRV2daPZaiqGofXyJwMBZFfSG8ie+ciikR+o/V
 Zizj4iv57O2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 16:51:06 -0700
IronPort-SDR: TxOk3O2Dhoc6fgNZ71oBbd5aQobkmOl/CzsllG7ZKqwTruJ1t3l3OLbyty3MAGvweDuONf9o3i
 OJMXmyO60rTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="290270618"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2020 16:51:03 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 3/4] mm/swapfile.c: compare tmp and max after trying to iterate on swap_map
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
        <20200419013921.14390-3-richard.weiyang@gmail.com>
        <87ftczt1cg.fsf@yhuang-dev.intel.com>
        <20200420213726.juehv5yr5kyhlbxv@master>
Date:   Tue, 21 Apr 2020 07:51:02 +0800
In-Reply-To: <20200420213726.juehv5yr5kyhlbxv@master> (Wei Yang's message of
        "Mon, 20 Apr 2020 21:37:26 +0000")
Message-ID: <87h7xdsom1.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Mon, Apr 20, 2020 at 09:03:43AM +0800, Huang, Ying wrote:
>>Wei Yang <richard.weiyang@gmail.com> writes:
>>
>>> There are two duplicate code to handle the case when there is no
>>> available swap entry. Just let the code go through and do the check at
>>> second place.
>>>
>>> No functional change is expected.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> ---
>>>  mm/swapfile.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 3aae700f9931..07b0bc095411 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -629,10 +629,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>  	tmp = cluster->next;
>>>  	max = min_t(unsigned long, si->max,
>>>  		    (cluster_next(&cluster->index) + 1) * SWAPFILE_CLUSTER);
>>> -	if (tmp >= max) {
>>> -		cluster_set_null(&cluster->index);
>>> -		goto new_cluster;
>>> -	}
>>
>>The code is to avoid to acquire the cluster lock unnecessarily.  So I think
>>we should keep this.
>>
>
> If you really want to avoid the lock, my suggestion is to add:
>
>   if (tmp < max) {
>       ci = lock_cluster(si, tmp);
>           while (tmp < max) {
> 	  ...
> 	  }
>       unlock_cluster(ci);
>   }
>
> Instead of do the similar thing twice.

This is a coding style problem.  The original code is common to avoid
too many nested code block.  But in this case, I think both works.

Best Regards,
Huang, Ying

>>Best Regards,
>>Huang, Ying
>>
>>>  	ci = lock_cluster(si, tmp);
>>>  	while (tmp < max) {
>>>  		if (!si->swap_map[tmp])
