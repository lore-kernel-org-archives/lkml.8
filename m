Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EECEC1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1346C2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584064824;
	bh=0BPLa6hnW8ipWdFehmaPOk77CPYHtoK1kcDT1IUFucM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N2syazIWwnEnGkdbYHgEZuA5O3rKSwfZgAsvlaWgWBKUoTwMnJ3BmssJ8oMDuqukK
	 nKI9X6srMkrz1kgpficiyKLSC8Ctk1xoSZHEbsSYjv4iR6WlrsWNO7y3BuSaSfktHd
	 5yqA4XEt6kTFqRGFOG6NeLO4Z4p0yI9PJa6oj3N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCMCAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:00:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42003 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMCAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:00:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id t3so3447032plz.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ULqLDVd2kkqniHcxRjAej9mWnrKAKa7fjvePHBiV/bU=;
        b=q5T8cai91O4phd6Vaaykn9whcXBcEuuQZWE5Ke77vprEFCayr01ooxsz+cTajraJN5
         2NCuYSDe2McfZej7ckrOAoyb6W1r+bs7mvdnePfhnznlSf0jJASidDUYUNZEvbMuI9+6
         HApmx5YS+jOl7jl3Dm2xrBGqhRRu/M0ttmPF9VFFJfaIi/nkarysoI3YKTwCC8uBDhtx
         1VZiaLGzS5jnnibEaeaZxrUyqrvLv85IIEq4mlVhE1BBzFaHBLgXRki1jBnDrXLAwqP1
         9RMUHMTuWklF0zr6apEgSO7sutkt/spSMhm6/x03K4qwVWSTSsNLResGF/KMvDFiyPEU
         RY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ULqLDVd2kkqniHcxRjAej9mWnrKAKa7fjvePHBiV/bU=;
        b=WH3Jes1aekGkl/YMSzx4IEh5O22RXpMkZhGJsiVd34BiOe0dicuyQD8xp+8aftw28y
         y+80blWGhlD2oPIFToxLZIifzG5I/Db5f1vWLQO8C0T0erwBd4/ZEcDm6dyLQoj+MCDH
         YdHmJ0l67Tk0rnHbd30GJKoyZBfDYAJu3RJm0nLQ31cRHXprKoaQLmdoY1VHI4TBqBmh
         UkCWPeY9rz+UeK2F7wrL3zBhIyGg2PkDxXodtfqDet8QvU8UOq8YeascOUg7G08PTl2Q
         CQF3I85rTfLCIciuJYGM6lNFQA5Qs77KvkidfWm9NfwWdfvfZlro/MeyfTmKGZW7na9D
         I8SQ==
X-Gm-Message-State: ANhLgQ3ggSSEIU/HSpm5dSCwQgJdZ37tdBkG2lazzhNij87MI+7DoCIE
        S3TGOsAUK1AhbrA0H0Vg58Q=
X-Google-Smtp-Source: ADFU+vv37YBJnDPGWsEgmZkosR1mP2+GO9n5l20/bA83dh1j15B1BxsiDccwfdYjU8+Ck1M608Z+OA==
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr7285128pjb.140.1584064821234;
        Thu, 12 Mar 2020 19:00:21 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b25sm5364108pfp.201.2020.03.12.19.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 19:00:19 -0700 (PDT)
Date:   Thu, 12 Mar 2020 19:00:18 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200313020018.GC68817@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <bd35c17d-8766-cba5-09b3-87970de4c731@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd35c17d-8766-cba5-09b3-87970de4c731@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:07PM -0700, Dave Hansen wrote:
> One other fun thing.  I have a "victim" thread sitting in a loop doing:
> 
> 	sleep(1)
> 	memcpy(&garbage, buffer, sz);
> 
> The "attacker" is doing
> 
> 	madvise(buffer, sz, MADV_PAGEOUT);
> 
> in a loop.  That, oddly enough doesn't cause the victim to page fault.
> But, if I do:
> 
> 	memcpy(&garbage, buffer, sz);
> 	madvise(buffer, sz, MADV_PAGEOUT);
> 
> It *does* cause the memory to get paged out.  The MADV_PAGEOUT code
> actually has a !pte_present() check.  It will punt on a PTE if it sees
> it.  In other words, if a page is in the swap cache but not mapped by a
> pte_present() PTE, MADV_PAGEOUT won't touch it.
> 
> Shouldn't MADV_PAGEOUT be able to find and reclaim those pages?  Patch
> attached.

> 
> 
> ---
> 
>  b/mm/madvise.c |   38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff -puN mm/madvise.c~madv-pageout-find-swap-cache mm/madvise.c
> --- a/mm/madvise.c~madv-pageout-find-swap-cache	2020-03-12 14:24:45.178775035 -0700
> +++ b/mm/madvise.c	2020-03-12 14:35:49.706773378 -0700
> @@ -248,6 +248,36 @@ static void force_shm_swapin_readahead(s
>  #endif		/* CONFIG_SWAP */
>  
>  /*
> + * Given a PTE, find the corresponding 'struct page'.  Also handles
> + * non-present swap PTEs.
> + */
> +struct page *pte_to_reclaim_page(struct vm_area_struct *vma,
> +				 unsigned long addr, pte_t ptent)
> +{
> +	swp_entry_t entry;
> +
> +	/* Totally empty PTE: */
> +	if (pte_none(ptent))
> +		return NULL;
> +
> +	/* A normal, present page is mapped: */
> +	if (pte_present(ptent))
> +		return vm_normal_page(vma, addr, ptent);
> +

Please check is_swap_pte first.

> +	entry = pte_to_swp_entry(vmf->orig_pte);
> +	/* Is it one of the "swap PTEs" that's not really swap? */
> +	if (non_swap_entry(entry))
> +		return false;
> +
> +	/*
> +	 * The PTE was a true swap entry.  The page may be in the
> +	 * swap cache.  If so, find it and return it so it may be
> +	 * reclaimed.
> +	 */
> +	return lookup_swap_cache(entry, vma, addr);

If we go with handling only exclusived owned page for anon,
I think we should apply the rule to swap cache, too.

Do you mind posting it as formal patch?

Thanks for the explain about vulnerability and the patch, Dave!

> +}
> +
> +/*
>   * Schedule all required I/O operations.  Do not wait for completion.
>   */
>  static long madvise_willneed(struct vm_area_struct *vma,
> @@ -389,13 +419,7 @@ regular_page:
>  	for (; addr < end; pte++, addr += PAGE_SIZE) {
>  		ptent = *pte;
>  
> -		if (pte_none(ptent))
> -			continue;
> -
> -		if (!pte_present(ptent))
> -			continue;
> -
> -		page = vm_normal_page(vma, addr, ptent);
> +		page = pte_to_reclaim_page(vma, addr, ptent);
>  		if (!page)
>  			continue;
>  
> _

