Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF06C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8474820724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584044168;
	bh=lkVIDnCi5ToPZPE8kzlmMp17saMTeWKr1pVh6bD5vwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KUawY4g6UwOovtzSr9r6CnziRX0gzSx5T2AAGNhajnTZAeN/o55DiN0XYTG1kx0qi
	 4nqXvbs0m9AbQUptp76WE8N/nUO+bhZZpxGeLUQ2z4wbwmJQLy+nhN4ALLjMmP78jw
	 KNsw0XrTZUhniSQkE5TFVtBPoLVXzrInT9vNEz24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCLUQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:16:07 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39105 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLUQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:16:06 -0400
Received: by mail-pj1-f67.google.com with SMTP id d8so3107768pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ODS1TFq9M93gWOQaGQ9WOy3EnmI/QAeYw+Gw8Sae8Y=;
        b=X/r/XGA7oK6/08aLFZb7cozSoP5Ox1n14lQ/b7pmAbgOSH2AocxqP3VTQCE0IZIiEd
         7Zhj7R74pgBIrG0Pzay4Gkz6RDMMjmTiLZcvnzN2QPzxKKxO66lDtOrSjWHseef3d0pW
         ko9LF2Cs3ROzOveWcMSMwJHX2in4UoFIdhsLMreC837s5gRVUvllRNCA4ZrLFrBxGeIY
         CDMqpHqo4KrY+cEQ1gxsRqPg84TWv1Ivf1loHceNVXenOgD+P9rXKfQZsfS5270ulRIH
         VwlwZkGDfbH0TRQcqiZ2Nm4xTaxFFLWi70hGeLwQVHhbOmk6puQP1n0/RPatfLZ4wQ7T
         iNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ODS1TFq9M93gWOQaGQ9WOy3EnmI/QAeYw+Gw8Sae8Y=;
        b=fVzN55WYeZ3+bzQvOMtbRh9tTqePiO75Nt0JLRe3sk7JjVRih9jYK2GUbP11Q2NSY5
         U+8HloI/j1MAt+r0jtSj/lHVhSMF84aBfs6bQctPIvVwA3VfGJJbOZGwNcdDOeVBVn8h
         BMbcZDOZtsWZ1pD9HaPyUra+l1EeUDKBbLvztRyVkdSLVAKr7XrCBunolSQuxAGayW5J
         h+BP4g7+629yrFywrZp7Hlohw9xqRMZ1xfR89Mx3OJIg2PJ08FItmh0nmGzQldpoKKeK
         MmmkNWGjGNseOWKVQ1LmKOwVdVT/cNFib+Qnl7B+gzcCQhJ0wANkOpF4jNn4Z6428YtB
         JVEQ==
X-Gm-Message-State: ANhLgQ30k8wbKl3DSihSZXUFlCI4d1KH/UyMTTu1S1jDw3eebIKjFtF3
        0oRmZRDhnuyFPkGZvsGV/iM=
X-Google-Smtp-Source: ADFU+vvSu5zD+w3Hi1A+OEefWgIKYLlwm40V2B013hdA5Huw5+NpY8qb95G53euZlUZM/kZuEzZlVQ==
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr5864534pjb.192.1584044165162;
        Thu, 12 Mar 2020 13:16:05 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b10sm5078236pfo.215.2020.03.12.13.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:16:03 -0700 (PDT)
Date:   Thu, 12 Mar 2020 13:16:02 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200312201602.GA68817@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312082248.GS23944@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> [Cc akpm]
> 
> So what about this?

Thanks, Michal.

I't likde to wait Jann's reply since Dave gave his opinion about the vulnerability.
https://lore.kernel.org/linux-mm/cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com/
Jann, could you give your insigh about that practically it's possible?

A real dumb question to understand vulnerability:

The attacker would be able to trigger heavy memory consumption so that he
could make paging them out without MADV_PAGEOUT. I know MADV_PAGEOUT makes
it easier but he still could do without MADV_PAGEOUT.
What makes difference here?

To clarify how MADV_PAGEWORK works:
If other process has accessed the page so that his page table has access
bit marked, MADV_PAGEOUT couldn't page it out.

> 
> From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 12 Mar 2020 09:04:35 +0100
> Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> 
> Jann has brought up a very interesting point [1]. While shared pages are
> excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> that way. This can lead to all sorts of hard to debug problems. E.g.
> performance problems outlined by Daniel [2]. There are runtime
> environments where there is a substantial memory shared among security
> domains via CoW memory and a easy to reclaim way of that memory, which
> MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> in for the parent process which might be more privileged or even open
> side channel attacks. The feasibility of the later is not really clear

I am not sure it's a good idea to mention performance stuff because
it's rather arguble. You and Johannes already pointed it out when I sbumit
early draft which had shared page filtering out logic due to performance
reason. You guys suggested the shared pages has higher chance to be touched
so that if it's really hot pages, that whould keep in the memory. I agree.

I think the only reason at this moment is just vulnerability.

> to me TBH but there is no real reason for exposure at this stage. It
> seems there is no real use case to depend on reclaiming CoW memory via
> madvise at this stage so it is much easier to simply disallow it and
> this is what this patch does. Put it simply MADV_{PAGEOUT,COLD} can
> operate only on the exclusively owned memory which is a straightforward
> semantic.
> 
> [1] http://lkml.kernel.org/r/CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com
> [2] http://lkml.kernel.org/r/CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/madvise.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 43b47d3fae02..4bb30ed6c8d2 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -335,12 +335,14 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		}
>  
>  		page = pmd_page(orig_pmd);
> +
> +		/* Do not interfere with other mappings of this page */


How about this?
/*
 * paging out only single mapped private pages for anonymous mapping,
 * otherwise, it opens a side channel.
 */

Otherwise, looks good to me.

> +		if (page_mapcount(page) != 1)
> +			goto huge_unlock;
> +
>  		if (next - addr != HPAGE_PMD_SIZE) {
>  			int err;
>  
> -			if (page_mapcount(page) != 1)
> -				goto huge_unlock;
> -
>  			get_page(page);
>  			spin_unlock(ptl);
>  			lock_page(page);
> @@ -426,6 +428,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			continue;
>  		}
>  
> +		/* Do not interfere with other mappings of this page */
> +		if (page_mapcount(page) != 1)
> +			continue;
> +
>  		VM_BUG_ON_PAGE(PageTransCompound(page), page);
>  
>  		if (pte_young(ptent)) {
> -- 
> 2.24.1
> 
> -- 
> Michal Hocko
> SUSE Labs
