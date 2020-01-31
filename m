Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF37C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8054214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgAaLdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:33:15 -0500
Received: from foss.arm.com ([217.140.110.172]:34480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgAaLdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:33:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D994C1063;
        Fri, 31 Jan 2020 03:33:13 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3476B3F67D;
        Fri, 31 Jan 2020 03:33:13 -0800 (PST)
Date:   Fri, 31 Jan 2020 11:33:08 +0000
From:   Steven Price <steven.price@arm.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH] mm/mapping_dirty_helpers: Update huge page-table entry
 callbacks
Message-ID: <20200131113307.GA34020@arm.com>
References: <20200131100052.58761-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200131100052.58761-1-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:00:52AM +0000, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Following the update of pagewalk code
> commit a07984d48146 ("mm: pagewalk: add p4d_entry() and pgd_entry()")
> we can modify the mapping_dirty_helpers' huge page-table entry callbacks
> to avoid splitting when a huge pud or -pmd is encountered.
> 
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Steven Price <steven.price@arm.com>

LGTM

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  mm/mapping_dirty_helpers.c | 42 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> index 71070dda9643..2c7d03675903 100644
> --- a/mm/mapping_dirty_helpers.c
> +++ b/mm/mapping_dirty_helpers.c
> @@ -111,26 +111,60 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
>  	return 0;
>  }
>  
> -/* wp_clean_pmd_entry - The pagewalk pmd callback. */
> +/*
> + * wp_clean_pmd_entry - The pagewalk pmd callback.
> + *
> + * Dirty-tracking should take place on the PTE level, so
> + * WARN() if encountering a dirty huge pmd.
> + * Furthermore, never split huge pmds, since that currently
> + * causes dirty info loss. The pagefault handler should do
> + * that if needed.
> + */
>  static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			      struct mm_walk *walk)
>  {
> -	/* Dirty-tracking should be handled on the pte level */
>  	pmd_t pmdval = pmd_read_atomic(pmd);
>  
> +	if (!pmd_trans_unstable(&pmdval))
> +		return 0;
> +
> +	if (pmd_none(pmdval)) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +
> +	/* Huge pmd, present or migrated */
> +	walk->action = ACTION_CONTINUE;
>  	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
>  		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
>  
>  	return 0;
>  }
>  
> -/* wp_clean_pud_entry - The pagewalk pud callback. */
> +/*
> + * wp_clean_pud_entry - The pagewalk pud callback.
> + *
> + * Dirty-tracking should take place on the PTE level, so
> + * WARN() if encountering a dirty huge puds.
> + * Furthermore, never split huge puds, since that currently
> + * causes dirty info loss. The pagefault handler should do
> + * that if needed.
> + */
>  static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
>  			      struct mm_walk *walk)
>  {
> -	/* Dirty-tracking should be handled on the pte level */
>  	pud_t pudval = READ_ONCE(*pud);
>  
> +	if (!pud_trans_unstable(&pudval))
> +		return 0;
> +
> +	if (pud_none(pudval)) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +
> +	/* Huge pud */
> +	walk->action = ACTION_CONTINUE;
>  	if (pud_trans_huge(pudval) || pud_devmap(pudval))
>  		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
>  
> -- 
> 2.21.1
> 
