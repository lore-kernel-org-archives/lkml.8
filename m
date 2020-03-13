Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E07C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E1F206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCMQ7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:59:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:13894 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgCMQ7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:59:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 09:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="246741156"
Received: from saurabhd-mobl.amr.corp.intel.com (HELO [10.251.16.241]) ([10.251.16.241])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2020 09:59:50 -0700
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz> <20200312201602.GA68817@google.com>
 <bd35c17d-8766-cba5-09b3-87970de4c731@intel.com>
 <20200313020018.GC68817@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <a3a8a428-17d3-e3cb-913c-b44de12db9e4@intel.com>
Date:   Fri, 13 Mar 2020 09:59:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200313020018.GC68817@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 7:00 PM, Minchan Kim wrote:
> On Thu, Mar 12, 2020 at 02:41:07PM -0700, Dave Hansen wrote:
>> One other fun thing.  I have a "victim" thread sitting in a loop doing:
>>
>> 	sleep(1)
>> 	memcpy(&garbage, buffer, sz);
>>
>> The "attacker" is doing
>>
>> 	madvise(buffer, sz, MADV_PAGEOUT);
>>
>> in a loop.  That, oddly enough doesn't cause the victim to page fault.
>> But, if I do:
>>
>> 	memcpy(&garbage, buffer, sz);
>> 	madvise(buffer, sz, MADV_PAGEOUT);
>>
>> It *does* cause the memory to get paged out.  The MADV_PAGEOUT code
>> actually has a !pte_present() check.  It will punt on a PTE if it sees
>> it.  In other words, if a page is in the swap cache but not mapped by a
>> pte_present() PTE, MADV_PAGEOUT won't touch it.
>>
>> Shouldn't MADV_PAGEOUT be able to find and reclaim those pages?  Patch
>> attached.
> 
>>
>>
>> ---
>>
>>  b/mm/madvise.c |   38 +++++++++++++++++++++++++++++++-------
>>  1 file changed, 31 insertions(+), 7 deletions(-)
>>
>> diff -puN mm/madvise.c~madv-pageout-find-swap-cache mm/madvise.c
>> --- a/mm/madvise.c~madv-pageout-find-swap-cache	2020-03-12 14:24:45.178775035 -0700
>> +++ b/mm/madvise.c	2020-03-12 14:35:49.706773378 -0700
>> @@ -248,6 +248,36 @@ static void force_shm_swapin_readahead(s
>>  #endif		/* CONFIG_SWAP */
>>  
>>  /*
>> + * Given a PTE, find the corresponding 'struct page'.  Also handles
>> + * non-present swap PTEs.
>> + */
>> +struct page *pte_to_reclaim_page(struct vm_area_struct *vma,
>> +				 unsigned long addr, pte_t ptent)
>> +{
>> +	swp_entry_t entry;
>> +
>> +	/* Totally empty PTE: */
>> +	if (pte_none(ptent))
>> +		return NULL;
>> +
>> +	/* A normal, present page is mapped: */
>> +	if (pte_present(ptent))
>> +		return vm_normal_page(vma, addr, ptent);
>> +
> 
> Please check is_swap_pte first.

Why?

is_swap_pte() duplicates the first two checks.  But, I need an explicit
pte_present() check somewhere because I need to call vm_normal_page()
only on present PTEs.

I guess the pte_present() check could be:

	if (!is_swap_pte(ptent))
		return vm_normal_page(...);

*after* the pte_none() check.

>> +	entry = pte_to_swp_entry(vmf->orig_pte);
>> +	/* Is it one of the "swap PTEs" that's not really swap? */
>> +	if (non_swap_entry(entry))
>> +		return false;
>> +
>> +	/*
>> +	 * The PTE was a true swap entry.  The page may be in the
>> +	 * swap cache.  If so, find it and return it so it may be
>> +	 * reclaimed.
>> +	 */
>> +	return lookup_swap_cache(entry, vma, addr);
> 
> If we go with handling only exclusived owned page for anon,
> I think we should apply the rule to swap cache, too.

I'm going back and forth on it.  If we're just trying to avoid causing
faults in other processes, we could add a mapcount>0 check here in
addition to the mapcount>1 checks that were added in the other patch.

But, if we want a check for true exclusivity: no other swap entries or
mappings, we need to check swap_count() too.  It's getting quite a bit
uglier as I add that it, but I guess we'll see how it looks in the end.

> Do you mind posting it as formal patch?

Yeah, I'll send something out.
