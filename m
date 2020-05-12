Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8F8C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCAA20675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgELHOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:14:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:12386 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgELHOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:14:49 -0400
IronPort-SDR: Sn1rb1n3vLxCNb9UADmbMOuYg/M3nYLXXWpAQcwmFMEzqqgUiCNLUy7AEkKhgTPbGph4PK/2De
 ZtmCn7dixPDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 00:14:48 -0700
IronPort-SDR: V1z1KjEy6HMCzIPAuWxnhTOX5UkYMr5RHKngLgpjWwKFS+gEstjCNqBLBBz+84D82120aO5YFZ
 13X3gAzlINRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,382,1583222400"; 
   d="scan'208";a="409198422"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2020 00:14:46 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm, swap: Use prandom_u32_max()
References: <20200512064147.514493-1-ying.huang@intel.com>
        <20200512065049.GN29153@dhcp22.suse.cz>
Date:   Tue, 12 May 2020 15:14:46 +0800
In-Reply-To: <20200512065049.GN29153@dhcp22.suse.cz> (Michal Hocko's message
        of "Tue, 12 May 2020 08:50:49 +0200")
Message-ID: <875zd1pqu1.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 12-05-20 14:41:46, Huang Ying wrote:
>> To improve the code readability and get random number with higher
>> quality.
>
> I understand the readability argument but why should prandom_u32_max
> (which I was not aware of) provide a higher quality randomness?

I am not expert on random number generator.  I have heard about that the
randomness of the low order bits of some random number generator isn't
good enough.  Anyway, by using the common implementation, the real
random number generator expert can fix the possible issue once for all
users.

>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>
> To the change itself
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

Best Regards,
Huang, Ying

>> ---
>>  mm/swapfile.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index a0a123e59ce6..2ec8b21201d6 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -3220,7 +3220,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  		 * select a random position to start with to help wear leveling
>>  		 * SSD
>>  		 */
>> -		p->cluster_next = 1 + (prandom_u32() % p->highest_bit);
>> +		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
>>  		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
>>  
>>  		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
>> -- 
>> 2.26.2
